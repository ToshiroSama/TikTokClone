//
//  DatabaseManager.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    public static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private init() {}
    
    // Public
    public func insertUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard var usersDictionary = snapshot.value as? [String: Any] else {
                self?.database.child("users").setValue(
                    [
                        username: [
                            "email": email
                        ]
                    ]
                ) { error, _ in
                    guard error == nil else {
                        return
                    }
                    completion(true)
                }
                return
            }
            usersDictionary[username] = ["email": email]
            self?.database.child("users").setValue(usersDictionary, withCompletionBlock:  { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    }
    
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
