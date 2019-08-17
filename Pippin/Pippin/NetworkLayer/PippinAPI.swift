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
    case signUp(user: UserSignUp)
    case signIn(user: UserSignIn)
    case getSchoolsForSearch
    case subscribeToSchool(userId: String, schools: SchoolSubscribe)
}

extension PippinAPI: EndPointType {
    
    public var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .production: return ""
        case .qa: return ""
        case .staging: return ""
        case .development: return APIConstants.EndPoint.development
        case .local: return APIConstants.EndPoint.local
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("base url could not be config") }
        return url
    }
    
    public var path: String {
        switch self {
        case .signUp:
            return APIConstants.User.signUp
        case .signIn:
            return APIConstants.User.signIn
        case .getSchoolsForSearch:
            return APIConstants.School.schools
        case .subscribeToSchool(userId: let userId, schools: _):
            return "\(APIConstants.User.users)/\(userId)/\(APIConstants.School.schoolSubscriptions)"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .signUp, .signIn:
            return .post
        case .getSchoolsForSearch:
            return .get
        case .subscribeToSchool:
            return .put
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .signUp(user: let newUserData):
            return .requestParameters(bodyParameters: newUserData, urlParameters: nil)
        case .signIn(user: let signInUser):
            return .requestParameters(bodyParameters: signInUser, urlParameters: nil)
        case.getSchoolsForSearch:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
        case .subscribeToSchool(userId: _, schools: let schools):
            return .requestParametersAndHeaders(bodyParameters: schools, urlParameters: nil, additionalHeaders: headers)
        }
    }
    
    public var headers: HTTPHeaders? {
        if let token = UserDefaultsManager.signedInUserToken {
            return ["Authorization": "Bearer \(token)"]
        }
        return nil
    }
}
