//
//  StorageManager.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    public static let shared = StorageManager()
    
    private let database = Storage.storage().reference()
    
    private init() {}
    
    // Public
    public func getVideoURL(with identifier: String, completion: (URL) -> Void) {
        
    }
    
    public func uploadVideoURL(from URL: URL) {
        
    }
}
