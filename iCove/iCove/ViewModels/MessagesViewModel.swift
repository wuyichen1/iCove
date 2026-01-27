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
    let userConversations = conversations.filter { conversation in
      guard let currentUserId = currentUserId else { return false }
      return conversation.participantIds.contains(currentUserId)
    }

    let filteredByBlocked = filterBlockedUsersConversations(userConversations)

    if searchText.isEmpty {
      return filteredByBlocked
    } else {
      return filteredByBlocked.filter { conversation in
        conversation.lastMessage.localizedCaseInsensitiveContains(searchText)
      }
    }
  }

  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    Task {
      await loadConversations()
    }
  }

  private func filterBlockedUsersConversations(_ conversations: [Conversation]) -> [Conversation] {
    guard let blockedUserIds = authManager?.currentUser?.blockedUserIds, !blockedUserIds.isEmpty
    else {
      return conversations
    }
    return conversations.filter { conversation in
      !conversation.participantIds.contains { blockedUserIds.contains($0) }
    }
  }

  // MARK: - Initialization
  init(conversationService: ConversationDataServiceProtocol = ConversationDataService.shared) {
    self.conversationService = conversationService
    Task {
      await loadConversations()
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        await self?.loadConversations()
      }
    }

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

    conversations = conversationService.loadAllConversations()
    updateUnreadCount()

    isLoading = false
  }

  func refresh() async {
    // 模拟刷新延迟
    try? await Task.sleep(nanoseconds: 300_000_000)

    conversations = conversationService.loadAllConversations()
    updateUnreadCount()
  }

  func markAsRead(_ conversation: Conversation) {
    if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
      conversations[index].isUnread = false
      conversations[index].unreadCount = 0
      conversationService.updateConversation(conversations[index])
      updateUnreadCount()
    }
  }

  func deleteConversation(_ conversation: Conversation) {
    conversations.removeAll { $0.id == conversation.id }
    conversationService.deleteConversation(conversation.id)
    updateUnreadCount()
  }

  func pinConversation(_ conversation: Conversation) {
    if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
      conversations[index].isPinned.toggle()
      conversationService.updateConversation(conversations[index])
      let pinned = conversations.filter { $0.isPinned }
      let unpinned = conversations.filter { !$0.isPinned }
      conversations = pinned + unpinned
    }
  }

  func refreshConversations() {
    conversations = conversationService.loadAllConversations()
    updateUnreadCount()
  }

  // MARK: - Private Methods
  private func updateUnreadCount() {
    unreadCount = conversations.reduce(0) { $0 + $1.unreadCount }
  }

}
