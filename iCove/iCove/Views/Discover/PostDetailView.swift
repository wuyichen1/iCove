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
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部操作栏 - 固定高度
        TopActionBar(
          onBack: {
            router.pop()
          },
          onMore: {
            // 更多选项
          },
          style: .whiteWithPurpleBorder
        )
        .frame(height: 54)

        if let post = viewModel.post {
          HStack(alignment: .top, spacing: 12) {
            // 左侧：固定宽度区域（小图列表 + 收藏按钮）
            VStack(spacing: 0) {
              // 左侧：小图列表（缩略图栏）
              leftThumbnailBar(post: post)

              Spacer()

              // 左下角收藏按钮
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
            .padding(.trailing, 8)

            // 右侧：大图显示区域 - 撑满剩余空间
            GeometryReader { geometry in
              VStack(spacing: 0) {
                // 大图显示 - 撑满剩余空间，支持加载用户上传的图片
                if selectedImageIndex < post.imageNames.count {
                  DynamicImage(imageName: post.imageNames[selectedImageIndex])
                    .frame(width: geometry.size.width, height: geometry.size.height - 160)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .clipped()
                }

                // 底部文字描述
                VStack(alignment: .leading, spacing: 0) {
                  Text(post.content)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 16)
              }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
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
    .enableInjection()
  }

  // MARK: - Left Thumbnail Bar
  private func leftThumbnailBar(post: Post) -> some View {
    ScrollView {
      VStack(spacing: 15) {
        ForEach(Array(post.imageNames.enumerated()), id: \.offset) { index, imageName in
          Button(action: {
            selectedImageIndex = index
          }) {
            DynamicImage(imageName: imageName)
              .frame(width: 62, height: 88)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(
                    selectedImageIndex == index ? Color.green : Color.clear,
                    lineWidth: selectedImageIndex == index ? 3 : 0
                  )
              )
          }
        }
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 12)
    }
    .frame(width: 62)
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
