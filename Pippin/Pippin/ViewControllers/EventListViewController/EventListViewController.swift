//
//  EventsViewController.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol EventListViewControllerProtocol: Presentable, LoadingView, NetworkingFailableView {
    var onSelectEvent: ((String) -> Void)? { get set }
}

class EventListViewController: UIViewController, EventListViewControllerProtocol {
    
    // MARK: - Properties
    
    var onSelectEvent: ((String) -> Void)?
    
    private var viewModel: EventListViewModelProtocol
    
    // MARK: - Initializer
    
    init(viewModel: EventListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        view.backgroundColor = .blue
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
