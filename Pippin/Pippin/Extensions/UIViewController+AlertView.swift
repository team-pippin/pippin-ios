//
//  UIViewController+AlertView.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

protocol NetworkingFailableView {
    func showErrorView(error: ErrorMessageable)
}

extension NetworkingFailableView where Self: UIViewController {
    
    func showErrorView(error: ErrorMessageable) {
        let alert = AlertView(content: AlertViewContent(alert: error.message), style: .standardStyle)
        view.showModalView(view: alert, allowUserToDismiss: true)
    }
}
