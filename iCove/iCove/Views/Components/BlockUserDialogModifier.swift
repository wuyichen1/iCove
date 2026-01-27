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

struct BlockUserDialogModifier: ViewModifier {
  @Binding var isPresented: Bool
  let uidK1uO6OuOGNky0: String?
  @EnvironmentObject var aumaI6T8ZpAC0vBQ8: AuthenticationManager
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  func body(content: Content) -> some View {
    content
      .overlay {
        if isPresented, let uidK1uO6OuOGNky0 = uidK1uO6OuOGNky0 {
          UnlockConfirmDialog(
            hasEnoughBalance: nil,
            onCancel: {
              isPresented = false
            },
            onConfirm: {
              Task {
                aumaI6T8ZpAC0vBQ8.addBlockedUserId(uidK1uO6OuOGNky0)
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
  /// - Parameters:
  ///   - isPresented: 控制弹窗显示的绑定
  ///   - uidK1uO6OuOGNky0: 要拉黑的用户ID
  func blockUserDialog(isPresented: Binding<Bool>, uidK1uO6OuOGNky0: String?) -> some View {
    modifier(BlockUserDialogModifier(isPresented: isPresented, uidK1uO6OuOGNky0: uidK1uO6OuOGNky0))
  }
}
