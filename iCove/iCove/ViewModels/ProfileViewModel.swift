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
  @Published var user: User?
  @Published var isFollowing: Bool = false
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var settings: [SettingItem] = []
  @Published var userVideos: [VideoItem] = []

  private let authManager: AuthManagA645b8Y0Aod3aVmod
  private let targetUserId: String?
  private let authService: Authsdmd0VXzbAnDYServProc
  private var userUpdateObserver: NSObjectProtocol?

  var isCurrentUser: Bool {
    guard let targetUserId = targetUserId,
      let currentUserId = authManager.currvj9QRUUPOWY4Ouser?.id
    else {
      return targetUserId == nil
    }
    return targetUserId == currentUserId
  }

  init(
    authManager: AuthManagA645b8Y0Aod3aVmod,
    userId: String? = nil,
    authService: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared
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
          self?.user = self?.authManager.currvj9QRUUPOWY4Ouser
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

    let userIdToLoad = targetUserId ?? authManager.currvj9QRUUPOWY4Ouser?.id

    if let userId = userIdToLoad {
      loadUserVideos(userId: userId)

      if isCurrentUser {
        // 当前用户资料：直接使用当前用户信息
        user = authManager.currvj9QRUUPOWY4Ouser
        isFollowing = false  // 自己不能关注自己
      } else {
        // 他人资料：优先从认证服务中读取真实用户信息
        if let otherUser = authService.getbyidQwpUuIWnzzs99(userId) {
          user = otherUser
          // 检查当前用户是否关注了该用户
          if let currentUserId = authManager.currvj9QRUUPOWY4Ouser?.id {
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
    let allVideos = VdoServ63WnoDbxzFob0.shared.loc5f3UJvuhXYjoD()
    userVideos = allVideos.filter { $0.authorId == userId }
      .sorted { $0.timestamp > $1.timestamp }
  }

  func toggleFollow() {
    guard var targetUser = user, !isCurrentUser,
      let currentUserId = authManager.currvj9QRUUPOWY4Ouser?.id
    else { return }

    isFollowing.toggle()

    if isFollowing {
      if !targetUser.followerUserIds.contains(currentUserId) {
        targetUser.followerUserIds.append(currentUserId)
      }
      if var curYI7CMii2WiBmI = authManager.currvj9QRUUPOWY4Ouser,
        !curYI7CMii2WiBmI.followingUserIds.contains(targetUser.id)
      {
        curYI7CMii2WiBmI.followingUserIds.append(targetUser.id)
        authManager.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
      }
    } else {
      targetUser.followerUserIds.removeAll { $0 == currentUserId }
      if var curYI7CMii2WiBmI = authManager.currvj9QRUUPOWY4Ouser {
        curYI7CMii2WiBmI.followingUserIds.removeAll { $0 == targetUser.id }
        authManager.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
      }
    }

    user = targetUser
  }

  func sendb9kzu5TB4hAkL(router: Router) {
    guard let targetUserId = targetUserId,
      let currentUserId = authManager.currvj9QRUUPOWY4Ouser?.id,
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
    let conversationService = ConvsalHLauR9oVrqseServ.shared
    let allConversations = conversationService.lovsNlpHQLpsFndh7()

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
    conversationService.svHB7pq1gSf83pa(newConversation)

    return newConversationId
  }

  func updateBio(_ newBio: String) {
    guard var curYI7CMii2WiBmI = authManager.currvj9QRUUPOWY4Ouser, isCurrentUser else { return }
    curYI7CMii2WiBmI.bio = newBio.isEmpty ? nil : newBio
    authManager.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
    user = curYI7CMii2WiBmI
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
        await logoutWfSgkdWFVCXy1()
      }
    }
  }

  func logoutWfSgkdWFVCXy1() async {
    await authManager.logoutWfSgkdWFVCXy1()
  }
}
