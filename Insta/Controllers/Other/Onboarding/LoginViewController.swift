//
//  LoginViewController.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let loginButton = UIButton()
    private let termsButton = UIButton()
    private let privacyButton = UIButton()
    private let createAccountButton = UIButton()
    
    private let headerView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        passwordTextField.isSecureTextEntry = true
        
        addSubviews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
        
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        
    }
    
    @objc private func didTapTermsButton() {
        
    }
    
    @objc private func didTapPrivacyButton() {
        
    }
    
    @objc private func didTapCreateAccountButton() {
        
    }

}
