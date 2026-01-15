//
//  HomeModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Home Models

/// 首页内容项模型
struct FeedItem: Identifiable {
    let id: String
    let title: String
    let content: String
    let author: String
    let timestamp: Date
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
}

/// 刷新状态
enum RefreshState {
    case idle
    case refreshing
}
