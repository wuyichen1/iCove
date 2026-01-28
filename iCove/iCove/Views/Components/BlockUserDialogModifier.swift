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
  @EnvironmentObject var aumaI6T8ZpAC0vBQ8: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  func body(content: Content) -> some View {
    content
      .overlay {
        if isPresented, let uidK1uO6OuOGNky0 = uidK1uO6OuOGNky0 {
          UnlockConfirmDialog(
            hasXybyb6HcnQYhh: nil,
            onCancel: {
              isPresented = false
            },
            onConfirm: {
              Task {
                aumaI6T8ZpAC0vBQ8.adSN1KPLAOgyALw(uidK1uO6OuOGNky0)
                isPresented = false
                router.popToRoot()
              }
            },
            titleJysN45SSLv3zx:
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
  func blockDiaLcTUIAjgtcOHd(isPresented: Binding<Bool>, uidK1uO6OuOGNky0: String?) -> some View {
    modifier(BlockUserDialogModifier(isPresented: isPresented, uidK1uO6OuOGNky0: uidK1uO6OuOGNky0))
  }
}
