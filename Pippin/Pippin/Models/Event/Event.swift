//
//  Event.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

struct Event: Codable {
    let id: String
    let location: String
    let startDate: String
    let endDate: String?
    let body: String
    let title: String
    let author: String
    let school: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case location, startDate, endDate, body, title, author, school
    }
}
