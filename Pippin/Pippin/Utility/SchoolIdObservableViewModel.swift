//
//  SchoolIdObservableViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

class SchoolIdObservableViewModel: SchoolIdObservable {
    
    // MARK: - Properties
    
    var schoolId: String {
        didSet {
            didSetSchool(school: schoolId)
        }
    }
    
    // MARK: - Initializer
    
    init?() {
        guard let firstRole = UserDefaultsManager.currentAccount?.roles?.first?.school else {
            NotificationCenter.default.post(name: .unauthorized, object: nil)
            print("Account has no roles")
            return nil
        }
        
        self.schoolId = UserDefaultsManager.activeSchoolId ?? firstRole
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSchool), name: .schoolChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(String(describing: self)) Deinit")
    }
    
    // MARK: - Methods
    
    func didSetSchool(school id: String) {
    }
    
    // MARK: - Actions
    
    @objc func didChangeSchool() {
        guard let firstRole = UserDefaultsManager.currentAccount?.roles?.first?.school else {
            NotificationCenter.default.post(name: .unauthorized, object: nil)
            print("Account has no roles")
            return
        }
        
        self.schoolId = UserDefaultsManager.activeSchoolId ?? firstRole
    }
}
