//
//  PostComment.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 16/06/22.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date
    
    static func mockComments() -> [PostComment] {
        let user = User(
            username: "kimnamjoon",
            profilePictureURL: nil,
            identifier: UUID().uuidString)
        var comments = [PostComment]()
        
        let text = [
            "This is cool",
            "This is rad",
            "Im learning so much!"
        ]
        
        for comment in text {
            comments.append(
                PostComment(
                    text: comment,
                    user: user,
                    date: Date()
                )
            )
        }
        
        return comments
    }
}
