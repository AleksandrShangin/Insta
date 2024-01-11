//  
//  ProfileRouter.swift
//  Insta
//
//  Created by Alexander Shangin on 09.10.2023.
//

import UIKit

final class ProfileRouter: BaseRouter {
    func showSettings() {
        let vc = SettingsFactory().build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFollowers() {
        var mockData = [UserRelationship]()
        for x in 0...10 {
            mockData.append(
                UserRelationship(
                    username: "@joe",
                    name: "Joe",
                    type: x % 2 == 0 ? .following : .not_following
                )
            )
        }
        let vc = FollowersListFactory(data: mockData).build()
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFollowing() {
        var mockData = [UserRelationship]()
        for x in 0...10 {
            mockData.append(
                UserRelationship(
                    username: "@joe",
                    name: "Joe",
                    type: x % 2 == 0 ? .following : .not_following
                )
            )
        }
        let vc = FollowersListFactory(data: mockData).build()
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showEditProfile() {
        let vc = EditProfileFactory().build()
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func showPost() {
        // get the model and open post controller
//        let vc = PostViewController(model: nil)
//        vc.title = "Post"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
