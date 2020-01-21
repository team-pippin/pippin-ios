//
//  APIError+Message.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

protocol ErrorMessageable {
    var message: String { get }
}

extension APIError: ErrorMessageable {
    var message: String {
        return "FAIL"
    }
}
