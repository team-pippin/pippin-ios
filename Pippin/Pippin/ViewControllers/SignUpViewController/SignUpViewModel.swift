//
//  SignUpViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol SignUpViewModelProtocol: class {
    var onIsLoading: ((Bool) -> Void)? { get set }
    var onNetworkingFailed: (() -> Void)? { get set }
    var onSignUpSuccess: (() -> Void)? { get set }
    
    func requestSignUp()
    func updateFirstName(with string: String?)
    func updateLastName(with string: String?)
    func updateEmail(with string: String?)
    func updatePassword(with string: String?)
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    // MARK: - Properties
    
    private var firstName: String?
    private var lastName: String?
    private var email: String?
    private var password: String?
    
    // MARK: - SignUpViewModelProtocol
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onSignUpSuccess: (() -> Void)?
    
    // MARK: - Methods
    
    func requestSignUp() {
        guard let first = firstName,
            let last = lastName,
            let email = email,
            let password = password else {
                onNetworkingFailed?()
            return
        }
        
        let newUser = NewUser(firstName: first,
                              lastName: last,
                              email: email,
                              password: password)
        // TODO: - Request Sign up with new user.
        onSignUpSuccess?()
    }
    
    func updateFirstName(with string: String?) {
        firstName = string
    }
    
    func updateLastName(with string: String?) {
        lastName = string
    }
    
    func updateEmail(with string: String?) {
        email = string
    }
    
    func updatePassword(with string: String?) {
        password = string
    }
}
