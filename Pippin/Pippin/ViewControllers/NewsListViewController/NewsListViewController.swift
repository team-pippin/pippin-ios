//
//  NewsListViewController.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol NewsListViewControllerProtocol: Presentable, LoadingView, NetworkingFailableView {
    var onSelectArticle: ((String) -> Void)? { get set }
}

class NewsListViewController: UIViewController, NewsListViewControllerProtocol {
    
    // MARK: - Properties
    
    var onSelectArticle: ((String) -> Void)?
    
    private var viewModel: NewsListViewModelProtocol
    
    // MARK: - Initializer
    
    init(viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .red
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
