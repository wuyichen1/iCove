//
//  MessagesViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class MessagesViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var conversations: [Conversation] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var unreadCount: Int = 0
    
    // MARK: - Computed Properties
    var filteredConversations: [Conversation] {
        if searchText.isEmpty {
            return conversations
        } else {
            return conversations.filter { conversation in
                conversation.participantName.localizedCaseInsensitiveContains(searchText) ||
                conversation.lastMessage.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // MARK: - Initialization
    init() {
        Task {
            await loadConversations()
        }
    }
    
    // MARK: - Public Methods
    func loadConversations() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 生成模拟会话数据
        conversations = generateMockConversations()
        updateUnreadCount()
        
        isLoading = false
    }
    
    func refresh() async {
        // 模拟刷新延迟
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        conversations = generateMockConversations()
        updateUnreadCount()
    }
    
    func markAsRead(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index].isUnread = false
            conversations[index].unreadCount = 0
            updateUnreadCount()
        }
    }
    
    func deleteConversation(_ conversation: Conversation) {
        conversations.removeAll { $0.id == conversation.id }
        updateUnreadCount()
    }
    
    func pinConversation(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index].isPinned.toggle()
            // 重新排序：置顶的在前
            let pinned = conversations.filter { $0.isPinned }
            let unpinned = conversations.filter { !$0.isPinned }
            conversations = pinned + unpinned
        }
    }
    
    // MARK: - Private Methods
    private func updateUnreadCount() {
        unreadCount = conversations.reduce(0) { $0 + $1.unreadCount }
    }
    
    private func generateMockConversations() -> [Conversation] {
        let names = ["张三", "李四", "王五", "赵六", "钱七", "孙八", "周九", "吴十",
                     "郑十一", "王十二", "冯十三", "陈十四", "褚十五", "卫十六"]
        
        return names.enumerated().map { index, name in
            let isUnread = Bool.random() && index < 5
            let unreadCount = isUnread ? Int.random(in: 1...99) : 0
            let isPinned = index < 2
            
            return Conversation(
                id: UUID().uuidString,
                participantName: name,
                participantAvatar: nil,
                lastMessage: generateRandomMessage(),
                timestamp: Date().addingTimeInterval(-Double(index * 3600 + Int.random(in: 0...3600))),
                unreadCount: unreadCount,
                isUnread: isUnread,
                isPinned: isPinned
            )
        }
    }
    
    private func generateRandomMessage() -> String {
        let messages = [
            "你好，最近怎么样？",
            "这个项目进展如何？",
            "明天有时间一起讨论一下吗？",
            "收到了，谢谢！",
            "好的，我会尽快处理",
            "这个想法很不错",
            "可以发给我看看吗？",
            "没问题，我来安排",
            "👍",
            "好的，明白了"
        ]
        return messages.randomElement() ?? "新消息"
    }
}

// MARK: - Supporting Types
struct Conversation: Identifiable {
    let id: String
    let participantName: String
    let participantAvatar: String?
    let lastMessage: String
    let timestamp: Date
    var unreadCount: Int
    var isUnread: Bool
    var isPinned: Bool
}
