//  
//  NotificationsRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

final class NotificationsRouter: BaseRouter {
    func showPost(post: UserPost) {
        let vc = PostFactory(post: post).build()
//        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
