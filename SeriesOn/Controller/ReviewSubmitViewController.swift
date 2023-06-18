//
//  ReviewSubmitViewController.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import UIKit

class ReviewSubmitViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var rateField: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var rateSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        rateField.text = "별점 \(value)"
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let reviewTitle = titleField.text, !reviewTitle.isEmpty,
              let reviewText = contentField.text, !reviewText.isEmpty else {
            // 리뷰 제목과 내용이 비어있을 경우 처리할 로직 추가
            return
        }
        
        let rating = Int(rateSlider.value)
        
        let currentDate = Date() // 현재 날짜와 시간 가져오기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 날짜 형식 지정
        let dateString = dateFormatter.string(from: currentDate) // 현재 날짜를 문자열로 변환
            
        
        // DetailViewController의 인스턴스에 접근하여 reviews에 새로운 리뷰 추가
        let new_review = Review(author: "guest", authorRating: rating, interestingVotes: InterestingVotes(down: 0, up: 0), reviewText: reviewText, reviewTitle: reviewTitle, submissionDate: dateString)
        
        if let detailViewController = presentingViewController as? DetailViewController {
            detailViewController.reviews.insert(new_review, at: 0) // 맨 앞에 추가
            detailViewController.reviewTableView.reloadData()
        }
        
        dismiss(animated: true, completion: nil) // 모달 창 닫기
    }
    
}
