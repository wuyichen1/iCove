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

  // MARK: - Computed Properties
  var filteredConversations: [Conversation] {
    // 首先过滤：只显示包含当前用户ID的会话
    let userConversations = conversations.filter { conversation in
      guard let currentUserId = currentUserId else { return false }
      return conversation.participantIds.contains(currentUserId)
    }

    // 然后根据搜索文本过滤
    if searchText.isEmpty {
      return userConversations
    } else {
      return userConversations.filter { conversation in
        // 根据消息内容过滤
        conversation.lastMessage.localizedCaseInsensitiveContains(searchText)
      }
    }
  }

  // MARK: - Initialization
  init(conversationService: ConversationDataServiceProtocol = ConversationDataService.shared) {
    self.conversationService = conversationService
    Task {
      await loadConversations()
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
