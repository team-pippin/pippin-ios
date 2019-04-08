//
//  SignUp.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

public struct UserSignUp: PropertyLoopable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct UserTokenResponseModel: Codable {
    let token: String?
}

public struct UserSignIn: PropertyLoopable {
    let email: String
    let password: String
}
