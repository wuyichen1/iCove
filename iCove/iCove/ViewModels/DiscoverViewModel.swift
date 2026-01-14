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
    
    // MARK: - Private Properties
    private var currentPage: Int = 1
    private let pageSize: Int = 15
    
    // MARK: - Initialization
    init() {
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
}

// MARK: - Supporting Types
struct DiscoverItem: Identifiable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String?
    let category: DiscoverCategory
    let viewCount: Int
    let author: String
    let timestamp: Date
}

struct TrendingTopic: Identifiable {
    let id: String
    let name: String
    let postCount: Int
    var isFollowing: Bool
    let trend: TrendDirection
}

enum DiscoverCategory: String, CaseIterable {
    case all = "全部"
    case tech = "科技"
    case design = "设计"
    case lifestyle = "生活"
    case travel = "旅行"
    
    var displayName: String {
        return self.rawValue
    }
}

enum TrendDirection {
    case up
    case down
    case stable
}
