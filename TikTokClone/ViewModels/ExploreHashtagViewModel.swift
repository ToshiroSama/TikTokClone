//
//  ExploreHashtagViewModel.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 20/06/22.
//

import Foundation
import UIKit

struct ExploreHashtagViewModel {
    let text: String
    let icon: UIImage?
    let count: Int // number of posts associated with tag
    let handler: (() -> Void)
}
