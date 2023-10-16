//  
//  ProfileFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import Foundation

final class ProfileFactory: ModuleFactory {
    func build() -> ProfileViewController {
        let service = DatabaseService.shared
        let viewModel = ProfileViewModelImpl(service: service)
        let viewController = ProfileViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
