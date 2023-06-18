import UIKit
import DropDown

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let AD = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var movieGroupTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var popupButton: UIButton!
    
    var original_movies: [Movie] = []
    var movies: [Movie] = [] // 영화 데이터를 담을 배열
    var popup_categories: [String] = ["가족", "코미디", "로맨스"]
    
    let cellName = "MovieListCell"
    let cellReuseIdentifier = "movieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registerXib()
        
        if let movies = AD?.movies{
            original_movies = movies
            self.movies = original_movies
        }
        
        movieGroupTableView.rowHeight = 120
        movieGroupTableView.delegate = self
        movieGroupTableView.dataSource = self
        
        setSegment()
        
        // segmentedControl의 값을 변경할 때마다 sortMovies 메서드를 호출합니다.
        segmentedControl.addTarget(self, action: #selector(sortMovies), for: .valueChanged)
        
        // 앱을 처음 실행했을 때 popularity의 내림차순으로 정렬합니다.
        sortMovies()
        
        // segmentedControl의 선택된 세그먼트를 popularity에 해당하는 인덱스로 설정합니다.
        segmentedControl.selectedSegmentIndex = 0
        
        setCategory()
    }
    
    func setCategory(){
        // [실시간 메뉴 버튼 클릭 이벤트 감지]
        let optionClosure = {(action: UIAction) in
            switch action.title {
            case "전체": // popularity의 내림차순으로 정렬
                self.movies = self.original_movies
            case "액션": // vote_average의 내림차순으로 정렬
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Action" }
                }
            case "스릴러":
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Thriller" }
                }
            case "판타지": // vote_count의 내림차순으로 정렬
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Fantasy" }
                }
            default:
                break
            }

            self.movieGroupTableView.reloadData()
            print(action.title)
        }
        
        popupButton.menu = UIMenu(title: "카테고리", options: .displayInline,children: [
            UIAction(title: "전체", state: .on, handler: optionClosure),
            UIAction(title: "액션", handler: optionClosure),
            UIAction(title: "스릴러", handler: optionClosure),
            UIAction(title: "판타지", handler: optionClosure)
        ])
        
        
        // [popup button 에 메뉴 지정 실시]
        self.popupButton.changesSelectionAsPrimaryAction = true
        self.popupButton.changesSelectionAsPrimaryAction = true
    }
    
    @objc func sortMovies() {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // popularity의 내림차순으로 정렬
            movies.sort { $0.popularity > $1.popularity }
        case 1: // vote_average의 내림차순으로 정렬
            movies.sort { $0.vote_average > $1.vote_average }
        case 2: // vote_count의 내림차순으로 정렬
            movies.sort { $0.vote_count > $1.vote_count }
        default:
            break
        }
        
        movieGroupTableView.reloadData()
    }
    
    func setSegment(){
        // UISegmentedControl의 설정
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        //segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.tintColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count>=20 {
            return 20
        } else{
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovieListCell
        let target = movies[indexPath.row]
        
        // 이미지 설정
        cell.movieImage.image = UIImage(named: target.poster_path)
        
        cell.rank?.text = String(indexPath.row+1)
        cell.title?.text = target.title
        cell.vote_avg?.text = String(target.vote_average)
        cell.vote_cnt?.text = "("+String(target.vote_count)+")"
        
        // 텍스트 속성 설정
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .strokeWidth: 1.0,
            .foregroundColor: UIColor.clear
        ]
        
        // rank 레이블에 텍스트 속성 적용
        let attributedText = NSAttributedString(string: cell.rank?.text ?? "", attributes: attributes)
        cell.rank?.attributedText = attributedText
        
        return cell
    }

    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        movieGroupTableView.register(nibName, forCellReuseIdentifier: cellReuseIdentifier)
    }
}
