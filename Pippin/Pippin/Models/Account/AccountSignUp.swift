//
//  AccountSignUp.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public struct AccountSignUp: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
