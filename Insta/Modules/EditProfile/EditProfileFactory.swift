//  
//  EditProfileFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation

final class EditProfileFactory: ModuleFactory {
    func build() -> EditProfileViewController {
        let service = DatabaseService.shared
        let viewModel = EditProfileViewModelImpl(service: service)
        let viewController = EditProfileViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
