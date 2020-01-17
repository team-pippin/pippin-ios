//
//  SignInRequest.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public struct SignInRequest: Codable {
    let email: String
    let password: String
}
