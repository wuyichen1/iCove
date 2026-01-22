//
//  VideoDetailView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import AVKit
import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct VideoDetailView: View {
  let video: VideoItem
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: VideoDetailViewModel
  @State private var isPlaying = false
  @State private var showingComments = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(video: VideoItem) {
    self.video = video
    _viewModel = StateObject(wrappedValue: VideoDetailViewModel(video: video))
  }

  var body: some View {
    ZStack {
      // 视频背景
      Color.black
        .ignoresSafeArea()

      // 背景可以用视频（可选）
      VideoPlayerView(videoName: video.videoName)  // 后台循环播放示例
        .ignoresSafeArea()
      // .overlay(Color.black.opacity(0.4))  // 半透明遮罩让内容清晰

      // 底部信息栏
      VStack(alignment: .leading) {
        Spacer()

        VStack(spacing: 16) {
          // 右侧：点赞和评论按钮整体居右
          HStack {
            Spacer()
            VStack(spacing: 24) {
              // 点赞按钮
              Button(action: {
                viewModel.toggleLike()
              }) {
                VStack(spacing: 8) {
                  Image(
                    viewModel.video.isLiked ? "zibeSwAfFlutEuhNml" : "beSwAfFlutEuhNml"
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 45, height: 45)
                  .clipped()

                  Text("\(viewModel.video.likeCount)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                }
                .frame(width: 50)
              }

              // 评论按钮
              Button(action: {
                showingComments = true
              }) {
                VStack(spacing: 8) {
                  Image("Qplz4ZYdXi5S8nP4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipped()

                  Text("\(viewModel.commentCount)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                }
                .frame(width: 50)
              }
            }
          }

          // 底部：用户信息和描述
          HStack {
            VStack(alignment: .leading, spacing: 12) {
              // 用户头像
              if let author = viewModel.author {
                HStack(spacing: 12) {
                  if let avatarName = author.avatar {
                    DynamicImage(imageName: avatarName)
                      .frame(width: 45, height: 45)
                      .clipShape(Circle())
                      .overlay(
                        Circle()
                          .stroke(Color("yinguanglv"), lineWidth: 1)
                      )
                  } else {
                    Circle()
                      .fill(Color.green.opacity(0.3))
                      .frame(width: 45, height: 45)
                      .overlay {
                        Text(String(author.username.prefix(1)))
                          .font(.headline)
                          .foregroundColor(.green)
                      }
                      .overlay(
                        Circle()
                          .stroke(Color.green, lineWidth: 2)
                      )
                  }

                  // username
                  Text(author.username)
                    .font(.custom("FredokaOne-Regular", size: 18))
                    .foregroundColor(.white)
                }

                // 视频描述
                Text(video.title)
                  .font(.system(size: 14))
                  .foregroundColor(.white)
                  .lineLimit(3)
              }
            }
            Spacer()
          }

        }
        .padding(.horizontal, 20)
        .padding(.bottom, 0)
      }

      // 顶部操作栏（放在视频内容之上）
      TopActionBar(
        onBack: {
          router.pop()
        },
        onMore: {
          // 更多选项
        },
      )
    }
    .navigationBarHidden(true)
    // .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      viewModel.setAuthManager(authManager)
    }
    .sheet(isPresented: $showingComments) {
      CommentSheet(videoId: video.id)
        .presentationDetents([.fraction(0.5)])  // 固定为屏幕高度的 50% （iOS 16+）
        .presentationBackground(.clear)  // 去掉默认背景色，使用透明背景
      // .presentationDragIndicator(.visible) // 显示拖拽指示器
    }
    .enableInjection()
  }
}

// MARK: - Video Detail ViewModel
@MainActor
class VideoDetailViewModel: ObservableObject {
  @Published var video: VideoItem
  @Published var author: User?
  @Published var commentCount: Int = 0

  private let videoService: VideoDataServiceProtocol
  private let commentService: CommentDataServiceProtocol
  private let authService: AuthenticationServiceProtocol
  private weak var authManager: AuthenticationManager?

  init(
    video: VideoItem,
    videoService: VideoDataServiceProtocol = VideoDataService.shared,
    commentService: CommentDataServiceProtocol = CommentDataService.shared,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    authManager: AuthenticationManager? = nil
  ) {
    self.video = video
    self.videoService = videoService
    self.commentService = commentService
    self.authService = authService
    self.authManager = authManager

    loadAuthor()
    loadCommentCount()

    // 监听评论更新通知
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CommentAdded"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.loadCommentCount()
      }
    }
    
    // 监听当前用户信息更新通知
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor [weak self] in
        guard let self = self,
              let updatedUser = notification.userInfo?["user"] as? User,
              updatedUser.id == self.video.authorId else { return }
        self.author = updatedUser
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func setAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    // 如果作者是当前用户，使用最新的用户信息
    if let currentUser = authManager.currentUser, currentUser.id == video.authorId {
      author = currentUser
    }
  }

  func toggleLike() {
    video.isLiked.toggle()
    if video.isLiked {
      video.likeCount += 1
    } else {
      video.likeCount = max(0, video.likeCount - 1)
    }
    videoService.updateVideo(video)
  }

  private func loadAuthor() {
    // 首先尝试从 AuthenticationService 获取用户信息
    author = authService.getUserById(video.authorId)
    
    // 如果找不到，检查是否是当前登录用户
    if author == nil, let currentUser = authManager?.currentUser, currentUser.id == video.authorId {
      author = currentUser
    }
  }

  private func loadCommentCount() {
    let comments = commentService.loadComments(for: video.id)
    commentCount = comments.count
  }
}

// #Preview {
//     VideoDetailView(
//         video: VideoItem(
//             imageName: "1akQNNqBpWFE3YsJ0J",
//             videoName: "春季穿搭",
//             title: "Today's outfit, wear the tenderness of spring on your body...",
//             authorId: "user_001",
//             likeCount: 346,
//             isLiked: false
//         ))
// }
