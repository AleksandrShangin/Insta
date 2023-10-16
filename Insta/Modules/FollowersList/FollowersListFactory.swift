//  
//  FollowersListFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation

final class FollowersListFactory: ModuleFactory {
    let data: [UserRelationship]
    
    init(data: [UserRelationship]) {
        self.data = data
    }
    
    func build() -> FollowersListViewController {
        let service = DatabaseService.shared
        let viewModel = FollowersListViewModelImpl(data: data, service: service)
        let viewController = FollowersListViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
