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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .red
    }
    
}
