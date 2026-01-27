//
//  DiscoverViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class DiscoverViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published var recommendedItems: [DiscoverItem] = []
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?

  @Published var collectedPosts: [Post] = []
  @Published var allPosts: [Post] = []

  // MARK: - Private Properties
  private var currentPage: Int = 1
  private let pageSize: Int = 15
  private let postService: PostDataServiceProtocol
  private var authManager: AuthenticationManager?

  // MARK: - Initialization
  init(
    postService: PostDataServiceProtocol = PostDataService.shared
  ) {
    self.postService = postService
    Task {
      await loadInitialData()
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("PostPublished"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refreshPosts()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refreshPosts()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refreshPosts()
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Public Methods
  func loadInitialData() async {
    guard !isLoading else { return }

    isLoading = true
    errorMessage = nil

    // 模拟网络请求延迟
    // try? await Task.sleep(nanoseconds: 400_000_000)

    collectedPosts = generateMockCollectedPosts()
    allPosts = generateMockAllPosts()

    isLoading = false
  }

  func refresh() async {
    currentPage = 1
    await loadCategoryContent()
  }

  func loadMore() async {
    guard !isLoading else { return }

    isLoading = true
    currentPage += 1

    // 模拟加载更多延迟
    // try? await Task.sleep(nanoseconds: 1_000_000_000)

    isLoading = false
  }

  // MARK: - Private Methods
  private func loadCategoryContent() async {
    isLoading = true
    currentPage = 1

    // try? await Task.sleep(nanoseconds: 800_000_000)

    isLoading = false
  }

  // MARK: - Post Methods
  private func generateMockCollectedPosts() -> [Post] {
    if let currentUser = authManager?.currentUser, !currentUser.collectedPostIds.isEmpty {
      let posts = postService.loadCollectedPosts(by: currentUser.collectedPostIds)
      return filterBlockedUsersPosts(posts)
    }
    return []
  }

  private func generateMockAllPosts() -> [Post] {
    let posts = postService.loadAllPosts()
    return filterBlockedUsersPosts(posts)
  }

  private func filterBlockedUsersPosts(_ posts: [Post]) -> [Post] {
    guard let blockedUserIds = authManager?.currentUser?.blockedUserIds, !blockedUserIds.isEmpty
    else {
      return posts
    }
    return posts.filter { !blockedUserIds.contains($0.authorId) }
  }

  func refreshCollectedPosts() {
    collectedPosts = generateMockCollectedPosts()
  }

  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    refreshCollectedPosts()
  }

  private func refreshPosts() {
    collectedPosts = generateMockCollectedPosts()
    allPosts = generateMockAllPosts()
  }
}

// MARK: - Post Card ViewModel
@MainActor
class PostCardViewModel: ObservableObject {
  @Published var author: User?
  private let authService: AuthenticationServiceProtocol
  private let authorId: String
  private weak var aumaOPNRYtaLzBwfO: AuthenticationManager?

  init(
    authorId: String,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    aumaOPNRYtaLzBwfO: AuthenticationManager? = nil
  ) {
    self.authService = authService
    self.authorId = authorId
    self.aumaOPNRYtaLzBwfO = aumaOPNRYtaLzBwfO
    loadAuthor(authorId: authorId)

    // 监听当前用户信息更新通知
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor in
        guard let self = self,
          let updatedUser = notification.userInfo?["user"] as? User,
          updatedUser.id == self.authorId
        else { return }
        self.author = updatedUser
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setAuthManager(_ aumaOPNRYtaLzBwfO: AuthenticationManager) {
    self.aumaOPNRYtaLzBwfO = aumaOPNRYtaLzBwfO
    // 如果之前没有找到作者信息，重新尝试加载
    if author == nil {
      loadAuthor(authorId: authorId)
    } else if let currentUser = aumaOPNRYtaLzBwfO.currentUser, currentUser.id == authorId {
      // 如果作者是当前用户，直接使用最新的用户信息
      author = currentUser
    }
  }

  private func loadAuthor(authorId: String) {
    // 首先尝试从 AuthenticationService 获取用户信息
    author = authService.getUserById(authorId)

    // 如果找不到，检查是否是当前登录用户
    if author == nil, let currentUser = aumaOPNRYtaLzBwfO?.currentUser, currentUser.id == authorId {
      author = currentUser
    }
  }
}
