//  
//  NotificationsViewModel.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import Foundation
import Combine

protocol NotificationsViewModel {
    var notifications: CurrentValueSubject<[UserNotification], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var onError: PassthroughSubject<Error, Never> { get }
    
    func fetchNotifications()
}

final class NotificationsViewModelImpl: NotificationsViewModel {
    
    //MARK: - Public Properties
    
    var notifications = CurrentValueSubject<[UserNotification], Never>([])
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var onError = PassthroughSubject<Error, Never>()
    
    //MARK: - Private Properties
    
//    private let service: NotificationsService
    private let service: DatabaseService
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(service: DatabaseService) {
        self.service = service
    }
    
    //MARK: - Public Methods
    
    func fetchNotifications() {
        self.isLoading.send(true)
        
        var models: [UserNotification] = []
        for x in 0...100 {
            let user = User(
                username: "joe",
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
            let model = UserNotification(
                type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                user: user,
                text: "Hello World"
            )
            models.append(model)
        }
        self.isLoading.send(false)
        self.notifications.send(models)
    }
    
    //MARK: - Private Methods
    
}


