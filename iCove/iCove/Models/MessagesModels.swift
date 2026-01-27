//
//  MessagesModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Messages Models

/// 会话模型
struct Conversation: Identifiable, Codable {
  let id: String
  let participantIds: [String] 
  var lastMessage: String
  var timestamp: Date
  var unreadCount: Int
  var isUnread: Bool
  var isPinned: Bool
}

/// 消息模型
struct Message: Identifiable, Codable {
  let id: String
  let conversationId: String 
  let senderId: String 
  let content: String 
  let messageType: MessageType 
  let timestamp: Date 
}

/// 消息类型
enum MessageType: String, Codable {
  case text 
  case image 
  case audio 
}
