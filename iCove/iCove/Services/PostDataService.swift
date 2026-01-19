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
}

/// 帖子数据服务 - 负责帖子数据的存储和管理
class PostDataService: PostDataServiceProtocol {
    static let shared = PostDataService()

    // MARK: - 持久化示例帖子数据

    /// 全部帖子数据（写死的示例数据）
    private let allPosts: [Post] = [
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
            timestamp: Date().addingTimeInterval(-3600),
            isCollected: false
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
            timestamp: Date().addingTimeInterval(-7200),
            isCollected: false
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
            authorId: "user_001",
            content:
                "Weekend vibes! Casual chic outfit perfect for a day out. Comfortable yet stylish, this is how I spend my weekends.",
            timestamp: Date().addingTimeInterval(-14400),
            isCollected: false
        ),
    ]

    private init() {}

    // MARK: - Public Methods

    func loadAllPosts() -> [Post] {
        return allPosts
    }

    func loadCollectedPosts() -> [Post] {
        // 此方法已废弃，收藏的帖子现在根据用户收藏ID列表动态获取
        return []
    }

    func loadCollectedPosts(by postIds: [String]) -> [Post] {
        // 根据帖子ID列表从全部帖子中筛选出收藏的帖子
        return allPosts.filter { postIds.contains($0.id) }
    }

    func getPostById(_ postId: String) -> Post? {
        return allPosts.first(where: { $0.id == postId })
    }

    func updatePost(_ post: Post) {
        // 注意：由于 allPosts 是 let 常量，这里无法直接修改
        // 在实际应用中，应该使用可变的数据源或持久化存储
        // 这里保持接口一致性，实际更新需要在持久化层处理
    }
}
