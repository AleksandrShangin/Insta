//  
//  HomeFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation

final class HomeFactory: ModuleFactory {
    func build() -> HomeViewController {
        let service = DatabaseManager()
        let viewModel = HomeViewModelImpl(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
