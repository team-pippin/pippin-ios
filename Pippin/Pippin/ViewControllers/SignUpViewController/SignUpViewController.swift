//
//  SignUpViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol SignUpViewControllerProtocol: Presentable {
    var onSignUpSuccessful: (() -> Void)? { get set }
}

class SignUpViewController: UIViewController, SignUpViewControllerProtocol, LoadingView, NetworkingFailableView {
    
    // MARK: - Properties
    
    private var nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "Name"
        textField.placeholder = "Name"
        
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
        let buttonContent = CustomButtonContent(title: "Sign Up")
        let button = CustomButton(content: buttonContent, style: CustomButtonStyle.formDefaultPrimary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.actionHandler = { [weak self] in
            self?.view.endEditing(true)
            self?.viewModel.requestSignUp()
        }
        return button
    }()
    
    private var viewModel: SignUpViewModelProtocol = SignUpViewModel()
    private var submitButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - SignUpViewControllerProtocol
    
    var onSignUpSuccessful: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Color.lightBackground
        title = "Sign Up"
        
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
        
        textFieldStackView.addArrangedSubview(nameTextField)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        nameTextField.addTarget(self, action: #selector(firstNameTextFieldChanged(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldNameChanged(_:)), for: .editingChanged)
        
        let signUpLabel = UILabel()
        view.addSubview(signUpLabel)
        signUpLabel.pinBelowView(view: cardView, constant: Style.Layout.margin)
        signUpLabel.pinToLeadingAndTrailingMargins()
        signUpLabel.text = "Already a account? SIGN IN"
        signUpLabel.textAlignment = .center
        signUpLabel.font = Style.Font.miniBold
        signUpLabel.textColor = Style.Color.secondaryTextLight
        
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
                self?.toggleLoadingView(isLoading)
            }
        }
        
        viewModel.onNetworkingFailed = { [weak self] in
            self?.showErrorView(error: APIError.requestFailed)
        }
        
        viewModel.onNetworkingSuccess = onSignUpSuccessful
    }
    
    @objc private func firstNameTextFieldChanged(_ textField: SkyFloatingLabelTextField) {
        viewModel.updateValue(with: .name, text: textField.text)
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
