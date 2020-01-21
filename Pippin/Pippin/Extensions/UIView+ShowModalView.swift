//
//  UIView+ShowModalView.swift
//  Pippin
//
//  Created by Will Brandin on 1/21/20.
//  Copyright © 2020 SchoolConnect. All rights reserved.
//

import UIKit

public extension UIView {
    /*!
     Presents a ModalView from the window belonging to the current view.
     The view will be presented with a bounce animation while blurring the background.
     
     allowTapOutsideToDismiss allows the user to tap outside the modal to dismiss it.
     The default is true
     */
    func showModalView(view: ModalPresentable, allowUserToDismiss: Bool = true) {
        if let window = window {
            let presenter = ModalPresenter(view: view,
                                           allowUserToDismiss: allowUserToDismiss)
            window.addSubview(presenter)
            if #available(iOS 11.0, *) {
                presenter.setMargins(top: UIApplication.shared.statusBarFrame.height,
                                     leading: 0,
                                     bottom: safeAreaInsets.bottom,
                                     trailing: 0)
            } else {
                // Fallback on earlier versions
                presenter.setMargins(top: UIApplication.shared.statusBarFrame.height,
                                     leading: 0,
                                     bottom: 0,
                                     trailing: 0)
            }
            presenter.pinToSuperview()
            
            presenter.show()
        }
    }
}
