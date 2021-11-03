//
//  PostRenderViewModel.swift
//  Insta
//
//  Created by Alex on 6/21/21.
//

import Foundation

/// Model of rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

/// States of a rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(content: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}

