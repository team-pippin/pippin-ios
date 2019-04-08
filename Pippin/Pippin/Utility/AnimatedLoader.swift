//
//  AnimatedLoader.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit
import SVProgressHUD

class AnimatedLoader {
    class func showProgressHud(title: String? = nil) {
        DispatchQueue.main.async {
            SVProgressHUD.setRingThickness(4)
            SVProgressHUD.show(withStatus: title)
        }
    }
    
    class func hideProgressHud() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    class func showInfo(message: String = "") {
        DispatchQueue.main.async {
            SVProgressHUD.showInfo(withStatus: message)
        }
    }
    
    class func showSuccessHud(message: String = "Success!") {
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: message)
        }
    }
    
    class func showFailureHud(message: String = "Failed!") {
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: message)
        }
    }
}
