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
}

/// 模拟用户模型（仅用于 Service 层）
struct MockUser: Codable {
    let email: String
    let password: String
    let username: String
    let userId: String
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
