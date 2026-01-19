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
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @StateObject private var viewModel = MessagesViewModel()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部标题区域
        headerSection

        // 内容区域
        if viewModel.isLoading && viewModel.conversations.isEmpty {
          loadingView
        } else if viewModel.filteredConversations.isEmpty {
          emptyStateView
        } else {
          contentView
        }
      }
    }
    .navigationBarHidden(true)
    .enableInjection()
    .onAppear {
      Task {
        await viewModel.loadConversations()
      }
    }
    .onChange(of: router.path.count) { _, _ in
      // 当从聊天详情页返回时，刷新会话列表
      Task {
        await viewModel.loadConversations()
      }
    }
  }

  // MARK: - Header Section
  private var headerSection: some View {
    VStack(spacing: 0) {
      // Chat 标题
      HStack {
        Text("Chat")
          .font(.custom("FredokaOne-Regular", size: 32))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.top, 50)
      .padding(.bottom, 24)

      // 当前用户头像和名称
      if let currentUser = authManager.currentUser {
        VStack(spacing: 12) {
          // 用户头像（带渐变边框）
          ProfileImageView(
            avatar: currentUser.avatar,
            username: currentUser.username,
            size: 120,
            subSize: 32,
          )

          // 用户名
          Text(currentUser.username)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
        }
        .padding(.bottom, 24)
      }

      // Friends 标题
      HStack {
        Text("Friends")
          .font(.custom("FredokaOne-Regular", size: 24))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
  }

  // MARK: - Content View
  private var contentView: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(viewModel.filteredConversations) { conversation in
          ConversationRow(conversation: conversation)
            .onTapGesture {
              viewModel.markAsRead(conversation)
              // 获取对方用户ID并跳转到聊天详情页
              if let currentUserId = authManager.currentUser?.id,
                 let otherUserId = conversation.participantIds.first(where: { $0 != currentUserId }) {
                router.push(.chatDetail(conversationId: conversation.id, otherUserId: otherUserId))
              }
            }
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 130)  // 为底部导航栏留出空间
    }
  }

  // MARK: - Loading View
  private var loadingView: some View {
    VStack(spacing: 20) {
      Spacer()
      ProgressView()
        .scaleEffect(1.5)
        .tint(.white)

      Text("加载中...")
        .font(.system(size: 16))
        .foregroundColor(.white.opacity(0.8))
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Empty State View
  private var emptyStateView: some View {
    VStack(spacing: 16) {
      Spacer()
      Image(systemName: "message.fill")
        .font(.system(size: 64))
        .foregroundColor(.white.opacity(0.5))

      Text("暂无消息")
        .font(.headline)
        .foregroundColor(.white.opacity(0.8))

      Text("开始与朋友聊天吧")
        .font(.subheadline)
        .foregroundColor(.white.opacity(0.6))
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

// MARK: - Conversation Row
struct ConversationRow: View {
  let conversation: Conversation
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: ConversationRowViewModel

  init(conversation: Conversation) {
    self.conversation = conversation
    _viewModel = StateObject(wrappedValue: ConversationRowViewModel(conversation: conversation))
  }

  private var timeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mma"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      // 右侧：深紫色聊天气泡
      ZStack {
        Image("todrcOCVKxRfLanQ")
          .resizable()
          .scaledToFill()
          .frame(width: .infinity, height: 80)

        VStack(alignment: .leading, spacing: 12) {
          // 用户名和时间戳
          HStack {
            Text(viewModel.otherUser?.username ?? "Unknown")
              .font(.custom("FredokaOne-Regular", size: 16))
              .foregroundColor(.white)

            Spacer()

            Text(timeFormatter.string(from: conversation.timestamp))
              .font(.system(size: 12))
              .foregroundColor(.white.opacity(0.6))
          }

          // 消息预览
          Text(conversation.lastMessage.isEmpty ? "" : conversation.lastMessage)
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.7))
            .lineLimit(1)
        }
        .padding(.leading, 106)
        .padding(.trailing, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        // .background(
        //   RoundedRectangle(cornerRadius: 16)
        //     .fill(Color(red: 60 / 255, green: 20 / 255, blue: 90 / 255))
        // )
      }
      .padding(.top, 12)

      // 左侧：小头像（带渐变边框）
      ProfileImageView(
        avatar: viewModel.otherUser?.avatar,
        username: viewModel.otherUser?.username ?? "Unknown",
        size: 62,
        subSize: 16,
      )
      .padding(.leading, 14)
    }
    .padding(.horizontal, 20)
    .onAppear {
      viewModel.loadOtherUser(currentUserId: authManager.currentUser?.id)
    }
    .onChange(of: authManager.currentUser?.id) { _, newUserId in
      viewModel.loadOtherUser(currentUserId: newUserId)
    }
  }
}

// MARK: - Conversation Row ViewModel
@MainActor
class ConversationRowViewModel: ObservableObject {
  @Published var otherUser: User?

  private let conversation: Conversation
  private let authService: AuthenticationServiceProtocol

  init(
    conversation: Conversation,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared
  ) {
    self.conversation = conversation
    self.authService = authService
  }

  func loadOtherUser(currentUserId: String?) {
    // 获取当前用户ID
    guard let currentUserId = currentUserId else {
      otherUser = nil
      return
    }

    // 从会话参与者中找到对方用户ID
    let otherUserId = conversation.participantIds.first { $0 != currentUserId }

    // 根据对方用户ID获取用户信息
    if let otherUserId = otherUserId {
      otherUser = authService.getUserById(otherUserId)
    } else {
      otherUser = nil
    }
  }
}

// #Preview {
//     MessagesView()
//         .environmentObject(AuthenticationManager())
// }
