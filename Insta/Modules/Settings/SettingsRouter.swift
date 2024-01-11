//  
//  SettingsRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import UIKit
import SafariServices

final class SettingsRouter: BaseRouter {
    func showEditProfile() {
        let vc = EditProfileFactory().build()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        viewController?.present(navVC, animated: true, completion: nil)
    }
    
    func showLogin() {
        let loginVC = LoginFactory().build()
        loginVC.modalPresentationStyle = .fullScreen
        viewController?.present(loginVC, animated: true) { [weak self] in
            self?.viewController?.navigationController?.popToRootViewController(animated: false)
            self?.viewController?.tabBarController?.selectedIndex = 0
        }
    }
    
    func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875"
        case .help:
            urlString = "https://help.instagram.com"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
