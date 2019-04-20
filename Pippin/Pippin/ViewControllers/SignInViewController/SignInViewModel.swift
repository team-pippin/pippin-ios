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
        
        let user = UserSignIn(email: email, password: password)
        requestSignInWebService(for: user)
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
    
    private func requestSignInWebService(for user: UserSignIn) {
        onIsLoading?(true)
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.signIn(user: user)
        
        networkingManager.request(for: endpoint, UserTokenResponseModel.self) { [weak self] result in
            self?.onIsLoading?(false)
            
            switch result {
            case .success(let response):
                UserDefaultsManager.signedInUserToken = response.token
                UserDefaultsManager.currentUser = response.account
                self?.onNetworkingSuccess?()
            case .error(let error):
                print(error)
                self?.onNetworkingFailed?()
            }
        }
    }
}
