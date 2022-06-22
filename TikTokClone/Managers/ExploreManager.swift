//
//  ExploreManager.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 21/06/22.
//

import Foundation
import UIKit

final class ExploreManager {
    static let shared = ExploreManager()
    
    public func getExploreBanners() -> [ExploreBannerViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        return exploreData.banners.compactMap({
            ExploreBannerViewModel(
                image: UIImage(named: $0.image),
                title: $0.title
            ) {
                // empty
            }
        })
    }
    
    public func getExploreCreators() -> [ExploreUserViewModel] {
        guard let exploreData = parseExploreData() else {
            return []
        }
        return exploreData.creators.compactMap({
            ExploreUserViewModel(
                profilePictureURL: UIImage(named: $0.image),
                username: $0.username,
                followerCount: $0.followers_count
            ) {
                    
            }
        })
    }
    
    private func parseExploreData() -> ExploreResponse? {
        let bundle = Bundle.main
        let type = "json"
        
        guard let path = bundle.path(forResource: "explore", ofType: type) else {
            return nil
        }
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(ExploreResponse.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

struct ExploreResponse: Codable {
    let banners: [Banner]
    let trendingPosts: [Post]
    let creators: [Creator]
    let recentPosts: [Post]
    let hashtags: [Hashtag]
    let popular: [Post]
    let recommended: [Post]
}

struct Banner: Codable {
    let id: String
    let image: String
    let title: String
    let action: String
}

struct Post: Codable {
    let id: String
    let image: String
    let caption: String
}

struct Creator: Codable {
    let id: String
    let image: String
    let username: String
    let followers_count: Int
}

struct Hashtag: Codable {
    let image: String
    let tag: String
    let count: Int
}
