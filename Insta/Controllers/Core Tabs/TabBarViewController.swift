//
//  TabBarViewController.swift
//  Insta
//
//  Created by Alex on 6/20/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let homeVC = HomeViewController()
        let exploreVC = ExploreViewController()
        let cameraVC = CameraViewController()
        let notificationsVC = NotificationsViewController()
        let profileVC = ProfileFactory().build()
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: exploreVC)
        let nav3 = UINavigationController(rootViewController: cameraVC)
        let nav4 = UINavigationController(rootViewController: notificationsVC)
        let nav5 = UINavigationController(rootViewController: profileVC)
        
        if #available (iOS 13.0, *) {
            nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
            nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 2)
            nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 3)
            nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 4)
            nav5.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 5)
        } else {
            nav1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
            nav2.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
            nav3.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
            nav4.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 4)
            nav5.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 5)
        }
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
    }
}
