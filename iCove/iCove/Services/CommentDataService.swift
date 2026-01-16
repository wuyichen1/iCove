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
              let comments = try? JSONDecoder().decode([Comment].self, from: data) else {
            return []
        }
        return comments.sorted { $0.timestamp > $1.timestamp } // 最新的在前
    }
    
    func saveComments(for videoId: String, comments: [Comment]) {
        let key = commentsKeyPrefix + videoId
        if let data = try? JSONEncoder().encode(comments) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func addComment(_ comment: Comment) {
        var comments = loadComments(for: comment.videoId)
        comments.insert(comment, at: 0) // 新评论添加到最前面
        saveComments(for: comment.videoId, comments: comments)
    }
    
    // MARK: - Private Methods
    
    private func initializeSampleComments() {
        // 为每个视频添加示例评论
        let sampleComments: [String: [Comment]] = [
            "": [ // 使用视频ID，这里先用空字符串作为示例
                Comment(
                    videoId: "",
                    authorId: "user_002",
                    content: "Your outfit is just amazing. This video is very practical.",
                    timestamp: Date().addingTimeInterval(-3600 * 2)
                ),
                Comment(
                    videoId: "",
                    authorId: "user_003",
                    content: "Love this style! Can't wait to try it out.",
                    timestamp: Date().addingTimeInterval(-3600 * 5)
                )
            ]
        ]
        
        // 为每个视频ID保存示例评论
        for (videoId, comments) in sampleComments {
            if !comments.isEmpty {
                saveComments(for: videoId, comments: comments)
            }
        }
    }
}
