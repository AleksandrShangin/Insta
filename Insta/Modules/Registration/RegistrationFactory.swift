//  
//  RegistrationFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation

final class RegistrationFactory: ModuleFactory {
    func build() -> RegistrationViewController {
        let service = AuthManager.shared
        let viewModel = RegistrationViewModelImpl(service: service)
        let viewController = RegistrationViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
