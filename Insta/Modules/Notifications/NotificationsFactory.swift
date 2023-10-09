//  
//  NotificationsFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import Foundation

final class NotificationsFactory: ModuleFactory {
    func build() -> NotificationsViewController {
//        let service = NotificationsService()
        let service = DatabaseManager()
        let viewModel = NotificationsViewModelImpl(service: service)
        let viewController = NotificationsViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
