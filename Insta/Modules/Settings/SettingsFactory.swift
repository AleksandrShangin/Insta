//  
//  SettingsFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation

final class SettingsFactory: ModuleFactory {
    func build() -> SettingsViewController {
        let service = AuthService.shared
        let viewModel = SettingsViewModelImpl(service: service)
        let viewController = SettingsViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
