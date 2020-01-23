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

private typealias SchoolResult = Result<School, APIError>
class HomeViewModel: SchoolIdObservableViewModel, HomeViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChanged: (() -> Void)?
    
    private var school: School?
    private var dispatchGroup = DispatchGroup()
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - Methods
    
    func requestData() {
        onIsLoading?(true)
        
        getSchool { [weak self] result in
            self?.handleSchoolResult(result)
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.onIsLoading?(false)
            self?.onStateChanged?()
        }
    }
    
    override func didSetSchool(school id: String) {
        requestData()
    }
    
    // MARK: - Private Methods
    
    private func getSchool(completion: @escaping (SchoolResult) -> Void) {
        let endPoint = PippinAPI.getSchool(schoolId: schoolId)
        let networkManager = NetworkManager.sharedInstance
        
        dispatchGroup.enter()
        networkManager.request(for: endPoint, School.self, completion: completion)
    }
    
    private func handleSchoolResult(_ result: SchoolResult) {
        switch result {
        case .success(let school):
            self.school = school
            
        case .error(let error):
            if error == .unauthorized {
                handleUnauthorized()
            } else {
                print(error.localizedDescription)
                onNetworkingFailed?()
            }
        }
        
        dispatchGroup.leave()
    }
    
    private func getSchoolLinks() {
    }
}
