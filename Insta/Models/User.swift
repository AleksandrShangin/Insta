//
//  User.swift
//  Insta
//
//  Created by Alex on 6/21/21.
//

import Foundation

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

enum Gender {
    case male, female, other
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
