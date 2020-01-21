//
//  SchoolSearchViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/13/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol SchoolSearchViewControllerProtocol: Presentable {
    var onDidSelectSchool: ((SchoolSearch) -> Void)? { get set }
}

class SchoolSearchViewController: UIViewController, SchoolSearchViewControllerProtocol, LoadingView {
    
    // MARK: - Properties
    
    var onDidSelectSchool: ((SchoolSearch) -> Void)?
    
    private var searchTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Search"
        
        textField.tintColor = Style.Color.interactiveTint
        textField.textColor = Style.Color.primaryTextDark
        
        textField.lineView.isHidden = true
        
        textField.selectedTitleColor = Style.Color.interactiveTint
        
        textField.font = Style.Font.p1
        textField.titleFont = Style.Font.mini
        textField.placeholderFont = Style.Font.p1
        
        textField.addTarget(self, action: #selector(searchTextFieldTextChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var viewModel: SchoolSearchViewModelProtocol = SchoolSearchViewModel()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Find your school"
        view.backgroundColor = Style.Color.lightBackground
        
        view.addSubview(searchTextField)
        searchTextField.pinToTop()
        searchTextField.pinToLeadingAndTrailingMargins()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SingleLineTextTableViewCell.self)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinBelowView(view: searchTextField)
        tableView.pinToBottom()
        tableView.pinToLeadingAndTrailing()
        
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onStateChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onIsLoading = { [weak self] isLoading in
            self?.toggleLoadingView(isLoading)
        }
        
        viewModel.onNetworkingFailed = {
            // Show Failure
        }
        
        viewModel.requestSchools()
    }
    
    // MARK: - Actions
    
    @objc private func searchTextFieldTextChanged(_ textField: SkyFloatingLabelTextField) {
        viewModel.updateSearchFilter(with: textField.text)
    }
}

extension SchoolSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellFor(for: tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let school = viewModel.getSelectedSchool(at: indexPath) else {
            print("Could not select school with index path \(indexPath)")
            return
        }
        
        onDidSelectSchool?(school)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Style.Layout.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
