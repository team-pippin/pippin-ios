//
//  APIConstants.swift
//  Pippin
//
//  Created by Will Brandin on 4/14/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

struct APIConstants {
    
    struct EndPoint {
        static let staging = "https://pippin-staging.herokuapp.com/api/"
        static let local = "http://localhost:5000/api/"
    }
    
    struct Account {
        static let accounts = "accounts"
        static let signUp = "\(APIConstants.Account.accounts)/sign-up"
        static let signIn = "\(APIConstants.Account.accounts)/sign-in"
    }
    
    struct School {
        static let schools = "schools"
        static let schoolSubscriptions = "school-subscriptions"
    }
}
