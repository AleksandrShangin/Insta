//
//  UITableView+Extensions.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cannot dequeue cell \(cell)")
        }
        return cell
    }
}
