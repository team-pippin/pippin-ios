//
//  SchoolSearchViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol SchoolSearchViewModelProtocol: ViewModelNetworker {
    var onStateChange: (() -> Void)? { get set }
    var onSelectSchool: ((SchoolSearch) -> Void)? { get set }
    
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    
    func updateSearchFilter(with text: String?)
    func cellFor(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func didSelectRow(at indexPath: IndexPath)
}

private typealias SearchResult = Result<[SchoolSearch], APIError>
class SchoolSearchViewModel: SchoolSearchViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChange: (() -> Void)?
    var onSelectSchool: ((SchoolSearch) -> Void)?
    
    var numberOfRows: Int {
        return schools?.count ?? 0
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    // MARK: - Private Properties
    
    private var pendingRequestWorkItem: DispatchWorkItem?

    private var schools: [SchoolSearch]? {
        didSet {
            onStateChange?()
        }
    }
    
    private var searchTerm: String? {
        didSet {
            
            pendingRequestWorkItem?.cancel()
            
            let requestWorkItem = DispatchWorkItem { [weak self] in
                self?.requestSchools(with: self?.searchTerm?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
            }
            
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)

        }
    }
    
    // MARK: - ViewModelNetworker
    
    var onIsLoading: ((Bool) -> Void)?
    var onNetworkingSuccess: (() -> Void)?
    var onNetworkingFailed: (() -> Void)?
    
    // MARK: - Methods
    
    func requestSchools(with query: String) {
        onIsLoading?(true)
        let networkingManager = NetworkManager.sharedInstance
        networkingManager.cancelRequest()
        let endpoint = PippinAPI.searchSchools(query: query)
        
        networkingManager.request(for: endpoint, [SchoolSearch].self) { [weak self] result in
            self?.handleSearchResult(result)
        }
    }
    
    func updateSearchFilter(with text: String?) {
        if text == searchTerm {
            return
        }
        
        searchTerm = text
    }
    
    func cellFor(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: SingleLineTextTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        cell.setCellContent(schools?[indexPath.row].name ?? "")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let selected = schools?[indexPath.row] else {
            return
        }
        
        onSelectSchool?(selected)
    }
    
    // MARK: - Private Methods
    
    private func handleSearchResult(_ result: SearchResult) {
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
