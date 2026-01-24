//
//  SettingsView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 设置页面
struct SettingsView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss
  @State private var showingDeleteDialog = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 背景色
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 24) {
        // 顶部返回 + 标题
        header
          .padding(.top, 0)
          .padding(.horizontal, 20)

        // 设置列表
        ScrollView {
          VStack(spacing: 16) {
            settingButton(
              title: "Edit personal information",
              isPrimary: true
            ) {
              router.push(.editProfile)
            }

            settingButton(title: "Blacklist", isPrimary: true) {
              router.push(.blacklist)
            }

            settingButton(title: "Privacy Policy", isPrimary: true) {
              // 打开隐私政策页面，需要传入实际的 URL
              router.push(
                .agreement(url: "https://app.li65pe2f.link/privacy", title: "Privacy Policy"))
            }

            settingButton(title: "User Agreement", isPrimary: true) {
              // 打开用户协议页面，需要传入实际的 URL
              router.push(
                .agreement(url: "https://app.li65pe2f.link/users", title: "User Agreement"))
            }

            settingButton(title: "Delete Account", isPrimary: true) {
              // 打开删除账号弹窗
              showingDeleteDialog = true
            }

            settingButton(title: "Log Out", isPrimary: true) {
              Task {
                await authManager.logout()
                router.popToRoot()
              }
            }
          }
          .padding(.horizontal, 20)
          .padding(.top, 8)
        }
      }

      if showingDeleteDialog {
        UnlockConfirmDialog(
          hasEnoughBalance: nil,
          onCancel: {
            showingDeleteDialog = false
          },
          onConfirm: {
            Task {
              await deleteAccount()
            }
          },
          title:
            "Are you sure you want to delete this account? All data will be permanently cleared and cannot be restored.",
          btnText: "Sure",
        )
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Header
  private var header: some View {
    VStack(alignment: .leading, spacing: 24) {
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

      Text("Settings")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(Color("btnpink"))
    }
  }

  // MARK: - Setting Button
  private func settingButton(
    title: String,
    isPrimary: Bool = false,
    action: @escaping () -> Void
  ) -> some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.white)
            .overlay(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(
                  isPrimary ? Color("btnpink") : Color.clear,
                  lineWidth: 3
                )
            )
        )
    }
  }

  // MARK: - Delete Account
  private func deleteAccount() async {
    defer { showingDeleteDialog = false }
    do {
      try await authManager.deleteAccount()
      router.popToRoot()
    } catch {
      print("Delete account failed: \(error)")
    }
  }
}
