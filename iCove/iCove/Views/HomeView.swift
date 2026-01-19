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
    @State private var showingPublishView = false
    @EnvironmentObject var router: Router
    
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

                ScrollView {
                    VStack(spacing: 0) {
                        // 顶部：App名称和AI形象区域
                        topSection
                            .padding(.top, 50)
                            .padding(.horizontal, 20)

                        // 热门视频列表
                        popularVideosSection
                            .padding(.top, 24)
                            .padding(.bottom, 130)  // 为底部导航栏留出空间
                    }
                }
                .refreshable {
                    await viewModel.refresh()
                }
        }
        .sheet(isPresented: $showingPublishView) {
            PublishVideoView()
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
                Spacer().frame(height: 56)
                // 对话气泡
                VStack(alignment: .center, spacing: 20) {
                    Text(
                        "Hi ~ I'm your personal outfit partner! You can tell me your requirements and I'll tailor them to your needs."
                    )
                    .font(.system(size: 13, weight: .regular, design: .default)).italic()
                    .foregroundColor(.white)
                    // .background(Color.white)
                    .cornerRadius(12)

                    // Unlock按钮
                    Button(action: {
                        // 解锁功能
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "carrot.fill")
                                .font(.system(size: 14))
                            Text("Unlock now")
                                .font(.system(size: 14, weight: .semibold))
                            Text("-200")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(8)
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

            VStack(alignment: .leading, spacing: 24) {
                // 标题和添加按钮
                HStack {
                    HStack(spacing: 8) {
                        ZStack {
                            Image("ZOVugBKGBc2g0HA3")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 45)
                                .clipped()
                                .cornerRadius(8)
                            Text("Popular videos")
                                .font(.custom("FredokaOne-Regular", size: 18))
                                .foregroundColor(.black)
                        }
                        .frame(height: 45)

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)

                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    // 添加按钮
                    Button(action: {
                        showingPublishView = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)

                // 视频网格
                if viewModel.isLoading && viewModel.videos.isEmpty {
                    ProgressView("加载中...")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                } else if viewModel.videos.isEmpty {
                    Text("暂无视频")
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 20),
                            GridItem(.flexible(), spacing: 20),
                        ], spacing: 16
                    ) {
                        ForEach(viewModel.videos) { video in
                            VideoCard(video: video) {
                                viewModel.toggleLike(for: video)
                            } onTap: {
                                router.push(.detail(id: video.id))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}

// MARK: - Video Card
struct VideoCard: View {
    let video: VideoItem
    let onLikeTapped: () -> Void
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // 视频封面
            Image(video.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("buttonPurple"), lineWidth: 2)
                )
                // 调试打印
                // .onAppear {
                //     print("📹 Video imageName: \(video.imageName)")
                // }

            // 点赞数（左上角）
            HStack(spacing: 4) {
                Button(action: onLikeTapped) {
                    Image(systemName: video.isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                        .foregroundColor(video.isLiked ? .red : Color("buttonPurple"))
                }
                .buttonStyle(PlainButtonStyle())
                Text("\(video.likeCount)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(8)
            .background(Color.black.opacity(0.5))
            .cornerRadius(8)
            .padding(8)

            // 更多选项（右上角）
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        // 更多选项
                    }) {
                        HStack(spacing: 2) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 4, height: 4)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 4, height: 4)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 4, height: 4)
                        }
                        .padding(8)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
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
