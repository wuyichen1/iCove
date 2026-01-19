//
//  ProfileView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss
  @State private var showingEditBio = false
  @State private var editedBio = ""
  @State private var showingMoreOptions = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    NavigationStack {
      contentView
        .navigationTitle(viewModel.isCurrentUser ? "我的" : "")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.isCurrentUser {
              // 我的页面：设置按钮
              Button(action: {
                // 打开设置页面
                print("打开设置")
              }) {
                Image(systemName: "gearshape.fill")
                  .foregroundColor(.white)
                  .frame(width: 32, height: 32)
                  .background(Color.purple.opacity(0.8))
                  .clipShape(Circle())
              }
            } else {
              // 他人页面：更多按钮
              Button(action: {
                showingMoreOptions = true
              }) {
                Image(systemName: "ellipsis")
                  .foregroundColor(.white)
                  .frame(width: 32, height: 32)
                  .background(Color.purple.opacity(0.8))
                  .clipShape(Circle())
              }
            }
          }

          if !viewModel.isCurrentUser {
            // 他人页面：返回按钮
            ToolbarItem(placement: .navigationBarLeading) {
              Button(action: {
                dismiss()
              }) {
                Image(systemName: "arrow.left")
                  .foregroundColor(.white)
                  .frame(width: 32, height: 32)
                  .background(Color.purple.opacity(0.8))
                  .clipShape(Circle())
              }
            }
          }
        }
        .refreshable {
          await viewModel.refresh()
        }
    }
    .sheet(isPresented: $showingMoreOptions) {
      MoreOptionsSheet()
    }
    .enableInjection()
  }

  @ViewBuilder
  private var contentView: some View {
    if viewModel.isLoading && viewModel.userProfile == nil {
      ProgressView("加载中...")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } else if let error = viewModel.errorMessage {
      ErrorView(message: error) {
        Task {
          await viewModel.loadUserProfile()
        }
      }
    } else if let profile = viewModel.userProfile {
      ScrollView {
        VStack(spacing: 24) {
          // 用户资料卡片
          profileHeaderCard(profile: profile)

          // 统计数据
          statsSection(profile: profile)

          // 操作按钮区域
          actionButtonsSection(profile: profile)

          // 设置列表（仅我的页面显示）
          if viewModel.isCurrentUser {
            settingsSection
          }
        }
        .padding()
      }
    }
  }

  // MARK: - Profile Header Card
  private func profileHeaderCard(profile: UserProfile) -> some View {
    VStack(spacing: 16) {
      // 头像
      Circle()
        .fill(
          LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 80, height: 80)
        .overlay {
          Text(String(profile.username.prefix(1)))
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
        }

      // 用户名
      Text(profile.username)
        .font(.title2)
        .fontWeight(.bold)

      // 简介
      HStack {
        Text(profile.bio)
          .font(.subheadline)
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)

        // 只有当前用户才能编辑简介
        if viewModel.isCurrentUser {
          Button(action: {
            editedBio = profile.bio
            showingEditBio = true
          }) {
            Image(systemName: "pencil")
              .font(.caption)
              .foregroundColor(.blue)
          }
        }
      }

      // 加入时间
      HStack(spacing: 4) {
        Image(systemName: "calendar")
          .font(.caption2)
        Text("加入于 \(profile.joinDate, style: .date)")
          .font(.caption)
      }
      .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(16)
    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    .sheet(isPresented: $showingEditBio) {
      EditBioSheet(bio: $editedBio) {
        viewModel.updateBio(editedBio)
      }
    }
  }

  // MARK: - Stats Section
  private func statsSection(profile: UserProfile) -> some View {
    HStack(spacing: 0) {
      StatItem(count: profile.postCount, label: "动态")
      Divider()
      StatItem(count: profile.followerCount, label: "粉丝")
      Divider()
      StatItem(count: profile.followingCount, label: "关注")
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(12)
    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
  }

  // MARK: - Action Buttons Section
  @ViewBuilder
  private func actionButtonsSection(profile: UserProfile) -> some View {
    if viewModel.isCurrentUser {
      // 我的页面：余额按钮
      Button(action: {
        // 打开余额页面
        print("打开余额页面")
      }) {
        HStack {
          Text("Balance: \(authManager.currentUser?.balance ?? 0)")
            .font(.headline)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("btnpink"))
        .cornerRadius(12)
      }
    } else {
      // 他人页面：关注和聊天按钮
      HStack(spacing: 12) {
        Button(action: {
          viewModel.toggleFollow()
        }) {
          Text(profile.isFollowing ? "Following" : "Follow")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(profile.isFollowing ? Color.purple : Color("btnpink"))
            .cornerRadius(12)
        }

        Button(action: {
          viewModel.sendMessage(router: router)
        }) {
          Text("Message")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .cornerRadius(12)
        }
      }
    }
  }

  // MARK: - Settings Section
  private var settingsSection: some View {
    VStack(spacing: 12) {
      ForEach(viewModel.settings) { setting in
        SettingRow(setting: setting) {
          viewModel.handleSettingAction(setting)
        }
      }
    }
  }
}

// MARK: - Stat Item
struct StatItem: View {
  let count: Int
  let label: String

  var body: some View {
    VStack(spacing: 4) {
      Text("\(count)")
        .font(.title3)
        .fontWeight(.bold)
      Text(label)
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity)
  }
}

// MARK: - Setting Row
struct SettingRow: View {
  let setting: SettingItem
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: 12) {
        Image(systemName: setting.icon)
          .font(.body)
          .foregroundColor(setting.isDestructive ? .red : .blue)
          .frame(width: 24)

        Text(setting.title)
          .font(.body)
          .foregroundColor(setting.isDestructive ? .red : .primary)

        Spacer()

        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding()
      .background(Color(.systemBackground))
      .cornerRadius(12)
      .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    .buttonStyle(.plain)
  }
}

// MARK: - Edit Bio Sheet
struct EditBioSheet: View {
  @Binding var bio: String
  let onSave: () -> Void
  @Environment(\.dismiss) var dismiss

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("个人简介", text: $bio, axis: .vertical)
            .lineLimit(3...6)
        } header: {
          Text("编辑简介")
        }
      }
      .navigationTitle("编辑简介")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("取消") {
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button("保存") {
            onSave()
            dismiss()
          }
        }
      }
    }
  }
}

// MARK: - More Options Sheet
struct MoreOptionsSheet: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    NavigationStack {
      List {
        Button(action: {
          // 举报用户
          print("举报用户")
          dismiss()
        }) {
          HStack {
            Image(systemName: "exclamationmark.triangle")
            Text("举报用户")
          }
          .foregroundColor(.red)
        }

        Button(action: {
          // 屏蔽用户
          print("屏蔽用户")
          dismiss()
        }) {
          HStack {
            Image(systemName: "eye.slash")
            Text("屏蔽用户")
          }
          .foregroundColor(.red)
        }
      }
      .navigationTitle("更多选项")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("取消") {
            dismiss()
          }
        }
      }
    }
  }
}

// #Preview {
//     ProfileView(viewModel: ProfileViewModel(authManager: AuthenticationManager()))
// }
