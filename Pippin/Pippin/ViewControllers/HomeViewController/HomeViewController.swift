//
//  HomeViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/18/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: Presentable {
    
}

class HomeViewController: UIViewController, HomeViewControllerProtocol, NetworkingFailableView {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        view.backgroundColor = .green
    }
    
}
