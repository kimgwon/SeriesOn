//
//  Credit.swift
//  SeriesOn
//
//  Created by keem on 2023/06/19.
//

import Foundation

class Credit: Codable{
    var cast: [Cast]
    var crew: [Crew]
    var Id: Int
    
    init(cast: [Cast], crew: [Crew], Id: Int) {
        self.cast = cast
        self.crew = crew
        self.Id = Id
    }
}
