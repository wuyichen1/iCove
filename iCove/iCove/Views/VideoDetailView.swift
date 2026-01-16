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

            // 顶部操作栏（放在视频内容之上）
            VStack {
                HStack {
                    // 返回按钮
                    Button(action: {
                        router.pop()
                    }) {
                        Image(systemName: "arrowshape.backward.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("buttonPurple"))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color("buttonPurple"), lineWidth: 1.5)
                            )
                    }

                    Spacer()

                    // 更多操作按钮
                    Button(action: {
                        // 更多选项
                    }) {
                        HStack(spacing: 3) {
                            Circle()
                                .fill(Color("buttonPurple"))
                                .frame(width: 4, height: 4)
                            Circle()
                                .fill(Color("buttonPurple"))
                                .frame(width: 4, height: 4)
                            Circle()
                                .fill(Color("buttonPurple"))
                                .frame(width: 4, height: 4)
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("buttonPurple"), lineWidth: 1.5)
                        )
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            // 底部信息栏
            VStack {
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
                                        systemName: viewModel.video.isLiked ? "flame.fill" : "flame"
                                    )
                                    .font(.system(size: 28))
                                    .foregroundColor(viewModel.video.isLiked ? .orange : .gray)

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
                                    Image(systemName: "message.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(.yellow)

                                    Text("\(viewModel.commentCount)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 50)
                            }
                        }
                        .padding(.trailing, 20)
                    }

                    // 底部：用户信息和描述
                    VStack(alignment: .leading, spacing: 12) {
                        // 用户头像
                        if let author = viewModel.author {
                            HStack(spacing: 12) {
                                if let avatarName = author.avatar {
                                    Image(avatarName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.green, lineWidth: 2)
                                        )
                                } else {
                                    Circle()
                                        .fill(Color.green.opacity(0.3))
                                        .frame(width: 40, height: 40)
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
                            }

                            // 视频描述
                            Text(video.title)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .lineLimit(3)
                        }
                    }

                }
                .padding(.horizontal, 20)
                .padding(.bottom, 0)
            }
        }
        .navigationBarHidden(true)
        // .toolbar(.hidden, for: .navigationBar)
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

    init(
        video: VideoItem,
        videoService: VideoDataServiceProtocol = VideoDataService.shared,
        commentService: CommentDataServiceProtocol = CommentDataService.shared,
        authService: AuthenticationServiceProtocol = AuthenticationService.shared
    ) {
        self.video = video
        self.videoService = videoService
        self.commentService = commentService
        self.authService = authService

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
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
        author = authService.getUserById(video.authorId)
    }

    private func loadCommentCount() {
        let comments = commentService.loadComments(for: video.id)
        commentCount = comments.count
    }
}

#Preview {
    VideoDetailView(
        video: VideoItem(
            imageName: "1akQNNqBpWFE3YsJ0J",
            videoName: "春季穿搭",
            title: "Today's outfit, wear the tenderness of spring on your body...",
            authorId: "user_001",
            likeCount: 346,
            isLiked: false
        ))
}
