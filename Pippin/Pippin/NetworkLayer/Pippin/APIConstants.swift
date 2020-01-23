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
        
        static func accountSubscriptions(id: String) -> String {
            return APIConstants.Account.accounts + "/\(id)/" + APIConstants.School.schoolSubscriptions
        }
    }
    
    struct School {
        static let schools = "schools"
        static let schoolSubscriptions = "school-subscriptions"
        
        static func school(with id: String) -> String {
            return schools + "/" + id
        }
    }
    
    struct News {
        static let articles = "articles"
        
        static func schoolNews(with schoolId: String) -> String {
            return School.school(with: schoolId) + "/" + articles
        }
        
        static func schoolNewsArticle(from schoolId: String, with articleId: String) -> String {
            return schoolNews(with: schoolId) + "/" + articleId
        }
    }
    
    struct Events {
        static let events = "events"
        
        static func schoolEvents(with schoolId: String) -> String {
            return School.school(with: schoolId) + "/" + events
        }
        
        static func schoolEventL(from schoolId: String, with eventId: String) -> String {
            return schoolEvents(with: schoolId) + "/" + eventId
        }
    }
}
