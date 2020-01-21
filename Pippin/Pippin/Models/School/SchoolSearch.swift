//
//  SchoolSearch.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public struct SchoolSearch: Codable {
    let name: String
    let id: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
