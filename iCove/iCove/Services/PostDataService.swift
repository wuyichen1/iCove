//
//  PostDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol PostDataServiceProtocol {
  func loadAllPosts() -> [Post]
  func loadCollectedPosts(by postIds: [String]) -> [Post]
  func getPostById(_ postId: String) -> Post?
  func updatePost(_ post: Post)
  func addPost(_ post: Post)
  func deletePostsByAuthor(_ authorId: String) -> [String]
}

class PostDataService: PostDataServiceProtocol {
  static let shared = PostDataService()

  private let postsKey = "saved_posts"

  private let samplePosts: [Post] = [
    Post(
      id: "post_001",
      imageNames: [
        "qC2VdAxOOOikJD6i11",
        "qC2VdAxOOOikJD6i12",
        "qC2VdAxOOOikJD6i13",
      ],
      authorId: "user_002",
      content:
        "Today, I wore a red sweater and a floral skirt, and added some delicate touches with pearl earrings.",
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
        "Who knows? Recently, I've been super into the green color scheme. Whether it's dark green or light green, it always looks super textured when worn.",
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
        "The main focus is on comfort. Simple combination, neat and tidy.",
      timestamp: Date().addingTimeInterval(-14400)
    ),
  ]

  private init() {
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

  func loadCollectedPosts(by postIds: [String]) -> [Post] {
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
    posts.insert(post, at: 0) 
    savePosts(posts)
  }

  func deletePostsByAuthor(_ authorId: String) -> [String] {
    let posts = loadAllPosts()
    let toRemove = posts.filter { $0.authorId == authorId }
    let removedIds = toRemove.map(\.id)
    let remaining = posts.filter { $0.authorId != authorId }
    savePosts(remaining)
    return removedIds
  }

  // MARK: - Private Methods

  private func initializeSamplePosts() {
    savePosts(samplePosts)
  }
}
