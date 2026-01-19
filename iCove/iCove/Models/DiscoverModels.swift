//
//  DiscoverModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Discover Models

/// 发现页内容项模型
struct DiscoverItem: Identifiable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String?
    let category: DiscoverCategory
    let viewCount: Int
    let author: String
    let timestamp: Date
}

/// 热门话题模型
struct TrendingTopic: Identifiable {
    let id: String
    let name: String
    let postCount: Int
    var isFollowing: Bool
    let trend: TrendDirection
}

/// 发现分类
enum DiscoverCategory: String, CaseIterable {
    case all = "全部"
    case tech = "科技"
    case design = "设计"
    case lifestyle = "生活"
    case travel = "旅行"
    
    var displayName: String {
        return self.rawValue
    }
}

/// 趋势方向
enum TrendDirection {
    case up
    case down
    case stable
}

/// 帖子模型
struct Post: Identifiable {
    let id: String
    let imageNames: [String]  // 图片名称数组
    let authorId: String  // 作者ID，通过此ID查找用户信息
    let content: String
    let timestamp: Date
    var isCollected: Bool  // 是否收藏
}
