//
//  HomeViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/18/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: ViewModelNetworker {
    var onStateChanged: (() -> Void)? { get set }
    
    func requestData()
}

class HomeViewModel: SchoolIdObservableViewModel, HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChanged: (() -> Void)?
    
    private var dispatchGroup = DispatchGroup()
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - Methods
    
    func requestData() {
        onIsLoading?(true)
        
        getSchool()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.onIsLoading?(false)
            self?.onStateChanged?()
        }
    }
    
    override func didSetSchool(school id: String) {
        requestData()
    }
    
    // MARK: - Private Methods
    
    private func getSchool() {
        let endPoint = PippinAPI.getSchool(schoolId: schoolId)
        let networkManager = NetworkManager.sharedInstance
        
        dispatchGroup.enter()
        networkManager.request(for: endPoint, School.self) { [weak self] (result) in
            
            switch result {
            case .success(let school):
                print(school)
                
            case .error:
                self?.onNetworkingFailed?()
            }
            
            self?.dispatchGroup.leave()
        }
    }
    
    private func getSchoolLinks() {
    }
}
