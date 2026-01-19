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
    
    // MARK: - Private Properties
    private let authManager: AuthenticationManager
    private let targetUserId: String?
    
    // MARK: - Computed Properties
    /// 是否是当前用户的资料页
    var isCurrentUser: Bool {
        guard let targetUserId = targetUserId,
              let currentUserId = authManager.currentUser?.id else {
            return targetUserId == nil
        }
        return targetUserId == currentUserId
    }
    
    // MARK: - Initialization
    init(authManager: AuthenticationManager, userId: String? = nil) {
        self.authManager = authManager
        self.targetUserId = userId
        Task {
            await loadUserProfile()
            if isCurrentUser {
                loadSettings()
            }
        }
    }
    
    // MARK: - Public Methods
    func loadUserProfile() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 如果是当前用户，使用当前用户信息；否则加载指定用户信息
        if isCurrentUser {
            // 当前用户资料
            if let currentUser = authManager.currentUser {
                userProfile = UserProfile(
                    id: currentUser.id,
                    username: currentUser.username,
                    bio: "这是我的个人简介，分享生活点滴",
                    avatar: currentUser.avatar,
                    followerCount: 1234,
                    followingCount: 567,
                    postCount: 89,
                    isFollowing: false,
                    joinDate: Date().addingTimeInterval(-365 * 24 * 3600)
                )
            }
        } else if let userId = targetUserId {
            // 其他用户资料（模拟数据）
            userProfile = UserProfile(
                id: userId,
                username: "Cormac",
                bio: "这是其他用户的个人简介",
                avatar: nil,
                followerCount: 218,
                followingCount: 100,
                postCount: 45,
                isFollowing: false,
                joinDate: Date().addingTimeInterval(-200 * 24 * 3600)
            )
        }
        
        isLoading = false
    }
    
    func refresh() async {
        await loadUserProfile()
    }
    
    func toggleFollow() {
        guard var profile = userProfile, !isCurrentUser else { return }
        profile.isFollowing.toggle()
        if profile.isFollowing {
            profile.followerCount += 1
        } else {
            profile.followerCount = max(0, profile.followerCount - 1)
        }
        userProfile = profile
    }
    
    func sendMessage(router: Router) {
        guard let targetUserId = targetUserId,
              let currentUserId = authManager.currentUser?.id,
              targetUserId != currentUserId else {
            return
        }
        
        // 查找或创建会话
        let conversationId = findOrCreateConversation(
            currentUserId: currentUserId,
            otherUserId: targetUserId
        )
        
        // 跳转到聊天页面
        router.push(.chatDetail(conversationId: conversationId, otherUserId: targetUserId))
    }
    
    // MARK: - Private Methods
    private func findOrCreateConversation(currentUserId: String, otherUserId: String) -> String {
        let conversationService = ConversationDataService.shared
        let allConversations = conversationService.loadAllConversations()
        
        // 查找是否已存在会话
        if let existingConversation = allConversations.first(where: { conversation in
            conversation.participantIds.contains(currentUserId) &&
            conversation.participantIds.contains(otherUserId) &&
            conversation.participantIds.count == 2
        }) {
            return existingConversation.id
        }
        
        // 创建新会话
        let newConversationId = "conv_\(UUID().uuidString.prefix(8))"
        let newConversation = Conversation(
            id: newConversationId,
            participantIds: [currentUserId, otherUserId],
            lastMessage: "",
            timestamp: Date(),
            unreadCount: 0,
            isUnread: false,
            isPinned: false
        )
        conversationService.saveConversation(newConversation)
        
        return newConversationId
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
            Task {
                await logout()
            }
        }
    }
    
    func logout() async {
        await authManager.logout()
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

