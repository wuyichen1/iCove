//
//  ProfileViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var userProfile: UserProfile?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var settings: [SettingItem] = []
    
    // MARK: - Initialization
    init() {
        Task {
            await loadUserProfile()
            loadSettings()
        }
    }
    
    // MARK: - Public Methods
    func loadUserProfile() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 生成模拟用户资料
        userProfile = UserProfile(
            id: UUID().uuidString,
            username: "用户昵称",
            bio: "这是我的个人简介，分享生活点滴",
            avatar: nil,
            followerCount: 1234,
            followingCount: 567,
            postCount: 89,
            isFollowing: false,
            joinDate: Date().addingTimeInterval(-365 * 24 * 3600)
        )
        
        isLoading = false
    }
    
    func refresh() async {
        await loadUserProfile()
    }
    
    func toggleFollow() {
        guard var profile = userProfile else { return }
        profile.isFollowing.toggle()
        if profile.isFollowing {
            profile.followerCount += 1
        } else {
            profile.followerCount = max(0, profile.followerCount - 1)
        }
        userProfile = profile
    }
    
    func updateBio(_ newBio: String) {
        guard var profile = userProfile else { return }
        profile.bio = newBio
        userProfile = profile
    }
    
    func handleSettingAction(_ setting: SettingItem) {
        // 处理设置项点击事件
        switch setting.type {
        case .account:
            print("打开账户设置")
        case .privacy:
            print("打开隐私设置")
        case .notification:
            print("打开通知设置")
        case .appearance:
            print("打开外观设置")
        case .about:
            print("打开关于")
        case .logout:
            print("退出登录")
        }
    }
    
    // MARK: - Private Methods
    private func loadSettings() {
        settings = [
            SettingItem(title: "账户设置", icon: "person.circle", type: .account),
            SettingItem(title: "隐私设置", icon: "lock.shield", type: .privacy),
            SettingItem(title: "通知设置", icon: "bell", type: .notification),
            SettingItem(title: "外观设置", icon: "paintbrush", type: .appearance),
            SettingItem(title: "关于", icon: "info.circle", type: .about),
            SettingItem(title: "退出登录", icon: "arrow.right.square", type: .logout, isDestructive: true)
        ]
    }
}

// MARK: - Supporting Types
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

struct SettingItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let type: SettingType
    var isDestructive: Bool = false
}

enum SettingType {
    case account
    case privacy
    case notification
    case appearance
    case about
    case logout
}
