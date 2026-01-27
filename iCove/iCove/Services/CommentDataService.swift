//
//  CommentDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol CommentDataServiceProtocol {
  func loadComments(for videoId: String) -> [Comment]
  func saveComments(for videoId: String, comments: [Comment])
  func addComment(_ comment: Comment)
  func deleteComments(for videoId: String)
}

class CommentDataService: CommentDataServiceProtocol {
  static let shared = CommentDataService()

  private let commentsKeyPrefix = "comments_video_"

  private init() {
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
    return comments.sorted { $0.timestamp > $1.timestamp }
  }

  func saveComments(for videoId: String, comments: [Comment]) {
    let key = commentsKeyPrefix + videoId
    if let data = try? JSONEncoder().encode(comments) {
      UserDefaults.standard.set(data, forKey: key)
    }
  }

  func addComment(_ comment: Comment) {
    var comments = loadComments(for: comment.videoId)
    comments.insert(comment, at: 0)
    saveComments(for: comment.videoId, comments: comments)
  }

  func deleteComments(for videoId: String) {
    let key = commentsKeyPrefix + videoId
    UserDefaults.standard.removeObject(forKey: key)
  }

  private func initializeSampleComments() {
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

    for (videoId, comments) in sampleComments {
      if loadComments(for: videoId).isEmpty && !comments.isEmpty {
        saveComments(for: videoId, comments: comments)
      }
    }
  }
}
