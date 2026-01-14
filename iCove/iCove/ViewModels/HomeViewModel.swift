//
//  HomeViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var feedItems: [FeedItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var refreshState: RefreshState = .idle
    
    // MARK: - Private Properties
    private var currentPage: Int = 1
    private let pageSize: Int = 20
    
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
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 模拟数据加载
        let mockItems = generateMockFeedItems(page: 1, size: pageSize)
        
        feedItems = mockItems
        isLoading = false
    }
    
    func refresh() async {
        refreshState = .refreshing
        currentPage = 1
        
        // 模拟刷新延迟
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        let mockItems = generateMockFeedItems(page: 1, size: pageSize)
        feedItems = mockItems
        
        refreshState = .idle
    }
    
    func loadMore() async {
        guard !isLoading else { return }
        
        isLoading = true
        currentPage += 1
        
        // 模拟加载更多延迟
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        let newItems = generateMockFeedItems(page: currentPage, size: pageSize)
        feedItems.append(contentsOf: newItems)
        
        isLoading = false
    }
    
    func toggleLike(for item: FeedItem) {
        if let index = feedItems.firstIndex(where: { $0.id == item.id }) {
            feedItems[index].isLiked.toggle()
            if feedItems[index].isLiked {
                feedItems[index].likeCount += 1
            } else {
                feedItems[index].likeCount = max(0, feedItems[index].likeCount - 1)
            }
        }
    }
    
    // MARK: - Private Methods
    private func generateMockFeedItems(page: Int, size: Int) -> [FeedItem] {
        let startIndex = (page - 1) * size
        return (startIndex..<startIndex + size).map { index in
            FeedItem(
                id: UUID().uuidString,
                title: "内容标题 \(index + 1)",
                content: "这是第 \(index + 1) 条内容，包含一些描述信息。",
                author: "用户\(index % 10 + 1)",
                timestamp: Date().addingTimeInterval(-Double(index * 3600)),
                likeCount: Int.random(in: 0...1000),
                commentCount: Int.random(in: 0...500),
                isLiked: Bool.random()
            )
        }
    }
}

// MARK: - Supporting Types
struct FeedItem: Identifiable {
    let id: String
    let title: String
    let content: String
    let author: String
    let timestamp: Date
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
}

enum RefreshState {
    case idle
    case refreshing
}
