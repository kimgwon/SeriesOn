//
//  Info.swift
//  SeriesOn
//
//  Created by keem on 2023/06/05.
//

import Foundation

class Info {
    var id: Int
    var name: String
    var poster_path: String
    var backdrop_path: String
    
    init(id: Int, name: String, poster_path: String, backdrop_path: String) {
        self.id = id
        self.name = name
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
    }
}
