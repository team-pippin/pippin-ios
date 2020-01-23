//
//  EventListViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/22/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

private typealias Table = Style.Table
private typealias EventResult = Result<[Event], APIError>

protocol EventListViewModelProtocol: ViewModelNetworker {
    var onStateChanged: (() -> Void)? { get set }
    
    var numberOfSections: Int { get }
    
    func requestData()
    func sizeForItem(in index: IndexPath) -> CGSize
    func numberOfItems(in section: Int) -> Int
    func sizeForHeader(in section: Int) -> CGSize
    func cellFor(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func didSelect(at indexPath: IndexPath)
    func minimumLine(minimumLineSpacingForSectionAt section: Int) -> CGFloat
}

class EventListViewModel: SchoolIdObservableViewModel, EventListViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChanged: (() -> Void)?
    
    var numberOfSections: Int {
        return 1
    }
    
    private var events: [Event] = [] {
        didSet {
            onStateChanged?()
        }
    }
    
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
    
    func sizeForItem(in index: IndexPath) -> CGSize {
       return CGSize(width: Style.screenWidth, height: Table.listCellHeight)
    }
    
    func numberOfItems(in section: Int) -> Int {
        return events.count
    }
    
    func sizeForHeader(in section: Int) -> CGSize {
        return CGSize(width: Style.screenWidth, height: Table.defaultSectionHeaderHeight)
    }
    
    func cellFor(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell: EventCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
        
        collectionViewCell.backgroundColor = (indexPath.row % 2 == 0) ? .red : .blue
        
        collectionViewCell.setupView()
        return collectionViewCell
    }
    
    func didSelect(at indexPath: IndexPath) {
        
    }
    
    func minimumLine(minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Style.Separator.height
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
        case .success(let events):
            self.events = [Event(id: "1234", location: "Dallas", startDate: "1231234", endDate: nil, body: "HELLO", title: "HELLO", author: "134123", school: "123451345"), Event(id: "1234", location: "Dallas", startDate: "1231234", endDate: nil, body: "HELLO", title: "HELLO", author: "134123", school: "123451345"), Event(id: "1234", location: "Dallas", startDate: "1231234", endDate: nil, body: "HELLO", title: "HELLO", author: "134123", school: "123451345"), Event(id: "1234", location: "Dallas", startDate: "1231234", endDate: nil, body: "HELLO", title: "HELLO", author: "134123", school: "123451345")]
            
        case .error(let error):
            if error == .unauthorized {
                handleUnauthorized()
            } else {
                print(error.localizedDescription)
                onNetworkingFailed?()
            }
        }
    }
}
