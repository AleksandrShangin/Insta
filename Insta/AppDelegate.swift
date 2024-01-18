//
//  AppDelegate.swift
//  Insta
//
//  Created by Alex on 3/19/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
    
}

