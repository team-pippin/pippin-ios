//
//  NewsListViewModel.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import Foundation

protocol NewsListViewModelProtocol: ViewModelNetworker {
    var onStateChanged: (() -> Void)? { get set }
    func requestData()
}

private typealias ArticleResult = Result<[Article], APIError>
class NewsListViewModel: SchoolIdObservableViewModel, NewsListViewModelProtocol {
    
    // MARK: - Properties
    
    var onStateChanged: (() -> Void)?
    
    private var articles: [Article] = [] {
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
        getSchoolNews { [weak self] result in
            self?.handleNewsResult(result)
        }
    }
    
    override func didSetSchool(school id: String) {
        requestData()
    }
    
    // MARK: - Private Methods
    
    private func getSchoolNews(completion: @escaping (ArticleResult) -> Void) {
        let endPoint = PippinAPI.getNews(schoolId: schoolId)
        let networkManager = NetworkManager.sharedInstance
        
        onIsLoading?(true)
        networkManager.request(for: endPoint, [Article].self, completion: completion)
    }
    
    private func handleNewsResult(_ result: ArticleResult) {
        onIsLoading?(false)
        
        switch result {
        case .success(let articles):
            self.articles = articles
            
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
