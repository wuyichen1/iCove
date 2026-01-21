//
//  CommentDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

/// 评论数据服务协议
protocol CommentDataServiceProtocol {
  func loadComments(for videoId: String) -> [Comment]
  func saveComments(for videoId: String, comments: [Comment])
  func addComment(_ comment: Comment)
}

/// 评论数据服务 - 负责评论数据的持久化存储
class CommentDataService: CommentDataServiceProtocol {
  static let shared = CommentDataService()

  private let commentsKeyPrefix = "comments_video_"

  private init() {
    // 初始化示例评论数据
    initializeSampleComments()
  }

  // MARK: - Public Methods

  func loadComments(for videoId: String) -> [Comment] {
    let key = commentsKeyPrefix + videoId
    guard let data = UserDefaults.standard.data(forKey: key),
      let comments = try? JSONDecoder().decode([Comment].self, from: data)
    else {
      return []
    }
    return comments.sorted { $0.timestamp > $1.timestamp }  // 最新的在前
  }

  func saveComments(for videoId: String, comments: [Comment]) {
    let key = commentsKeyPrefix + videoId
    if let data = try? JSONEncoder().encode(comments) {
      UserDefaults.standard.set(data, forKey: key)
    }
  }

  func addComment(_ comment: Comment) {
    var comments = loadComments(for: comment.videoId)
    comments.insert(comment, at: 0)  // 新评论添加到最前面
    saveComments(for: comment.videoId, comments: comments)
  }

  // MARK: - Private Methods

  private func initializeSampleComments() {
    // 为每个视频添加示例评论
    let sampleComments: [String: [Comment]] = [
      "video_001": [
        Comment(
          videoId: "video_001",
          authorId: "user_002",
          content: "It suits your style very well.",
          timestamp: Date().addingTimeInterval(-3600 * 2)
        )
      ],
      "video_002": [
        Comment(
          videoId: "video_002",
          authorId: "user_003",
          content: "The color combination is very good.",
          timestamp: Date().addingTimeInterval(-3600 * 5)
        )
      ],
      "video_003": [
        Comment(
          videoId: "video_003",
          authorId: "user_004",
          content: "You look really cool!",
          timestamp: Date().addingTimeInterval(-3600 * 8)
        )
      ],
      "video_004": [
        Comment(
          videoId: "video_004",
          authorId: "user_005",
          content: "the green jumper is SO cute",
          timestamp: Date().addingTimeInterval(-3600 * 10)
        )
      ],
      "video_005": [
        Comment(
          videoId: "video_005",
          authorId: "user_006",
          content: "Okay the star ring is actually everything",
          timestamp: Date().addingTimeInterval(-3600 * 12)
        )
      ],
      "video_006": [
        Comment(
          videoId: "video_006",
          authorId: "user_004",
          content: "A perfectly perfect daily outfit",
          timestamp: Date().addingTimeInterval(-3600 * 14)
        )
      ],
    ]

    // 为每个视频ID保存示例评论
    for (videoId, comments) in sampleComments {
      // 检查是否已经存在评论，避免重复初始化
      if loadComments(for: videoId).isEmpty && !comments.isEmpty {
        saveComments(for: videoId, comments: comments)
      }
    }
  }
}
