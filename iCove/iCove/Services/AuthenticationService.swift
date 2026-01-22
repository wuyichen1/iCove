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
  func deleteUserAccount(userId: String) async throws
  func resetPassword(email: String, newPassword: String) async throws
  func getUserById(_ userId: String) -> User?
  func updateUser(_ user: User) -> Void
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
      username: "User1",
      avatar: "eitJTglOzkSfZvNi1",
      balance: 1000,
      collectedPostIds: ["post_001", "post_002", "post_003"],
      blockedUserIds: [],
      followingUserIds: ["user_002", "user_003"],
      followerUserIds: ["user_002"]
    ),
    // 示例用户数据（不需要邮箱和密码）
    "user_002": User(
      id: "user_002",
      email: "",
      username: "Maddison",
      avatar: "eitJTglOzkSfZvNi2",
      balance: 0,
      followingUserIds: ["user_001"],
      followerUserIds: ["user_001"]
    ),
    "user_003": User(
      id: "user_003",
      email: "",
      username: "StyleGuide",
      avatar: "eitJTglOzkSfZvNi3",
      balance: 0,
      followerUserIds: ["user_001"]
    ),
    "user_004": User(
      id: "user_004",
      email: "",
      username: "DailyWear",
      avatar: "eitJTglOzkSfZvNi4",
      balance: 0
    ),
    "user_005": User(
      id: "user_005",
      email: "",
      username: "WeekendStyle",
      avatar: "eitJTglOzkSfZvNi5",
      balance: 0
    ),
    "user_006": User(
      id: "user_006",
      email: "",
      username: "StreetFashion",
      avatar: "eitJTglOzkSfZvNi6",
      balance: 0
    ),
  ]

  // 邮箱到用户 ID 的映射（仅用于可登录用户）
  private var emailToUserId: [String: String] = [
    "test@gmail.com": "user_001"
  ]

  // 密码存储：email -> password（仅用于可登录用户）
  private var passwords: [String: String] = [
    "test@gmail.com": "123456"
  ]
  
  // UserDefaults keys
  private let usersKey = "persisted_users"
  private let emailToUserIdKey = "persisted_email_to_user_id"
  private let passwordsKey = "persisted_passwords"

  private init() {
    loadPersistedData()
  }
  
  // MARK: - Persistence
  /// 加载持久化的用户数据
  private func loadPersistedData() {
    // 加载用户列表
    if let usersData = UserDefaults.standard.data(forKey: usersKey),
       let serializableUsers = try? JSONSerialization.jsonObject(with: usersData) as? [String: String] {
      var loadedUsers: [String: User] = [:]
      for (key, base64String) in serializableUsers {
        if let userData = Data(base64Encoded: base64String),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
          loadedUsers[key] = user
        }
      }
      if !loadedUsers.isEmpty {
        users = loadedUsers
      } else {
        saveUsers()
      }
    } else {
      // 如果没有持久化的数据，保存默认的示例用户数据
      saveUsers()
    }
    
    // 加载邮箱到用户ID的映射
    if let emailToUserIdData = UserDefaults.standard.data(forKey: emailToUserIdKey),
       let loadedEmailToUserId = try? JSONSerialization.jsonObject(with: emailToUserIdData) as? [String: String] {
      if !loadedEmailToUserId.isEmpty {
        emailToUserId = loadedEmailToUserId
      } else {
        saveEmailToUserId()
      }
    } else {
      // 如果没有持久化的数据，保存默认的映射
      saveEmailToUserId()
    }
    
    // 加载密码（注意：实际应用中不应该持久化密码，这里只是为了演示）
    if let passwordsData = UserDefaults.standard.data(forKey: passwordsKey),
       let loadedPasswords = try? JSONSerialization.jsonObject(with: passwordsData) as? [String: String] {
      if !loadedPasswords.isEmpty {
        passwords = loadedPasswords
      } else {
        savePasswords()
      }
    } else {
      // 如果没有持久化的数据，保存默认的密码
      savePasswords()
    }
  }
  
  /// 保存用户列表到持久化存储
  private func saveUsers() {
    // 将字典转换为数组进行编码
    var serializableUsers: [String: String] = [:]
    for (key, user) in users {
      if let userData = try? JSONEncoder().encode(user) {
        serializableUsers[key] = userData.base64EncodedString()
      }
    }
    
    if let usersData = try? JSONSerialization.data(withJSONObject: serializableUsers) {
      UserDefaults.standard.set(usersData, forKey: usersKey)
    }
  }
  
  /// 保存邮箱到用户ID的映射到持久化存储
  private func saveEmailToUserId() {
    // [String: String] 可以直接使用 JSONSerialization
    if let emailToUserIdData = try? JSONSerialization.data(withJSONObject: emailToUserId) {
      UserDefaults.standard.set(emailToUserIdData, forKey: emailToUserIdKey)
    }
  }
  
  /// 保存密码到持久化存储（注意：实际应用中不应该持久化密码）
  private func savePasswords() {
    // [String: String] 可以直接使用 JSONSerialization
    if let passwordsData = try? JSONSerialization.data(withJSONObject: passwords) {
      UserDefaults.standard.set(passwordsData, forKey: passwordsKey)
    }
  }

  // MARK: - Login
  func login(email: String, password: String) async throws -> AuthResponse {
    // 模拟网络延迟
    try await Task.sleep(nanoseconds: 1_000_000_000)

    // 模拟网络错误（10% 概率）
    if Int.random(in: 1...10) == 1 {
      throw AuthError.networkError("Network connection failed, please try again later.")
    }

    // 验证邮箱格式
    guard isValidEmail(email) else {
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    // 验证密码长度
    guard password.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    // 查找用户
    let emailKey = email.lowercased()
    guard let userId = emailToUserId[emailKey],
      let user = users[userId]
    else {
      throw AuthError.userNotFound("User does not exist.")
    }

    // 验证密码
    guard passwords[emailKey] == password else {
      throw AuthError.invalidCredentials("Incorrect email or password.")
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
      throw AuthError.networkError("Network connection failed, please try again later.")
    }

    // 验证邮箱格式
    guard isValidEmail(email) else {
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    // 验证密码长度
    guard password.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    // 验证用户名长度
    guard username.count >= 2 && username.count <= 20 else {
      throw AuthError.invalidUsername("The username must be between 2 and 20 characters long.")
    }

    // 检查邮箱是否已注册
    let emailKey = email.lowercased()
    if emailToUserId[emailKey] != nil {
      throw AuthError.emailAlreadyExists("The email has already been registered.")
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
    
    // 持久化数据
    saveUsers()
    saveEmailToUserId()
    savePasswords()

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
      
      // 持久化数据
      saveUsers()
      saveEmailToUserId()
      savePasswords()
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
      quickLoginUser.id == userId
    {
      users.removeValue(forKey: userId)
      if !quickLoginUser.email.isEmpty {
        emailToUserId.removeValue(forKey: quickLoginUser.email)
        passwords.removeValue(forKey: quickLoginUser.email)
      }
      
      // 持久化数据
      saveUsers()
      saveEmailToUserId()
      savePasswords()
      clearQuickLoginUser()
    }
  }

  // MARK: - Delete User Account (通用)
  func deleteUserAccount(userId: String) async throws {
    // 模拟网络延迟
    try await Task.sleep(nanoseconds: 600_000_000)

    // 清理该用户发布的视频
    let videoService = VideoDataService.shared
    let remainingVideos = videoService.loadVideos().filter { $0.authorId != userId }
    videoService.saveVideos(remainingVideos)

    // 清理该用户发布的评论（遍历所有视频的评论）
    let commentService = CommentDataService.shared
    let videoIds = Set(remainingVideos.map { $0.id })
    for videoId in videoIds {
      let comments = commentService.loadComments(for: videoId)
      let filtered = comments.filter { $0.authorId != userId }
      if filtered.count != comments.count {
        commentService.saveComments(for: videoId, comments: filtered)
      }
    }

    // 移除用户信息
    if let user = users[userId] {
      users.removeValue(forKey: userId)
      if !user.email.isEmpty {
        emailToUserId.removeValue(forKey: user.email)
        passwords.removeValue(forKey: user.email)
      }
      
      // 持久化数据
      saveUsers()
      saveEmailToUserId()
      savePasswords()
    }

    // 如果是快速登录用户，也移除本地缓存
    if let quickLoginUser = getQuickLoginUser(),
      quickLoginUser.id == userId
    {
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
      let user = try? JSONDecoder().decode(User.self, from: userData)
    else {
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
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    // 验证密码长度
    guard newPassword.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    // 查找用户
    let emailKey = email.lowercased()
    guard emailToUserId[emailKey] != nil else {
      throw AuthError.userNotFound("User does not exist.")
    }

    // 更新密码
    passwords[emailKey] = newPassword
    savePasswords() // 持久化密码

    // 如果这是快速登录用户，也需要更新
    if let quickLoginUser = getQuickLoginUser(),
      quickLoginUser.email == emailKey
    {
      saveQuickLoginUser(quickLoginUser)
    }
  }

  // MARK: - Get User By ID
  func getUserById(_ userId: String) -> User? {
    return users[userId]
  }
  
  // MARK: - Update User
  /// 更新用户信息（同步更新用户列表）
  func updateUser(_ user: User) {
    users[user.id] = user
    saveUsers() // 持久化用户列表
    
    // 如果是快速登录用户，也需要更新本地缓存
    if let quickLoginUser = getQuickLoginUser(),
       quickLoginUser.id == user.id
    {
      saveQuickLoginUser(user)
    }
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
