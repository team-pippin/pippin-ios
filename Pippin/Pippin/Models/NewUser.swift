//
//  SignUp.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public struct NewUser: PropertyLoopable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct NewUserResponseModel: Codable {
    let token: String?
}
