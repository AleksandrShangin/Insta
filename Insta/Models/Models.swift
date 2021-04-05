//
//  Models.swift
//  Insta
//
//  Created by Alex on 4/5/21.
//

import Foundation


enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}


struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}


public enum UserPostType {
    case photo, video
}

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
