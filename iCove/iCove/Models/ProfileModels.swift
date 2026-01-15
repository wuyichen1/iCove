//
//  ProfileModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Profile Models

/// 用户资料模型
struct UserProfile {
    let id: String
    var username: String
    var bio: String
    let avatar: String?
    var followerCount: Int
    var followingCount: Int
    var postCount: Int
    var isFollowing: Bool
    let joinDate: Date
}

/// 设置项模型
struct SettingItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let type: SettingType
    var isDestructive: Bool = false
}

/// 设置类型
enum SettingType {
    case account
    case privacy
    case notification
    case appearance
    case about
    case logout
}
