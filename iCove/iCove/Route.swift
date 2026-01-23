//
//  Route.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

/// 发布类型枚举
enum PublishType: String, Hashable {
    case video = "video"
    case imagePost = "imagePost"
}

/// 路由枚举 - 定义所有可导航的页面
enum Route: Hashable {
    case home
    case detail(id: String)
    case postDetail(postId: String)
    case chatDetail(conversationId: String, otherUserId: String)
    case videoCall(conversationId: String, otherUserId: String)
    case profile(userId: String)
    case settings
    case editProfile
    case blacklist
    case wallet
    case ai
    case publish(type: PublishType)
    case report(userId: String)
    case agreement(url: String, title: String)
}