//
//  CommentSheet.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct CommentSheet: View {
  let videoId: String
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: CommentSheetViewModel
  @State private var commentText: String = ""
  @FocusState private var isInputFocused: Bool

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(videoId: String) {
    self.videoId = videoId
    _viewModel = StateObject(wrappedValue: CommentSheetViewModel(videoId: videoId))
  }

  var body: some View {
    ZStack {
      // //自定义一个图片做背景
      Image("f2YTqp3rK3ZgautI")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
      // .scaledToFill() // cover

      VStack(spacing: 0) {
        // 头部
        HStack {
          Text("Comments")
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.black)

          Spacer()

          Button(action: {
            dismiss()
          }) {
            Image(systemName: "xmark")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.black)
              .frame(width: 26, height: 26)
              .clipShape(Circle())
              .overlay(
                Circle()
                  .stroke(Color.black, lineWidth: 1.5)
              )
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 26)
        .padding(.bottom, 10)

        // 评论列表
        ScrollView {
          LazyVStack(spacing: 20) {
            ForEach(viewModel.comments) { comment in
              CommentRow(comment: comment)
            }
          }
          .padding(.horizontal, 20)
          .padding(.top, 12)
        }

        // 输入框
        HStack(spacing: 12) {
          ZStack(alignment: .leading) {
            if commentText.isEmpty {
              Text("Say something...")
                .foregroundColor(.white.opacity(0.4))
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
            }
            TextField("", text: $commentText, axis: .vertical)
              .textFieldStyle(.plain)
              .foregroundColor(.white)
              .padding(.horizontal, 16)
              .padding(.vertical, 15)
              .cornerRadius(15)
              .lineLimit(1...4)
              .focused($isInputFocused)
              .foregroundColor(.primary)
          }

          Button(action: {
            sendComment()
          }) {
            Image(systemName: "paperplane.fill")
              .font(.system(size: 20))
              .foregroundColor(Color("yinguanglv"))
              .frame(width: 44, height: 44)
              .clipShape(Circle())
              .padding(.trailing, 3)
          }
          .disabled(commentText.isEmpty)
          // .opacity(commentText.isEmpty ? 0.5 : 1.0)
        }
        .background(Color(red: 25 / 255, green: 33 / 255, blue: 38 / 255))
        .cornerRadius(16)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        // .background(Color("buttonPurple").opacity(0.9))
      }
    }
    .onAppear {
      viewModel.updateAuthManager(authManager)
    }
    .enableInjection()
    // .frame(height: UIScreen.main.bounds.height * 0.5)  // 固定为屏幕高度的 50%
  }

  private func sendComment() {
    guard !commentText.isEmpty else { return }
    guard let userId = authManager.currentUser?.id else {
      // 未登录用户使用默认ID
      return
    }

    let comment = Comment(
      videoId: videoId,
      authorId: userId,
      content: commentText,
      timestamp: Date()
    )

    viewModel.addComment(comment)
    commentText = ""
    isInputFocused = false

    // 发送通知，通知视频详情页更新评论数
    NotificationCenter.default.post(name: NSNotification.Name("CommentAdded"), object: nil)
  }
}

// MARK: - Comment Row
struct CommentRow: View {
  let comment: Comment
  @StateObject private var viewModel: CommentRowViewModel
  @EnvironmentObject var authManager: AuthenticationManager

  init(comment: Comment) {
    self.comment = comment
    _viewModel = StateObject(wrappedValue: CommentRowViewModel(authorId: comment.authorId))
  }

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      // 头像
      if let author = viewModel.author {
        if let avatarName = author.avatar {
          DynamicImage(imageName: avatarName)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(
              Circle()
                .stroke(Color.white, lineWidth: 2.5)
            )
        } else {
          Circle()
            .fill(Color.pink.opacity(0.3))
            .frame(width: 50, height: 50)
            .overlay {
              Text(String(author.username.prefix(1)))
                .font(.headline)
                .foregroundColor(.pink)
            }
        }
      } else {
        Circle()
          .fill(Color.pink.opacity(0.3))
          .frame(width: 40, height: 40)
      }

      // 评论内容
      VStack(alignment: .leading, spacing: 4) {
        if let author = viewModel.author {
          Text(author.username)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black)
        }

        Text(comment.content)
          .font(.system(size: 14))
          .foregroundColor(.black.opacity(0.8))
          .fixedSize(horizontal: false, vertical: true)
      }

      Spacer()

      // 更多选项
      Button(action: {
        // 更多选项
      }) {
        Image(systemName: "ellipsis")
          .font(.system(size: 16))
          .foregroundColor(.black.opacity(0.7))
      }
    }
    .onAppear {
      viewModel.setAuthManager(authManager)
    }
  }
}

// MARK: - Comment Row ViewModel
@MainActor
class CommentRowViewModel: ObservableObject {
  @Published var author: User?
  private let authService: AuthenticationServiceProtocol
  private let authorId: String
  private weak var authManager: AuthenticationManager?

  init(
    authorId: String,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    authManager: AuthenticationManager? = nil
  ) {
    self.authService = authService
    self.authorId = authorId
    self.authManager = authManager
    loadAuthor(authorId: authorId)

    // 监听当前用户信息更新通知
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor in
        guard let self = self,
          let updatedUser = notification.userInfo?["user"] as? User,
          updatedUser.id == self.authorId
        else { return }
        self.author = updatedUser
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    // 如果之前没有找到作者信息，重新尝试加载
    if author == nil {
      loadAuthor(authorId: authorId)
    } else if let currentUser = authManager.currentUser, currentUser.id == authorId {
      // 如果作者是当前用户，直接使用最新的用户信息
      author = currentUser
    }
  }

  private func loadAuthor(authorId: String) {
    // 首先尝试从 AuthenticationService 获取用户信息
    author = authService.getUserById(authorId)

    // 如果找不到，检查是否是当前登录用户
    if author == nil, let currentUser = authManager?.currentUser, currentUser.id == authorId {
      author = currentUser
    }
  }
}

// MARK: - Comment Sheet ViewModel
@MainActor
class CommentSheetViewModel: ObservableObject {
  @Published var comments: [Comment] = []

  private let commentService: CommentDataServiceProtocol
  private let videoId: String
  private var authManager: AuthenticationManager?

  init(
    videoId: String,
    commentService: CommentDataServiceProtocol = CommentDataService.shared
  ) {
    self.videoId = videoId
    self.commentService = commentService

    // 监听新评论通知
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CommentAdded"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadComments()
      }
    }

    // 监听用户拉黑通知，刷新评论列表
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadComments()
      }
    }

    // 监听用户取消拉黑通知，刷新评论列表
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadComments()
      }
    }

    // 延迟加载，确保在主线程
    Task { @MainActor [weak self] in
      self?.loadComments()
    }
  }

  /// 更新authManager引用（用于在View的onAppear中设置）
  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    loadComments()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func addComment(_ comment: Comment) {
    commentService.addComment(comment)
    loadComments()
  }

  private func loadComments() {
    let allComments = commentService.loadComments(for: videoId)
    // 过滤被拉黑用户的评论
    comments = filterBlockedUsersComments(allComments)
  }

  /// 过滤被拉黑用户的评论
  private func filterBlockedUsersComments(_ comments: [Comment]) -> [Comment] {
    guard let blockedUserIds = authManager?.currentUser?.blockedUserIds, !blockedUserIds.isEmpty
    else {
      return comments
    }
    return comments.filter { !blockedUserIds.contains($0.authorId) }
  }
}

// #Preview {
//     CommentSheet(videoId: "test_video_id")
//         .environmentObject(AuthenticationManager())
// }
