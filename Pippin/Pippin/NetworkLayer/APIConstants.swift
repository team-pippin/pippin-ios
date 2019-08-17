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
        static let development = "https://us-central1-pippin-dev.cloudfunctions.net/api"
        static let local = "http://localhost:5000/pippin-dev/us-central1/api"
    }
    
    struct User {
        static let users = "users"
        static let signUp = "\(APIConstants.User.users)/signup"
        static let signIn = "\(APIConstants.User.users)/signin"
    }
    
    struct School {
        static let schools = "schools"
        static let schoolSubscriptions = "school-subscriptions"
    }
}
