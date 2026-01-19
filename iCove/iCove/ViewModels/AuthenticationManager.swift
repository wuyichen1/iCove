//
//  AuthenticationManager.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

/// 认证状态管理器 - 管理全局登录状态
@MainActor
class AuthenticationManager: ObservableObject {
    // MARK: - Published Properties
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    @Published var authToken: String?
    @Published var isQuickLogin: Bool = false
    
    // MARK: - Private Properties
    private let authService: AuthenticationServiceProtocol
    private let tokenKey = "auth_token"
    private let userKey = "current_user"
    private let loginTypeKey = "login_type" // "normal" 或 "quick"
    
    // MARK: - Initialization
    init(authService: AuthenticationServiceProtocol = AuthenticationService.shared) {
        self.authService = authService
        loadSavedAuthState()
    }
    
    // MARK: - Public Methods
    func login(email: String, password: String) async throws {
        let response = try await authService.login(email: email, password: password)
        
        // 保存认证信息
        authToken = response.token
        currentUser = response.user
        isAuthenticated = true
        isQuickLogin = false
        
        // 持久化存储，标记为普通登录
        saveAuthState(token: response.token, user: response.user, loginType: "normal")
    }
    
    func register(email: String, password: String, username: String) async throws {
        let response = try await authService.register(email: email, password: password, username: username)
        
        // 保存认证信息
        authToken = response.token
        currentUser = response.user
        isAuthenticated = true
        isQuickLogin = false
        
        // 持久化存储，标记为普通登录
        saveAuthState(token: response.token, user: response.user, loginType: "normal")
    }
    
    func logout() async {
        // 如果有 token，调用登出 API
        if let token = authToken {
            try? await authService.logout(token: token)
        }
        
        // 获取登录类型
        let wasQuickLogin = isQuickLogin
        
        // 清除认证信息
        authToken = nil
        currentUser = nil
        isAuthenticated = false
        isQuickLogin = false
        
        // 清除持久化存储（但保留快速登录用户信息，除非是删除快速登录用户）
        // 普通登录退出不影响快速登录用户信息
        clearAuthState(keepQuickLogin: wasQuickLogin)
    }
    
    // MARK: - Quick Login
    func quickLogin() async throws {
        let response = try await authService.quickLogin()
        
        // 保存认证信息
        authToken = response.token
        currentUser = response.user
        isAuthenticated = true
        isQuickLogin = true
        
        // 持久化存储，标记为快速登录
        saveAuthState(token: response.token, user: response.user, loginType: "quick")
    }
    
    // MARK: - Delete Quick Login User
    func deleteQuickLoginUser() async throws {
        guard let userId = currentUser?.id else {
            return
        }
        
        // 删除快速登录用户
        try await authService.deleteQuickLoginUser(userId: userId)
        
        // 清除认证信息
        authToken = nil
        currentUser = nil
        isAuthenticated = false
        isQuickLogin = false
        
        // 清除所有持久化存储（包括快速登录用户信息）
        clearAuthState(keepQuickLogin: false)
    }
    
    // MARK: - Update User Collection
    /// 添加收藏的帖子ID
    func addCollectedPostId(_ postId: String) {
        guard var user = currentUser else { return }
        if !user.collectedPostIds.contains(postId) {
            user.collectedPostIds.append(postId)
            currentUser = user
            saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
        }
    }
    
    /// 移除收藏的帖子ID
    func removeCollectedPostId(_ postId: String) {
        guard var user = currentUser else { return }
        user.collectedPostIds.removeAll { $0 == postId }
        currentUser = user
        saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
    }
    
    /// 切换收藏状态
    func toggleCollectedPostId(_ postId: String) {
        guard let user = currentUser else { return }
        if user.collectedPostIds.contains(postId) {
            removeCollectedPostId(postId)
        } else {
            addCollectedPostId(postId)
        }
    }
    
    // MARK: - Private Methods
    private func saveAuthState(token: String, user: User, loginType: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(loginType, forKey: loginTypeKey)
        
        if let userData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userData, forKey: userKey)
        }
    }
    
    private func loadSavedAuthState() {
        // 加载保存的 token
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            authToken = token
            
            // 加载保存的用户信息
            if let userData = UserDefaults.standard.data(forKey: userKey),
               let user = try? JSONDecoder().decode(User.self, from: userData) {
                currentUser = user
                isAuthenticated = true
                
                // 检查登录类型
                let loginType = UserDefaults.standard.string(forKey: loginTypeKey)
                isQuickLogin = (loginType == "quick")
            } else {
                // 如果用户信息不存在，清除 token
                clearAuthState()
            }
        }
    }
    
    private func clearAuthState(keepQuickLogin: Bool = false) {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userKey)
        
        // 如果不是快速登录，清除登录类型
        // 如果是快速登录且 keepQuickLogin 为 false，也清除登录类型
        if !keepQuickLogin {
            UserDefaults.standard.removeObject(forKey: loginTypeKey)
        }
    }
}
