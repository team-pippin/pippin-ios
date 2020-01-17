//
//  AccountRoleType.swift
//  Pippin
//
//  Created by Will Brandin on 1/17/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

public enum AccountRoleType: String, Codable {
    case admin = "ADMIN"
    case editor = "EDITOR"
    case subscriber = "SUBSCRIBER"
}
