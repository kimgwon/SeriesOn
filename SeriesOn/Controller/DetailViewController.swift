import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var idField: UILabel!
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var languageField: UILabel!
    @IBOutlet weak var genreField: UILabel!
    @IBOutlet weak var taglineField: UILabel!
    @IBOutlet weak var overviewField: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var selectedMovie: Movie!
    var selectedId: Int = -1
    
    var reviews: [Review] = []
    
    let apiKey = "ecd3e09f34msh13d17379eba4651p196a43jsnc1588928f719"
    let cellReuseIdentifier = "reviewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewTableView.rowHeight = 150
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        
        if let selectedMovie = selectedMovie{
            idField.text = String(selectedMovie.id)
            titleField.text = selectedMovie.title
            dateField.text = selectedMovie.release_date
            languageField.text = selectedMovie.original_language
            taglineField.text = selectedMovie.tagline
            overviewField.text = selectedMovie.overview
            posterView.image = UIImage(named: selectedMovie.poster_path)

            let genreNames = selectedMovie.genres.map { $0.name }
            let joinedGenreNames = genreNames.joined(separator: ", ")
            genreField.text = joinedGenreNames
        }
        
        backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(showModal(_:)), for: .touchUpInside)
        
        fetchReviews(for: selectedMovie.imdb_id)
        
    }
    
    func fetchReviews(for imdbId: String) {
        let urlString = "https://imdb8.p.rapidapi.com/title/get-user-reviews?tconst=\(imdbId)&currentCountry=US&purchaseCountry=US"
        
        guard let url = URL(string: urlString) else {
            print("유효하지 않은 URL입니다: \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("ecd3e09f34msh13d17379eba4651p196a43jsnc1588928f719", forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("imdb8.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("리뷰 가져오기 실패: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("데이터를 받아오지 못했습니다")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let reviewsData = json as? [String: Any],
                      let reviewsArray = reviewsData["reviews"] as? [[String: Any]] else {
                    print("리뷰 데이터를 찾을 수 없습니다")
                    return
                }
                
                for reviewData in reviewsArray {
                    guard let author = reviewData["author"] as? [String: Any],
                          let authorDisplayName = author["displayName"] as? String,
                          let authorRating = reviewData["authorRating"] as? Int,
                          let interestingVotesData = reviewData["interestingVotes"] as? [String: Int],
                          let upVotes = interestingVotesData["up"],
                          let downVotes = interestingVotesData["down"],
                          let reviewText = reviewData["reviewText"] as? String,
                          let reviewTitle = reviewData["reviewTitle"] as? String,
                          let submissionDate = reviewData["submissionDate"] as? String else {
                        print("리뷰 데이터를 파싱할 수 없습니다")
                        continue
                    }
                    
                    let interestingVotes = InterestingVotes(down: downVotes, up: upVotes)
                    let review = Review(author: authorDisplayName, authorRating: authorRating, interestingVotes: interestingVotes, reviewText: reviewText, reviewTitle: reviewTitle, submissionDate: submissionDate)
                    
                    // author 정보 출력
                    self.reviews.append(review)
                }
                DispatchQueue.main.async {
                    self.reviewTableView.reloadData()
                }
            } catch {
                print("리뷰 데이터 파싱 오류: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    @IBAction func showModal(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let modalViewController = storyboard.instantiateViewController(withIdentifier: "ReviewSubmitViewController") as! ReviewSubmitViewController
        
        submitButton.addTarget(modalViewController, action: #selector(modalViewController.submitButtonTapped(_:)), for: .touchUpInside)
        
        let sheetPresentationController = modalViewController.presentationController as! UISheetPresentationController
        sheetPresentationController.detents = [.medium(), .large()]
        sheetPresentationController.prefersGrabberVisible = true
        
        present(modalViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ReviewListCell
        let target = reviews[indexPath.row]
        
        reviewCount.text = "댓글 " + String(reviews.count)
        
        // 셀에 리뷰 정보 표시
        cell.r_id.text = target.author
        cell.r_date.text = target.submissionDate
        cell.r_like.text = "공감: " + String(target.interestingVotes.up)
        cell.r_rate.text = String(target.authorRating) + "점"
        cell.r_text.text = target.reviewText
        cell.r_title.text = target.reviewTitle
        
        return cell
    }

    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }

}
