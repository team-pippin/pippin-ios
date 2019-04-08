//
//  PippinAPI.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let sharedInstance = RocketNetworkManager<PippinAPI>()
    
    static func setEnvironment(for environment: NetworkEnvironment) {
        NetworkManager.sharedInstance.setupNetworkLayer(in: environment)
    }
}

public enum PippinAPI {
    case signUp(user: NewUser)
}

extension PippinAPI: EndPointType {
    
    public var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .production: return ""
        case .qa: return ""
        case .staging: return ""
        case .development: return "https://us-central1-pippin-dev.cloudfunctions.net/api"
        case .local: return "http://localhost:5000/pippin-dev/us-central1/api"
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
        return url
    }
    
    public var path: String {
        switch self {
        case .signUp:
            return "users/signup"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .signUp(user: let newUserData):
            return .requestParameters(bodyParameters: newUserData, urlParameters: nil)
        default:
            return .request
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
