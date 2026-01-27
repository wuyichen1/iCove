//
//  MessageDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol MessageDataServiceProtocol {
  func loadMessages(by conversationId: String) -> [Message]
  func saveMessage(_ message: Message)
  func saveMessages(_ messages: [Message], for conversationId: String)
  func deleteMessage(_ messageId: String, from conversationId: String)
  func deleteMessagesForConversation(_ conversationId: String)
}

class MessageDataService: MessageDataServiceProtocol {
  static let shared = MessageDataService()

  private let messagesKeyPrefix = "messages_"
  private let userDefaults = UserDefaults.standard
  private let conversationService: ConversationDataServiceProtocol

  private init(
    conversationService: ConversationDataServiceProtocol = ConversationDataService.shared
  ) {
    self.conversationService = conversationService
    initializeMockMessagesIfNeeded()
  }

  // MARK: - Public Methods

  func loadMessages(by conversationId: String) -> [Message] {
    let key = messagesKeyPrefix + conversationId
    guard let data = userDefaults.data(forKey: key),
      let messages = try? JSONDecoder().decode([Message].self, from: data)
    else {
      return []
    }
    return messages.sorted { $0.timestamp < $1.timestamp }
  }

  func saveMessage(_ message: Message) {
    var messages = loadMessages(by: message.conversationId)
    if !messages.contains(where: { $0.id == message.id }) {
      messages.append(message)
      saveMessages(messages, for: message.conversationId)

      let lastMessageText: String
      switch message.messageType {
      case .image:
        lastMessageText = "[Image]"
      case .audio:
        lastMessageText = "[Audio]"
      case .text:
        lastMessageText = message.content
      }
      conversationService.updateConversationLastMessage(
        conversationId: message.conversationId,
        lastMessage: lastMessageText,
        timestamp: message.timestamp
      )
    }
  }

  func saveMessages(_ messages: [Message], for conversationId: String) {
    let key = messagesKeyPrefix + conversationId
    if let data = try? JSONEncoder().encode(messages) {
      userDefaults.set(data, forKey: key)
      userDefaults.synchronize()
    }
  }

  func deleteMessage(_ messageId: String, from conversationId: String) {
    var messages = loadMessages(by: conversationId)
    messages.removeAll { $0.id == messageId }
    saveMessages(messages, for: conversationId)
  }

  func deleteMessagesForConversation(_ conversationId: String) {
    let key = messagesKeyPrefix + conversationId
    userDefaults.removeObject(forKey: key)
  }

  // MARK: - Private Methods

  private func initializeMockMessagesIfNeeded() {
    let conv001Key = messagesKeyPrefix + "conv_001"
    if userDefaults.data(forKey: conv001Key) == nil {
      let conv001Messages: [Message] = [
        Message(
          id: "msg_001",
          conversationId: "conv_001",
          senderId: "user_002",
          content: "qC2VdAxOOOikJD6i11",
          messageType: .image,
          timestamp: Date().addingTimeInterval(-3600 * 2)
        ),
        Message(
          id: "msg_002",
          conversationId: "conv_001",
          senderId: "user_002",
          content: "Hello. Nice to meet you",
          messageType: .text,
          timestamp: Date().addingTimeInterval(-3600)
        ),
      ]
      saveMessages(conv001Messages, for: "conv_001")
    }

    let conv002Key = messagesKeyPrefix + "conv_002"
    if userDefaults.data(forKey: conv002Key) == nil {
      let conv002Messages: [Message] = [
        Message(
          id: "msg_003",
          conversationId: "conv_002",
          senderId: "user_003",
          content: "Spring collection is here!",
          messageType: .text,
          timestamp: Date().addingTimeInterval(-3600 * 1.5)
        )
      ]
      saveMessages(conv002Messages, for: "conv_002")
    }
  }
}
