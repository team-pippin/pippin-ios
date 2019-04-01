//
//  UserDefaultsManager.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - User Default Keys
    
    private static let selectedUserSchoolIdKey = "selectedUserSchoolIdKey"
    
    // MARK: - User Default Values
    
    static var selectedUserSchoolId: String? {
        get {
            guard let value = UserDefaults.standard.string(forKey: selectedUserSchoolIdKey) else {
                return nil
            }
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: selectedUserSchoolIdKey)
        }
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
