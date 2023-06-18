//
//  Author.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import Foundation

class Author: Codable{
    var displayName: String
    var authorRating: Int
    
    init(displayName: String, authorRating: Int) {
        self.displayName = displayName
        self.authorRating = authorRating
    }
}
