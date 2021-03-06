//
//  SignUpViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

enum SignUpTextField {
    case name
    case email
    case password
}

protocol SignUpViewModelProtocol: ViewModelNetworker {
    func requestSignUp()
    func updateValue(with textFieldType: SignUpTextField, text: String?)
}

class SignUpViewModel: SignUpViewModelProtocol {
    
    // MARK: - Properties
    
    private var name: String?
    private var email: String?
    private var password: String?
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - SignUpViewModelProtocol
    
    func requestSignUp() {
        guard let name = name,
            let email = email,
            let password = password else {
            onNetworkingFailed?()
            return
        }
        
        let newAccount = AccountSignUp(name: name,
                              email: email,
                              password: password)
        requestSignUpWebService(for: newAccount)
    }
    
    func updateValue(with textFieldType: SignUpTextField, text: String?) {
        switch textFieldType {
        case .name:
            name = text
        case .email:
            email = text
        case .password:
            password = text
        }
    }
    
    // MARK: - Private Methods
    
    private func requestSignUpWebService(for newAccount: AccountSignUp) {
        onIsLoading?(true)
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.signUp(account: newAccount)
        
        networkingManager.request(for: endpoint, SignInResponse.self) { [weak self] result in
            self?.onIsLoading?(false)
            
            switch result {
            case .success(let response):
                UserDefaultsManager.signedInAccountToken = response.token
                UserDefaultsManager.currentAccount = response.account
                self?.onNetworkingSuccess?()
            case .error(let error):
                print(error)
                self?.onNetworkingFailed?()
            }
        }
    }
}
