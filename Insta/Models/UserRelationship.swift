//
//  UserRelationship.swift
//  Insta
//
//  Created by Alex on 6/21/21.
//

import Foundation

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}

enum FollowState {
    case following // indicates the current user is following the other user
    case not_following // indicates the current user is NOT following the other user
}

