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
    public func getAllUsers(completion: ([String]) -> Void) {
        
    }
}
