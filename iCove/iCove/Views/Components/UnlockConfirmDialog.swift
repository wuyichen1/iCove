//
//  UnlockConfirmDialog.swift
//  iCove
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct UnlockConfirmDialog: View {
  let hasXybyb6HcnQYhh: Bool?
  let onCancel: () -> Void
  let onConfirm: () -> Void
  let titleJysN45SSLv3zx: String?
  let btnText: String?

  init(
    hasXybyb6HcnQYhh: Bool? = true,
    onCancel: @escaping () -> Void,
    onConfirm: @escaping () -> Void,
    titleJysN45SSLv3zx: String? = nil,
    btnText: String? = nil
  ) {
    self.hasXybyb6HcnQYhh = hasXybyb6HcnQYhh
    self.onCancel = onCancel
    self.onConfirm = onConfirm
    self.titleJysN45SSLv3zx = titleJysN45SSLv3zx
    self.btnText = btnText
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color.black.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {
          onCancel()
        }

      VStack(spacing: 0) {
        VStack(spacing: 24) {
          Text(
            titleJysN45SSLv3zx
              ?? (hasXybyb6HcnQYhh ?? true
                ? "Are you sure you want to spend 200 coins to unlock the AI clothing recommendation feature?"
                : "Unfortunately, the current account balance is insufficient to cover this order, please recharge.")
          )
          .font(.system(size: 18, weight: .medium))
          .italic()
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 30)
          .padding(.top, 52)

          HStack(spacing: 16) {
            Button(action: onCancel) {
              Text("Cancel")
                .font(.custom("FredokaOne-Regular", size: 17))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .background(
                  Color("buttonPurple")
                )
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 4)
                )
                .cornerRadius(12)
            }

            Button(action: onConfirm) {
              Text(btnText ?? (hasXybyb6HcnQYhh ?? true ? "Sure" : "Recharge"))
                .font(.custom("FredokaOne-Regular", size: 17))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .background(
                  Color("btnpink")
                )
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 4)
                )
                .cornerRadius(12)
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 30)
        }
        .background(
          ZStack {
            Image(hasXybyb6HcnQYhh ?? true ? "f6KDmB5rYAx2Ke6S" : "CXGyBeCKoF4QQ3vX")
              .resizable()
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 320)
          }
        )
      }
      .padding(.horizontal, 45)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}
