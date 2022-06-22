//
//  ExploreUserViewModel.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 20/06/22.
//

import Foundation
import UIKit

struct ExploreUserViewModel {
    let profilePictureURL: UIImage?
    let username: String
    let followerCount: Int
    let handler: (() -> Void)
}

