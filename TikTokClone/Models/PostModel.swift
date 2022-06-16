//
//  PostModel.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 15/06/22.
//

import Foundation

struct PostModel {
    let identifier: String
    
    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}