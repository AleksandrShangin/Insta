//  
//  LoginFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation

final class LoginFactory: ModuleFactory {
    func build() -> LoginViewController {
        let service = AuthService.shared
        let viewModel = LoginViewModelImpl(service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
