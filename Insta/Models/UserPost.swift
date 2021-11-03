//
//  UserPost.swift
//  Insta
//
//  Created by Alex on 6/21/21.
//

import Foundation

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likedCount: [PostLike]
    let comments: [PostComment]
    let postedDate: Date
    let taggedUsers: [User]
    let owner: User
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let postedDate: Date
    let likes: [CommentLike]
}
