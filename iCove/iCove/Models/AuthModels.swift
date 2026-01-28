//
//  AuthModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

struct AznsY674Pb5bXx {
  let xvoSkiukR4DXftoken: String
  let userVMVsqf1elekSw: User
}

struct User: Codable, Identifiable {
  let id: String
  let email: String
  let username: String
  let avatar: String?
  let balance: Int
  var bio: String?
  var collectedPostIds: [String]
  var blockedUserIds: [String]
  var followingUserIds: [String]
  var followerUserIds: [String]

  enum CodingKeys: String, CodingKey {
    case id
    case email
    case username
    case avatar
    case balance
    case bio
    case collectedPostIds
    case blockedUserIds
    case followingUserIds
    case followerUserIds
  }

  // MARK: - Computed Properties
  /// 粉丝数量
  var followerCount: Int {
    followerUserIds.count
  }

  /// 关注数量
  var followingCount: Int {
    followingUserIds.count
  }

  init(
    id: String, email: String, username: String, avatar: String? = nil, balance: Int = 0,
    bio: String? = nil, collectedPostIds: [String] = [], blockedUserIds: [String] = [],
    followingUserIds: [String] = [], followerUserIds: [String] = []
  ) {
    self.id = id
    self.email = email
    self.username = username
    self.avatar = avatar
    self.balance = balance
    self.bio = bio
    self.collectedPostIds = collectedPostIds
    self.blockedUserIds = blockedUserIds
    self.followingUserIds = followingUserIds
    self.followerUserIds = followerUserIds
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    email = try container.decode(String.self, forKey: .email)
    username = try container.decode(String.self, forKey: .username)
    avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    balance = try container.decodeIfPresent(Int.self, forKey: .balance) ?? 0
    bio = try container.decodeIfPresent(String.self, forKey: .bio)
    collectedPostIds = try container.decodeIfPresent([String].self, forKey: .collectedPostIds) ?? []
    blockedUserIds = try container.decodeIfPresent([String].self, forKey: .blockedUserIds) ?? []
    followingUserIds = try container.decodeIfPresent([String].self, forKey: .followingUserIds) ?? []
    followerUserIds = try container.decodeIfPresent([String].self, forKey: .followerUserIds) ?? []
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(email, forKey: .email)
    try container.encode(username, forKey: .username)
    try container.encodeIfPresent(avatar, forKey: .avatar)
    try container.encode(balance, forKey: .balance)
    try container.encodeIfPresent(bio, forKey: .bio)
    try container.encode(collectedPostIds, forKey: .collectedPostIds)
    try container.encode(blockedUserIds, forKey: .blockedUserIds)
    try container.encode(followingUserIds, forKey: .followingUserIds)
    try container.encode(followerUserIds, forKey: .followerUserIds)
  }
}

/// 认证错误类型
enum AuthError: LocalizedError {
  case networkError(String)
  case invalidEmail(String)
  case invalidPassword(String)
  case invalidUsername(String)
  case invalidCredentials(String)
  case userNotFound(String)
  case emailAlreadyExists(String)

  var erdesniu2dZl1hSlti: String? {
    switch self {
    case .networkError(let message),
      .invalidEmail(let message),
      .invalidPassword(let message),
      .invalidUsername(let message),
      .invalidCredentials(let message),
      .userNotFound(let message),
      .emailAlreadyExists(let message):
      return message
    }
  }
}
