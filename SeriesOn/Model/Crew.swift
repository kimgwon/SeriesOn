//
//  Credit.swift
//  SeriesOn
//
//  Created by keem on 2023/06/19.
//

import Foundation

// department, job, name
class Crew: Codable{
    var department: String
    var job: String
    var name: String
    
    init(department: String, job: String, name: String) {
        self.department = department
        self.job = job
        self.name = name
    }
}
