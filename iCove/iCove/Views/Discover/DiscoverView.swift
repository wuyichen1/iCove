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
  @State private var showingBlockDialog = false
  @State private var blockUserId: String? = nil
  @State private var showingReportBlockSheet = false
  @State private var reportBlockUserId: String? = nil
  @State private var pendingReportBlockUserId: String? = nil
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
    .blockUserDialog(isPresented: $showingBlockDialog, userId: blockUserId)
    .sheet(
      isPresented: Binding(
        get: { showingReportBlockSheet },
        set: { newValue in
          showingReportBlockSheet = newValue
          if !newValue {
            // 弹窗关闭时清空 userId
            reportBlockUserId = nil
          }
        }
      )
    ) {
      Group {
        if let userId = reportBlockUserId {
          ReportBlockBottomSheet(
            userId: userId,
            isPresented: Binding(
              get: { showingReportBlockSheet },
              set: { newValue in
                showingReportBlockSheet = newValue
                if !newValue {
                  reportBlockUserId = nil
                }
              }
            ),
            onBlock: {
              blockUserId = userId
              showingBlockDialog = true
            }
          )
          .environmentObject(authManager)
          .environmentObject(router)
          .presentationDetents([.height(240)])
          .presentationBackground(.clear)
          .presentationDragIndicator(.hidden)
        } else {
          // 占位视图，防止白屏
          Color.clear
            .frame(width: 0, height: 0)
        }
      }
    }
    .enableInjection()
    .onAppear {
      // 更新ViewModel的authManager引用
      viewModel.updateAuthManager(authManager)
    }
    .onChange(of: authManager.currentUser?.collectedPostIds) { oldValue, newValue in
      // 当用户的收藏列表改变时，刷新收藏的帖子
      viewModel.refreshCollectedPosts()
    }
    .onChange(of: reportBlockUserId) { oldValue, newValue in
      // 当 reportBlockUserId 被设置时，打开弹窗
      if let userId = newValue, !showingReportBlockSheet {
        // 确保值已设置，然后打开弹窗
        DispatchQueue.main.async {
          // 再次确认值已设置
          if reportBlockUserId == userId {
            showingReportBlockSheet = true
          } else {
            // 如果值丢失，重新设置
            reportBlockUserId = userId
            DispatchQueue.main.async {
              showingReportBlockSheet = true
            }
          }
        }
      }
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
    VStack(alignment: .leading, spacing: 0) {

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
          .padding(.bottom, 0)

          collectionCarousel
            .padding(.bottom, 16)
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
                PostCard(
                  post: post,
                  onBlock: {
                    blockUserId = post.authorId
                    showingBlockDialog = true
                  },
                  onReportBlockUser: { userId in
                    // 设置 userId，onChange 会自动打开弹窗
                    reportBlockUserId = userId
                  }
                )
                .onTapGesture {
                  // 跳转到详情页
                  router.push(.postDetail(postId: post.id))
                }
              }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 130)  // 为底部导航栏留出空间
            .padding(.top, 10)
            .animation(
              .spring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.4),
              value: viewModel.allPosts
            )
          }
        }
      }

    }
  }

  // MARK: - Collection Carousel
  private var collectionCarousel: some View {
    GeometryReader { geometry in
      // 一屏显示三项：中间项完整，左右各显示一部分
      let screenWidth = geometry.size.width
      let itemWidth = screenWidth * 2 / 3  // 每项宽度（约2/3屏幕宽度）
      let cardSpacing: CGFloat = 18  // 卡片之间的间距
      let containerHeight: CGFloat = 220  // 外层滚动空间高度
      let cardHeight: CGFloat = 180  // 卡片高度
      let spacerHeight: CGFloat = 20  // 空白占位高度
      // 左右各留出的宽度，让左右两侧各显示一部分
      let sidePadding = (screenWidth - itemWidth) / 2

      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: cardSpacing) {
            ForEach(Array(viewModel.collectedPosts.enumerated()), id: \.element.id) { index, post in
              if let firstImage = post.imageNames.first {
                CollectionCardView(
                  imageName: firstImage,
                  post: post,
                  itemWidth: itemWidth,
                  cardHeight: cardHeight,
                  spacerHeight: spacerHeight,
                  containerHeight: containerHeight,
                  scrollWidth: screenWidth,
                  onReportBlockUser: { userId in
                    // 设置 userId，onChange 会自动打开弹窗
                    reportBlockUserId = userId
                  }
                )
                .id(index)
              }
            }
          }
          .padding(.horizontal, sidePadding)  // 左右各留出空间，让首尾项也能居中
          .scrollTargetLayout()
        }
        .coordinateSpace(name: "scroll")
        .scrollTargetBehavior(.viewAligned)
        .scrollBounceBehavior(.basedOnSize)  // 根据内容大小调整弹性效果
        .scrollDismissesKeyboard(.never)  // 防止键盘干扰滚动
        .frame(width: screenWidth)  // 限制宽度，确保超出部分被裁剪
        .onAppear {
          // 初始时滚动到第一项
          if !viewModel.collectedPosts.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              proxy.scrollTo(0, anchor: .center)
            }
          }
        }
      }
      .frame(width: screenWidth, height: containerHeight)
    }
    .frame(height: 220)
  }
}

// MARK: - Collection Card View
struct CollectionCardView: View {
  let imageName: String
  let post: Post
  let itemWidth: CGFloat
  let cardHeight: CGFloat
  let spacerHeight: CGFloat
  let containerHeight: CGFloat
  let scrollWidth: CGFloat
  var onReportBlockUser: ((String) -> Void)? = nil
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router

  var body: some View {
    GeometryReader { cardGeometry in
      // 计算卡片相对于滚动视图中心的位置
      let cardCenterX = cardGeometry.frame(in: .named("scroll")).midX
      let scrollCenterX = scrollWidth / 2
      let distanceFromCenter = abs(cardCenterX - scrollCenterX)
      // 最大距离是屏幕宽度的一半
      let maxDistance = scrollWidth / 2

      // 计算进度值（0.0 在中心，1.0 在边缘）
      let progress = min(1.0, distanceFromCenter / maxDistance)

      // 使用平滑的插值来控制卡片位置
      // progress = 0 时，卡片在上方（中间项）
      // progress = 1 时，卡片在下方（非中间项）
      let topSpacerHeight = spacerHeight * progress  // 上方空白高度，随progress增加
      let bottomSpacerHeight = spacerHeight * (1.0 - progress)  // 下方空白高度，随progress减少

      // 使用垂直布局：通过动态调整空白高度实现平滑过渡
      VStack(spacing: 0) {
        // 上方空白，高度随progress变化
        Spacer()
          .frame(height: topSpacerHeight)

        // 卡片视图
        cardView

        // 下方空白，高度随progress变化
        Spacer()
          .frame(height: bottomSpacerHeight)
      }
      .frame(width: itemWidth, height: containerHeight)
      .animation(
        .spring(response: 0.35, dampingFraction: 0.75, blendDuration: 0.15),
        value: progress
      )
    }
    .frame(width: itemWidth, height: containerHeight)
  }

  private var cardView: some View {
    DynamicImage(imageName: imageName, contentMode: .fill)
      .frame(width: itemWidth, height: cardHeight)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .overlay(
        // 星星图标覆盖层（右下角）
        VStack {
          if authManager.currentUser?.id != post.authorId {
            HStack {
              Spacer()

              // 更多按钮图标
              Button(action: {
                onReportBlockUser?(post.authorId)
              }) {
                Image(systemName: "ellipsis")
                  .font(.system(size: 24))
                  .foregroundColor(.white)
              }
            }
            .padding(.trailing, 16)
            .padding(.top, 16)

          }
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              // 收藏操作
              authManager.toggleCollectPost(postId: post.id)
            }) {
              Image(systemName: "star.fill")
                .font(.system(size: 18))
                .foregroundColor(
                  authManager.isPostCollected(postId: post.id) ? .yellow : .white
                )
                .padding(8)
                .background(Color("buttonPurple"))
                .clipShape(Circle())
            }
            .padding(.trailing, 12)
            .padding(.bottom, 12)
          }
        }
      )
      // 添加一个白色边框
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.white, lineWidth: 2)
      )
      .contentShape(RoundedRectangle(cornerRadius: 16))
      .onTapGesture {
        // 跳转到详情页
        router.push(.postDetail(postId: post.id))
      }
  }
}

// MARK: - Post Card
struct PostCard: View {
  let post: Post
  var onBlock: (() -> Void)? = nil
  var onReportBlockUser: ((String) -> Void)? = nil
  @StateObject private var viewModel: PostCardViewModel
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager

  init(post: Post, onBlock: (() -> Void)? = nil, onReportBlockUser: ((String) -> Void)? = nil) {
    self.post = post
    self.onBlock = onBlock
    self.onReportBlockUser = onReportBlockUser
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
            DynamicImage(imageName: avatar)
              .frame(width: 46, height: 46)
              .clipShape(Circle())
          }
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
            if authManager.currentUser?.id != post.authorId {
              Button(action: {
                if let authorId = viewModel.author?.id {
                  onReportBlockUser?(authorId)
                }
              }) {
                Image(systemName: "ellipsis")
                  .font(.system(size: 18))
                  .foregroundColor(.white)
              }
            }
          }

          // 帖子内容
          Text(post.content)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .lineLimit(3)
            .padding(.bottom, 6)

          // 图片网格 - 支持加载用户上传的图片
          if !post.imageNames.isEmpty {
            HStack(spacing: 8) {
              ForEach(Array(post.imageNames.prefix(3).enumerated()), id: \.offset) {
                index, imageName in
                ZStack {
                  DynamicImage(imageName: imageName)
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

// #Preview {
//     DiscoverView()
// }
