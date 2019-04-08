//
//  SignUp.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

struct NewUser: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
