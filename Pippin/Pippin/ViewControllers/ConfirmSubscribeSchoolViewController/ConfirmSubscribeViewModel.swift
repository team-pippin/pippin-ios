//
//  ConfirmSubscribeViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/14/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol ConfirmSubscribeViewModelProtocol: ViewModelNetworker {
    var schoolName: String { get }
    
    func requestSubscribe()
}

class ConfirmSubscribeViewModel: ConfirmSubscribeViewModelProtocol {
    
    // MARK: - Properties
    
    var schoolSearched: SchoolSearch
    
    var schoolName: String {
        return schoolSearched.name
    }
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - Init
    
    init(school: SchoolSearch) {
        self.schoolSearched = school
    }
    
    // MARK: - Methods
    
    func requestSubscribe() {
        subscribeTo(school: schoolSearched)
    }
    
    // MARK: - Private Methods
    
    private func subscribeTo(school: SchoolSearch) {
        onIsLoading?(true)
        let model = SchoolSubscription(schools: [school.id])
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.subscribeToSchool(accountId: UserDefaultsManager.currentAccount?.id ?? "", schools: model)
        
        networkingManager.request(for: endpoint, Account.self) { [weak self] result in
            self?.onIsLoading?(false)
            
            switch result {
            case .success(let account):
                UserDefaultsManager.currentAccount = account
                self?.onNetworkingSuccess?()
                
            case .error(let error):
                if error == .unauthorized {
                    self?.handleUnauthorized()
                }
                
                print(error.localizedDescription)
                self?.onNetworkingFailed?()
            }
        }
    }
}
