//  
//  ExploreRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 16.10.2023.
//

import Foundation

final class ExploreRouter: BaseRouter {
    func showPost() {
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
        let vc = PostFactory(post: post).build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
