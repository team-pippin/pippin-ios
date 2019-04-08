//
//  SignUpViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

enum SignUpTextField {
    case firstName
    case lastName
    case email
    case password
}

protocol SignUpViewModelProtocol: class {
    var onIsLoading: ((Bool) -> Void)? { get set }
    var onNetworkingFailed: (() -> Void)? { get set }
    var onSignUpSuccess: (() -> Void)? { get set }
    
    func requestSignUp()
    func updateValue(with textFieldType: SignUpTextField, text: String?)
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
        guard let first = firstName, let last = lastName, let email = email, let password = password else {
            onNetworkingFailed?()
            return
        }
        
        let newUser = NewUser(firstName: first,
                              lastName: last,
                              email: email,
                              password: password)
        requestSignUpWebService(for: newUser)
        // TODO: - Request Sign up with new user.
        onSignUpSuccess?()
    }
    
    func updateValue(with textFieldType: SignUpTextField, text: String?) {
        switch textFieldType {
        case .firstName:
            firstName = text
        case .lastName:
            lastName = text
        case .email:
            email = text
        case .password:
            password = text
        }
    }
    
    // MARK: - Private Methods
    
    private func requestSignUpWebService(for newUser: NewUser) {
        
    }
}
