//
//  Review.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import Foundation

class Review: Codable{
    var author: String
    var authorRating: Int
    var interestingVotes: InterestingVotes
    var reviewText: String
    var reviewTitle: String
    var submissionDate: String
    
    init(author: String, authorRating: Int, interestingVotes: InterestingVotes, reviewText: String, reviewTitle: String, submissionDate: String) {
        self.author = author
        self.authorRating = authorRating
        self.interestingVotes = interestingVotes
        self.reviewText = reviewText
        self.reviewTitle = reviewTitle
        self.submissionDate = submissionDate
    }
}
