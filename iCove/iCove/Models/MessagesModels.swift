//
//  MessagesModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

struct Conversation: Identifiable, Codable {
  let id: String
  let pA5rT1iC3iP5aN7t: [String]
  var lA9sT1mE3sS5aG7e: String
  var tK3lM5nO7pQ9rS: Date
  var uN9rE1aD3cO5uN7t: Int
  var iS1uN3rE5aD7eN: Bool
  var iS1pI3nN5eD7eN: Bool

  enum CodingKeys: String, CodingKey {
    case id
    case pA5rT1iC3iP5aN7t = "participantIds"
    case lA9sT1mE3sS5aG7e = "lastMessage"
    case tK3lM5nO7pQ9rS = "timestamp"
    case uN9rE1aD3cO5uN7t = "unreadCount"
    case iS1uN3rE5aD7eN = "isUnread"
    case iS1pI3nN5eD7eN = "isPinned"
  }
}

struct Message: Identifiable, Codable {
  let id: String
  let cO5nV1eR3sA5tI7oN: String
  let sE5nD1eR3iD5eN: String
  let cL7mN9oP1qR3sT: String
  let mE5sS1aG3eT5yP7e: MtyWY6eefw4eu6Ve
  let tK3lM5nO7pQ9rS: Date

  enum CodingKeys: String, CodingKey {
    case id
    case cO5nV1eR3sA5tI7oN = "conversationId"
    case sE5nD1eR3iD5eN = "senderId"
    case cL7mN9oP1qR3sT = "content"
    case mE5sS1aG3eT5yP7e = "messageType"
    case tK3lM5nO7pQ9rS = "timestamp"
  }
}

enum MtyWY6eefw4eu6Ve: String, Codable {
  case text
  case image
  case audio
}
