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
    @Published var userVideos: [VideoItem] = []
    
    // MARK: - Private Properties
    private let authManager: AuthenticationManager
    private let targetUserId: String?
    private let authService: AuthenticationServiceProtocol
    private var userUpdateObserver: NSObjectProtocol?
    
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
    init(
        authManager: AuthenticationManager,
        userId: String? = nil,
        authService: AuthenticationServiceProtocol = AuthenticationService.shared
    ) {
        self.authManager = authManager
        self.targetUserId = userId
        self.authService = authService
        Task {
            await loadUserProfile()
            if isCurrentUser {
                loadSettings()
            }
        }
        
        // 监听用户信息更新通知
        userUpdateObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name("CurrentUserUpdated"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            // 如果是当前用户的资料页，重新加载用户资料
            if self?.isCurrentUser == true {
                Task { @MainActor [weak self] in
                    await self?.loadUserProfile()
                }
            }
        }
    }
    
    deinit {
        if let observer = userUpdateObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    // MARK: - Public Methods
    func loadUserProfile() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        // try? await Task.sleep(nanoseconds: 500_000_000)
        
        // 如果是当前用户，使用当前用户信息；否则加载指定用户信息
        let userIdToLoad = targetUserId ?? authManager.currentUser?.id
        
        if let userId = userIdToLoad {
            // 先加载该用户发布的视频
            loadUserVideos(userId: userId)
            
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
                        postCount: userVideos.count,
                        isFollowing: false,
                        joinDate: Date().addingTimeInterval(-365 * 24 * 3600)
                    )
                }
            } else {
                // 他人资料：优先从认证服务中读取真实用户信息
                if let otherUser = authService.getUserById(userId) {
                    userProfile = UserProfile(
                        id: otherUser.id,
                        username: otherUser.username,
                        bio: "这是其他用户的个人简介",
                        avatar: otherUser.avatar,
                        followerCount: 218,
                        followingCount: 100,
                        postCount: userVideos.count,
                        isFollowing: false,
                        joinDate: Date().addingTimeInterval(-200 * 24 * 3600)
                    )
                } else {
                    // 回退：根据 userId 构造一个占位用户
                    userProfile = UserProfile(
                        id: userId,
                        username: "用户\(userId.suffix(4))",
                        bio: "这是其他用户的个人简介",
                        avatar: nil,
                        followerCount: 218,
                        followingCount: 100,
                        postCount: userVideos.count,
                        isFollowing: false,
                        joinDate: Date().addingTimeInterval(-200 * 24 * 3600)
                    )
                }
            }
        }
        
        isLoading = false
    }
    
    func refresh() async {
        await loadUserProfile()
    }
    
    // MARK: - Load User Videos
    private func loadUserVideos(userId: String) {
        let allVideos = VideoDataService.shared.loadVideos()
        userVideos = allVideos.filter { $0.authorId == userId }
            .sorted { $0.timestamp > $1.timestamp } // 最新的在前
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

