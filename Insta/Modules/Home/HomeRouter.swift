//  
//  HomeRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation

final class HomeRouter: BaseRouter {
    func showLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        viewController.present(loginVC, animated: false, completion: nil)
    }
}
