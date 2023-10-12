//  
//  LoginRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import UIKit
import SafariServices

final class LoginRouter: BaseRouter {
    func showRegistration() {
        let vc = RegistrationFactory().build()
        vc.title = "Create Account"
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func showTerms() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        viewController.present(vc, animated: true)
    }
    
    func showPolicy() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        viewController.present(vc, animated: true)
    }
}
