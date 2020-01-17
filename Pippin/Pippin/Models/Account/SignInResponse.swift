//
//  SignInResponse.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    let token: String?
    let account: Account
}
