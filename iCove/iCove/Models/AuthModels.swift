//
//  AuthModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Authentication Models

/// 认证响应模型
struct AuthResponse {
    let token: String
    let user: User
}

/// 用户模型
struct User: Codable {
    let id: String
    let email: String
    let username: String
    let avatar: String?
    let balance: Int
    var collectedPostIds: [String]  // 收藏的帖子ID列表
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case avatar
        case balance
        case collectedPostIds
    }
    
    init(id: String, email: String, username: String, avatar: String? = nil, balance: Int = 0, collectedPostIds: [String] = []) {
        self.id = id
        self.email = email
        self.username = username
        self.avatar = avatar
        self.balance = balance
        self.collectedPostIds = collectedPostIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        username = try container.decode(String.self, forKey: .username)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        balance = try container.decodeIfPresent(Int.self, forKey: .balance) ?? 0
        collectedPostIds = try container.decodeIfPresent([String].self, forKey: .collectedPostIds) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(username, forKey: .username)
        try container.encodeIfPresent(avatar, forKey: .avatar)
        try container.encode(balance, forKey: .balance)
        try container.encode(collectedPostIds, forKey: .collectedPostIds)
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
    
    var errorDescription: String? {
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
