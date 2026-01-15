//
//  DiscoverView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI
#if DEBUG
import HotSwiftUI  // 导入库
#endif

struct DiscoverView: View {
    @StateObject private var viewModel = DiscoverViewModel()
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("发现")
                .navigationBarTitleDisplayMode(.large)
                .refreshable {
                    await viewModel.refresh()
                }
        }
        .enableInjection()
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading && viewModel.recommendedItems.isEmpty {
            ProgressView("加载中...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error) {
                Task {
                    await viewModel.loadInitialData()
                }
            }
        } else {
            ScrollView {
                VStack(spacing: 20) {
                    // 热门话题
                    trendingTopicsSection
                    
                    // 分类选择
                    categorySection
                    
                    // 推荐内容
                    recommendedContentSection
                }
                .padding()
            }
        }
    }
    
    // MARK: - Trending Topics Section
    private var trendingTopicsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("热门话题")
                .font(.headline)
                .padding(.horizontal, 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.trendingTopics) { topic in
                        TrendingTopicChip(topic: topic) {
                            viewModel.toggleFollow(for: topic)
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
    
    // MARK: - Category Section
    private var categorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(DiscoverCategory.allCases, id: \.self) { category in
                    CategoryChip(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectCategory(category)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
    
    // MARK: - Recommended Content Section
    private var recommendedContentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("推荐内容")
                .font(.headline)
                .padding(.horizontal, 4)
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.recommendedItems) { item in
                    DiscoverItemCard(item: item)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if !viewModel.recommendedItems.isEmpty {
                    LoadMoreButton {
                        Task {
                            await viewModel.loadMore()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Trending Topic Chip
struct TrendingTopicChip: View {
    let topic: TrendingTopic
    let onFollowTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            if topic.trend == .up {
                Image(systemName: "arrow.up.right")
                    .font(.caption2)
                    .foregroundColor(.red)
            }
            
            Text(topic.name)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text("\(topic.postCount)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button(action: onFollowTapped) {
                Image(systemName: topic.isFollowing ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundColor(topic.isFollowing ? .blue : .secondary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}

// MARK: - Category Chip
struct CategoryChip: View {
    let category: DiscoverCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.displayName)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .cornerRadius(20)
        }
    }
}

// MARK: - Discover Item Card
struct DiscoverItemCard: View {
    let item: DiscoverItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 分类标签
            HStack {
                Text(item.category.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                
                Spacer()
                
                Text(item.viewCount.formatted() + " 浏览")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // 标题和描述
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            // 作者和时间
            HStack {
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 24, height: 24)
                    .overlay {
                        Text(String(item.author.prefix(1)))
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                
                Text(item.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("·")
                    .foregroundColor(.secondary)
                
                Text(item.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    DiscoverView()
}
