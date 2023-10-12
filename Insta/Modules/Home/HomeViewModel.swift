//  
//  HomeViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 12.10.2023.
//

import Foundation
import Combine

protocol HomeViewModel {
    var feedRenderModels: CurrentValueSubject<[HomeFeedRenderViewModel], Never> { get }
    
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
}

final class HomeViewModelImpl: HomeViewModel {
    
    //MARK: - Public Properties
    
    var feedRenderModels = CurrentValueSubject<[HomeFeedRenderViewModel], Never>([])
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
    private let service: DatabaseManager
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: DatabaseManager) {
        self.service = service
        createMockData()
    }
    
    //MARK: - Public Methods
        
    func createMockData() {
        var models = [HomeFeedRenderViewModel]()
        
        let user = User(
            username: "@kanye_west",
            bio: "", name: (first: "", last: ""),
            profilePhoto: URL(string: "https://www.google.com")!,
            birthDate: Date(),
            gender: .male,
            counts: UserCount(followers: 1, following: 1, posts: 1),
            joinDate: Date()
        )
        let post = UserPost(
            identifier: "",
            postType: .photo,
            thumbnailImage: URL(string: "https://www.google.com")!,
            postURL: URL(string: "https://www.google.com")!,
            caption: nil,
            likedCount: [],
            comments: [],
            postedDate: Date(),
            taggedUsers: [],
            owner: user
        )
        
        
        for x in 0...4 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(content: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "")),
                comments: PostRenderViewModel(renderType: .comments(comments: [
                    PostComment(
                        identifier: "123_\(x)",
                        username: "@dave",
                        text: "Great post!",
                        postedDate: Date(),
                        likes: []
                    ),
                    PostComment(
                        identifier: "123_\(x)",
                        username: "@dave",
                        text: "Great post!",
                        postedDate: Date(),
                        likes: []
                    ),
                ]))
            )
            models.append(viewModel)
        }
        self.feedRenderModels.send(models)
    }
    
    //MARK: - Private Methods
    
}


