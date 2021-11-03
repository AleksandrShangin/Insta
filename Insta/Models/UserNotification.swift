//
//  UserNotification.swift
//  Insta
//
//  Created by Alex on 6/21/21.
//

import Foundation

struct UserNotification {
    let type: UserNotificationType
    let user: User
    let text: String
}

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}
