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
  @Published var user: User?
  @Published var isFollowing: Bool = false
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
  var isCurrentUser: Bool {
    guard let targetUserId = targetUserId,
      let currentUserId = authManager.currentUser?.id
    else {
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
        // loadSettings()
      }
    }

    userUpdateObserver = NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      if self?.isCurrentUser == true {
        Task { @MainActor [weak self] in
          self?.user = self?.authManager.currentUser
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

    let userIdToLoad = targetUserId ?? authManager.currentUser?.id

    if let userId = userIdToLoad {
      loadUserVideos(userId: userId)

      if isCurrentUser {
        // 当前用户资料：直接使用当前用户信息
        user = authManager.currentUser
        isFollowing = false  // 自己不能关注自己
      } else {
        // 他人资料：优先从认证服务中读取真实用户信息
        if let otherUser = authService.getUserById(userId) {
          user = otherUser
          // 检查当前用户是否关注了该用户
          if let currentUserId = authManager.currentUser?.id {
            isFollowing = otherUser.followerUserIds.contains(currentUserId)
          }
        } else {
          // 回退：根据 userId 构造一个占位用户
          user = User(
            id: userId,
            email: "",
            username: "用户\(userId.suffix(4))",
            avatar: nil,
            balance: 0,
            bio: nil
          )
          isFollowing = false
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
      .sorted { $0.timestamp > $1.timestamp }
  }

  func toggleFollow() {
    guard var targetUser = user, !isCurrentUser,
      let currentUserId = authManager.currentUser?.id
    else { return }

    isFollowing.toggle()

    if isFollowing {
      if !targetUser.followerUserIds.contains(currentUserId) {
        targetUser.followerUserIds.append(currentUserId)
      }
      if var currentUser = authManager.currentUser,
        !currentUser.followingUserIds.contains(targetUser.id)
      {
        currentUser.followingUserIds.append(targetUser.id)
        authManager.currentUser = currentUser
      }
    } else {
      targetUser.followerUserIds.removeAll { $0 == currentUserId }
      if var currentUser = authManager.currentUser {
        currentUser.followingUserIds.removeAll { $0 == targetUser.id }
        authManager.currentUser = currentUser
      }
    }

    user = targetUser
  }

  func sendMessage(router: Router) {
    guard let targetUserId = targetUserId,
      let currentUserId = authManager.currentUser?.id,
      targetUserId != currentUserId
    else {
      return
    }

    let conversationId = findOrCreateConversation(
      currentUserId: currentUserId,
      otherUserId: targetUserId
    )

    router.push(.chatDetail(conversationId: conversationId, otherUserId: targetUserId))
  }

  // MARK: - Private Methods
  private func findOrCreateConversation(currentUserId: String, otherUserId: String) -> String {
    let conversationService = ConversationDataService.shared
    let allConversations = conversationService.loadAllConversations()

    if let existingConversation = allConversations.first(where: { conversation in
      conversation.participantIds.contains(currentUserId)
        && conversation.participantIds.contains(otherUserId)
        && conversation.participantIds.count == 2
    }) {
      return existingConversation.id
    }

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
    guard var currentUser = authManager.currentUser, isCurrentUser else { return }
    currentUser.bio = newBio.isEmpty ? nil : newBio
    authManager.currentUser = currentUser
    user = currentUser
  }

  func handleSettingAction(_ setting: SettingItem) {
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

  // // MARK: - Private Methods
  // private func loadSettings() {
  //   settings = [
  //     SettingItem(title: "账户设置", icon: "person.circle", type: .account),
  //     SettingItem(title: "隐私设置", icon: "lock.shield", type: .privacy),
  //     SettingItem(title: "通知设置", icon: "bell", type: .notification),
  //     SettingItem(title: "外观设置", icon: "paintbrush", type: .appearance),
  //     SettingItem(title: "关于", icon: "info.circle", type: .about),
  //     SettingItem(title: "退出登录", icon: "arrow.right.square", type: .logout, isDestructive: true),
  //   ]
  // }
}
