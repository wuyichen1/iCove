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
    let participantIds: [String]  // 聊天双方的用户ID列表
    var lastMessage: String
    var timestamp: Date
    var unreadCount: Int
    var isUnread: Bool
    var isPinned: Bool
}

/// 消息模型
struct Message: Identifiable, Codable {
    let id: String
    let conversationId: String  // 所属会话ID
    let senderId: String  // 发送者用户ID
    let content: String  // 消息内容（文本或图片名称）
    let messageType: MessageType  // 消息类型
    let timestamp: Date  // 发送时间
}

/// 消息类型
enum MessageType: String, Codable {
    case text  // 文本消息
    case image  // 图片消息
    case audio  // 音频消息
}
