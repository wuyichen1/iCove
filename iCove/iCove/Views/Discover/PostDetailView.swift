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
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: PostDetailViewModel
  @State private var selectedImageIndex: Int = 0
  @State private var showingReportBlockSheet = false
  @State private var showingBlockDialog = false
  @State private var blockUserId: String? = nil

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
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部操作栏 - 固定高度
        TopActionBar(
          onBack: {
            router.pop()
          },
          onMore: {
            if let post = viewModel.post {
              showingReportBlockSheet = true
            }
          },
          style: .whiteWithPurpleBorder
        )
        .frame(height: 54)

        if let post = viewModel.post {
          GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let totalHeight = geometry.size.height
            let leftWidth: CGFloat = 64  // 左侧固定宽度
            let spacing: CGFloat = 16
            let rightWidth = totalWidth - leftWidth - spacing

            HStack(alignment: .top, spacing: spacing) {
              // 左侧：小图列表 + 收藏按钮
              VStack(spacing: 0) {
                // 缩略图列表
                ScrollView(.vertical, showsIndicators: false) {
                  VStack(spacing: 16) {
                    ForEach(Array(post.imageNames.enumerated()), id: \.offset) { index, imageName in
                      thumbnailItem(imageName: imageName, index: index)
                    }
                  }
                  .padding(.top, 12)
                }

                Spacer(minLength: 20)

                // 收藏按钮
                Button(action: {
                  viewModel.toggleCollect()
                }) {
                  ZStack {
                    Circle()
                      .fill(Color("buttonPurple"))
                      .frame(width: 54, height: 54)

                    Image(systemName: "star.fill")
                      .font(.system(size: 24))
                      .foregroundColor(viewModel.post?.isCollected == true ? .yellow : .white)
                  }
                }
                .padding(.bottom, 20)
              }
              .frame(width: leftWidth)
              .zIndex(1)  // 确保左侧在上层

              // 右侧：大图 + 文字描述
              VStack(spacing: 0) {
                // 大图
                if selectedImageIndex < post.imageNames.count {
                  DynamicImage(imageName: post.imageNames[selectedImageIndex])
                    .id(selectedImageIndex)  // 将index作为id，每次id变化，就强制在 index 变化时重新创建视图
                    .frame(width: rightWidth, height: max(0, totalHeight - 160))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .contentShape(RoundedRectangle(cornerRadius: 20))  // 限制点击区域
                }

                // 底部文字描述
                Text(post.content)
                  .font(.system(size: 14))
                  .foregroundColor(.white)
                  .lineLimit(nil)
                  .fixedSize(horizontal: false, vertical: true)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.vertical, 16)
              }
              .frame(width: rightWidth)
              .padding(.top, 12)
            }
          }
          .padding(.horizontal, 20)
        } else {
          ProgressView("Loading...")
            .foregroundColor(.white)
        }
      }
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    .sheet(isPresented: $showingReportBlockSheet) {
      if let post = viewModel.post {
        ReportBlockBottomSheet(
          userId: post.authorId,
          isPresented: $showingReportBlockSheet,
          onBlock: {
            if let post = viewModel.post {
              blockUserId = post.authorId
              showingBlockDialog = true
            }
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
    .enableInjection()
  }

  // MARK: - Thumbnail Item
  private func thumbnailItem(imageName: String, index: Int) -> some View {
    ZStack {
      DynamicImage(imageName: imageName)
        .frame(width: 62, height: 88)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .allowsHitTesting(false)  // 禁止图片拦截点击

      // 选中边框
      RoundedRectangle(cornerRadius: 12)
        .stroke(
          selectedImageIndex == index ? Color("yinguanglv") : Color.clear,
          lineWidth: 2
        )
        .frame(width: 62, height: 88)
        .allowsHitTesting(false)
    }
    .frame(width: 64, height: 88)
    .contentShape(Rectangle())  // 明确定义整个区域可点击
    .onTapGesture {
      selectedImageIndex = index
      print("selectedImageIndex: \(selectedImageIndex)")
    }
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
