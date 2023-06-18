//
//  InterestingVotes.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import Foundation

class InterestingVotes: Codable{
    var down: Int
    var up: Int
    
    init(down: Int, up: Int) {
        self.down = down
        self.up = up
    }
}
