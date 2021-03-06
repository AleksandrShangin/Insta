//
//  RegistrationViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import ColorCompatibility



class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }

    // MARK: - UI
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = ColorCompatibility.secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = ColorCompatibility.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = ColorCompatibility.secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = ColorCompatibility.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.isSecureTextEntry = true
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = ColorCompatibility.secondarySystemBackground
        field.layer.borderWidth = 1.0
        
        field.layer.borderColor = ColorCompatibility.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCompatibility.systemBackground
        
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordTextField.delegate = self
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordTextField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordTextField.bottom+10, width: view.width-40, height: 52)
    }
    
    
    // MARK: - Actions
    
    @objc private func didTapRegisterButton() {
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





