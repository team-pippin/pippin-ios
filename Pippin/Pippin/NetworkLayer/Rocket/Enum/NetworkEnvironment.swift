//
//  NetworkEnvironment.swift
//  RocketNetworking
//
//  Created by Will Brandin on 1/26/19.
//  Copyright © 2019 williambrandin. All rights reserved.
//

import Foundation

public enum NetworkEnvironment: Int {
    case qa = 2
    case production = 4
    case staging = 3
    case development = 1
    case local = 0
    
    var name: String {
        switch self {
        case .qa: return "QA"
        case .production: return "Production"
        case .staging: return "Staging"
        case .development: return "Develop"
        case .local: return "Local"
        }
    }
}
