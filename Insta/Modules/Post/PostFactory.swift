//  
//  PostFactory.swift
//  Insta
//
//  Created by Alexander Shangin on 10.10.2023.
//

import Foundation

final class PostFactory: ModuleFactory {
    let post: UserPost
    
    init(post: UserPost) {
        self.post = post
    }
    
    func build() -> PostViewController {
        let service = DatabaseService.shared
        let viewModel = PostViewModelImpl(post: self.post, service: service)
        let viewController = PostViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
