//
//  PublishView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct PublishView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel = PublishViewModel()

  let publishType: PublishType

  @State private var ideaText: String = ""
  @State private var contentText: String = ""
  @State private var selectedImageName: String?
  @State private var isUploading: Bool = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  // 可用的图片资源
  private let availableImages = [
    "1akQNNqBpWFE3YsJ0J",
    "2bnmWxXjHOykhJtNRF",
    "3cdKT1VeSfXcPS1lVn",
    "4dv94xvRXwbcpHXAn1",
    "CXGyBeCKoF4QQ3vX",
    "EjFPYXDNG5OrCp97",
    "Qc4hYFPT1LVSkXq5",
    "ZOVugBKGBc2g0HA3",
    "f6KDmB5rYAx2Ke6S",
    "gY80sW7YXCRIPed2",
    "jK792W9HOGn9U1z3",
    "jXFWhEc2SdV2UuW7",
    "qTU6kHWx1MR2Ual5",
  ]

  var body: some View {
    ZStack {
      // 背景色
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 返回按钮
        HStack {
          Button(action: {
            dismiss()
          }) {
            ZStack {
              Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
              Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
                .font(.system(size: 18, weight: .semibold))
            }
          }
          // .padding(.top, 46)
          .padding(.leading, 20)

          Spacer()
        }
        .padding(.bottom, 20)

        ScrollView {
          VStack(spacing: 24) {
            // 主要内容卡片
            mainContentCard
              .padding(.horizontal, 20)
              .padding(.top, 20)

            // Upload 按钮
            uploadButton
              .padding(.horizontal, 20)
              .padding(.top, 20)
              .padding(.bottom, 40)
          }
        }
      }
    }
    .navigationBarHidden(true)
    .enableInjection()
  }

  // MARK: - Main Content Card
  private var mainContentCard: some View {
    ZStack {
      // 渐变背景
      LinearGradient(
        colors: [
          Color("btnpink"),
          Color.white,
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))

      VStack(alignment: .leading, spacing: 20) {
        if publishType == .imagePost {
          // 发布图片帖子：Idea 和 Picture
          ideaSection
          pictureSection
        } else {
          // 发布视频：Content 和 Video works
          contentSection
          videoSection
        }
      }
      .padding(20)
    }
  }

  // MARK: - Idea Section (图片帖子)
  private var ideaSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Idea:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 180)

        TextEditor(text: $ideaText)
          .scrollContentBackground(.hidden)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .foregroundColor(.black)
          .font(.system(size: 15))

        if ideaText.isEmpty {
          Text("Enter")
            .foregroundColor(.gray.opacity(0.5))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
      }
    }
  }

  // MARK: - Picture Section (图片帖子)
  private var pictureSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Picture:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if let imageName = selectedImageName {
          // 显示选中的图片
          Button(action: {
            selectedImageName = nil
          }) {
            ZStack(alignment: .topTrailing) {
              Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .padding(8)
            }
          }
        } else {
          // 显示图片选择器
          Button(action: {
            // 打开图片选择器或从可用图片中选择
            selectedImageName = availableImages.randomElement()
          }) {
            VStack(spacing: 8) {
              Image("nTJj2vmUFcjHzW5I")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
            }
          }
        }
      }
    }
  }

  // MARK: - Content Section (视频)
  private var contentSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Content:")
        .font(.custom("FredokaOne-Regular", size: 18))
        // .foregroundColor(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
        .foregroundColor(.white)

      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 180)

        TextEditor(text: $contentText)
          .scrollContentBackground(.hidden)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .foregroundColor(.black)
          .font(.system(size: 15))

        if contentText.isEmpty {
          Text("Enter")
            .foregroundColor(.gray.opacity(0.5))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
      }
    }
  }

  // MARK: - Video Section (视频)
  private var videoSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Video works:")
        .font(.custom("FredokaOne-Regular", size: 18))
        // .foregroundColor(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
        .foregroundColor(.white)

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if let imageName = selectedImageName {
          // 显示选中的视频封面
          Button(action: {
            selectedImageName = nil
          }) {
            ZStack(alignment: .topTrailing) {
              Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .padding(8)
            }
          }
        } else {
          // 显示视频选择器
          Button(action: {
            // 打开视频选择器或从可用图片中选择封面
            selectedImageName = availableImages.randomElement()
          }) {
            VStack(spacing: 8) {
              Image("2AQ4HXnboJp7so7u")
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
            }
          }
        }
      }
    }
  }

  // MARK: - Upload Button
  private var uploadButton: some View {
    Button(action: {
      Task {
        await upload()
      }
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color("buttonPurple"))
          .frame(width: 220, height: 50)
          .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .stroke(Color.white, lineWidth: 2)
          )

        if isUploading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text("Upload")
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.white)
        }
      }
    }
    .disabled(!canUpload || isUploading)
  }

  private var canUpload: Bool {
    if publishType == .imagePost {
      return !ideaText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && selectedImageName != nil
    } else {
      return !contentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && selectedImageName != nil
    }
  }

  // MARK: - Upload Action
  private func upload() async {
    guard !isUploading else { return }
    isUploading = true

    // 模拟上传延迟
    try? await Task.sleep(nanoseconds: 600_000_000)

    guard let userId = authManager.currentUser?.id else {
      isUploading = false
      return
    }

    if publishType == .imagePost {
      // 发布图片帖子
      guard let imageName = selectedImageName else {
        isUploading = false
        return
      }

      let post = Post(
        imageNames: [imageName],
        authorId: userId,
        content: ideaText.trimmingCharacters(in: .whitespacesAndNewlines),
        timestamp: Date(),
        isCollected: false
      )

      viewModel.publishPost(post)

      // 发送通知，通知发现页刷新
      NotificationCenter.default.post(name: NSNotification.Name("PostPublished"), object: nil)
    } else {
      // 发布视频
      guard let imageName = selectedImageName else {
        isUploading = false
        return
      }

      let video = VideoItem(
        imageName: imageName,
        videoName: contentText,
        title: contentText,
        authorId: userId,
        timestamp: Date(),
        likeCount: 0,
        isLiked: false
      )

      viewModel.publishVideo(video)

      // 发送通知，通知首页刷新
      NotificationCenter.default.post(name: NSNotification.Name("VideoPublished"), object: nil)
    }

    isUploading = false
    dismiss()
  }
}

// MARK: - Publish ViewModel
@MainActor
class PublishViewModel: ObservableObject {
  private let videoService: VideoDataServiceProtocol = VideoDataService.shared
  private let postService: PostDataServiceProtocol = PostDataService.shared

  func publishVideo(_ video: VideoItem) {
    videoService.addVideo(video)
  }

  func publishPost(_ post: Post) {
    postService.addPost(post)
  }
}

// #Preview {
//     PublishView(publishType: .video)
// }
