//
//  LandingViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/1/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol LandingViewControllerProtocol: Presentable {
    var onDidTapLogin: (() -> Void)? { get set }
    var onDidTapSignUp: (() -> Void)? { get set }
}

class LandingViewController: UIViewController, LandingViewControllerProtocol {
    
    // MARK: - LandingViewControllerProtocol
    
    var onDidTapLogin: (() -> Void)?
    var onDidTapSignUp: (() -> Void)?
    
    // MARK: - Properties
    
    private var titleText: String {
        return "Welcome to Pippin!"
    }
    
    private var subtitleText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
    }
    
    private var landingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "landingPageIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = Style.Font.h2
        title.textColor = Style.Color.primaryTextDark
        title.textAlignment = .center
        title.text = titleText
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subTitle = UILabel()
        subTitle.font = Style.Font.p1
        subTitle.textColor = Style.Color.secondaryTextLight
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
        subTitle.text = subtitleText
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    
    private lazy var signUpButton: CustomButton = {
        let buttonContent = CustomButtonContent(title: "Sign Up")
        let button = CustomButton(content: buttonContent)
        button.actionHandler = onDidTapSignUp
        return button
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Color.lightBackground
        addRightNavigationLink(title: "Login", target: self, action: #selector(handleLoginTap))
        
        view.setMargins(top: Style.Layout.marginXL,
                        leading: Style.Layout.marginXL,
                        bottom: Style.Layout.marginXL,
                        trailing: Style.Layout.marginXL)
        
        view.addSubview(signUpButton)
        signUpButton.pinToLeadingAndTrailingMargins()
        signUpButton.pinToBottomMargin()
        
        view.addSubview(subtitleLabel)
        subtitleLabel.pinToLeadingAndTrailingMargins()
        subtitleLabel.pinAboveView(view: signUpButton, constant: Style.Layout.marginXL)
        
        view.addSubview(titleLabel)
        titleLabel.pinToLeadingAndTrailingMargins()
        titleLabel.pinAboveView(view: subtitleLabel, constant: Style.Layout.marginXL)
        
        view.addSubview(landingImageView)
        landingImageView.pinToTopMargin()
        landingImageView.pinToLeadingAndTrailingMargins()
        landingImageView.pinAboveView(view: titleLabel, constant: Style.Layout.marginXL)
        
        landingImageView.layer.cornerRadius = 25
        landingImageView.clipsToBounds = true
    }
    
    // MARK: - Private Methods
    
    @objc private func handleLoginTap() {
        onDidTapLogin?()
    }
}
