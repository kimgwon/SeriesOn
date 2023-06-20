import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let AD = UIApplication.shared.delegate as? AppDelegate
    var movies: [Movie] = [] // 영화 데이터를 담을 배열
    var credits: [Credit] = [] // 배우 데이터 담을 배열

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var countField: UILabel!
    
    var searchResults: [Movie] = []
    let cellReuseIdentifier = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movies = AD?.movies{
            self.movies = movies
        }
        if let credits = AD?.credits{
            self.credits = credits
        }
        
        searchTableView.rowHeight = 120
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        searchButton.isEnabled = false // 초기에 버튼 비활성화
        searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside) // 버튼의 액션 설정
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged) // 텍스트 필드의 편집 내용이 변경되었을 때 호출할 메서드 등록
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        // 검색어 처리
        guard let searchQuery = searchField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchQuery.isEmpty else {
            // 검색어가 비어있는 경우 처리
            searchButton.isEnabled = false // 초기에 버튼 비활성화
            return
        }
        
        // 배우명 또는 영화 제목으로 검색 결과를 찾기 위해 movies 배열을 순회
        let searchResultsActor = credits.filter { credit in
            credit.cast.contains { cast in
                cast.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }.compactMap { credit in
            movies.first { movie in
                movie.id == credit.Id
            }
        }
        
        // 검색 결과 업데이트
        let searchResultsMovie = movies.filter { movie in
            // 영화 제목 또는 배우명에 검색어가 포함되어 있는지 확인
            return movie.title.localizedCaseInsensitiveContains(searchQuery)
        }
        
        let searchResults = searchResultsActor + searchResultsMovie
        
        // 검색 결과를 vote_average의 내림차순으로 정렬
        let sortedResults = searchResults.sorted { $0.vote_average > $1.vote_average }
        
        // 검색 결과를 테이블 뷰에 업데이트
        self.searchResults = searchResults
        
        // 검색 결과의 개수를 표시
        countField.text = "'\(searchField.text!)'의 검색 결과: \(searchResults.count)개"
        
        searchTableView.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // 텍스트 필드의 내용이 변경되었을 때 호출되는 메서드
        if let searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SearchListCell
        let target = searchResults[indexPath.row]
        
        // 이미지 설정
        cell.poster_image.image = UIImage(named: target.poster_path)
        
        // 셀에 영화 정보 표시
        cell.movie_name.text = target.title
        cell.movie_id.text = "#" + String(target.id)
        cell.overview.text = target.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = searchResults[indexPath.row]

        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        // 영화 정보 넘겨주기
        detailViewController.selectedMovie = target
        // 화면 전환 애니메이션 설정
        detailViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: true, completion: nil)
    }

}
