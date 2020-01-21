//
//  School.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public struct School: Codable {
    let id: String
    let name: String
    let city: String
    let state: String
    let postalCode: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, city, state, postalCode
    }
}
