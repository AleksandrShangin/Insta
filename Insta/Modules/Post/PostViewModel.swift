//  
//  PostViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 10.10.2023.
//

import Foundation
import Combine

protocol PostViewModel {
    var userPost: UserPost { get }
    var renderModels: [PostRenderViewModel] { get set }
    
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class PostViewModelImpl: PostViewModel {
    
    //MARK: - Public Properties
    
    var userPost: UserPost
    
    var renderModels = [PostRenderViewModel]()
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: DatabaseManager
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(
        post: UserPost,
        service: DatabaseManager
    ) {
        self.userPost = post
        self.service = service
        configureModels()
    }
    
    //MARK: - Public Methods
        
    
    
    //MARK: - Private Methods
    
    private func configureModels() {
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPost.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(content: userPost)))
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // 4 Comments
        var comments = [PostComment]()
        for x in 1...4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "@dave",
                                        text: "Great post!",
                                        postedDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
}


