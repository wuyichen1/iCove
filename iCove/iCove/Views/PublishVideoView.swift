//
//  PublishVideoView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI
#if DEBUG
import HotSwiftUI
#endif

struct PublishVideoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthenticationManager
    @StateObject private var viewModel = PublishVideoViewModel()
    @State private var selectedImage: String?
    @State private var videoName: String = ""
    @State private var title: String = ""
    @State private var showingImagePicker = false
    
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
        "qTU6kHWx1MR2Ual5"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // 图片选择区域
                    imageSelectionSection
                    
                    // 视频名称输入区域
                    videoNameInputSection
                    
                    // 标题输入区域
                    titleInputSection
                    
                    // 发布按钮
                    publishButton
                }
                .padding()
            }
            .navigationTitle("发布视频")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
            }
        }
        .enableInjection()
    }
    
    // MARK: - Image Selection Section
    private var imageSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("选择视频封面")
                .font(.headline)
                .foregroundColor(.primary)
            
            if let selectedImage = selectedImage {
                // 显示选中的图片
                Image(selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .overlay(
                        Button(action: {
                            self.selectedImage = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding(8),
                        alignment: .topTrailing
                    )
            } else {
                // 图片选择网格
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(availableImages, id: \.self) { imageName in
                        Button(action: {
                            selectedImage = imageName
                        }) {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 100)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Video Name Input Section
    private var videoNameInputSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("视频名称")
                .font(.headline)
                .foregroundColor(.primary)
            
            TextField("输入视频名称...", text: $videoName)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    // MARK: - Title Input Section
    private var titleInputSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("视频标题")
                .font(.headline)
                .foregroundColor(.primary)
            
            TextField("输入视频标题...", text: $title, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(3...6)
        }
    }
    
    // MARK: - Publish Button
    private var publishButton: some View {
        Button(action: {
            publishVideo()
        }) {
            Text("发布")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(canPublish ? Color("buttonPurple") : Color.gray)
                .cornerRadius(12)
        }
        .disabled(!canPublish)
    }
    
    private var canPublish: Bool {
        !videoName.isEmpty && !title.isEmpty && selectedImage != nil
    }
    
    private func publishVideo() {
        guard let imageName = selectedImage else { return }
        guard let userId = authManager.currentUser?.id else {
            // 如果用户未登录，使用默认用户 ID
            // 实际应用中应该要求用户先登录
            return
        }
        
        let video = VideoItem(
            imageName: imageName,
            videoName: videoName,
            title: title,
            authorId: userId,
            timestamp: Date(),
            likeCount: 0,
            isLiked: false
        )
        
        viewModel.publishVideo(video)
        
        // 发送通知，通知首页刷新
        NotificationCenter.default.post(name: NSNotification.Name("VideoPublished"), object: nil)
        
        dismiss()
    }
}

// MARK: - Publish Video ViewModel
@MainActor
class PublishVideoViewModel: ObservableObject {
    private let videoService: VideoDataServiceProtocol = VideoDataService.shared
    
    func publishVideo(_ video: VideoItem) {
        videoService.addVideo(video)
    }
}

// #Preview {
//     PublishVideoView()
// }
