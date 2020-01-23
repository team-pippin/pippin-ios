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
    case signUp(account: AccountSignUp)
    case signIn(account: SignInRequest)
    case getAccountSchools(accountId: String)
    case getSchoolsForSearch
    case subscribeToSchool(accountId: String, schools: SchoolSubscription)
    case getSchool(schoolId: String)
    case getNews(schoolId: String)
    case getEvents(schoolId: String)
}

extension PippinAPI: EndPointType {
    
    public var environmentBaseURL: String {
        switch NetworkManager.sharedInstance.environment {
        case .production: return ""
        case .qa: return ""
        case .staging: return APIConstants.EndPoint.staging
        case .development: return ""
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
            return APIConstants.Account.signUp
        case .signIn:
            return APIConstants.Account.signIn
        case .getSchoolsForSearch:
            return APIConstants.School.schools
        case .subscribeToSchool(accountId: let accountId, schools: _):
            return APIConstants.Account.accountSubscriptions(id: accountId)
        case .getAccountSchools(let accountId):
            return APIConstants.Account.accountSubscriptions(id: accountId)
        case .getSchool(schoolId: let schoolId):
            return APIConstants.School.school(with: schoolId)
        case .getNews(schoolId: let schoolId):
            return APIConstants.News.schoolNews(with: schoolId)
        case .getEvents(schoolId: let schoolId):
            return APIConstants.Events.schoolEvents(with: schoolId)
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .signUp, .signIn:
            return .post
        case .getSchoolsForSearch, .getAccountSchools, .getSchool, .getNews, .getEvents:
            return .get
        case .subscribeToSchool:
            return .put
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .signUp(account: let newAccountData):
            return .requestParameters(bodyParameters: newAccountData, urlParameters: nil)
            
        case .signIn(account: let signInAccount):
            return .requestParameters(bodyParameters: signInAccount, urlParameters: nil)
            
        case .getSchoolsForSearch, .getAccountSchools, .getSchool, .getNews, .getEvents:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: headers)
            
        case .subscribeToSchool(accountId: _, schools: let schools):
            return .requestParametersAndHeaders(bodyParameters: schools, urlParameters: nil, additionalHeaders: headers)
        }
    }
    
    public var headers: HTTPHeaders? {
        if let token = UserDefaultsManager.signedInAccountToken {
            return ["Authorization": "Bearer \(token)"]
        }
        
        return nil
    }
}
