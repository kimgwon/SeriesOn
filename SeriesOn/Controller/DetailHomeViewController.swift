import UIKit

class DetailHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let AD = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var original_movies: [Movie] = []
    var movies: [Movie] = []
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movies = AD?.movies {
            original_movies = movies
            self.movies = original_movies
        }

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setSegment()
        // segmentedControl의 값을 변경할 때마다 sortMovies 메서드를 호출합니다.
        segmentedControl.addTarget(self, action: #selector(setCategory), for: .valueChanged)

    }
    
    @objc func setCategory(){
        // [실시간 메뉴 버튼 클릭 이벤트 감지]
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                self.movies = self.original_movies
            case 1:
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Action" }
                }
            case 2:
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Thriller" }
                }
            case 3:
                self.movies = self.original_movies.filter { movie in
                    movie.genres.contains { $0.name == "Fantasy" }
                }
            default:
                break
            }
            
            self.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let target = movies[indexPath.row]
        
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        // 영화 정보 넘겨주기
        detailViewController.selectedMovie = target
        // 화면 전환 애니메이션 설정
        detailViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: true, completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailViewCell
        let target = movies[indexPath.row]

        // 이미지 설정
        cell.movieImage.image = UIImage(named: target.poster_path)

        // 셀에 영화 정보 표시
        cell.movieTitle.text = target.title
        cell.backgroundColor = UIColor.clear

        cell.movieImage.frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height * 0.8)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 3
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}
