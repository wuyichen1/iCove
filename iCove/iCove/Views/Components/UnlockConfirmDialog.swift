//
//  UnlockConfirmDialog.swift
//  iCove
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

/// 解锁确认弹窗 - 根据余额显示不同内容
struct UnlockConfirmDialog: View {
  let hasEnoughBalance: Bool
  let onCancel: () -> Void
  let onConfirm: () -> Void  // 确认按钮回调（Sure 或 Recharge）
  let title: String?
  let btnText: String?

  init(
    hasEnoughBalance: Bool,
    onCancel: @escaping () -> Void,
    onConfirm: @escaping () -> Void,
    title: String? = nil,
    btnText: String? = nil
  ) {
    self.hasEnoughBalance = hasEnoughBalance
    self.onCancel = onCancel
    self.onConfirm = onConfirm
    self.title = title
    self.btnText = btnText
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 半透明背景
      Color.black.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {
          onCancel()
        }

      // 弹窗内容
      VStack(spacing: 0) {
        // 弹窗主体
        VStack(spacing: 24) {
          // 提示文字
          Text(
            title
              ?? (hasEnoughBalance
                ? "Are you sure you want to spend 200 coins to unlock the AI clothing recommendation feature?"
                : "Unfortunately, the current account balance is insufficient to cover this order, please recharge.")
          )
          .font(.system(size: 18, weight: .medium))
          .italic()
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 20)
          .padding(.top, 32)

          // 按钮区域
          HStack(spacing: 16) {
            // 取消按钮
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

            // 确认按钮（Sure 或 Recharge）
            Button(action: onConfirm) {
              Text(btnText ?? (hasEnoughBalance ? "Sure" : "Recharge"))
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
          .padding(.bottom, 16)
        }
        .background(
          ZStack {
            Image(hasEnoughBalance ? "f6KDmB5rYAx2Ke6S" : "CXGyBeCKoF4QQ3vX")
              .resizable()
              .scaledToFill()
            // .clipped()
            // .frame(maxWidth: .infinity, maxHeight: 300)
            // 渐变背景
            // LinearGradient(
            //   colors: [
            //     Color(red: 180 / 255, green: 100 / 255, blue: 200 / 255),
            //     Color(red: 130 / 255, green: 50 / 255, blue: 150 / 255),
            //   ],
            //   startPoint: .top,
            //   endPoint: .bottom
            // )
          }
        )
        // .cornerRadius(20)
      }
      .padding(.horizontal, 45)
    }
    .enableInjection()
  }
}
