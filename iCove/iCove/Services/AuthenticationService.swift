//
//  AuthenticationService.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

protocol AuthenticationServiceProtocol {
  func login(email: String, password: String) async throws -> AuthResponse
  func register(email: String, password: String, username: String) async throws -> AuthResponse
  func logout(token: String) async throws
  func quickLogin() async throws -> AuthResponse
  // func deleteQuickLoginUser(userId: String) async throws
  func deleteUserAccount(userId: String) async throws
  func resetPassword(email: String, newPassword: String) async throws
  func getUserById(_ userId: String) -> User?
  func updateUser(_ user: User)
}

class AuthenticationService: AuthenticationServiceProtocol {
  static let shared = AuthenticationService()

  // 模拟用户数据库 - 使用 userId 作为 key
  private var users: [String: User] = [
    "user_001": User(
      id: "user_001",
      email: "icove@gmail.com",
      username: "Garrett",
      avatar: "eitJTglOzkSfZvNi1",
      balance: 1000,
      collectedPostIds: ["post_001", "post_002", "post_003"],
      blockedUserIds: [],
      followingUserIds: ["user_002", "user_003"],
      followerUserIds: ["user_002"]
    ),
    "user_002": User(
      id: "user_002",
      email: "",
      username: "Nolan",
      avatar: "eitJTglOzkSfZvNi2",
      balance: 0,
      followingUserIds: ["user_001"],
      followerUserIds: ["user_001"]
    ),
    "user_003": User(
      id: "user_003",
      email: "",
      username: "Bishop",
      avatar: "eitJTglOzkSfZvNi3",
      balance: 0,
      followerUserIds: ["user_001"]
    ),
    "user_004": User(
      id: "user_004",
      email: "",
      username: "Ruth",
      avatar: "eitJTglOzkSfZvNi4",
      balance: 0
    ),
    "user_005": User(
      id: "user_005",
      email: "",
      username: "Silvia",
      avatar: "eitJTglOzkSfZvNi5",
      balance: 0
    ),
    "user_006": User(
      id: "user_006",
      email: "",
      username: "Glinda",
      avatar: "eitJTglOzkSfZvNi6",
      balance: 0
    ),
  ]

  // 邮箱到用户 ID 的映射（仅用于可登录用户）
  private var emailToUserId: [String: String] = [
    "icove@gmail.com": "user_001"
  ]

  // 密码存储：email -> password（仅用于可登录用户）
  private var passwords: [String: String] = [
    "icove@gmail.com": "123456"
  ]

  private let usersKey = "persisted_users"
  private let emailToUserIdKey = "persisted_email_to_user_id"
  private let passwordsKey = "persisted_passwords"

  private init() {
    loadPersistedData()
  }

  // MARK: - Persistence
  private func loadPersistedData() {
    if let usersData = UserDefaults.standard.data(forKey: usersKey),
      let serializableUsers = try? JSONSerialization.jsonObject(with: usersData)
        as? [String: String]
    {
      var loadedUsers: [String: User] = [:]
      for (key, base64String) in serializableUsers {
        if let userData = Data(base64Encoded: base64String),
          let user = try? JSONDecoder().decode(User.self, from: userData)
        {
          loadedUsers[key] = user
        }
      }
      if !loadedUsers.isEmpty {
        users = loadedUsers
      } else {
        saveUsers()
      }
    } else {
      saveUsers()
    }

    // 加载邮箱到用户ID的映射
    if let emailToUserIdData = UserDefaults.standard.data(forKey: emailToUserIdKey),
      let loadedEmailToUserId = try? JSONSerialization.jsonObject(with: emailToUserIdData)
        as? [String: String]
    {
      if !loadedEmailToUserId.isEmpty {
        emailToUserId = loadedEmailToUserId
      } else {
        saveEmailToUserId()
      }
    } else {
      saveEmailToUserId()
    }

    if let passwordsData = UserDefaults.standard.data(forKey: passwordsKey),
      let loadedPasswords = try? JSONSerialization.jsonObject(with: passwordsData)
        as? [String: String]
    {
      if !loadedPasswords.isEmpty {
        passwords = loadedPasswords
      } else {
        savePasswords()
      }
    } else {
      savePasswords()
    }
  }

  private func saveUsers() {
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

  private func saveEmailToUserId() {
    if let emailToUserIdData = try? JSONSerialization.data(withJSONObject: emailToUserId) {
      UserDefaults.standard.set(emailToUserIdData, forKey: emailToUserIdKey)
    }
  }

  private func savePasswords() {
    if let passwordsData = try? JSONSerialization.data(withJSONObject: passwords) {
      UserDefaults.standard.set(passwordsData, forKey: passwordsKey)
    }
  }

  // MARK: - Login
  func login(email: String, password: String) async throws -> AuthResponse {
    // 模拟网络延迟
    try await Task.sleep(nanoseconds: 1_000_000_000)

    guard isValidEmail(email) else {
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    guard password.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    let emailKey = email.lowercased()
    guard let userId = emailToUserId[emailKey],
      let user = users[userId]
    else {
      throw AuthError.userNotFound("User does not exist.")
    }

    guard passwords[emailKey] == password else {
      throw AuthError.invalidCredentials("Incorrect email or password.")
    }

    let token = generateToken(for: user.id)

    return AuthResponse(
      token: token,
      user: user
    )
  }

  // MARK: - Register
  func register(email: String, password: String, username: String) async throws -> AuthResponse {
    // 模拟网络延迟
    try await Task.sleep(nanoseconds: 1_000_000_000)

    guard isValidEmail(email) else {
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    guard password.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    guard username.count >= 2 && username.count <= 20 else {
      throw AuthError.invalidUsername("The username must be between 2 and 20 characters long.")
    }

    let emailKey = email.lowercased()
    if emailToUserId[emailKey] != nil {
      throw AuthError.emailAlreadyExists("The email has already been registered.")
    }

    let userId = "user_\(UUID().uuidString.prefix(8))"
    let newUser = User(
      id: userId,
      email: emailKey,
      username: username,
      avatar: "icove_logo",
      balance: 0
    )
    users[userId] = newUser
    emailToUserId[emailKey] = userId
    passwords[emailKey] = password

    saveUsers()
    saveEmailToUserId()
    savePasswords()

    let token = generateToken(for: userId)

    return AuthResponse(
      token: token,
      user: newUser
    )
  }

  // MARK: - Logout
  func logout(token: String) async throws {
    try await Task.sleep(nanoseconds: 300_000_000)
  }

  // MARK: - Quick Login
  func quickLogin() async throws -> AuthResponse {
    try await Task.sleep(nanoseconds: 1_000_000_000)

    if let quickLoginUser = getQuickLoginUser() {
      let token = generateToken(for: quickLoginUser.id)
      return AuthResponse(
        token: token,
        user: quickLoginUser
      )
    } else {
      let userId = "quick_\(UUID().uuidString.prefix(8))"
      let email = "quick_\(UUID().uuidString.prefix(8))@quicklogin.local"
      let username = "Quick\(Int.random(in: 1000...9999))"
      let password = UUID().uuidString

      let newUser = User(
        id: userId,
        email: email,
        username: username,
        avatar: "icove_logo",
        balance: 0
      )

      users[userId] = newUser
      emailToUserId[email] = userId
      passwords[email] = password

      saveUsers()
      saveEmailToUserId()
      savePasswords()
      saveQuickLoginUser(newUser)

      let token = generateToken(for: userId)

      return AuthResponse(
        token: token,
        user: newUser
      )
    }
  }

  // MARK: - Delete User Account (通用)
  func deleteUserAccount(userId: String) async throws {
    try await Task.sleep(nanoseconds: 500_000_000)

    let videoService = VideoDataService.shared
    let commentService = CommentDataService.shared
    let postService = PostDataService.shared
    let conversationService = ConversationDataService.shared
    let messageService = MessageDataService.shared

    let allVideos = videoService.loadVideos()
    let deletedVideoIds = allVideos.filter { $0.authorId == userId }.map(\.id)
    let remainingVideos = allVideos.filter { $0.authorId != userId }
    videoService.saveVideos(remainingVideos)

    for videoId in deletedVideoIds {
      commentService.deleteComments(for: videoId)
    }
    let remainingVideoIds = Set(remainingVideos.map(\.id))
    for videoId in remainingVideoIds {
      let comments = commentService.loadComments(for: videoId)
      let filtered = comments.filter { $0.authorId != userId }
      if filtered.count != comments.count {
        commentService.saveComments(for: videoId, comments: filtered)
      }
    }

    let deletedPostIds = postService.deletePostsByAuthor(userId)

    let allConversations = conversationService.loadAllConversations()
    let conversationsToRemove = allConversations.filter { $0.participantIds.contains(userId) }
    for conv in conversationsToRemove {
      messageService.deleteMessagesForConversation(conv.id)
      conversationService.deleteConversation(conv.id)
    }

    for (uid, var u) in users where uid != userId {
      u.followingUserIds.removeAll { $0 == userId }
      u.followerUserIds.removeAll { $0 == userId }
      u.blockedUserIds.removeAll { $0 == userId }
      u.collectedPostIds.removeAll { deletedPostIds.contains($0) }
      users[uid] = u
    }

    if let user = users[userId] {
      users.removeValue(forKey: userId)
      if !user.email.isEmpty {
        emailToUserId.removeValue(forKey: user.email)
        passwords.removeValue(forKey: user.email)
      }
      saveUsers()
      saveEmailToUserId()
      savePasswords()
    }

    if let quickLoginUser = getQuickLoginUser(), quickLoginUser.id == userId {
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

    return users[user.id]
  }

  private func clearQuickLoginUser() {
    UserDefaults.standard.removeObject(forKey: "quick_login_user")
  }

  // MARK: - Reset Password
  func resetPassword(email: String, newPassword: String) async throws {
    // 模拟网络延迟
    try await Task.sleep(nanoseconds: 1_500_000_000)

    guard isValidEmail(email) else {
      throw AuthError.invalidEmail("Incorrect email format.")
    }

    guard newPassword.count >= 6 else {
      throw AuthError.invalidPassword("The password must be at least 6 characters long.")
    }

    let emailKey = email.lowercased()
    guard emailToUserId[emailKey] != nil else {
      throw AuthError.userNotFound("User does not exist.")
    }

    passwords[emailKey] = newPassword
    savePasswords()

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
  func updateUser(_ user: User) {
    users[user.id] = user
    saveUsers()

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
    return "token_\(userId)_\(UUID().uuidString.prefix(16))"
  }
}
