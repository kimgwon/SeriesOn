//
//  Cast.swift
//  SeriesOn
//
//  Created by keem on 2023/06/19.
//

import Foundation

// character, name
class Cast: Codable{
    var character: String
    var name: String
    
    init(character: String, name: String) {
        self.character = character
        self.name = name
    }
}
