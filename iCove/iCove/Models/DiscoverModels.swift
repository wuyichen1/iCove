//
//  DiscoverModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Discover Models

/// 发现页内容项模型
struct DiscoverItem: Identifiable {
  let id: String
  let title: String
  let description: String
  let imageUrl: String?
  let viewCount: Int
  let author: String
  let timestamp: Date
}

/// 帖子模型
struct Post: Identifiable, Codable, Hashable {
  let id: String
  let imageNames: [String] 
  let authorId: String 
  let content: String
  let timestamp: Date

  enum CodingKeys: String, CodingKey {
    case id
    case imageNames
    case authorId
    case content
    case timestamp
  }

  init(
    id: String = UUID().uuidString,
    imageNames: [String],
    authorId: String,
    content: String,
    timestamp: Date = Date()
  ) {
    self.id = id
    self.imageNames = imageNames
    self.authorId = authorId
    self.content = content
    self.timestamp = timestamp
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    imageNames = try container.decode([String].self, forKey: .imageNames)
    authorId = try container.decode(String.self, forKey: .authorId)
    content = try container.decode(String.self, forKey: .content)
    let timestampInterval = try container.decode(TimeInterval.self, forKey: .timestamp)
    timestamp = Date(timeIntervalSince1970: timestampInterval)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(imageNames, forKey: .imageNames)
    try container.encode(authorId, forKey: .authorId)
    try container.encode(content, forKey: .content)
    try container.encode(timestamp.timeIntervalSince1970, forKey: .timestamp)
  }

  // MARK: - Hashable
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Post, rhs: Post) -> Bool {
    return lhs.id == rhs.id
  }
}
