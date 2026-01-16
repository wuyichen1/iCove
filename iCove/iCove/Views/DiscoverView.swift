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
    @StateObject private var viewModel = DiscoverViewModel()
    @State private var selectedCollectionIndex: Int = 0
    @EnvironmentObject var router: Router
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        ZStack {
            // 背景图片 - 深紫色背景，右上角有浅紫色点状图案
            Color(red: 0.25, green: 0.18, blue: 0.35)
                .ignoresSafeArea()
            
            // 背景图案（可选，如果需要点状图案）
            // 这里可以添加自定义背景图案视图
            
            VStack(spacing: 0) {
                // 顶部标题区域 - 始终显示
                headerSection
                
                // 内容区域 - 根据加载状态显示不同内容
                if viewModel.isLoading && viewModel.collectedPosts.isEmpty && viewModel.allPosts.isEmpty {
                    loadingView
                } else {
                    contentView
                }
            }
        }
        .navigationBarHidden(true)
        .enableInjection()
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
            .padding(.top, 60)
            .padding(.bottom, 16)
            
            // My collection 文字
            HStack {
                Text("My collection")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.green)
                
                // 两个星星图标
                HStack(spacing: 4) {
                    Image(systemName: "sparkle")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                    Image(systemName: "sparkle")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
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
            
            Text("加载中...")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Content View
    private var contentView: some View {
        VStack(spacing: 0) {
            // 收藏图片轮播
            if !viewModel.collectedPosts.isEmpty {
                collectionCarousel
                    .padding(.bottom, 20)
            }
            
            // All 和 + 按钮
            HStack(spacing: 12) {
                // All 按钮
                Button(action: {
                    // 显示全部
                }) {
                    HStack(spacing: 4) {
                        Text("All")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Image(systemName: "sparkle")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Image(systemName: "sparkle")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.green)
                    .cornerRadius(12)
                }
                
                // + 按钮
                Button(action: {
                    // 添加操作
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
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
                .padding(.bottom, 100)  // 为底部导航栏留出空间
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
                        .frame(height: 250)
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
        .frame(height: 250)
    }
}

// MARK: - Post Card
struct PostCard: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 头部：头像、用户名、更多选项
            HStack(alignment: .top) {
                // 头像
                if let avatar = post.authorAvatar {
                    Image(avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pink, Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2.5
                                )
                        )
                } else {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.3)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .overlay {
                            Text(String(post.authorUsername.prefix(1)))
                                .font(.headline)
                                .foregroundColor(.pink)
                        }
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pink, Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2.5
                                )
                        )
                }
                
                // 用户名
                Text(post.authorUsername)
                    .font(.system(size: 16, weight: .bold))
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
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 12)
            
            // 帖子内容
            Text(post.content)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .lineLimit(3)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            // 图片网格
            if !post.imageNames.isEmpty {
                HStack(spacing: 8) {
                    ForEach(Array(post.imageNames.prefix(3).enumerated()), id: \.offset) { index, imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width - 60) / 3, height: (UIScreen.main.bounds.width - 60) / 3)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // 如果图片超过3张，显示"+N"
                    if post.imageNames.count > 3 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.9))
                            
                            Text("+\(post.imageNames.count - 3)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(width: (UIScreen.main.bounds.width - 60) / 3, height: (UIScreen.main.bounds.width - 60) / 3)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

// #Preview {
//     DiscoverView()
// }
