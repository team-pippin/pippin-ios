//
//  SignInViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol SignInViewModelProtocol: ViewModelNetworker {
    func requestSignIn()
    func updateValue(with textFieldType: SignUpTextField, text: String?)
}

class SignInViewModel: SignInViewModelProtocol {
    
    // MARK: - Properties
    
    private var email: String?
    private var password: String?
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    var onNetworkingFailed: (() -> Void)?
    
    // MARK: - SignInViewModelProtocol
    
    func requestSignIn() {
        guard let email = email, let password = password else {
            onNetworkingFailed?()
            return
        }
        
        let account = SignInRequest(email: email, password: password)
        requestSignInWebService(for: account)
    }
    
    func updateValue(with textFieldType: SignUpTextField, text: String?) {
        switch textFieldType {
        case .email:
            email = text
        case .password:
            password = text
        default:
            return
        }
    }
    
    // MARK: - Private Methods
    
    private func requestSignInWebService(for account: SignInRequest) {
        onIsLoading?(true)
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.signIn(account: account)
        
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
