//
//  SignInViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/8/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

protocol SignInViewControllerProtocol: Presentable {
    var onSignInSuccessful: (() -> Void)? { get set }
}

class SignInViewController: UIViewController, SignInViewControllerProtocol {
    
    // MARK: - Properties
    
    private var emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "E-Mail"
        textField.placeholder = "E-Mail"
        textField.keyboardType = .emailAddress
        
        textField.tintColor = Style.Color.interactiveTint
        textField.textColor = Style.Color.primaryTextDark
        
        textField.lineView.isHidden = true
        
        textField.selectedTitleColor = Style.Color.interactiveTint
        
        textField.font = Style.Font.p1
        textField.titleFont = Style.Font.mini
        textField.placeholderFont = Style.Font.p1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "Password"
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        
        textField.tintColor = Style.Color.interactiveTint
        textField.textColor = Style.Color.primaryTextDark
        
        textField.lineView.isHidden = true
        
        textField.selectedTitleColor = Style.Color.interactiveTint
        
        textField.font = Style.Font.p1
        textField.titleFont = Style.Font.mini
        textField.placeholderFont = Style.Font.p1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var submitButton: CustomButton = {
        let buttonContent = CustomButtonContent(title: "Login")
        let button = CustomButton(content: buttonContent, style: CustomButtonStyle.formDefaultPrimary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.actionHandler = { [weak self] in
            self?.view.endEditing(true)
            self?.viewModel.requestSignIn()
        }
        return button
    }()
    
    private var viewModel: SignInViewModelProtocol = SignInViewModel()
    private var submitButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - SignInViewControllerProtocol
    
    var onSignInSuccessful: (() -> Void)?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Color.lightBackground
        title = "Sign In"
        
        let cardView = UIView()
        cardView.backgroundColor = Style.Color.lightBackground
        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = false
        
        let cardShadow = LayerShadow(shadowColor: Style.Color.darkBackground,
                                     shadowOpacity: 0.15,
                                     shadowRadius: 10,
                                     shadowOffset: CGSize(width: 1, height: 10))
        cardView.setShadow(shadow: cardShadow)
        view.addSubview(cardView)
        
        cardView.pinToLeadingAndTrailingMargins()
        cardView.pinToTopMargin(constant: Style.Layout.margin)
        
        let textFieldStackView = UIStackView()
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = Style.Layout.margin
        
        cardView.addSubview(textFieldStackView)
        textFieldStackView.pinToMargins()

        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldNameChanged(_:)), for: .editingChanged)
        
        let signInLabel = UILabel()
        view.addSubview(signInLabel)
        signInLabel.pinBelowView(view: cardView, constant: Style.Layout.margin)
        signInLabel.pinToLeadingAndTrailingMargins()
        signInLabel.text = "Don't have an account? SIGN UP"
        signInLabel.textAlignment = .center
        signInLabel.font = Style.Font.miniBold
        signInLabel.textColor = Style.Color.secondaryTextLight
        
        view.addSubview(submitButton)
        
        submitButtonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 58)
        submitButtonBottomConstraint?.isActive = true
        submitButton.pinToLeadingAndTrailing()
        submitButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        subscribeToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onIsLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.submitButton.isLoading = isLoading
                self?.submitButton.isUserInteractionEnabled = !isLoading
                self?.view.isUserInteractionEnabled = !isLoading
                
                if isLoading {
                    AnimatedLoader.showProgressHud()
                } else {
                    AnimatedLoader.hideProgressHud()
                }
            }
        }
        
        viewModel.onNetworkingFailed = {
            AnimatedLoader.showFailureHud()
        }
        
        viewModel.onNetworkingSuccess = onSignInSuccessful
    }
    
    @objc private func emailTextFieldChanged(_ textField: SkyFloatingLabelTextField) {
        viewModel.updateValue(with: .email, text: textField.text)
    }
    
    @objc private func passwordTextFieldNameChanged(_ textField: SkyFloatingLabelTextField) {
        viewModel.updateValue(with: .password, text: textField.text)
    }
    
    // MARK: - Keyboard Notifications
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, submitButtonBottomConstraint?.constant == submitButton.height {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
                self.submitButtonBottomConstraint?.constant -= keyboardSize.height + submitButton.height
                
                UIView.animate(withDuration: duration.doubleValue, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(curve))], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.submitButtonBottomConstraint?.constant = 58
        
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int {
            UIView.animate(withDuration: duration.doubleValue, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(curve))], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
