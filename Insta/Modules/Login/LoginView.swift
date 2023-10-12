//  
//  LoginView.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import UIKit

final class LoginView: UIView {
    
    //MARK: - Properties
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - UI
    
    var usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    var passwordTextField: UITextField = {
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
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    var privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.layer.masksToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    var headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
//        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Setup
    
    private func setupSubviews() {
        backgroundColor = .systemBackground
        
        addSubview(usernameEmailField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(termsButton)
        addSubview(privacyButton)
        addSubview(createAccountButton)
        addSubview(headerView)
    }
    
    private func setupConstraints() {
        // asign frames
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: width,
            height: height/3.0
        )
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom+40,
            width: width-50,
            height: 52
        )
        passwordTextField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom+10,
            width: width-50,
            height: 52
        )
        loginButton.frame = CGRect(
            x: 25,
            y: passwordTextField.bottom+10,
            width: width-50,
            height: 52
        )
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom+10,
            width: width-50,
            height: 52
        )
        termsButton.frame = CGRect(
            x: 10,
            y: height-safeAreaInsets.bottom-100,
            width: width-20,
            height: 50
        )
        privacyButton.frame = CGRect(
            x: 10,
            y: height-safeAreaInsets.bottom-50,
            width: width-20,
            height: 50
        )
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        // Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: headerView.width/4,
            y: safeAreaInsets.top,
            width: headerView.width/2.0,
            height: headerView.height - safeAreaInsets.top
        )
    }
    
}



