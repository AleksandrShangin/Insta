//
//  LoginViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private var usernameEmailField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
    private var termsButton: UIButton!
    private var privacyButton: UIButton!
    private var createAccountButton: UIButton!
    private var headerView: UIView!
    
    private let viewModel: LoginViewModel
    
    private var router: LoginRouter!
    
    // MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = LoginView()
        self.usernameEmailField = view.usernameEmailField
        self.passwordTextField = view.passwordTextField
        self.loginButton = view.loginButton
        self.termsButton = view.termsButton
        self.privacyButton = view.privacyButton
        self.createAccountButton = view.createAccountButton
        self.headerView = view.headerView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRouter()
        configureViews()
        
    }
    
    private func configureRouter() {
        router = LoginRouter(viewController: self)
    }
    
    private func configureViews() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        usernameEmailField.delegate = self
        passwordTextField.delegate = self
    }
        
    // MARK: - Actions
    
    @objc
    private func didTapLoginButton() {
        passwordTextField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
            return
        }
        var username: String?
        var email: String?
        // login functionality
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            // username
            username = usernameEmail
        }
        AuthService.shared.loginUser(username: username, email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error occured
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc
    private func didTapTermsButton() {
        self.router.showTerms()
    }
    
    @objc private func didTapPrivacyButton() {
        self.router.showPolicy()
    }
    
    @objc
    private func didTapCreateAccountButton() {
        self.router.showRegistration()
    }

}

// MARK: - Extension for TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
    
}
