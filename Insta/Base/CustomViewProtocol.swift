//
//  CustomViewProtocol.swift
//  Insta
//
//  Created by Alexander Shangin on 18.01.2024.
//

import UIKit

protocol CustomViewProtocol {
    associatedtype RootView: UIView
}

extension CustomViewProtocol where Self: UIViewController {
    var customView: RootView { view as! RootView }
}
