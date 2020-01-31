//
//  UserDefaultsManager.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Account Default Keys
    
    private static let signedInAccountTokenKey = "signedInAccountTokenKey"
    private static let signedInAccountKey = "signedInAccountKey"
    private static let activeSchoolIdKey = "activeSchoolIdKey"

    // MARK: - Account Default Values
    
    static var activeSchoolId: String? {
        get {
            guard let value = UserDefaults.standard.string(forKey: activeSchoolIdKey), !value.isEmpty else {
                return nil
            }
            
            return value
        }
        set {
            if let value = UserDefaults.standard.string(forKey: activeSchoolIdKey) {
                if newValue != value {
                    UserDefaults.standard.set(newValue, forKey: activeSchoolIdKey)
                    
                    if value != nil {
                        NotificationCenter.default.post(name: .schoolChanged, object: nil)
                    }
                }
            } else {
                UserDefaults.standard.set(newValue, forKey: activeSchoolIdKey)
                NotificationCenter.default.post(name: .schoolChanged, object: nil)
            }
        }
    }
    
    static var signedInAccountToken: String? {
        get {
            guard let value = UserDefaults.standard.string(forKey: signedInAccountTokenKey), !value.isEmpty else {
                return nil
            }
            
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: signedInAccountTokenKey)
        }
    }
    
    static var currentAccount: Account? {
        get {
            return retieveEncoded(type: Account.self, for: signedInAccountKey)
        }
        set {
            saveCodable(with: newValue, for: signedInAccountKey)
        }
    }
    
    // MARK: - Methods
    
    public static func clear() {
        currentAccount = nil
        signedInAccountToken = nil
        activeSchoolId = nil
    }
    
    // MARK: - Private Methods
    
    private static func saveCodable<T: Codable>(with object: T?, for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    private static func retieveEncoded<T: Codable>(type: T.Type, for key: String) -> T? {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(type, from: savedData) {
                return decodedData
            }
            return nil
        }
        return nil
    }
}
