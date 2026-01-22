//
//  MessagesViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class MessagesViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published var conversations: [Conversation] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  @Published var searchText: String = ""
  @Published var unreadCount: Int = 0

  // MARK: - Private Properties
  private let conversationService: ConversationDataServiceProtocol
  var currentUserId: String? = nil
  private var authManager: AuthenticationManager?

  // MARK: - Computed Properties
  var filteredConversations: [Conversation] {
    // 首先过滤：只显示包含当前用户ID的会话
    let userConversations = conversations.filter { conversation in
      guard let currentUserId = currentUserId else { return false }
      return conversation.participantIds.contains(currentUserId)
    }
    
    // 过滤包含被拉黑用户的会话
    let filteredByBlocked = filterBlockedUsersConversations(userConversations)

    // 然后根据搜索文本过滤
    if searchText.isEmpty {
      return filteredByBlocked
    } else {
      return filteredByBlocked.filter { conversation in
        // 根据消息内容过滤
        conversation.lastMessage.localizedCaseInsensitiveContains(searchText)
      }
    }
  }
  
  /// 更新authManager引用（用于在View的onAppear中设置）
  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    Task {
      await loadConversations()
    }
  }
  
  /// 过滤包含被拉黑用户的会话
  private func filterBlockedUsersConversations(_ conversations: [Conversation]) -> [Conversation] {
    guard let blockedUserIds = authManager?.currentUser?.blockedUserIds, !blockedUserIds.isEmpty else {
      return conversations
    }
    return conversations.filter { conversation in
      // 如果会话的参与者中包含被拉黑的用户，则过滤掉
      !conversation.participantIds.contains { blockedUserIds.contains($0) }
    }
  }

  // MARK: - Initialization
  init(conversationService: ConversationDataServiceProtocol = ConversationDataService.shared) {
    self.conversationService = conversationService
    Task {
      await loadConversations()
    }
    
    // 监听用户拉黑通知，刷新会话列表
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        await self?.loadConversations()
      }
    }
    
    // 监听用户取消拉黑通知，刷新会话列表
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        await self?.loadConversations()
      }
    }
  }

  // MARK: - Public Methods
  func loadConversations() async {
    guard !isLoading else { return }

    isLoading = true
    errorMessage = nil

    // 模拟网络请求延迟
    try? await Task.sleep(nanoseconds: 300_000_000)

    // 从持久化存储加载会话数据
    conversations = conversationService.loadAllConversations()
    updateUnreadCount()

    isLoading = false
  }

  func refresh() async {
    // 模拟刷新延迟
    try? await Task.sleep(nanoseconds: 300_000_000)

    // 从持久化存储重新加载会话数据
    conversations = conversationService.loadAllConversations()
    updateUnreadCount()
  }

  func markAsRead(_ conversation: Conversation) {
    if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
      conversations[index].isUnread = false
      conversations[index].unreadCount = 0
      // 持久化更新
      conversationService.updateConversation(conversations[index])
      updateUnreadCount()
    }
  }

  func deleteConversation(_ conversation: Conversation) {
    conversations.removeAll { $0.id == conversation.id }
    // 持久化删除
    conversationService.deleteConversation(conversation.id)
    updateUnreadCount()
  }

  func pinConversation(_ conversation: Conversation) {
    if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
      conversations[index].isPinned.toggle()
      // 持久化更新
      conversationService.updateConversation(conversations[index])
      // 重新排序：置顶的在前
      let pinned = conversations.filter { $0.isPinned }
      let unpinned = conversations.filter { !$0.isPinned }
      conversations = pinned + unpinned
    }
  }

  /// 刷新会话列表（当消息更新时调用）
  func refreshConversations() {
    conversations = conversationService.loadAllConversations()
    updateUnreadCount()
  }

  // MARK: - Private Methods
  private func updateUnreadCount() {
    unreadCount = conversations.reduce(0) { $0 + $1.unreadCount }
  }

}
