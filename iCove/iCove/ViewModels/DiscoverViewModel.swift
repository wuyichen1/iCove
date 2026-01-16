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
    @Published var trendingTopics: [TrendingTopic] = []
    @Published var selectedCategory: DiscoverCategory = .all
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 新的帖子相关属性
    @Published var collectedPosts: [Post] = []  // 收藏的帖子
    @Published var allPosts: [Post] = []  // 全部帖子
    
    // MARK: - Private Properties
    private var currentPage: Int = 1
    private let pageSize: Int = 15
    private let postService: PostDataServiceProtocol
    
    // MARK: - Initialization
    init(
        postService: PostDataServiceProtocol = PostDataService.shared
    ) {
        self.postService = postService
        Task {
            await loadInitialData()
        }
    }
    
    // MARK: - Public Methods
    func loadInitialData() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        try? await Task.sleep(nanoseconds: 1_200_000_000)
        
        // 加载推荐内容和热门话题
        recommendedItems = generateMockRecommendedItems()
        trendingTopics = generateMockTrendingTopics()
        
        // 加载帖子数据
        collectedPosts = generateMockCollectedPosts()
        allPosts = generateMockAllPosts()
        
        isLoading = false
    }
    
    func selectCategory(_ category: DiscoverCategory) {
        selectedCategory = category
        Task {
            await loadCategoryContent()
        }
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
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let newItems = generateMockRecommendedItems(for: selectedCategory, page: currentPage)
        recommendedItems.append(contentsOf: newItems)
        
        isLoading = false
    }
    
    func toggleFollow(for topic: TrendingTopic) {
        if let index = trendingTopics.firstIndex(where: { $0.id == topic.id }) {
            trendingTopics[index].isFollowing.toggle()
        }
    }
    
    // MARK: - Private Methods
    private func loadCategoryContent() async {
        isLoading = true
        currentPage = 1
        
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        recommendedItems = generateMockRecommendedItems(for: selectedCategory, page: 1)
        
        isLoading = false
    }
    
    private func generateMockRecommendedItems(for category: DiscoverCategory = .all, page: Int = 1) -> [DiscoverItem] {
        let startIndex = (page - 1) * pageSize
        let categories: [DiscoverCategory] = category == .all ? [.tech, .design, .lifestyle, .travel] : [category]
        
        return (startIndex..<startIndex + pageSize).map { index in
            let randomCategory = categories.randomElement() ?? .all
            return DiscoverItem(
                id: UUID().uuidString,
                title: "\(randomCategory.displayName) - 推荐内容 \(index + 1)",
                description: "这是来自 \(randomCategory.displayName) 类别的推荐内容，包含有趣的发现和探索。",
                imageUrl: nil,
                category: randomCategory,
                viewCount: Int.random(in: 100...10000),
                author: "创作者\(index % 20 + 1)",
                timestamp: Date().addingTimeInterval(-Double(index * 1800))
            )
        }
    }
    
    private func generateMockTrendingTopics() -> [TrendingTopic] {
        let topics = ["SwiftUI", "iOS开发", "设计灵感", "科技前沿", "生活分享", "旅行日记"]
        return topics.enumerated().map { index, name in
            TrendingTopic(
                id: UUID().uuidString,
                name: name,
                postCount: Int.random(in: 100...5000),
                isFollowing: Bool.random(),
                trend: index < 3 ? .up : .stable
            )
        }
    }
    
    // MARK: - Post Methods
    private func generateMockCollectedPosts() -> [Post] {
        return postService.loadCollectedPosts()
    }
    
    private func generateMockAllPosts() -> [Post] {
        return postService.loadAllPosts()
    }
}

