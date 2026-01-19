//
//  ConversationDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

/// 会话数据服务协议
protocol ConversationDataServiceProtocol {
  func loadAllConversations() -> [Conversation]
  func saveConversation(_ conversation: Conversation)
  func updateConversationLastMessage(conversationId: String, lastMessage: String, timestamp: Date)
  func updateConversation(_ conversation: Conversation)
  func deleteConversation(_ conversationId: String)
}

/// 会话数据服务 - 负责会话数据的持久化存储和管理
class ConversationDataService: ConversationDataServiceProtocol {
  static let shared = ConversationDataService()

  private let conversationsKey = "conversations"
  private let userDefaults = UserDefaults.standard

  private init() {
    // 初始化时加载示例数据（如果还没有数据）
    initializeMockConversationsIfNeeded()
  }

  // MARK: - Public Methods

  func loadAllConversations() -> [Conversation] {
    guard let data = userDefaults.data(forKey: conversationsKey),
          let conversations = try? JSONDecoder().decode([Conversation].self, from: data)
    else {
      return []
    }
    // 按时间戳排序：最新的在前，置顶的优先
    return conversations.sorted { conv1, conv2 in
      if conv1.isPinned != conv2.isPinned {
        return conv1.isPinned
      }
      return conv1.timestamp > conv2.timestamp
    }
  }

  func saveConversation(_ conversation: Conversation) {
    var conversations = loadAllConversations()
    // 检查会话是否已存在
    if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
      conversations[index] = conversation
    } else {
      conversations.append(conversation)
    }
    saveAllConversations(conversations)
  }

  func updateConversationLastMessage(conversationId: String, lastMessage: String, timestamp: Date) {
    var conversations = loadAllConversations()
    if let index = conversations.firstIndex(where: { $0.id == conversationId }) {
      conversations[index].lastMessage = lastMessage
      conversations[index].timestamp = timestamp
      saveAllConversations(conversations)
    }
  }

  func updateConversation(_ conversation: Conversation) {
    saveConversation(conversation)
  }

  func deleteConversation(_ conversationId: String) {
    var conversations = loadAllConversations()
    conversations.removeAll { $0.id == conversationId }
    saveAllConversations(conversations)
  }

  // MARK: - Private Methods

  private func saveAllConversations(_ conversations: [Conversation]) {
    if let data = try? JSONEncoder().encode(conversations) {
      userDefaults.set(data, forKey: conversationsKey)
      userDefaults.synchronize()
    }
  }

  /// 初始化示例会话数据（如果还没有数据）
  private func initializeMockConversationsIfNeeded() {
    guard userDefaults.data(forKey: conversationsKey) == nil else { return }

    let mockConversations: [Conversation] = [
      Conversation(
        id: "conv_001",
        participantIds: ["user_001", "user_002"],
        lastMessage: "Hello. Nice to meet you",
        timestamp: Date().addingTimeInterval(-3600),  // 1小时前
        unreadCount: 2,
        isUnread: true,
        isPinned: true
      ),
      Conversation(
        id: "conv_002",
        participantIds: ["user_001", "user_003"],
        lastMessage: "Spring collection is here!",
        timestamp: Date().addingTimeInterval(-3600 * 1.5),  // 1.5小时前
        unreadCount: 0,
        isUnread: false,
        isPinned: true
      ),
    ]
    saveAllConversations(mockConversations)
  }
}
