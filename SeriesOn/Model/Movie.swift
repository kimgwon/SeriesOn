//
//  Metadata.swift
//  SeriesOn
//
//  Created by keem on 2023/06/05.
//

import Foundation

// budget, id, original_language, original_title, overview, release_date, revenue, runtime, title, status, vote_average, vote_count
class Movie{
    var id: Int
    var budget: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var release_date: String
    var revenue: Int
    var runtime: Float
    var status: String
    var tagline: String
    var title: String
    var vote_average: Float
    var vote_count: Int
    
    init(id: Int, budget: Int, original_language: String, original_title: String, overview: String, popularity: Float, release_date: String, revenue: Int, runtime: Float, status: String, tagline: String, title: String, vote_average: Float, vote_count: Int) {
        self.id = id
        self.budget = budget
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.release_date = release_date
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
