//
//  AuthenticationManager.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class AuthenticationManager: ObservableObject {
  @Published var isAuthenticated: Bool = false
  @Published var currentUser: User?
  @Published var authToken: String?
  @Published var isQuickLogin: Bool = false

  private let authService: AuthenticationServiceProtocol
  private let tokenKey = "auth_token"
  private let userKey = "current_user"
  private let loginTypeKey = "login_type"  // "normal" 或 "quick"

  init(authService: AuthenticationServiceProtocol = AuthenticationService.shared) {
    self.authService = authService
    loadSavedAuthState()
  }

  func login(email: String, password: String) async throws {
    let response = try await authService.login(email: email, password: password)

    authToken = response.token
    currentUser = response.user
    isAuthenticated = true
    isQuickLogin = false

    saveAuthState(token: response.token, user: response.user, loginType: "normal")
  }

  func register(email: String, password: String, username: String) async throws {
    let response = try await authService.register(
      email: email, password: password, username: username)

    authToken = response.token
    currentUser = response.user
    isAuthenticated = true
    isQuickLogin = false

    saveAuthState(token: response.token, user: response.user, loginType: "normal")
  }

  func logout() async {
    if let token = authToken {
      try? await authService.logout(token: token)
    }

    let wasQuickLogin = isQuickLogin

    authToken = nil
    currentUser = nil
    isAuthenticated = false
    isQuickLogin = false

    clearAuthState(keepQuickLogin: wasQuickLogin)
  }

  func quickLogin() async throws {
    let response = try await authService.quickLogin()

    authToken = response.token
    currentUser = response.user
    isAuthenticated = true
    isQuickLogin = true

    saveAuthState(token: response.token, user: response.user, loginType: "quick")
  }

  // MARK: - Update Profile
  func updateUsername(_ newUsername: String) {
    guard var user = currentUser else { return }
    user = User(
      id: user.id,
      email: user.email,
      username: newUsername,
      avatar: user.avatar,
      balance: user.balance,
      collectedPostIds: user.collectedPostIds,
      blockedUserIds: user.blockedUserIds
    )
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")

    authService.updateUser(user)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": user]
    )
  }

  func updateAvatar(_ image: UIImage) {
    guard var user = currentUser else { return }

    let avatarFileName = saveAvatarToLocal(image, userId: user.id)

    user = User(
      id: user.id,
      email: user.email,
      username: user.username,
      avatar: avatarFileName,
      balance: user.balance,
      collectedPostIds: user.collectedPostIds,
      blockedUserIds: user.blockedUserIds
    )
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")

    authService.updateUser(user)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": user]
    )
  }

  func toggleCollectPost(postId: String) {
    guard var user = currentUser else { return }

    var collectedPostIds = user.collectedPostIds
    if collectedPostIds.contains(postId) {
      collectedPostIds.removeAll { $0 == postId }
    } else {
      collectedPostIds.append(postId)
    }

    user = User(
      id: user.id,
      email: user.email,
      username: user.username,
      avatar: user.avatar,
      balance: user.balance,
      bio: user.bio,
      collectedPostIds: collectedPostIds,
      blockedUserIds: user.blockedUserIds,
      followingUserIds: user.followingUserIds,
      followerUserIds: user.followerUserIds
    )
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")

    authService.updateUser(user)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": user]
    )

    NotificationCenter.default.post(
      name: NSNotification.Name("PostCollectionUpdated"),
      object: nil,
      userInfo: ["postId": postId, "isCollected": !collectedPostIds.contains(postId)]
    )
  }

  func isPostCollected(postId: String) -> Bool {
    return currentUser?.collectedPostIds.contains(postId) ?? false
  }

  private func saveAvatarToLocal(_ image: UIImage, userId: String) -> String {
    let fileName = "avatar_\(userId)_\(Int(Date().timeIntervalSince1970)).jpg"

    if let data = image.jpegData(compressionQuality: 0.8) {
      let documentsDirectory = FileManager.default.urls(
        for: .documentDirectory, in: .userDomainMask
      ).first!
      let userImagesDirectory = documentsDirectory.appendingPathComponent("UserImages")

      try? FileManager.default.createDirectory(
        at: userImagesDirectory, withIntermediateDirectories: true, attributes: nil)

      let fileURL = userImagesDirectory.appendingPathComponent(fileName)

      try? data.write(to: fileURL)

      return fileName
    }

    return ""
  }

  func addBalance(_ amount: Int) {
    guard var user = currentUser else { return }
    user = User(
      id: user.id,
      email: user.email,
      username: user.username,
      avatar: user.avatar,
      balance: user.balance + amount,
      collectedPostIds: user.collectedPostIds,
      blockedUserIds: user.blockedUserIds
    )
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
  }

  func deductBalance(_ amount: Int) {
    guard var user = currentUser else { return }
    let newBalance = max(0, user.balance - amount)
    user = User(
      id: user.id,
      email: user.email,
      username: user.username,
      avatar: user.avatar,
      balance: newBalance,
      collectedPostIds: user.collectedPostIds,
      blockedUserIds: user.blockedUserIds
    )
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
  }

  // MARK: - Block User Management
  func addBlockedUserId(_ userId: String) {
    guard var user = currentUser else { return }
    if !user.blockedUserIds.contains(userId) {
      user.blockedUserIds.append(userId)
      currentUser = user
      saveAuthState(
        token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
      NotificationCenter.default.post(
        name: NSNotification.Name("UserBlocked"), object: nil, userInfo: ["blockedUserId": userId])
    }
  }

  func removeBlockedUserId(_ userId: String) {
    guard var user = currentUser else { return }
    user.blockedUserIds.removeAll { $0 == userId }
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
    NotificationCenter.default.post(
      name: NSNotification.Name("UserUnblocked"), object: nil, userInfo: ["unblockedUserId": userId]
    )
  }

  func isUserBlocked(_ userId: String) -> Bool {
    return currentUser?.blockedUserIds.contains(userId) ?? false
  }

  // MARK: - Delete Account (通用)
  func deleteAccount() async throws {
    guard let userId = currentUser?.id else { return }

    try await authService.deleteUserAccount(userId: userId)

    authToken = nil
    currentUser = nil
    isAuthenticated = false
    isQuickLogin = false
    clearAuthState(keepQuickLogin: false)
  }

  // MARK: - Update User Collection
  func addCollectedPostId(_ postId: String) {
    guard var user = currentUser else { return }
    if !user.collectedPostIds.contains(postId) {
      user.collectedPostIds.append(postId)
      currentUser = user
      saveAuthState(
        token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
    }
  }

  func removeCollectedPostId(_ postId: String) {
    guard var user = currentUser else { return }
    user.collectedPostIds.removeAll { $0 == postId }
    currentUser = user
    saveAuthState(token: authToken ?? "", user: user, loginType: isQuickLogin ? "quick" : "normal")
  }

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
    if let token = UserDefaults.standard.string(forKey: tokenKey) {
      authToken = token

      if let userData = UserDefaults.standard.data(forKey: userKey),
        let user = try? JSONDecoder().decode(User.self, from: userData)
      {
        currentUser = user
        isAuthenticated = true

        let loginType = UserDefaults.standard.string(forKey: loginTypeKey)
        isQuickLogin = (loginType == "quick")
      } else {
        clearAuthState()
      }
    }
  }

  private func clearAuthState(keepQuickLogin: Bool = false) {
    UserDefaults.standard.removeObject(forKey: tokenKey)
    UserDefaults.standard.removeObject(forKey: userKey)

    if !keepQuickLogin {
      UserDefaults.standard.removeObject(forKey: loginTypeKey)
    }
  }
}
