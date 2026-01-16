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
    func getPostById(_ postId: String) -> Post?
    func updatePost(_ post: Post)
}

/// 帖子数据服务 - 负责帖子数据的存储和管理
class PostDataService: PostDataServiceProtocol {
    static let shared = PostDataService()
    
    private var allPosts: [Post] = []
    private var collectedPosts: [Post] = []
    
    private init() {
        initializeSamplePosts()
    }
    
    // MARK: - Public Methods
    
    func loadAllPosts() -> [Post] {
        return allPosts
    }
    
    func loadCollectedPosts() -> [Post] {
        return collectedPosts
    }
    
    func getPostById(_ postId: String) -> Post? {
        return allPosts.first(where: { $0.id == postId }) ?? collectedPosts.first(where: { $0.id == postId })
    }
    
    func updatePost(_ post: Post) {
        if let index = allPosts.firstIndex(where: { $0.id == post.id }) {
            allPosts[index] = post
        }
        if let index = collectedPosts.firstIndex(where: { $0.id == post.id }) {
            collectedPosts[index] = post
        }
    }
    
    // MARK: - Private Methods
    
    private func initializeSamplePosts() {
        // 生成收藏的帖子数据
        let mockImageNames = [
            ["1akQNNqBpWFE3YsJ0J", "ZOVugBKGBc2g0HA3", "Qc4hYFPT1LVSkXq5"],
            ["f2YTqp3rK3ZgautI", "YLXVqZ8wbqT0SSgp1"],
            ["1akQNNqBpWFE3YsJ0J", "ZOVugBKGBc2g0HA3", "Qc4hYFPT1LVSkXq5", "f2YTqp3rK3ZgautI"],
        ]
        
        collectedPosts = mockImageNames.enumerated().map { index, images in
            Post(
                id: "collected_\(index)",
                imageNames: images,
                authorId: "user_00\(index + 1)",
                authorUsername: "用户\(index + 1)",
                authorAvatar: nil,
                content: "这是一个收藏的帖子内容 \(index + 1)",
                timestamp: Date().addingTimeInterval(-Double(index * 3600)),
                isCollected: true
            )
        }
        
        // 生成全部帖子数据，包含Maddison的示例帖子
        var posts: [Post] = []
        
        // Maddison的帖子（根据UI图）
        posts.append(Post(
            id: "post_maddison_001",
            imageNames: [
                "1akQNNqBpWFE3YsJ0J",
                "ZOVugBKGBc2g0HA3",
                "Qc4hYFPT1LVSkXq5",
                "f2YTqp3rK3ZgautI",
                "YLXVqZ8wbqT0SSgp1"
            ],
            authorId: "user_maddison",
            authorUsername: "Maddison",
            authorAvatar: "1akQNNqBpWFE3YsJ0J",
            content: "A must-read for office workers! My colleagues thought I had changed five wardrobes every week without repeating my commute! Go on an autumn date! Caramel-colored outfit + beret, walking among the fallen leaves feels like a movie scene, gentle to the core",
            timestamp: Date().addingTimeInterval(-3600),
            isCollected: false
        ))
        
        // 更多示例帖子
        let mockImageSets = [
            ["1akQNNqBpWFE3YsJ0J", "ZOVugBKGBc2g0HA3"],
            ["Qc4hYFPT1LVSkXq5", "f2YTqp3rK3ZgautI", "YLXVqZ8wbqT0SSgp1"],
            ["1akQNNqBpWFE3YsJ0J", "ZOVugBKGBc2g0HA3", "Qc4hYFPT1LVSkXq5"],
        ]
        
        for (index, images) in mockImageSets.enumerated() {
            posts.append(Post(
                id: "post_\(index)",
                imageNames: images,
                authorId: "user_00\(index + 2)",
                authorUsername: "用户\(index + 2)",
                authorAvatar: nil,
                content: "这是帖子内容 \(index + 1)，展示了一些好看的搭配。",
                timestamp: Date().addingTimeInterval(-Double(index * 7200)),
                isCollected: index % 2 == 0
            ))
        }
        
        allPosts = posts
    }
}
