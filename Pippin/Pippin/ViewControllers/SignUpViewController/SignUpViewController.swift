//
//  SignUpViewController.swift
//  Pippin
//
//  Created by Will Brandin on 4/7/19.
//  Copyright © 2019 SchoolConnect. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProtocol: Presentable {
    var onSignUpSuccessful: (() -> Void)? { get set }
}

class SignUpViewController: UIViewController, SignUpViewControllerProtocol {
    
    // MARK: - Properties
    
    private var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var submitButton: CustomButton = {
        let buttonContent = CustomButtonContent(title: "Submit")
        let button = CustomButton(content: buttonContent, style: CustomButtonStyle.formDefaultPrimary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.actionHandler = { [weak self] in
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
        
        firstNameTextField.addTarget(self, action: #selector(firstNameTextFieldChanged(_:)), for: .editingChanged)
        view.addSubview(firstNameTextField)
        firstNameTextField.pinToTopMargin(constant: Style.Layout.margin)
        firstNameTextField.pinToLeadingAndTrailingMargins()
        firstNameTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        lastNameTextField.addTarget(self, action: #selector(lastNameTextFieldChanged(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldNameChanged(_:)), for: .editingChanged)
        
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
            self?.submitButton.isLoading = isLoading
            self?.submitButton.isUserInteractionEnabled = !isLoading
        }
        
        viewModel.onNetworkingFailed = {
            print("Networking error")
        }
        
        viewModel.onSignUpSuccess = onSignUpSuccessful
    }
    
    @objc private func firstNameTextFieldChanged(_ textField: UITextField) {
        viewModel.updateFirstName(with: textField.text)
    }
    
    @objc private func lastNameTextFieldChanged(_ textField: UITextField) {
        viewModel.updateLastName(with: textField.text)
    }
    
    @objc private func emailTextFieldChanged(_ textField: UITextField) {
        viewModel.updateEmail(with: textField.text)
    }
    
    @objc private func passwordTextFieldNameChanged(_ textField: UITextField) {
        viewModel.updatePassword(with: textField.text)
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
