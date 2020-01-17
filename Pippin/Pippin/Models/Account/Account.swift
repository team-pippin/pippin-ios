//
//  SignUp.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public struct Account: Codable {
    let id: String
    let name: String
    let email: String
    let roles: [String]?
}
