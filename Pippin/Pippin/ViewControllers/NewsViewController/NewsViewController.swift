//
//  NewsViewController.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol NewsViewControllerProtocol: Presentable {
    
}

class NewsViewController: UIViewController, NewsViewControllerProtocol, NetworkingFailableView {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .red
    }
    
}
