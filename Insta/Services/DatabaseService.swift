//
//  DatabaseService.swift
//  Insta
//
//  Created by Alex on 3/20/21.
//

import Foundation
import FirebaseDatabase

public class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let database = Database.database().reference()
    
    private init() {}
    
    // MARK: - Public
    
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert new user data into database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database enty succeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { (error, _) in
            if error == nil {
                // succeded
                completion(true)
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
    
    
}
