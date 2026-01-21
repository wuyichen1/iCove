//
//  HomeView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  @State private var showingUnlockDialog = false
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 背景图片
      Image("Qc4hYFPT1LVSkXq5")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      // // 背景色
      // Color("buttonPurple")
      //     .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部：App名称和AI形象区域（固定不滚动）
        topSection
          .padding(.top, 50)
          .padding(.horizontal, 20)

        // 热门视频列表（可滚动）
        popularVideosSection
          .padding(.top, 20)
      }

      // 解锁确认弹窗
      if showingUnlockDialog {
        UnlockConfirmDialog(
          hasEnoughBalance: (authManager.currentUser?.balance ?? 0) >= 200,
          onCancel: {
            showingUnlockDialog = false
          },
          onConfirm: {
            showingUnlockDialog = false
            let hasEnoughBalance = (authManager.currentUser?.balance ?? 0) >= 200
            if hasEnoughBalance {
              // 余额充足，扣除 200 余额并跳转到 AI 页
              authManager.deductBalance(200)
              router.push(.ai)
            } else {
              // 余额不足，跳转到钱包页
              router.push(.wallet)
            }
          },
        )
      }
    }
    .navigationBarHidden(true)
    .enableInjection()
  }

  // MARK: - Top Section (App Name & AI Avatar)
  private var topSection: some View {
    VStack(alignment: .leading, spacing: 0) {
      // App名称
      Text("ICove")
        .font(.custom("FredokaOne-Regular", size: 32))
        .foregroundColor(.white)

      // AI内容区域
      VStack(spacing: 0) {
        Spacer().frame(height: 60)
        // 对话气泡
        VStack(alignment: .center, spacing: 16) {
          Text(
            "Hi ~ I'm your personal outfit partner! You can tell me your requirements and I'll tailor them to your needs."
          )
          .font(.system(size: 13, weight: .regular, design: .default)).italic()
          .foregroundColor(.white)

          // Unlock按钮
          Button(action: {
            showingUnlockDialog = true
          }) {
            ZStack(alignment: .topTrailing) {
              VStack {
                HStack(spacing: 4) {
                  Text("Unlock now")
                    .font(.custom("FredokaOne-Regular", size: 14))
                    .foregroundColor(.black)
                  Image("jXFWhEc2SdV2UuW7")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .clipped()

                  Text("-200")
                    .font(.custom("FredokaOne-Regular", size: 14))
                    .foregroundColor(.black)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color("yinguanglv"))
                .cornerRadius(32)
              }
              .padding(.top, 10)

              Image("qTU6kHWx1MR2Ual5")
                .resizable()
                .scaledToFill()
                .frame(width: 26, height: 26)
                .clipped()
            }

          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
        .padding(.trailing, 130)
      }
    }
  }

  // MARK: - Popular Videos Section
  private var popularVideosSection: some View {
    ZStack {
      // 透明填充，只有上边框是绿色的盒子
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
          // 只绘制上边框
          TopBorderShape(cornerRadius: 33)
            .stroke(Color.green, lineWidth: 2)
        )
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .padding(.top, 40)
        .padding(.bottom, 100)

      VStack(alignment: .leading, spacing: 16) {
        // 标题和添加按钮
        HStack {
          HStack(spacing: 8) {
            ZStack {
              Image("ZOVugBKGBc2g0HA3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 155, height: 48)
                .clipped()
                .cornerRadius(8)
              StarText(
                text: "Popular videos",
                textColor: .black,
                textSize: 16
              )
            }
            .frame(height: 45)
          }
          .padding(.trailing, 20)

          // 添加按钮
          Button(action: {
            router.push(.publish(type: .video))
          }) {
            Image("Tz0wJDM3mdSWeD0Y")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 66, height: 43)
              .clipped()
          }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)

        // 视频网格（可滚动区域）
        ScrollView {
          Group {
            if viewModel.isLoading && viewModel.videos.isEmpty {
              ProgressView("Loading...")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
            } else if viewModel.videos.isEmpty {
              Text("No video available.")
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
            } else {
              videoGridView
            }
          }
          .padding(.top, 12)
        }
        .refreshable {
          await viewModel.refresh()
        }
      }
    }
  }

  // MARK: - Video Grid View
  private var videoGridView: some View {
    let screenWidth = UIScreen.main.bounds.width
    let availableWidth = screenWidth - 40  // 减去左右 padding (20 * 2)
    let cardWidth = (availableWidth - 20) / 2  // 减去中间 spacing

    return LazyVGrid(
      columns: [
        GridItem(.fixed(cardWidth), spacing: 20),
        GridItem(.fixed(cardWidth), spacing: 20),
      ], spacing: 16
    ) {
      ForEach(viewModel.videos) { video in
        VideoCard(cardWidth: cardWidth, video: video) {
          viewModel.toggleLike(for: video)
        } onTap: {
          router.push(.detail(id: video.id))
        }
        .frame(width: cardWidth)
      }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 130)  // 为底部导航栏留出空间
  }
}

// MARK: - Video Card
struct VideoCard: View {
  let cardWidth: CGFloat
  let video: VideoItem
  let onLikeTapped: () -> Void
  var onTap: (() -> Void)? = nil

  var body: some View {
    ZStack(alignment: .topLeading) {
      // 视频封面
      Image(video.imageName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: cardWidth, height: 200)
        .clipped()
        .cornerRadius(14)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(Color("btnpink"), lineWidth: 4)
        )

      // 点赞数（左上角）
      HStack(spacing: 4) {
        Button(action: onLikeTapped) {
          Image(systemName: video.isLiked ? "heart.fill" : "heart")
            .font(.system(size: 14))
            .foregroundColor(.white)
        }
        .buttonStyle(PlainButtonStyle())
        Text("\(video.likeCount)")
          .font(.system(size: 12, weight: .medium))
          .foregroundColor(.white)
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(Color("buttonPurple"))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.white, lineWidth: 1.5)
      )
      .cornerRadius(8)
      .padding(8)

      // 更多选项（右上角）
      VStack {
        HStack {
          Spacer()
          Button(action: {
            // 更多选项
          }) {
            Image(systemName: "ellipsis")
              .foregroundColor(.white)
              .font(.system(size: 20, weight: .bold))
              .padding(8)
              .cornerRadius(8)
          }
          .buttonStyle(PlainButtonStyle())
          .padding(6)
        }
        Spacer()
      }

      // 视频描述（底部）
      VStack {
        Spacer()
        VStack(alignment: .leading, spacing: 0) {
          Text(video.title)
            .font(.system(size: 12))
            .foregroundColor(.white)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
          LinearGradient(
            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      onTap?()
    }
  }
}

// MARK: - Corner Radius Extension
extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

// MARK: - Top Border Shape
struct TopBorderShape: Shape {
  var cornerRadius: CGFloat

  func path(in rect: CGRect) -> Path {
    var path = Path()

    // 从左上角圆角开始
    path.move(to: CGPoint(x: 0, y: cornerRadius))

    // 绘制左上角圆角
    path.addArc(
      center: CGPoint(x: cornerRadius, y: cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(degrees: 180),
      endAngle: Angle(degrees: 270),
      clockwise: false
    )

    // 绘制上边框直线
    path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))

    // 绘制右上角圆角
    path.addArc(
      center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
      radius: cornerRadius,
      startAngle: Angle(degrees: 270),
      endAngle: Angle(degrees: 360),
      clockwise: false
    )

    return path
  }
}

// #Preview {
//     HomeView()
// }
