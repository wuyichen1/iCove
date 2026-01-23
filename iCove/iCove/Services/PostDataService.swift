//
//  PostDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

/// 帖子数据服务协议
protocol PostDataServiceProtocol {
  func loadAllPosts() -> [Post]
  func loadCollectedPosts() -> [Post]
  func loadCollectedPosts(by postIds: [String]) -> [Post]  // 根据帖子ID列表获取收藏的帖子
  func getPostById(_ postId: String) -> Post?
  func updatePost(_ post: Post)
  func addPost(_ post: Post)  // 添加新帖子
}

/// 帖子数据服务 - 负责帖子数据的存储和管理
class PostDataService: PostDataServiceProtocol {
  static let shared = PostDataService()

  private let postsKey = "saved_posts"

  // MARK: - 示例帖子数据（用于初始化）
  private let samplePosts: [Post] = [
    // Maddison的帖子（根据UI图）
    Post(
      id: "post_001",
      imageNames: [
        "qC2VdAxOOOikJD6i11",
        "qC2VdAxOOOikJD6i12",
        "qC2VdAxOOOikJD6i13",
      ],
      authorId: "user_002",
      content:
        "A must-read for office workers! My colleagues thought I had changed five wardrobes every week without repeating my commute! Go on an autumn date! Caramel-colored outfit + beret, walking among the fallen leaves feels like a movie scene, gentle to the core",
      timestamp: Date().addingTimeInterval(-3600)
    ),
    Post(
      id: "post_002",
      imageNames: [
        "qC2VdAxOOOikJD6i21",
        "qC2VdAxOOOikJD6i22",
        "qC2VdAxOOOikJD6i23",
        "qC2VdAxOOOikJD6i24",
      ],
      authorId: "user_003",
      content:
        "Spring collection is here! Fresh and elegant style for your daily commute. Perfect combination of comfort and fashion.",
      timestamp: Date().addingTimeInterval(-7200)
    ),
    Post(
      id: "post_003",
      imageNames: [
        "qC2VdAxOOOikJD6i31",
        "qC2VdAxOOOikJD6i32",
        "qC2VdAxOOOikJD6i33",
        "qC2VdAxOOOikJD6i34",
        "qC2VdAxOOOikJD6i35",
      ],
      authorId: "user_004",
      content:
        "Weekend vibes! Casual chic outfit perfect for a day out. Comfortable yet stylish, this is how I spend my weekends.",
      timestamp: Date().addingTimeInterval(-14400)
    ),
  ]

  private init() {
    // 如果是首次启动，初始化示例数据
    if loadAllPosts().isEmpty {
      initializeSamplePosts()
    }
  }

  // MARK: - Public Methods

  func loadAllPosts() -> [Post] {
    guard let data = UserDefaults.standard.data(forKey: postsKey),
      let posts = try? JSONDecoder().decode([Post].self, from: data)
    else {
      return []
    }
    return posts
  }

  func savePosts(_ posts: [Post]) {
    if let data = try? JSONEncoder().encode(posts) {
      UserDefaults.standard.set(data, forKey: postsKey)
    }
  }

  func loadCollectedPosts() -> [Post] {
    // 此方法已废弃，收藏的帖子现在根据用户收藏ID列表动态获取
    return []
  }

  func loadCollectedPosts(by postIds: [String]) -> [Post] {
    // 根据帖子ID列表从全部帖子中筛选出收藏的帖子
    let allPosts = loadAllPosts()
    return allPosts.filter { postIds.contains($0.id) }
  }

  func getPostById(_ postId: String) -> Post? {
    let allPosts = loadAllPosts()
    return allPosts.first(where: { $0.id == postId })
  }

  func updatePost(_ post: Post) {
    var posts = loadAllPosts()
    if let index = posts.firstIndex(where: { $0.id == post.id }) {
      posts[index] = post
      savePosts(posts)
    }
  }

  func addPost(_ post: Post) {
    var posts = loadAllPosts()
    posts.insert(post, at: 0)  // 新帖子添加到最前面
    savePosts(posts)
  }

  // MARK: - Private Methods

  private func initializeSamplePosts() {
    savePosts(samplePosts)
  }
}
