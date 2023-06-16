//
//  SimpleMovie.swift
//  SeriesOn
//
//  Created by keem on 2023/06/09.
//

import Foundation

class SimpleMovie{
    var belongs_to_collection: Info
    var vote_average: Float
    var vote_count: Int

    init(belongs_to_collection: Info, vote_average: Float, vote_count: Int) {
        self.belongs_to_collection = belongs_to_collection
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
}
