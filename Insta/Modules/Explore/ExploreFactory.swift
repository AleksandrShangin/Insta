//  
//  ExploreFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation

final class ExploreFactory: ModuleFactory {
    func build() -> ExploreViewController {
        let service = DatabaseManager.shared
        let viewModel = ExploreViewModelImpl(service: service)
        let viewController = ExploreViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
