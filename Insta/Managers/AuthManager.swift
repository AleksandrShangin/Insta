//
//  AuthManager.swift
//  Insta
//
//  Created by Alex on 3/20/21.
//

import Foundation
import FirebaseAuth


public class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - check if username is available
         - check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
            if canCreate {
                /*
                 - create account
                 - insert account into database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard result != nil, error == nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // insert account into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (inserted) in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            // failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // either username or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    print(error!)
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
    
    
    /// Attempt to log out firebase user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error.localizedDescription)
            completion(false)
            return
        }
    }
    
}
