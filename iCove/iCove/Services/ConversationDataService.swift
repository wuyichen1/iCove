//
//  ConversationDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol ConversationDataServiceProtocol {
  func loadAllConversations() -> [Conversation]
  func saveConversation(_ conversation: Conversation)
  func updateConversationLastMessage(conversationId: String, lastMessage: String, timestamp: Date)
  func updateConversation(_ conversation: Conversation)
  func deleteConversation(_ conversationId: String)
}

class ConversationDataService: ConversationDataServiceProtocol {
  static let shared = ConversationDataService()

  private let conversationsKey = "conversations"
  private let userDefaults = UserDefaults.standard

  private init() {
    initializeMockConversationsIfNeeded()
  }

  // MARK: - Public Methods

  func loadAllConversations() -> [Conversation] {
    guard let data = userDefaults.data(forKey: conversationsKey),
      let conversations = try? JSONDecoder().decode([Conversation].self, from: data)
    else {
      return []
    }
    return conversations.sorted { conv1, conv2 in
      if conv1.isPinned != conv2.isPinned {
        return conv1.isPinned
      }
      return conv1.timestamp > conv2.timestamp
    }
  }

  func saveConversation(_ conversation: Conversation) {
    var conversations = loadAllConversations()
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

  private func initializeMockConversationsIfNeeded() {
    guard userDefaults.data(forKey: conversationsKey) == nil else { return }

    let mockConversations: [Conversation] = [
      Conversation(
        id: "conv_001",
        participantIds: ["user_001", "user_002"],
        lastMessage: "Hello. Nice to meet you",
        timestamp: Date().addingTimeInterval(-3600),
        unreadCount: 2,
        isUnread: true,
        isPinned: true
      ),
      Conversation(
        id: "conv_002",
        participantIds: ["user_001", "user_003"],
        lastMessage: "Spring collection is here!",
        timestamp: Date().addingTimeInterval(-3600 * 1.5),
        unreadCount: 0,
        isUnread: false,
        isPinned: true
      ),
    ]
    saveAllConversations(mockConversations)
  }
}
