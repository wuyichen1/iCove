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
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: DiscoverViewModel
  @State private var selectedCollectionIndex: Int = 0
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init() {
    // ViewModel会在onAppear中获取authManager
    _viewModel = StateObject(wrappedValue: DiscoverViewModel())
  }

  var body: some View {
    ZStack {

      // 背景图片
      Image("KYECVROdZxhA1GUw")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      // 背景图案（可选，如果需要点状图案）
      // 这里可以添加自定义背景图案视图

      VStack(spacing: 0) {
        // 顶部标题区域 - 始终显示
        headerSection

        // 内容区域 - 根据加载状态显示不同内容
        if viewModel.isLoading && viewModel.collectedPosts.isEmpty
          && viewModel.allPosts.isEmpty
        {
          loadingView
        } else {
          contentView
        }
      }
    }
    // .navigationBarHidden(true)
    .enableInjection()
    .onAppear {
      // 更新ViewModel的authManager引用
      viewModel.updateAuthManager(authManager)
    }
    .onChange(of: authManager.currentUser?.collectedPostIds) { _ in
      // 当用户的收藏列表改变时，刷新收藏的帖子
      viewModel.refreshCollectedPosts()
    }
  }

  // MARK: - Header Section
  private var headerSection: some View {
    VStack(spacing: 0) {
      // Discover 标题
      HStack {
        Text("Discover")
          .font(.custom("FredokaOne-Regular", size: 32))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.top, 50)
      .padding(.bottom, 16)
    }
  }

  // MARK: - Loading View
  private var loadingView: some View {
    VStack(spacing: 20) {
      Spacer()
      ProgressView()
        .scaleEffect(1.5)
        .tint(.white)

      Text("Loading...")
        .font(.system(size: 16))
        .foregroundColor(.white.opacity(0.8))
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Content View
  private var contentView: some View {
    VStack(alignment: .leading, spacing: 26) {

      // 收藏图片轮播
      if !viewModel.collectedPosts.isEmpty {
        VStack {
          // My collection 文字
          HStack {
            StarText(
              text: "My collection",
              textColor: Color("yinguanglv"),
              textSize: 18
            )

            Spacer()
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 16)

          collectionCarousel
        }

      }

      ZStack {
        // 透明填充，只有上边框是绿色的盒子
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.clear)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(
            // 只绘制上边框
            TopBorderShape(cornerRadius: 40)
              .stroke(Color.green, lineWidth: 2)
          )
          .cornerRadius(12, corners: [.topLeft, .topRight])
          .padding(.top, 26)

        VStack(alignment: .leading) {
          // All 和 + 按钮
          HStack(spacing: 24) {
            // All 按钮
            ZStack {
              Image("TYRzuMytPGz0mCSA")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 45)
                .clipped()

              HStack {
                StarText(
                  text: "All",
                  textColor: .black,
                  textSize: 18
                )
              }

            }
            .frame(height: 45)

            // + 按钮
            Button(action: {
              router.push(.publish(type: .imagePost))
            }) {
              Image("Tz0wJDM3mdSWeD0Y")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 66, height: 43)
                .clipped()
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 6)
          .padding(.leading, 16)

          // 帖子列表
          ScrollView {
            LazyVStack(spacing: 16) {
              ForEach(viewModel.allPosts) { post in
                PostCard(post: post)
                  .onTapGesture {
                    // 跳转到详情页
                    router.push(.postDetail(postId: post.id))
                  }
              }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 130)  // 为底部导航栏留出空间
            .padding(.top, 10)
          }
        }
      }

    }
  }

  // MARK: - Collection Carousel
  private var collectionCarousel: some View {
    TabView(selection: $selectedCollectionIndex) {
      ForEach(Array(viewModel.collectedPosts.enumerated()), id: \.element.id) { index, post in
        if let firstImage = post.imageNames.first {
          Image(firstImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
              // 星星图标覆盖层（底部）
              VStack {
                Spacer()
                HStack {
                  Button(action: {
                    // 收藏操作
                  }) {
                    Image(systemName: post.isCollected ? "star.fill" : "star")
                      .font(.system(size: 18))
                      .foregroundColor(.white)
                      .padding(8)
                      .background(Color.purple.opacity(0.7))
                      .clipShape(Circle())
                      .overlay(
                        Circle()
                          .stroke(Color.white, lineWidth: 1.5)
                      )
                  }
                  .padding(.leading, 12)
                  .padding(.bottom, 12)
                  Spacer()
                }
              }
            )
            .padding(.horizontal, 20)
            .tag(index)
        }
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .frame(height: 200)
  }
}

// MARK: - Post Card
struct PostCard: View {
  let post: Post
  @StateObject private var viewModel: PostCardViewModel
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager

  init(post: Post) {
    self.post = post
    _viewModel = StateObject(wrappedValue: PostCardViewModel(authorId: post.authorId))
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .top) {
        // 头像
        if let author = viewModel.author, let avatar = author.avatar {
          Button(action: {
            // 点击头像跳转到用户页
            if let author = viewModel.author {
              router.push(.profile(userId: author.id))
            }
          }) {
            Image(avatar)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 46, height: 46)
              .clipShape(Circle())
          }
          // .overlay(
          //   Circle()
          //     .stroke(
          //       LinearGradient(
          //         gradient: Gradient(colors: [Color.pink, Color.purple]),
          //         startPoint: .topLeading,
          //         endPoint: .bottomTrailing
          //       ),
          //       lineWidth: 2.5
          //     )
          // )
        } else {
          Circle()
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [
                  Color.pink.opacity(0.3), Color.purple.opacity(0.3),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
            .frame(width: 46, height: 46)
            .overlay {
              if let author = viewModel.author {
                Text(String(author.username.prefix(1)))
                  .font(.headline)
                  .foregroundColor(.pink)
              }
            }
        }

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            // 用户名
            Text(viewModel.author?.username ?? "Unknown")
              .font(.custom("FredokaOne-Regular", size: 17))
              .foregroundColor(.white)

            Spacer()

            // 更多选项
            Button(action: {
              // 更多选项
            }) {
              Image(systemName: "ellipsis")
                .font(.system(size: 18))
                .foregroundColor(.white)
            }
          }

          // 帖子内容
          Text(post.content)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .lineLimit(3)
            .padding(.bottom, 6)

          // 图片网格
          if !post.imageNames.isEmpty {
            HStack(spacing: 8) {
              ForEach(Array(post.imageNames.prefix(3).enumerated()), id: \.offset) {
                index, imageName in
                ZStack {
                  Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                      width: (UIScreen.main.bounds.width - 150) / 3,
                      height: (UIScreen.main.bounds.width - 150) / 3
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                  // 如果是第三张图片且总图片数超过3张，显示遮罩层
                  if index == 2 && post.imageNames.count > 3 {
                    RoundedRectangle(cornerRadius: 8)
                      .fill(Color.black.opacity(0.5))
                      .frame(
                        width: (UIScreen.main.bounds.width - 150) / 3,
                        height: (UIScreen.main.bounds.width - 150) / 3
                      )

                    Text("+\(post.imageNames.count - 3)")
                      .font(.system(size: 18, weight: .bold))
                      .foregroundColor(.white)
                  }
                }
              }
            }
          }
        }
        .padding(.leading, 3)
        .padding(.top, 10)
      }
      .padding(.top, 10)
      .padding(.horizontal, 16)
      .padding(.bottom, 16)

    }
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
          Color(red: 216 / 255, green: 177 / 255, blue: 227 / 255),
          // Color.white,
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    )
    .cornerRadius(20)
    .onAppear {
      viewModel.setAuthManager(authManager)
    }
  }
}

// MARK: - Post Card ViewModel
@MainActor
class PostCardViewModel: ObservableObject {
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
  }

  func setAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    // 如果之前没有找到作者信息，重新尝试加载
    if author == nil {
      loadAuthor(authorId: authorId)
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

// #Preview {
//     DiscoverView()
// }
