//
//  Genre.swift
//  SeriesOn
//
//  Created by keem on 2023/06/05.
//

import Foundation

class Genre: Codable{
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
// [{'id': 18, 'name': 'Drama'}]
