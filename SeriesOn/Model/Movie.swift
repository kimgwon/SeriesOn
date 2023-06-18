//
//  Metadata.swift
//  SeriesOn
//
//  Created by keem on 2023/06/05.
//

import Foundation

// budget, id, original_language, original_title, overview, release_date, revenue, runtime, title, status, vote_average, vote_count
class Movie: Codable{
    var id: Int
    var budget: Int
    var genres: [Genre]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var release_date: String
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String
    var title: String
    var vote_average: Double
    var vote_count: Int
    var poster_path: String
    var imdb_id: String
    
    init(id: Int, budget: Int, genres: [Genre], original_language: String, original_title: String, overview: String, popularity: Double, release_date: String, revenue: Int, runtime: Int, status: String, tagline: String, title: String, vote_average: Double, vote_count: Int, poster_path: String, imdb_id: String) {
        self.id = id
        self.budget = budget
        self.genres = genres
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
        self.poster_path = poster_path
        self.imdb_id = imdb_id
    }
    
}
