//
//  ExploreBannerViewModdel.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 20/06/22.
//

import Foundation
import UIKit

struct ExploreBannerViewModel {
    let image: UIImage?
    let title: String
    let handler: (() -> Void)
}
