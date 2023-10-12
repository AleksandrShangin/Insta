//
//  RegistrationViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var usernameField: UITextField!
    private var emailField: UITextField!
    private var passwordTextField: UITextField!
    private var registerButton: UIButton!
    
    private let viewModel: RegistrationViewModel
    
    private var router: RegistrationRouter!
    
    // MARK: - Init
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = RegistrationView()
        self.view = view
        self.usernameField = view.usernameField
        self.emailField = view.emailField
        self.passwordTextField = view.passwordTextField
        self.registerButton = view.registerButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureViews()
        configureBindings()
    }
    
    // MARK: - Configure
    
    private func configureRouter() {
        router = RegistrationRouter(viewController: self)
    }
    
    private func configureViews() {
        usernameField.delegate = self
        emailField.delegate = self
        passwordTextField.delegate = self
        registerButton.addTarget(
            self,
            action: #selector(didTapRegisterButton),
            for: .touchUpInside
        )
    }
    
    private func configureBindings() {
        
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapRegisterButton() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
                return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { (registered) in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                } else {
                    // failed
                }
            }
        }
    }
    
}

// MARK: - Extension for TextField Delegate

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordTextField.becomeFirstResponder()
        } else {
            didTapRegisterButton()
        }
        return true
    }
    
}





