//
//  ConfirmSubscribeViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/14/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol ConfirmSubscribeViewControllerProtocol: Presentable {
    var onDidSubscribeToSchool: (() -> Void)? { get set }
}

class ConfirmSubscribeViewController: UIViewController, ConfirmSubscribeViewControllerProtocol, LoadingView {
    
    // MARK: - ConfirmSubscribeViewControllerProtocol
    
    var onDidSubscribeToSchool: (() -> Void)?
    
    // MARK: - Properties
    
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    
    private lazy var subscribeButton: CustomButton = {
        let buttonContent = CustomButtonContent(title: "Subscribe")
        let button = CustomButton(content: buttonContent)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.actionHandler = { [weak self] in
            self?.viewModel.requestSubscribe()
        }
        
        return button
    }()
    
    private var viewModel: ConfirmSubscribeViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: ConfirmSubscribeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Color.lightBackground
        view.setMargins(top: Style.Layout.marginXL,
                        leading: Style.Layout.marginXL,
                        bottom: Style.Layout.marginXL,
                        trailing: Style.Layout.marginXL)
        
        title = "Subscribe"
        
        view.addSubview(subscribeButton)
        subscribeButton.pinToBottomMargin()
        subscribeButton.pinToLeadingAndTrailingMargins()
        
        subtitleLabel.font = Style.Font.p1
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = Style.Color.secondaryTextDark
        subtitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.;l"
        
        view.addSubview(subtitleLabel)
        subtitleLabel.pinAboveView(view: subscribeButton, constant: Style.Layout.marginXL * 4)
        subtitleLabel.pinToLeadingAndTrailingMargins()
        
        titleLabel.font = Style.Font.h2
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Style.Color.primaryTextDark
        titleLabel.text = viewModel.schoolName
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinAboveView(view: subtitleLabel, constant: Style.Layout.innerSpacing)
        titleLabel.pinToLeadingAndTrailingMargins()
        
        subscribeToViewModel()
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onIsLoading = { isLoading in
            self.toggleLoadingView(isLoading)
        }
        
        viewModel.onNetworkingFailed = {
//            AnimatedLoader.showFailureHud()
        }
        
        viewModel.onNetworkingSuccess = { [weak self] in
            self?.onDidSubscribeToSchool?()
        }
    }
}
