//
//  ImagePickerView.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import AVFoundation
import Photos
import PhotosUI
import SwiftUI
import UIKit

/// 公共的图片选择组件
/// 支持从相册选择或相机拍照
struct ImagePickerView: ViewModifier {
  @Binding var selectedImage: UIImage?
  @Binding var showImageSourcePicker: Bool
  @State private var selectedPhotoItem: PhotosPickerItem?
  @State private var showPhotoPicker: Bool = false
  @State private var showCameraPicker: Bool = false
  @State private var showCameraErrorAlert: Bool = false
  @State private var showPhotoPermissionAlert: Bool = false
  @State private var showCameraPermissionAlert: Bool = false

  func body(content: Content) -> some View {
    content
      .confirmationDialog(
        "Select Photo Source", isPresented: $showImageSourcePicker, titleVisibility: .visible
      ) {
        Button("Gallery") {
          checkAndOpenPhotoLibrary()
        }
        Button("Camera") {
          checkAndOpenCamera()
        }
        Button("Cancel", role: .cancel) {}
      }
      .photosPicker(
        isPresented: $showPhotoPicker,
        selection: $selectedPhotoItem,
        matching: .images,
        photoLibrary: .shared()
      )
      .onChange(of: selectedPhotoItem) {
        loadSelectedImage()
      }
      .fullScreenCover(isPresented: $showCameraPicker) {
        CameraPickerView(selectedImage: $selectedImage)
      }
      .alert("Camera Unavailable", isPresented: $showCameraErrorAlert) {
        Button("OK", role: .cancel) {}
      } message: {
        Text("Camera is not available on this device or camera access is not permitted.")
      }
      .alert("Photo Library Permission Required", isPresented: $showPhotoPermissionAlert) {
        Button("Settings") {
          if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
          }
        }
        Button("Cancel", role: .cancel) {}
      } message: {
        Text("Please grant photo library access in Settings to select photos.")
      }
      .alert("Camera Permission Required", isPresented: $showCameraPermissionAlert) {
        Button("Settings") {
          if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
          }
        }
        Button("Cancel", role: .cancel) {}
      } message: {
        Text("Please grant camera access in Settings to take photos.")
      }
  }

  // 检查并打开相册
  private func checkAndOpenPhotoLibrary() {
    let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

    switch status {
    case .authorized, .limited:
      // 已有权限，打开相册
      showPhotoPicker = true
    case .notDetermined:
      // 未确定，请求权限
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
        DispatchQueue.main.async {
          if newStatus == .authorized || newStatus == .limited {
            showPhotoPicker = true
          } else {
            showPhotoPermissionAlert = true
          }
        }
      }
    case .denied, .restricted:
      // 被拒绝或受限，显示提示
      showPhotoPermissionAlert = true
    @unknown default:
      showPhotoPermissionAlert = true
    }
  }

  // 检查摄像头是否可用并请求权限
  private func checkAndOpenCamera() {
    // 先检查设备是否支持相机
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      showCameraErrorAlert = true
      return
    }

    // 检查是否有可用的摄像头设备
    let cameraMediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
    guard !cameraMediaTypes.isEmpty else {
      showCameraErrorAlert = true
      return
    }

    // 检查相机权限
    let status = AVCaptureDevice.authorizationStatus(for: .video)

    switch status {
    case .authorized:
      // 已有权限，打开相机
      showCameraPicker = true
    case .notDetermined:
      // 未确定，请求权限
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          if granted {
            showCameraPicker = true
          } else {
            showCameraPermissionAlert = true
          }
        }
      }
    case .denied, .restricted:
      // 被拒绝或受限，显示提示
      showCameraPermissionAlert = true
    @unknown default:
      showCameraPermissionAlert = true
    }
  }

  // 加载选中的图片
  private func loadSelectedImage() {
    Task {
      if let item = selectedPhotoItem,
        let data = try? await item.loadTransferable(type: Data.self),
        let image = UIImage(data: data)
      {
        await MainActor.run {
          selectedImage = image
          selectedPhotoItem = nil
        }
      }
    }
  }
}

/// 扩展 View 以方便使用
extension View {
  func imagePicker(selectedImage: Binding<UIImage?>, showPicker: Binding<Bool>) -> some View {
    modifier(ImagePickerView(selectedImage: selectedImage, showImageSourcePicker: showPicker))
  }
}

/// 相机选择器
struct CameraPickerView: UIViewControllerRepresentable {
  @Binding var selectedImage: UIImage?
  @Environment(\.dismiss) var dismiss

  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator

    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      picker.sourceType = .camera
      picker.cameraCaptureMode = .photo
    }

    return picker
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: CameraPickerView

    init(_ parent: CameraPickerView) {
      self.parent = parent
    }

    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
      if let image = info[.originalImage] as? UIImage {
        parent.selectedImage = image
      }
      parent.dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.dismiss()
    }
  }
}

/// 图片选择器视图模型 - 用于管理图片选择状态
@MainActor
class ImagePickerViewModel: ObservableObject {
  @Published var selectedImage: UIImage?
  @Published var selectedPhotoItem: PhotosPickerItem?
  @Published var showImageSourcePicker: Bool = false
  @Published var showPhotoPicker: Bool = false
  @Published var showCameraPicker: Bool = false
  @Published var showCameraErrorAlert: Bool = false
  @Published var showPhotoPermissionAlert: Bool = false
  @Published var showCameraPermissionAlert: Bool = false

  func showImagePicker() {
    showImageSourcePicker = true
  }

  // 检查并打开相册
  func checkAndOpenPhotoLibrary() {
    let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

    switch status {
    case .authorized, .limited:
      // 已有权限，打开相册
      showPhotoPicker = true
    case .notDetermined:
      // 未确定，请求权限
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] newStatus in
        DispatchQueue.main.async {
          if newStatus == .authorized || newStatus == .limited {
            self?.showPhotoPicker = true
          } else {
            self?.showPhotoPermissionAlert = true
          }
        }
      }
    case .denied, .restricted:
      // 被拒绝或受限，显示提示
      showPhotoPermissionAlert = true
    @unknown default:
      showPhotoPermissionAlert = true
    }
  }

  // 检查摄像头是否可用并请求权限
  func checkAndOpenCamera() {
    // 先检查设备是否支持相机
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      showCameraErrorAlert = true
      return
    }

    // 检查是否有可用的摄像头设备
    let cameraMediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
    guard !cameraMediaTypes.isEmpty else {
      showCameraErrorAlert = true
      return
    }

    // 检查相机权限
    let status = AVCaptureDevice.authorizationStatus(for: .video)

    switch status {
    case .authorized:
      // 已有权限，打开相机
      showCameraPicker = true
    case .notDetermined:
      // 未确定，请求权限
      AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
        DispatchQueue.main.async {
          if granted {
            self?.showCameraPicker = true
          } else {
            self?.showCameraPermissionAlert = true
          }
        }
      }
    case .denied, .restricted:
      // 被拒绝或受限，显示提示
      showCameraPermissionAlert = true
    @unknown default:
      showCameraPermissionAlert = true
    }
  }

  func loadSelectedImage() {
    Task {
      if let item = selectedPhotoItem,
        let data = try? await item.loadTransferable(type: Data.self),
        let image = UIImage(data: data)
      {
        selectedImage = image
        selectedPhotoItem = nil
      }
    }
  }
}

/// 图片选择器按钮视图 - 可以独立使用的组件
struct ImagePickerButton: View {
  @StateObject private var pickerViewModel = ImagePickerViewModel()
  let onImageSelected: (UIImage) -> Void

  var body: some View {
    Button {
      pickerViewModel.showImagePicker()
    } label: {
      Color.clear
        .frame(width: 46, height: 46)
    }
    .confirmationDialog(
      "Select Photo Source", isPresented: $pickerViewModel.showImageSourcePicker,
      titleVisibility: .visible
    ) {
      Button("Gallery") {
        pickerViewModel.checkAndOpenPhotoLibrary()
      }
      Button("Camera") {
        pickerViewModel.checkAndOpenCamera()
      }
      Button("Cancel", role: .cancel) {}
    }
    .photosPicker(
      isPresented: $pickerViewModel.showPhotoPicker,
      selection: $pickerViewModel.selectedPhotoItem,
      matching: .images,
      photoLibrary: .shared()
    )
    .onChange(of: pickerViewModel.selectedPhotoItem) {
      pickerViewModel.loadSelectedImage()
    }
    .onChange(of: pickerViewModel.selectedImage) { _, newImage in
      if let image = newImage {
        onImageSelected(image)
        pickerViewModel.selectedImage = nil  // 重置状态
      }
    }
    .fullScreenCover(isPresented: $pickerViewModel.showCameraPicker) {
      CameraPickerView(selectedImage: $pickerViewModel.selectedImage)
    }
    .alert("Camera Unavailable", isPresented: $pickerViewModel.showCameraErrorAlert) {
      Button("OK", role: .cancel) {}
    } message: {
      Text("Camera is not available on this device or camera access is not permitted.")
    }
    .alert(
      "Photo Library Permission Required", isPresented: $pickerViewModel.showPhotoPermissionAlert
    ) {
      Button("Settings") {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsURL)
        }
      }
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Please grant photo library access in Settings to select photos.")
    }
    .alert("Camera Permission Required", isPresented: $pickerViewModel.showCameraPermissionAlert) {
      Button("Settings") {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsURL)
        }
      }
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Please grant camera access in Settings to take photos.")
    }
  }
}
