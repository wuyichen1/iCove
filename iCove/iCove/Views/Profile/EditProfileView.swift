//
//  EditProfileView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import PhotosUI
import SwiftUI
import UIKit

#if DEBUG
  import HotSwiftUI
#endif

/// 编辑个人信息页面
struct EditProfileView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss

  @State private var username: String = ""

  // 头像选择相关状态
  @State private var selectedImage: UIImage?
  @State private var showImageSourcePicker: Bool = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .top) {
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 32) {
        // 顶部区域：返回 + 标题
        topBar
          .padding(.top, 46)
          .padding(.horizontal, 20)

        // 头像区域
        avatarSection
          .padding(.vertical, 24)

        // 表单区域
        formSection
          .padding(.horizontal, 24)

        // 保存按钮
        saveButton
          .padding(.horizontal, 40)
          .padding(.vertical, 60)
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      if username.isEmpty {
        username = authManager.currentUser?.username ?? ""
      }
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Top Bar
  private var topBar: some View {
    HStack {
      Button {
        router.pop()
      } label: {
        Circle()
          .fill(Color.white)
          .frame(width: 40, height: 40)
          .overlay(
            Image(systemName: "arrow.uturn.left")
              .foregroundColor(Color("buttonPurple"))
          )
      }

      Spacer()

      Text("Information")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)

    }
  }

  // MARK: - Avatar Section
  private var avatarSection: some View {
    Button {
      showImageSourcePicker = true
    } label: {
      ZStack(alignment: .topTrailing) {
        // 头像 - 优先显示临时选择的图片
        if let selectedImage = selectedImage {
          ProfileImageView(
            avatar: selectedImage,
            username: authManager.currentUser?.username ?? "",
            size: 115,
            subSize: 32
          )
        } else if let avatarName = authManager.currentUser?.avatar {
          ProfileImageView(
            avatar: avatarName,
            username: authManager.currentUser?.username ?? "",
            size: 115,
            subSize: 32
          )
        } else {
          ProfileImageView(
            avatar: "icove_logo",
            username: authManager.currentUser?.username ?? "",
            size: 115,
            subSize: 32
          )
        }

        // 相机图标
        Image("2uIPOm40mxvOSEtB")
          .resizable()
          .scaledToFill()
          .frame(width: 24, height: 24)
      }
    }
    .imagePicker(selectedImage: $selectedImage, showPicker: $showImageSourcePicker)
  }

  // MARK: - Form Section
  private var formSection: some View {
    VStack(alignment: .leading, spacing: 16) {

      ZStack {
        // 渐变背景
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .fill(
            LinearGradient(
              colors: [
                // rgb(216, 72, 227)
                Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                Color.white,
              ],
              startPoint: .top,
              endPoint: .bottom
            )
          )

        VStack(alignment: .leading) {
          Text("Username:")
            .font(.custom("FredokaOne-Regular", size: 20))
            .foregroundColor(.white)

          TextField("Enter your username", text: $username)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
            )
            .submitLabel(.done)
        }
        .padding(.horizontal, 16)

      }
      .frame(maxWidth: .infinity, maxHeight: 150)
    }
  }

  // MARK: - Save Button
  private var saveButton: some View {
    Button {
      saveChanges()
    } label: {
      Text("Save")
        .font(.custom("FredokaOne-Regular", size: 22))
        .foregroundColor(.white)
        .frame(maxWidth: 240)
        .padding(.vertical, 13)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color("buttonPurple"))
            .overlay(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white, lineWidth: 2)
            )
        )
    }
  }

  // MARK: - Actions
  private func saveChanges() {
    let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }

    // 更新用户名（会持久化到 UserDefaults）
    authManager.updateUsername(trimmed)

    // 如果选择了新头像，保存头像（会持久化头像文件名到 UserDefaults）
    // updateAvatar 方法会：
    // 1. 将图片保存到 UserImages 目录
    // 2. 更新 currentUser.avatar 为文件名（@Published，会触发 UI 更新）
    // 3. 调用 saveAuthState 持久化整个 User 对象到 UserDefaults
    if let image = selectedImage {
      authManager.updateAvatar(image)
      // 清除临时选择的图片，让页面显示更新后的头像（从 currentUser.avatar 读取）
      selectedImage = nil
    }

    // 由于 currentUser 是 @Published，更新会自动传播到所有使用 @EnvironmentObject 的视图
    // 所有依赖 authManager.currentUser 的页面都会自动更新
    router.pop()
  }
}
