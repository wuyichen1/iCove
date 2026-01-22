//
//  ReportBlockBottomSheet.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 举报拉黑用户底部弹窗
struct ReportBlockBottomSheet: View {
  let userId: String
  @Binding var isPresented: Bool
  var onBlock: (() -> Void)? = nil
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router

  @State private var user: User?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 238 / 255, green: 173 / 255, blue: 243 / 255),
          // Color(red: 217 / 255, green: 115 / 255, blue: 228 / 255),
          Color.white,
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .cornerRadius(30, corners: [.topLeft, .topRight])
      .padding(.top, 55)
      .ignoresSafeArea()

      VStack(spacing: 0) {
        // 弹窗内容
        VStack(spacing: 20) {
          // 用户头像
          if let user = user {
            if let avatar = user.avatar {
              DynamicImage(imageName: avatar)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                  Circle()
                    .stroke(
                      Color(red: 238 / 255, green: 173 / 255, blue: 243 / 255), lineWidth: 3)
                )
            } else {
              Circle()
                .fill(
                  LinearGradient(
                    gradient: Gradient(colors: [
                      Color.pink.opacity(0.3),
                      Color.purple.opacity(0.3),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                  )
                )
                .frame(width: 60, height: 60)
                .overlay {
                  Text(String(user.username.prefix(1)))
                    .font(.headline)
                    .foregroundColor(.pink)
                }
                .overlay(
                  Circle()
                    .stroke(Color.white, lineWidth: 3)
                )
            }

            // 用户名
            Text(user.username)
              .font(.custom("FredokaOne-Regular", size: 20))
              .foregroundColor(.black)

            // 按钮区域
            HStack(spacing: 18) {
              // 举报按钮
              Button(action: {
                isPresented = false
                router.push(.report(userId: userId))
              }) {
                HStack(spacing: 8) {
                  Image("vlIErnTTBdCclTvG")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                  Text("Report")
                    .font(.custom("FredokaOne-Regular", size: 22))
                    .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                  Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255).opacity(0.2),
                )
                .cornerRadius(16)
              }

              // 拉黑按钮
              Button(action: {
                isPresented = false
                onBlock?()
              }) {
                HStack(spacing: 8) {
                  Image("fQgK89G89HDoUILx")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                  Text("Block")
                    .font(.custom("FredokaOne-Regular", size: 22))
                    .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                  Color(red: 147 / 255, green: 19 / 255, blue: 223 / 255).opacity(0.2),
                )
                .cornerRadius(16)
              }
            }
            .padding(.horizontal, 24)
          } else {
            // 加载中
            ProgressView()
              .padding()
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .onAppear {
      loadUser()
    }
    .enableInjection()
  }

  private func loadUser() {
    user = AuthenticationService.shared.getUserById(userId)
  }
}
