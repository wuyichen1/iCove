//
//  BlockUserDialogModifier.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 拉黑用户弹窗修饰符 - 可复用的拉黑确认弹窗
struct BlockUserDialogModifier: ViewModifier {
  @Binding var isPresented: Bool
  let userId: String?
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  func body(content: Content) -> some View {
    content
      .overlay {
        if isPresented, let userId = userId {
          UnlockConfirmDialog(
            hasEnoughBalance: nil,
            onCancel: {
              isPresented = false
            },
            onConfirm: {
              Task {
                authManager.addBlockedUserId(userId)
                isPresented = false
                router.popToRoot()
              }
            },
            title:
              "Are you sure you want to block this user and no longer receive any content related to this user?",
            btnText: "Sure",
          )
        }
      }
      #if DEBUG
        .enableInjection()
      #endif
  }
}

extension View {
  /// 添加拉黑用户确认弹窗
  /// - Parameters:
  ///   - isPresented: 控制弹窗显示的绑定
  ///   - userId: 要拉黑的用户ID
  func blockUserDialog(isPresented: Binding<Bool>, userId: String?) -> some View {
    modifier(BlockUserDialogModifier(isPresented: isPresented, userId: userId))
  }
}
