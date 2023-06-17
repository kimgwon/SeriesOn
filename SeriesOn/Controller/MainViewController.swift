import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let AD = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var movieGroupTableView: UITableView!
    var movies: [Movie] = [] // 영화 데이터를 담을 배열
    
    let cellName = "MovieListCell"
    let cellReuseIdentifier = "movieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registerXib()
        
        if let movies = AD?.movies{
            self.movies = movies
        }
        
        movieGroupTableView.delegate = self
        movieGroupTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovieListCell
        let target = movies[indexPath.row]
        
        cell.rank?.text = String(indexPath.row+1)
        cell.title?.text = target.title
        cell.vote_avg?.text = String(target.vote_average)
        cell.vote_cnt?.text = String(target.vote_count)
        
        return cell
    }

    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        movieGroupTableView.register(nibName, forCellReuseIdentifier: cellReuseIdentifier)
    }
}
