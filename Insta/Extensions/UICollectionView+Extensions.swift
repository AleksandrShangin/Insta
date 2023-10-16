//
//  UICollectionView+Extensions.swift
//  Insta
//
//  Created by Alexander Shangin on 15.10.2023.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cannot dequeue cell :: \(cell)")
        }
        return cell
    }
}
