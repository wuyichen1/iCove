//
//  MessagesView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI
#if DEBUG
import HotSwiftUI  // 导入库
#endif

struct MessagesView: View {
    @StateObject private var viewModel = MessagesViewModel()
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("消息")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $viewModel.searchText, prompt: "搜索会话")
                .refreshable {
                    await viewModel.refresh()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if viewModel.unreadCount > 0 {
                            Text("\(viewModel.unreadCount)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                    }
                }
        }
        .enableInjection()
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading && viewModel.conversations.isEmpty {
            ProgressView("加载中...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error) {
                Task {
                    await viewModel.loadConversations()
                }
            }
        } else if viewModel.filteredConversations.isEmpty {
            emptyStateView
        } else {
            conversationListView
        }
    }
    
    private var conversationListView: some View {
        List {
            ForEach(viewModel.filteredConversations) { conversation in
                ConversationRow(conversation: conversation)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            viewModel.deleteConversation(conversation)
                        } label: {
                            Label("删除", systemImage: "trash")
                        }
                        
                        Button {
                            viewModel.pinConversation(conversation)
                        } label: {
                            Label(conversation.isPinned ? "取消置顶" : "置顶", 
                                  systemImage: conversation.isPinned ? "pin.slash" : "pin")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.markAsRead(conversation)
                        } label: {
                            Label("标记已读", systemImage: "checkmark.circle")
                        }
                        .tint(.green)
                    }
                    .onTapGesture {
                        viewModel.markAsRead(conversation)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "message.fill")
                .font(.system(size: 64))
                .foregroundColor(.secondary.opacity(0.5))
            
            Text(viewModel.searchText.isEmpty ? "暂无消息" : "未找到相关会话")
                .font(.headline)
                .foregroundColor(.secondary)
            
            if viewModel.searchText.isEmpty {
                Text("开始与朋友聊天吧")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Conversation Row
struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // 头像
            Circle()
                .fill(Color.purple.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay {
                    Text(String(conversation.participantName.prefix(1)))
                        .font(.headline)
                        .foregroundColor(.purple)
                }
                .overlay(alignment: .bottomTrailing) {
                    if conversation.isUnread {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                            .overlay {
                                Circle()
                                    .stroke(Color(.systemBackground), lineWidth: 2)
                            }
                    }
                }
            
            // 内容
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(conversation.participantName)
                        .font(.headline)
                        .foregroundColor(conversation.isUnread ? .primary : .secondary)
                    
                    if conversation.isPinned {
                        Image(systemName: "pin.fill")
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text(conversation.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if conversation.unreadCount > 0 {
                        Text("\(conversation.unreadCount)")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MessagesView()
}
