//
//  EventListViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

protocol EventListViewModelProtocol: ViewModelNetworker {
    var onStateChanged: (() -> Void)? { get set }
    
    func requestData()
}

private typealias EventResult = Result<[Event], APIError>
class EventListViewModel: SchoolIdObservableViewModel, EventListViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChanged: (() -> Void)?
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingFailed: (() -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    
    // MARK: - Methods
    
    func requestData() {
        getSchoolEvents { [weak self] result in
            self?.handleEventResult(result)
        }
    }
    
    override func didSetSchool(school id: String) {
        requestData()
    }
    
    // MARK: - Private Methods
    
    private func getSchoolEvents(completion: @escaping (EventResult) -> Void) {
        let endPoint = PippinAPI.getEvents(schoolId: schoolId)
        let networkManager = NetworkManager.sharedInstance
        
        onIsLoading?(true)
        networkManager.request(for: endPoint, [Event].self, completion: completion)
    }
    
    private func handleEventResult(_ result: EventResult) {
        onIsLoading?(false)
        
        switch result {
        case .success(let articles):
            print(articles)
            onStateChanged?()
            
        case .error:
            onNetworkingFailed?()
        }
    }
}
