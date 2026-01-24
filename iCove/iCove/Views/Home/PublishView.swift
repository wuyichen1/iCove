//
//  PublishView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import AVFoundation
import AVKit
import Photos
import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

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
  @State private var isUploading: Bool = false

  // 多图选择相关状态
  @State private var selectedImages: [UIImage] = []
  @State private var selectedPhotoItems: [PhotosPickerItem] = []
  @State private var showImagePicker: Bool = false

  // 视频选择相关状态
  @State private var selectedVideoURL: URL?
  @State private var selectedVideoThumbnail: UIImage?
  @State private var showVideoSourcePicker: Bool = false
  @State private var showVideoPicker: Bool = false
  @State private var showCameraRecorder: Bool = false

  // 权限相关状态
  @State private var showPermissionAlert: Bool = false
  @State private var permissionAlertTitle: String = ""
  @State private var permissionAlertMessage: String = ""

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  // 可用的图片资源（作为默认占位图）
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
              Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color("buttonPurple"))
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
    #if DEBUG
      .enableInjection()
    #endif
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

        CustomTextEditor(text: $ideaText)
          .padding(.horizontal, 16)
          .padding(.vertical, 15)

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

  // MARK: - Picture Section (图片帖子 - 支持多图)
  private var pictureSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("Picture:")
          .font(.custom("FredokaOne-Regular", size: 18))
          .foregroundColor(.white)

        Spacer()

        if !selectedImages.isEmpty {
          Text("\(selectedImages.count)/9")
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.8))
        }
      }

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(minHeight: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if selectedImages.isEmpty {
          // 显示添加图片按钮 - 先检查权限
          Button(action: {
            requestPhotoLibraryPermission { granted in
              if granted {
                showImagePicker = true
              }
            }
          }) {
            VStack(spacing: 8) {
              Image("nTJj2vmUFcjHzW5I")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
            }
          }
        } else {
          // 显示已选择的图片网格
          VStack(spacing: 8) {
            LazyVGrid(
              columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
              ], spacing: 8
            ) {
              ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                ZStack(alignment: .topTrailing) {
                  Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                  Button(action: {
                    removeImage(at: index)
                  }) {
                    Image(systemName: "xmark.circle.fill")
                      .foregroundColor(.white)
                      .background(Color.black.opacity(0.6))
                      .clipShape(Circle())
                      .font(.system(size: 18))
                  }
                  .offset(x: 4, y: -4)
                }
              }

              // 添加更多图片按钮 - 先检查权限
              if selectedImages.count < 9 {
                Button(action: {
                  requestPhotoLibraryPermission { granted in
                    if granted {
                      showImagePicker = true
                    }
                  }
                }) {
                  ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                      .fill(Color.gray.opacity(0.2))
                      .frame(width: 80, height: 80)

                    Image(systemName: "plus")
                      .font(.system(size: 24))
                      .foregroundColor(.gray)
                  }
                }
              }
            }
            .padding(12)
          }
        }
      }
    }
    .photosPicker(
      isPresented: $showImagePicker,
      selection: $selectedPhotoItems,
      maxSelectionCount: selectedImages.isEmpty ? 9 : 9 - selectedImages.count,
      matching: .images,
      photoLibrary: .shared()
    )
    .onChange(of: selectedPhotoItems) {
      loadSelectedImages()
    }
  }

  // 加载选中的图片
  private func loadSelectedImages() {
    Task {
      var images: [UIImage] = selectedImages
      for item in selectedPhotoItems {
        if let data = try? await item.loadTransferable(type: Data.self),
          let image = UIImage(data: data)
        {
          if !images.contains(where: { $0.pngData() == image.pngData() }) {
            images.append(image)
          }
        }
      }
      await MainActor.run {
        selectedImages = Array(images.prefix(9))
        selectedPhotoItems = []
      }
    }
  }

  // 移除指定索引的图片
  private func removeImage(at index: Int) {
    guard index < selectedImages.count else { return }
    selectedImages.remove(at: index)
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

        CustomTextEditor(text: $contentText)
          .padding(.horizontal, 16)
          .padding(.vertical, 15)

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

  // MARK: - Video Section (视频 - 支持相册选择和相机录制)
  private var videoSection: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Video works:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if let thumbnail = selectedVideoThumbnail {
          // 显示选中的视频缩略图
          ZStack(alignment: .topTrailing) {
            ZStack {
              Image(uiImage: thumbnail)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

              // 播放图标
              Image(systemName: "play.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.8))
            }

            Button(action: {
              clearSelectedVideo()
            }) {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .font(.system(size: 24))
            }
            .padding(12)
          }
        } else {
          // 显示视频选择按钮
          Button(action: {
            showVideoSourcePicker = true
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
    .confirmationDialog(
      "Select Video Source", isPresented: $showVideoSourcePicker, titleVisibility: .visible
    ) {
      Button("Gallery") {
        requestPhotoLibraryPermission { granted in
          if granted {
            showVideoPicker = true
          }
        }
      }
      Button("Record") {
        requestCameraAndMicrophonePermission { granted in
          if granted {
            showCameraRecorder = true
          }
        }
      }
      Button("Cancel", role: .cancel) {}
    }
    .sheet(isPresented: $showVideoPicker) {
      VideoPickerView(
        selectedVideoURL: $selectedVideoURL, selectedThumbnail: $selectedVideoThumbnail)
    }
    .fullScreenCover(isPresented: $showCameraRecorder) {
      CameraRecorderView(
        selectedVideoURL: $selectedVideoURL, selectedThumbnail: $selectedVideoThumbnail)
    }
    .alert(permissionAlertTitle, isPresented: $showPermissionAlert) {
      Button("Cancel", role: .cancel) {}
      // Button("Settings") {
      //   openAppSettings()
      // }
    } message: {
      Text(permissionAlertMessage)
    }
  }

  // MARK: - Permission Methods

  // 请求相册权限
  private func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
    let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

    switch status {
    case .authorized, .limited:
      completion(true)
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
        DispatchQueue.main.async {
          if newStatus == .authorized || newStatus == .limited {
            completion(true)
          } else {
            showPermissionDeniedAlert(for: "Photo Library")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      showPermissionDeniedAlert(for: "Photo Library")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  // 请求相机和麦克风权限
  private func requestCameraAndMicrophonePermission(completion: @escaping (Bool) -> Void) {
    // 首先检查设备是否有相机
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      showCameraUnavailableAlert()
      completion(false)
      return
    }

    // 检查相机权限
    let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)

    switch cameraStatus {
    case .authorized:
      // 相机已授权，继续检查麦克风
      requestMicrophonePermission(completion: completion)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          if granted {
            self.requestMicrophonePermission(completion: completion)
          } else {
            self.showPermissionDeniedAlert(for: "Camera")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      showPermissionDeniedAlert(for: "Camera")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  // 显示相机不可用的提示
  private func showCameraUnavailableAlert() {
    permissionAlertTitle = "Camera Unavailable"
    permissionAlertMessage = "This device does not have a camera or the camera is not available."
    showPermissionAlert = true
  }

  // 请求麦克风权限
  private func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
    let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)

    switch micStatus {
    case .authorized:
      completion(true)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .audio) { granted in
        DispatchQueue.main.async {
          if granted {
            completion(true)
          } else {
            self.showPermissionDeniedAlert(for: "Microphone")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      showPermissionDeniedAlert(for: "Microphone")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  // 显示权限被拒绝的提示
  private func showPermissionDeniedAlert(for permission: String) {
    permissionAlertTitle = "\(permission) Access Required"
    permissionAlertMessage =
      "Please enable \(permission) access in Settings to use this feature."
    showPermissionAlert = true
  }

  // 打开应用设置
  private func openAppSettings() {
    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
      UIApplication.shared.open(settingsURL)
    }
  }

  // 清除选中的视频
  private func clearSelectedVideo() {
    // 删除临时文件
    if let url = selectedVideoURL {
      try? FileManager.default.removeItem(at: url)
    }
    selectedVideoURL = nil
    selectedVideoThumbnail = nil
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
        && !selectedImages.isEmpty
    } else {
      return !contentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && selectedVideoURL != nil
    }
  }

  // MARK: - Upload Action
  private func upload() async {
    guard !isUploading else { return }
    isUploading = true

    // 模拟上传延迟
    try? await Task.sleep(nanoseconds: 500_000_000)

    guard let userId = authManager.currentUser?.id else {
      isUploading = false
      return
    }

    if publishType == .imagePost {
      // 发布图片帖子 - 支持多图
      guard !selectedImages.isEmpty else {
        isUploading = false
        return
      }

      // 保存选中的图片到本地并获取文件名
      let savedImageNames = await saveImagesToLocal(selectedImages)

      guard !savedImageNames.isEmpty else {
        isUploading = false
        return
      }

      let post = Post(
        imageNames: savedImageNames,
        authorId: userId,
        content: ideaText.trimmingCharacters(in: .whitespacesAndNewlines),
        timestamp: Date()
      )

      viewModel.publishPost(post)

      // 发送通知，通知发现页刷新
      NotificationCenter.default.post(name: NSNotification.Name("PostPublished"), object: nil)
    } else {
      // 发布视频
      guard let videoURL = selectedVideoURL else {
        isUploading = false
        return
      }

      // 保存视频到本地并获取文件名
      let savedVideoName = await saveVideoToLocal(videoURL)
      let thumbnailName = await saveThumbnailToLocal(selectedVideoThumbnail)

      let video = VideoItem(
        imageName: thumbnailName ?? availableImages.randomElement() ?? "1akQNNqBpWFE3YsJ0J",
        videoName: savedVideoName ?? videoURL.lastPathComponent,
        title: contentText.trimmingCharacters(in: .whitespacesAndNewlines),
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

  // MARK: - Helper Methods

  // 保存图片到本地
  private func saveImagesToLocal(_ images: [UIImage]) async -> [String] {
    var savedNames: [String] = []
    let fileManager = FileManager.default

    guard
      let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return savedNames
    }

    let imagesFolder = documentsPath.appendingPathComponent("UserImages", isDirectory: true)

    // 创建文件夹
    try? fileManager.createDirectory(at: imagesFolder, withIntermediateDirectories: true)

    for (index, image) in images.enumerated() {
      let fileName = "img_\(UUID().uuidString)_\(index).jpg"
      let fileURL = imagesFolder.appendingPathComponent(fileName)

      if let imageData = image.jpegData(compressionQuality: 0.8) {
        do {
          try imageData.write(to: fileURL)
          savedNames.append(fileName)
        } catch {
          print("Failed to save image: \(error)")
        }
      }
    }

    return savedNames
  }

  // 保存视频到本地
  private func saveVideoToLocal(_ videoURL: URL) async -> String? {
    let fileManager = FileManager.default

    guard
      let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return nil
    }

    let videosFolder = documentsPath.appendingPathComponent("UserVideos", isDirectory: true)

    // 创建文件夹
    try? fileManager.createDirectory(at: videosFolder, withIntermediateDirectories: true)

    let fileName = "video_\(UUID().uuidString).mp4"
    let destinationURL = videosFolder.appendingPathComponent(fileName)

    do {
      // 如果目标文件已存在，先删除
      if fileManager.fileExists(atPath: destinationURL.path) {
        try fileManager.removeItem(at: destinationURL)
      }
      try fileManager.copyItem(at: videoURL, to: destinationURL)
      return fileName
    } catch {
      print("Failed to save video: \(error)")
      return nil
    }
  }

  // 保存缩略图到本地
  private func saveThumbnailToLocal(_ thumbnail: UIImage?) async -> String? {
    guard let thumbnail = thumbnail else { return nil }

    let fileManager = FileManager.default

    guard
      let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return nil
    }

    let thumbnailsFolder = documentsPath.appendingPathComponent(
      "VideoThumbnails", isDirectory: true)

    // 创建文件夹
    try? fileManager.createDirectory(at: thumbnailsFolder, withIntermediateDirectories: true)

    let fileName = "thumb_\(UUID().uuidString).jpg"
    let fileURL = thumbnailsFolder.appendingPathComponent(fileName)

    if let imageData = thumbnail.jpegData(compressionQuality: 0.8) {
      do {
        try imageData.write(to: fileURL)
        return fileName
      } catch {
        print("Failed to save thumbnail: \(error)")
      }
    }

    return nil
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

// MARK: - Video Picker View (从相册选择视频)
struct VideoPickerView: UIViewControllerRepresentable {
  @Binding var selectedVideoURL: URL?
  @Binding var selectedThumbnail: UIImage?
  @Environment(\.dismiss) var dismiss

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .videos
    config.selectionLimit = 1

    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: VideoPickerView

    init(_ parent: VideoPickerView) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.dismiss()

      guard let result = results.first else { return }

      // 检查是否包含视频
      if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
        result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) {
          url, error in
          guard let url = url, error == nil else {
            print("Error loading video: \(error?.localizedDescription ?? "unknown error")")
            return
          }

          // 复制视频到临时目录
          let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(
            UUID().uuidString + ".mp4")
          do {
            try FileManager.default.copyItem(at: url, to: tempURL)

            // 生成缩略图
            let thumbnail = self.generateThumbnail(for: tempURL)

            DispatchQueue.main.async {
              self.parent.selectedVideoURL = tempURL
              self.parent.selectedThumbnail = thumbnail
            }
          } catch {
            print("Error copying video: \(error)")
          }
        }
      }
    }

    // 生成视频缩略图
    func generateThumbnail(for url: URL) -> UIImage? {
      let asset = AVURLAsset(url: url)
      let imageGenerator = AVAssetImageGenerator(asset: asset)
      imageGenerator.appliesPreferredTrackTransform = true

      // 使用同步方式获取缩略图（在后台线程调用）
      let semaphore = DispatchSemaphore(value: 0)
      var resultImage: UIImage?

      imageGenerator.generateCGImageAsynchronously(
        for: CMTime(seconds: 0, preferredTimescale: 1)
      ) { cgImage, _, error in
        if let cgImage = cgImage {
          resultImage = UIImage(cgImage: cgImage)
        } else if let error = error {
          print("Error generating thumbnail: \(error)")
        }
        semaphore.signal()
      }

      semaphore.wait()
      return resultImage
    }
  }
}

// MARK: - Camera Recorder View (相机录制视频)
struct CameraRecorderView: View {
  @Binding var selectedVideoURL: URL?
  @Binding var selectedThumbnail: UIImage?
  @Environment(\.dismiss) var dismiss

  @State private var showError: Bool = false
  @State private var errorMessage: String = ""

  var body: some View {
    Group {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        CameraRecorderViewController(
          selectedVideoURL: $selectedVideoURL,
          selectedThumbnail: $selectedThumbnail,
          onError: { error in
            errorMessage = error
            showError = true
          }
        )
        .ignoresSafeArea()
      } else {
        // 相机不可用时显示提示
        VStack(spacing: 20) {
          Image(systemName: "camera.fill")
            .font(.system(size: 60))
            .foregroundColor(.gray)

          Text("Camera Unavailable")
            .font(.headline)

          Text("This device does not have a camera or the camera is not available.")
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)

          Button("Close") {
            dismiss()
          }
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
        }
      }
    }
    .alert("Error", isPresented: $showError) {
      Button("OK") {
        dismiss()
      }
    } message: {
      Text(errorMessage)
    }
  }
}

// MARK: - Camera Recorder ViewController Representable
struct CameraRecorderViewController: UIViewControllerRepresentable {
  @Binding var selectedVideoURL: URL?
  @Binding var selectedThumbnail: UIImage?
  var onError: (String) -> Void
  @Environment(\.dismiss) var dismiss

  func makeUIViewController(context: Context) -> UIViewController {
    // 再次检查相机是否可用
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      let errorVC = UIViewController()
      DispatchQueue.main.async {
        onError("Camera is not available on this device.")
      }
      return errorVC
    }

    do {
      let picker = UIImagePickerController()
      picker.sourceType = .camera

      // 检查是否支持视频录制
      guard
        let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: .camera),
        availableMediaTypes.contains(UTType.movie.identifier)
      else {
        DispatchQueue.main.async {
          onError("Video recording is not supported on this device.")
        }
        return UIViewController()
      }

      picker.mediaTypes = [UTType.movie.identifier]
      picker.videoMaximumDuration = 60  // 最大录制时长60秒
      picker.videoQuality = .typeHigh
      picker.cameraCaptureMode = .video
      picker.delegate = context.coordinator
      return picker
    }
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: CameraRecorderViewController

    init(_ parent: CameraRecorderViewController) {
      self.parent = parent
    }

    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
      parent.dismiss()

      if let videoURL = info[.mediaURL] as? URL {
        // 复制视频到临时目录
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(
          UUID().uuidString + ".mp4")
        do {
          try FileManager.default.copyItem(at: videoURL, to: tempURL)

          // 生成缩略图
          let thumbnail = generateThumbnail(for: tempURL)

          DispatchQueue.main.async {
            self.parent.selectedVideoURL = tempURL
            self.parent.selectedThumbnail = thumbnail
          }
        } catch {
          print("Error copying video: \(error)")
          DispatchQueue.main.async {
            self.parent.onError("Failed to save the recorded video.")
          }
        }
      }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.dismiss()
    }

    // 生成视频缩略图
    func generateThumbnail(for url: URL) -> UIImage? {
      let asset = AVURLAsset(url: url)
      let imageGenerator = AVAssetImageGenerator(asset: asset)
      imageGenerator.appliesPreferredTrackTransform = true

      // 使用同步方式获取缩略图（在后台线程调用）
      let semaphore = DispatchSemaphore(value: 0)
      var resultImage: UIImage?

      imageGenerator.generateCGImageAsynchronously(
        for: CMTime(seconds: 0, preferredTimescale: 1)
      ) { cgImage, _, error in
        if let cgImage = cgImage {
          resultImage = UIImage(cgImage: cgImage)
        } else if let error = error {
          print("Error generating thumbnail: \(error)")
        }
        semaphore.signal()
      }

      semaphore.wait()
      return resultImage
    }
  }
}

// MARK: - Custom Text Editor (支持 Done 按钮关闭键盘)
struct CustomTextEditor: UIViewRepresentable {
  @Binding var text: String

  func makeUIView(context: Context) -> UITextView {
    let textView = UITextView()
    textView.delegate = context.coordinator
    textView.font = .systemFont(ofSize: 15)
    textView.textColor = .black
    textView.backgroundColor = .clear
    textView.returnKeyType = .done
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    return textView
  }

  func updateUIView(_ uiView: UITextView, context: Context) {
    if uiView.text != text {
      uiView.text = text
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UITextViewDelegate {
    let parent: CustomTextEditor

    init(_ parent: CustomTextEditor) {
      self.parent = parent
    }

    func textViewDidChange(_ textView: UITextView) {
      parent.text = textView.text
    }

    func textView(
      _ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String
    ) -> Bool {
      // 当用户点击 Done 按钮时（输入换行符），关闭键盘
      if text == "\n" && textView.returnKeyType == .done {
        textView.resignFirstResponder()
        return false
      }
      return true
    }
  }
}

// #Preview {
//     PublishView(publishType: .video)
// }
