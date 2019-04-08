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

protocol SignUpViewModelProtocol: ViewModelNetworker {
    func requestSignUp()
    func updateValue(with textFieldType: SignUpTextField, text: String?)
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    // MARK: - Properties
    
    private var firstName: String?
    private var lastName: String?
    private var email: String?
    private var password: String?
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - SignUpViewModelProtocol
    
    func requestSignUp() {
        guard let first = firstName,
            let last = lastName,
            let email = email,
            let password = password else {
            onNetworkingFailed?()
            return
        }
        
        let newUser = UserSignUp(firstName: first,
                              lastName: last,
                              email: email,
                              password: password)
        requestSignUpWebService(for: newUser)
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
    
    private func requestSignUpWebService(for newUser: UserSignUp) {
        onIsLoading?(true)
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.signUp(user: newUser)
        
        networkingManager.request(for: endpoint, UserTokenResponseModel.self) { [weak self] result in
            self?.onIsLoading?(false)
            
            switch result {
            case .success(let response):
                UserDefaultsManager.signedInUserToken = response.token
                self?.onNetworkingSuccess?()
            case .error(let error):
                print(error)
                self?.onNetworkingFailed?()
            }
        }
    }
}
