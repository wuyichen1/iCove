//
//  AuthenticationService.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

/// 认证服务 - 处理登录和注册的网络请求
protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) async throws -> AuthResponse
    func register(email: String, password: String, username: String) async throws -> AuthResponse
    func logout(token: String) async throws
    func quickLogin() async throws -> AuthResponse
    func deleteQuickLoginUser(userId: String) async throws
    func resetPassword(email: String, newPassword: String) async throws
    func getUserById(_ userId: String) -> User?
}

class AuthenticationService: AuthenticationServiceProtocol {
    // MARK: - Singleton (仅用于服务层，ViewModel 不使用)
    static let shared = AuthenticationService()
    
    // 模拟用户数据库 - 使用 userId 作为 key
    private var users: [String: User] = [
        // 可登录用户
        "user_001": User(
            id: "user_001",
            email: "test@gmail.com",
            username: "测试用户",
            avatar: "eitJTglOzkSfZvNi1",
            balance: 1000
        ),
        // 示例用户数据（不需要邮箱和密码）
        "user_002": User(
            id: "user_002",
            email: "",
            username: "Fashionista",
            avatar: "eitJTglOzkSfZvNi2",
            balance: 850
        ),
        "user_003": User(
            id: "user_003",
            email: "",
            username: "StyleGuide",
            avatar: "eitJTglOzkSfZvNi3",
            balance: 1200
        ),
        "user_004": User(
            id: "user_004",
            email: "",
            username: "DailyWear",
            avatar: "eitJTglOzkSfZvNi4",
            balance: 650
        ),
        "user_005": User(
            id: "user_005",
            email: "",
            username: "WeekendStyle",
            avatar: "eitJTglOzkSfZvNi5",
            balance: 950
        ),
        "user_006": User(
            id: "user_006",
            email: "",
            username: "StreetFashion",
            avatar: "eitJTglOzkSfZvNi6",
            balance: 1100
        )
    ]
    
    // 邮箱到用户 ID 的映射（仅用于可登录用户）
    private var emailToUserId: [String: String] = [
        "test@gmail.com": "user_001"
    ]
    
    // 密码存储：email -> password（仅用于可登录用户）
    private var passwords: [String: String] = [
        "test@gmail.com": "123456"
    ]
    
    private init() {}
    
    // MARK: - Login
    func login(email: String, password: String) async throws -> AuthResponse {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        // 模拟网络错误（10% 概率）
        if Int.random(in: 1...10) == 1 {
            throw AuthError.networkError("网络连接失败，请稍后重试")
        }
        
        // 验证邮箱格式
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail("邮箱格式不正确")
        }
        
        // 验证密码长度
        guard password.count >= 6 else {
            throw AuthError.invalidPassword("密码长度至少为 6 位")
        }
        
        // 查找用户
        let emailKey = email.lowercased()
        guard let userId = emailToUserId[emailKey],
              let user = users[userId] else {
            throw AuthError.userNotFound("用户不存在")
        }
        
        // 验证密码
        guard passwords[emailKey] == password else {
            throw AuthError.invalidCredentials("邮箱或密码错误")
        }
        
        // 生成 token
        let token = generateToken(for: user.id)
        
        return AuthResponse(
            token: token,
            user: user
        )
    }
    
    // MARK: - Register
    func register(email: String, password: String, username: String) async throws -> AuthResponse {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        // 模拟网络错误（10% 概率）
        if Int.random(in: 1...10) == 1 {
            throw AuthError.networkError("网络连接失败，请稍后重试")
        }
        
        // 验证邮箱格式
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail("邮箱格式不正确")
        }
        
        // 验证密码长度
        guard password.count >= 6 else {
            throw AuthError.invalidPassword("密码长度至少为 6 位")
        }
        
        // 验证用户名长度
        guard username.count >= 2 && username.count <= 20 else {
            throw AuthError.invalidUsername("用户名长度应在 2-20 个字符之间")
        }
        
        // 检查邮箱是否已注册
        let emailKey = email.lowercased()
        if emailToUserId[emailKey] != nil {
            throw AuthError.emailAlreadyExists("该邮箱已被注册")
        }
        
        // 创建新用户
        let userId = "user_\(UUID().uuidString.prefix(8))"
        let newUser = User(
            id: userId,
            email: emailKey,
            username: username,
            avatar: nil,
            balance: 0
        )
        users[userId] = newUser
        emailToUserId[emailKey] = userId
        passwords[emailKey] = password
        
        // 生成 token
        let token = generateToken(for: userId)
        
        return AuthResponse(
            token: token,
            user: newUser
        )
    }
    
    // MARK: - Logout
    func logout(token: String) async throws {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // 在实际应用中，这里会调用服务器 API 使 token 失效
        // 模拟成功
    }
    
    // MARK: - Quick Login
    func quickLogin() async throws -> AuthResponse {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 检查是否有保存的快速登录用户
        if let quickLoginUser = getQuickLoginUser() {
            // 使用保存的快速登录用户登录
            let token = generateToken(for: quickLoginUser.id)
            return AuthResponse(
                token: token,
                user: quickLoginUser
            )
        } else {
            // 创建新的快速登录用户
            let userId = "quick_\(UUID().uuidString.prefix(8))"
            let email = "quick_\(UUID().uuidString.prefix(8))@quicklogin.local"
            let username = "Quick\(Int.random(in: 1000...9999))"
            let password = UUID().uuidString
            
            let newUser = User(
                id: userId,
                email: email,
                username: username,
                avatar: "icove_logo",
                balance: 500
            )
            
            // 保存快速登录用户
            users[userId] = newUser
            emailToUserId[email] = userId
            passwords[email] = password
            saveQuickLoginUser(newUser)
            
            // 生成 token
            let token = generateToken(for: userId)
            
            return AuthResponse(
                token: token,
                user: newUser
            )
        }
    }
    
    // MARK: - Delete Quick Login User
    func deleteQuickLoginUser(userId: String) async throws {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // 从内存中删除
        if let quickLoginUser = getQuickLoginUser(),
           quickLoginUser.id == userId {
            users.removeValue(forKey: userId)
            if !quickLoginUser.email.isEmpty {
                emailToUserId.removeValue(forKey: quickLoginUser.email)
                passwords.removeValue(forKey: quickLoginUser.email)
            }
            clearQuickLoginUser()
        }
    }
    
    // MARK: - Quick Login User Management
    private func saveQuickLoginUser(_ user: User) {
        if let userData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(userData, forKey: "quick_login_user")
        }
    }
    
    private func getQuickLoginUser() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: "quick_login_user"),
              let user = try? JSONDecoder().decode(User.self, from: userData) else {
            return nil
        }
        
        // 验证用户是否还存在
        return users[user.id]
    }
    
    private func clearQuickLoginUser() {
        UserDefaults.standard.removeObject(forKey: "quick_login_user")
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String, newPassword: String) async throws {
        // 模拟网络延迟
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        // 验证邮箱格式
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail("邮箱格式不正确")
        }
        
        // 验证密码长度
        guard newPassword.count >= 6 else {
            throw AuthError.invalidPassword("密码长度至少为 6 位")
        }
        
        // 查找用户
        let emailKey = email.lowercased()
        guard emailToUserId[emailKey] != nil else {
            throw AuthError.userNotFound("用户不存在")
        }
        
        // 更新密码
        passwords[emailKey] = newPassword
        
        // 如果这是快速登录用户，也需要更新
        if let quickLoginUser = getQuickLoginUser(),
           quickLoginUser.email == emailKey {
            saveQuickLoginUser(quickLoginUser)
        }
    }
    
    // MARK: - Get User By ID
    func getUserById(_ userId: String) -> User? {
        return users[userId]
    }
    
    // MARK: - Private Helpers
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func generateToken(for userId: String) -> String {
        // 模拟生成 token
        return "token_\(userId)_\(UUID().uuidString.prefix(16))"
    }
}

