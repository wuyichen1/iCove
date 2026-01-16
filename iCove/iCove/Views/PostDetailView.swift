//
//  PostDetailView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
    import HotSwiftUI
#endif

struct PostDetailView: View {
    let postId: String
    @EnvironmentObject var router: Router
    @StateObject private var viewModel: PostDetailViewModel
    @State private var selectedImageIndex: Int = 0
    
    #if DEBUG
        @ObserveInjection var redraw
    #endif
    
    init(postId: String) {
        self.postId = postId
        _viewModel = StateObject(wrappedValue: PostDetailViewModel(postId: postId))
    }
    
    var body: some View {
        ZStack {
            // 深紫色背景
            Color(red: 0.25, green: 0.18, blue: 0.35)
                .ignoresSafeArea()
            
            if let post = viewModel.post {
                HStack(spacing: 0) {
                    // 左侧：小图列表
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(Array(post.imageNames.enumerated()), id: \.offset) { index, imageName in
                                Button(action: {
                                    selectedImageIndex = index
                                }) {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    selectedImageIndex == index ? Color.white : Color.clear,
                                                    lineWidth: 3
                                                )
                                        )
                                }
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                    }
                    .frame(width: 104)
                    .background(Color(red: 0.25, green: 0.18, blue: 0.35))
                    
                    // 右侧：大图显示
                    ZStack {
                        // 大图显示
                        if selectedImageIndex < post.imageNames.count {
                            Image(post.imageNames[selectedImageIndex])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipped()
                        }
                        
                        // 顶部操作栏
                        VStack {
                            HStack {
                                // 返回按钮
                                Button(action: {
                                    router.pop()
                                }) {
                                    Image(systemName: "arrowshape.backward.fill")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.2))
                                        .clipShape(Circle())
                                }
                                
                                Spacer()
                                
                                // 更多选项
                                Button(action: {
                                    // 更多选项
                                }) {
                                    Image(systemName: "ellipsis")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.2))
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            
                            Spacer()
                        }
                        
                        // 底部内容区域
                        VStack {
                            Spacer()
                            
                            // 底部描述
                            VStack(alignment: .leading, spacing: 8) {
                                Text(post.content)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.clear,
                                        Color(red: 0.25, green: 0.18, blue: 0.35).opacity(0.95)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            
                            // 底部收藏按钮
                            HStack {
                                Spacer()
                                Button(action: {
                                    viewModel.toggleCollect()
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.purple)
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: viewModel.post?.isCollected == true ? "star.fill" : "star")
                                            .font(.system(size: 24))
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding(.trailing, 20)
                                .padding(.bottom, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            } else {
                ProgressView("加载中...")
                    .foregroundColor(.white)
            }
        }
        .navigationBarHidden(true)
        .enableInjection()
    }
}

// MARK: - Post Detail ViewModel
@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    
    private let postId: String
    private let postService: PostDataServiceProtocol
    
    init(
        postId: String,
        postService: PostDataServiceProtocol = PostDataService.shared
    ) {
        self.postId = postId
        self.postService = postService
        loadPost()
    }
    
    private func loadPost() {
        post = postService.getPostById(postId)
    }
    
    func toggleCollect() {
        guard var post = post else { return }
        post.isCollected.toggle()
        self.post = post
        postService.updatePost(post)
    }
}

// #Preview {
//     PostDetailView(postId: "test_post_id")
// }
