//
//  BlacklistView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 拉黑名单页面
struct BlacklistView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @StateObject private var viewModel = BlacklistViewModel()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 背景色
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部返回 + 标题
        header
          .padding(.horizontal, 20)
          .padding(.bottom, 10)

        // 拉黑用户列表
        if viewModel.blockedUsers.isEmpty {
          // 空状态
          VStack(spacing: 16) {
            Image(systemName: "person.slash")
              .font(.system(size: 48))
              .foregroundColor(.white.opacity(0.5))
            Text("还没有拉黑的用户")
              .font(.subheadline)
              .foregroundColor(.white.opacity(0.7))
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          ScrollView {
            VStack(spacing: 16) {
              ForEach(viewModel.blockedUsers, id: \.id) { user in
                blacklistItem(user: user)
              }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .padding(.top, 16)
          }
        }
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      viewModel.loadBlockedUsers(
        blockedUserIds: authManager.currentUser?.blockedUserIds ?? [],
        authService: AuthenticationService.shared
      )
    }
    .enableInjection()
  }

  // MARK: - Header
  private var header: some View {
    HStack {
      // 返回按钮
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

      // 标题
      Text("Blacklist")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)
    }
  }

  // MARK: - Blacklist Item
  private func blacklistItem(user: User) -> some View {
    ZStack(alignment: .topLeading) {
      // 右侧：深紫色聊天气泡
      ZStack {
        Image("todrcOCVKxRfLanQ")
          .resizable()
          .scaledToFill()
          .frame(width: .infinity, height: 80)

        VStack(alignment: .leading, spacing: 12) {
          // 用户名和时间戳
          HStack {
            Text(user.username)
              .font(.custom("FredokaOne-Regular", size: 16))
              .foregroundColor(.white)

            Spacer()

            // 移除按钮
            Button {
              authManager.removeBlockedUserId(user.id)
              viewModel.removeUser(userId: user.id)
            } label: {
              Text("Remove")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                  RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("buttonPurple"))
                    .overlay(
                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                    )
                )
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(.leading, 106)
        .padding(.trailing, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.top, 12)

      // 头像
      ProfileImageView(
        avatar: user.avatar,
        username: user.username,
        size: 62,
        subSize: 16,
      )
      .padding(.leading, 14)

    }
  }
}

// MARK: - Blacklist ViewModel
@MainActor
class BlacklistViewModel: ObservableObject {
  @Published var blockedUsers: [User] = []

  func loadBlockedUsers(blockedUserIds: [String], authService: AuthenticationServiceProtocol) {
    blockedUsers = blockedUserIds.compactMap { userId in
      authService.getUserById(userId)
    }
  }

  func removeUser(userId: String) {
    blockedUsers.removeAll { $0.id == userId }
  }
}
