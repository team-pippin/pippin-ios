//
//  HomeViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/18/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: Presentable, LoadingView, NetworkingFailableView {
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    // MARK: - Properties
    
    private var viewModel: HomeViewModelProtocol
    
    // MARK: - Initializer
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .green
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onStateChanged = {
            // LOAD HOME
        }
        
        viewModel.onIsLoading = { [weak self] isLoading in
            self?.toggleLoadingView(isLoading)
        }
        
        viewModel.onNetworkingFailed = { [weak self] in
            self?.showErrorView(error: APIError.requestFailed)
        }
                
        viewModel.requestData()
    }
}
