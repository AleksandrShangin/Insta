//
//  UIViewController+Extensions.swift
//  Insta
//
//  Created by Alexander Shangin on 11.10.2023.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style,
        actions: [UIAlertAction]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
