//
//  BaseRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
