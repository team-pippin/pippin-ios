//
//  School.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public struct SchoolSearch: Codable {
    let name: String
    let id: String
}

public struct SchoolSubscribe: PropertyLoopable {
    let schools: [String]
}
