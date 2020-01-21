//
//  AccountSchoolViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

class AccountSchoolViewModel: SchoolSearchViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChange: (() -> Void)?
    
    var numberOfRows: Int {
        return filteredSchools?.count ?? 0
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    private var schools: [SchoolSearch]? {
        didSet {
            onStateChange?()
        }
    }
    
    private var filteredSchools: [SchoolSearch]? {
        if let filter = textFilter, !filter.isEmpty {
            return schools?.filter({ $0.name.contains(filter) }).sorted(by: { $0.name < $1.name })
        } else {
            return schools
        }
    }
    
    private var textFilter: String? {
        didSet {
            onStateChange?()
        }
    }
    
    // mutable data source that when changed, table view is refreshed.
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    var onNetworkingFailed: (() -> Void)?
    
    // MARK: - Methods
    
    func requestSchools() {
        onIsLoading?(true)
        
        guard let accountId = UserDefaultsManager.currentAccount?.id else {
            return
        }
        
        let networkingManager = NetworkManager.sharedInstance
        let endpoint = PippinAPI.getAccountSchools(accountId: accountId)
        
        networkingManager.request(for: endpoint, [SchoolSearch].self) { [weak self] result in
            self?.onIsLoading?(false)
            
            switch result {
            case .success(let response):
                self?.schools = response
                self?.onNetworkingSuccess?()
            case .error(let error):
                if error == .unauthorized {
                    self?.handleUnauthorized()
                } else {
                    print(error.localizedDescription)
                    self?.onNetworkingFailed?()
                }
            }
        }
    }
    
    func updateSearchFilter(with text: String?) {
        textFilter = text
    }
    
    func cellFor(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: SingleLineTextTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        cell.setCellContent(filteredSchools?[indexPath.row].name ?? "")
        return cell
    }
    
    func getSelectedSchool(at indexPath: IndexPath) -> SchoolSearch? {
        return filteredSchools?[indexPath.row]
    }
}
