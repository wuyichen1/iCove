//
//  ProfileView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss
  @State private var showingEditBio = false
  @State private var editedBio = ""
  @State private var showingReportBlockSheet = false
  @State private var showingBlockDialog = false
  @State private var blockUserId: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    contentView
      .sheet(isPresented: $showingReportBlockSheet) {
        if let userId = viewModel.user?.id {
          ReportBlockBottomSheet(
            userId: userId,
            isPresented: $showingReportBlockSheet,
            onBlock: {
              blockUserId = viewModel.user?.id
              showingBlockDialog = true
            }
          )
          .environmentObject(authManager)
          .environmentObject(router)
          .presentationDetents([.height(240)])
          .presentationBackground(.clear)
          .presentationDragIndicator(.hidden)
        }
      }
      .blockUserDialog(isPresented: $showingBlockDialog, userId: blockUserId)
      .navigationBarHidden(true)
      // .toolbar(.hidden, for: .tabBar)
      .onChange(of: authManager.currentUser?.avatar) { _, _ in
        // 当用户头像更新时，如果是当前用户的资料页，刷新资料
        if viewModel.isCurrentUser {
          Task {
            await viewModel.refresh()
          }
        }
      }
      .onChange(of: authManager.currentUser?.username) { _, _ in
        // 当用户名更新时，如果是当前用户的资料页，刷新资料
        if viewModel.isCurrentUser {
          Task {
            await viewModel.refresh()
          }
        }
      }
      #if DEBUG
        .enableInjection()
      #endif
  }

  @ViewBuilder
  private var contentView: some View {
    if viewModel.isLoading && viewModel.user == nil {
      ProgressView("Loading...")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } else if let user = viewModel.user {
      ZStack {
        // 背景色
        Image("gY80sW7YXCRIPed2")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        // Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        // .ignoresSafeArea()

        ScrollView {
          VStack(spacing: 0) {
            // 头部区域（背景图、头像、用户名、关注/粉丝）
            headerSection(user: user)
              .padding(.bottom, 26)

            // Works部分
            worksSection(user: user)
              .padding(.horizontal, 20)
              .padding(.bottom, 100)  // 为底部导航栏留出空间
          }
        }
        .refreshable {
          await viewModel.refresh()
        }
      }
    }
  }

  // MARK: - Header Section
  private func headerSection(user: User) -> some View {
    ZStack {
      // 背景图（模糊的用户头像）
      headerBackground(user: user)

      VStack(alignment: .leading, spacing: 12) {
        // 顶部操作栏
        topBar

        HStack(alignment: .bottom, spacing: 16) {
          // 左侧：用户名和统计数据
          VStack(alignment: .leading, spacing: 20) {
            Text(user.username)
              .font(.custom("FredokaOne-Regular", size: 22))
              .foregroundColor(.white)

            statsInline(user: user)

            // 操作按钮
            actionButtonsSection(user: user)
              .padding(.top, 5)
          }

          Spacer()

          // 右侧：头像（带绿色边框）
          avatarView(user: user)
        }
        .padding(.horizontal, 20)

      }
    }
  }

  private func headerBackground(user: User) -> some View {
    let bgImageName = user.avatar ?? "icove_logo"
    return ZStack {
      DynamicImage(imageName: bgImageName)
        .scaledToFill()
        .blur(radius: 3)
        .clipped()

      LinearGradient(
        colors: [.clear, Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)],
        startPoint: .top,
        endPoint: .bottom
      )
    }
    .frame(width: .infinity, height: 260)
    .ignoresSafeArea(edges: .top)
  }

  private var topBar: some View {
    HStack {
      if !viewModel.isCurrentUser {
        TopActionBar(
          onBack: {
            dismiss()
          },
          onMore: {
            showingReportBlockSheet = true
          }
        )
        .padding(.top, 46)
      } else {
        HStack {
          Spacer()

          // 设置或更多按钮
          Button {
            if viewModel.isCurrentUser {
              router.push(.settings)
            } else {
              showingReportBlockSheet = true
            }
          } label: {
            Circle()
              .fill(Color.white)
              .frame(width: 40, height: 40)
              .overlay(
                Image(systemName: viewModel.isCurrentUser ? "gearshape" : "ellipsis")
                  .foregroundColor(Color("buttonPurple"))
              )
          }
        }
        .padding(.top, 46)
        .padding(.horizontal, 20)
      }
    }

  }

  private func avatarView(user: User) -> some View {
    let avatarName = user.avatar ?? "7X1p2a4Cu1Xn8nXt"
    return DynamicImage(imageName: avatarName)
      .frame(width: 116, height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 98, style: .continuous))
      .overlay(
        RoundedRectangle(cornerRadius: 98, style: .continuous)
          .stroke(Color("yinguanglv"), lineWidth: 3)
      )
      .shadow(radius: 10)
  }

  private func statsInline(user: User) -> some View {
    HStack(spacing: 32) {
      VStack(alignment: .leading, spacing: 4) {
        Text("\(user.followingCount)")
          .font(.custom("FredokaOne-Regular", size: 20))
          // .font(.title3)
          .bold()
          .foregroundColor(.white)
        Text("Following")
          .font(.subheadline)
          .foregroundColor(.white.opacity(0.8))
      }

      VStack(alignment: .leading, spacing: 4) {
        Text("\(user.followerCount)")
          .font(.custom("FredokaOne-Regular", size: 20))
          .bold()
          .foregroundColor(.white)
        Text("Followers")
          .font(.subheadline)
          .foregroundColor(.white.opacity(0.8))
      }
    }
  }

  private func bioSection(user: User) -> some View {
    HStack(spacing: 8) {
      Text(user.bio ?? "")
        .foregroundColor(.white.opacity(0.9))
        .font(.subheadline)
        .lineLimit(2)

      if viewModel.isCurrentUser {
        Button {
          editedBio = user.bio ?? ""
          showingEditBio = true
        } label: {
          Image(systemName: "pencil")
            .foregroundColor(.white)
        }
      }

      Spacer()
    }
  }

  // MARK: - Works Section
  private func worksSection(user: User) -> some View {
    VStack(alignment: .leading, spacing: 20) {
      // Works标题按钮
      ZStack(alignment: .center) {
        Image("TYRzuMytPGz0mCSA")
          .resizable()
          .scaledToFill()
          .frame(width: 110, height: 45)
          .clipped()

        StarText(
          text: "Works",
          textColor: .black,
          textSize: 18
        )
      }

      // 视频网格
      if viewModel.userVideos.isEmpty {
        // 空状态
        EmptyPlaceholderView()
          .frame(maxWidth: .infinity)
          .padding(.vertical, 40)
      } else {
        videoGrid
      }
    }
  }

  // MARK: - Video Grid
  private var videoGrid: some View {
    let screenWidth = UIScreen.main.bounds.width
    let availableWidth = screenWidth - 40  // 减去左右 padding (20 * 2)
    let cardWidth = (availableWidth - 16) / 2  // 减去中间 spacing

    return LazyVGrid(
      columns: [
        GridItem(.fixed(cardWidth), spacing: 16),
        GridItem(.fixed(cardWidth), spacing: 16),
      ], spacing: 16
    ) {
      ForEach(viewModel.userVideos) { video in
        workCard(video, cardWidth: cardWidth)
      }
    }
  }

  private func workCard(_ video: VideoItem, cardWidth: CGFloat) -> some View {
    Button {
      router.push(.detail(id: video.id))
    } label: {
      ZStack(alignment: .center) {
        // 视频封面
        // Image(video.imageName)
        DynamicImage(imageName: video.imageName)
          .scaledToFill()
          .frame(width: cardWidth, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
          .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
              .stroke(Color("buttonPurple"), lineWidth: 2)
          )

        // 播放按钮
        Image("HTLmY1hsavuQ7Jn2")
          .resizable()
          .scaledToFill()
          .frame(width: 40, height: 40)
          .clipped()
        // .offset(x: 8, y: -8)

        // 标题
        VStack(alignment: .leading, spacing: 0) {
          Spacer()
          Text(video.title)
            .font(.footnote)
            .foregroundColor(.white)
            .lineLimit(2)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
              Color.white.opacity(0.3)
                // .blur(radius: 3)
                .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))

            )
        }
      }
    }
    .buttonStyle(.plain)
  }

  // MARK: - Action Buttons Section
  @ViewBuilder
  private func actionButtonsSection(user: User) -> some View {
    if viewModel.isCurrentUser {
      // 我的页面：余额按钮
      Button(action: {
        router.push(.wallet)
      }) {
        HStack {
          Text("Balance: \(authManager.currentUser?.balance ?? 0)")
            .font(.custom("FredokaOne-Regular", size: 18))
            // .font(.headline)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
          Image("RDxEu2AHYnJdZ8zm")
            .resizable()
        )
      }
    } else {
      // 他人页面：关注和聊天按钮
      VStack(spacing: 12) {
        Button(action: {
          viewModel.toggleFollow()
        }) {
          Text(viewModel.isFollowing ? "Following" : "Follow")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            // .background(viewModel.isFollowing ? Color.purple : Color("btnpink"))
            .background(
              Image("RDxEu2AHYnJdZ8zm")
                .resizable()
            )
        }

        Button(action: {
          viewModel.sendMessage(router: router)
        }) {
          Text("Message")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
              Image("yKWcYXzqIaPg4DDM")
                .resizable()
            )
        }
      }
    }
  }

  // MARK: - Settings Section
  private var settingsSection: some View {
    VStack(spacing: 12) {
      ForEach(viewModel.settings) { setting in
        SettingRow(setting: setting) {
          viewModel.handleSettingAction(setting)
        }
      }
    }
  }
}

// MARK: - Stat Item
struct StatItem: View {
  let count: Int
  let label: String

  var body: some View {
    VStack(spacing: 4) {
      Text("\(count)")
        .font(.title3)
        .fontWeight(.bold)
      Text(label)
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: - Setting Row
struct SettingRow: View {
  let setting: SettingItem
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: 12) {
        Image(systemName: setting.icon)
          .font(.body)
          .foregroundColor(setting.isDestructive ? .red : .blue)
          .frame(width: 24)

        Text(setting.title)
          .font(.body)
          .foregroundColor(setting.isDestructive ? .red : .primary)

        Spacer()

        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding()
      .background(Color(.systemBackground))
      .cornerRadius(12)
      .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    .buttonStyle(.plain)
  }
}


// #Preview {
//     ProfileView(viewModel: ProfileViewModel(authManager: AuthenticationManager()))
// }
