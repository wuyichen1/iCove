//
//  HomeView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("首页")
                .navigationBarTitleDisplayMode(.large)
                .refreshable {
                    await viewModel.refresh()
                }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading && viewModel.feedItems.isEmpty {
            ProgressView("加载中...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error) {
                Task {
                    await viewModel.loadInitialData()
                }
            }
        } else {
            feedListView
        }
    }
    
    private var feedListView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.feedItems) { item in
                    FeedItemCard(item: item) {
                        viewModel.toggleLike(for: item)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if !viewModel.feedItems.isEmpty {
                    LoadMoreButton {
                        Task {
                            await viewModel.loadMore()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Feed Item Card
struct FeedItemCard: View {
    let item: FeedItem
    let onLikeTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 作者信息
            HStack {
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text(String(item.author.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.author)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text(item.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // 内容
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(item.content)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            // 操作栏
            HStack(spacing: 24) {
                Button(action: onLikeTapped) {
                    HStack(spacing: 4) {
                        Image(systemName: item.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(item.isLiked ? .red : .secondary)
                        Text("\(item.likeCount)")
                            .font(.caption)
                    }
                }
                .buttonStyle(.plain)
                
                HStack(spacing: 4) {
                    Image(systemName: "message")
                        .foregroundColor(.secondary)
                    Text("\(item.commentCount)")
                        .font(.caption)
                }
                
                Spacer()
                
                Image(systemName: "bookmark")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Load More Button
struct LoadMoreButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("加载更多")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Error View
struct ErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)
            
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("重试", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}
