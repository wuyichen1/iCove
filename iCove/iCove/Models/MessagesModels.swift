//
//  MessagesModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Messages Models

/// 会话模型
struct Conversation: Identifiable {
    let id: String
    let participantName: String
    let participantAvatar: String?
    let lastMessage: String
    let timestamp: Date
    var unreadCount: Int
    var isUnread: Bool
    var isPinned: Bool
}
