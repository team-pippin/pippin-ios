//
//  AccountSchoolViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol AccountSchoolViewModelProtocol: SchoolSearchViewModelProtocol {
    func requestSchools()
}

private typealias SearchResult = Result<[SchoolSearch], APIError>
class AccountSchoolViewModel: AccountSchoolViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChange: (() -> Void)?
    var onSelectSchool: ((SchoolSearch) -> Void)?
    
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
            self?.handleSchoolResult(result)
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
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let selected = filteredSchools?[indexPath.row] else {
            return
        }
        
        UserDefaultsManager.activeSchoolId = selected.id
        onSelectSchool?(selected)
    }
    
    // MARK: - Private Methods
    
    private func handleSchoolResult(_ result: SearchResult) {
        onIsLoading?(false)
        
        switch result {
        case .success(let schools):
            self.schools = schools
            onNetworkingSuccess?()
            
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
