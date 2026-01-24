//
//  VideoCallView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct VideoCallView: View {
  let conversationId: String
  let otherUserId: String
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: VideoCallViewModel

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(conversationId: String, otherUserId: String) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    _viewModel = StateObject(
      wrappedValue: VideoCallViewModel(
        conversationId: conversationId,
        otherUserId: otherUserId
      )
    )
  }

  var body: some View {
    ZStack {
      // 深紫色背景
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack {
        Spacer()

        // 对方用户信息
        if let otherUser = viewModel.otherUser {
          VStack(spacing: 16) {
            ProfileImageView(
              avatar: otherUser.avatar,
              username: otherUser.username,
              size: 120
            )

            Text(otherUser.username)
              .font(.custom("FredokaOne-Regular", size: 24))
              .foregroundColor(.white)

            Text("视频通话中...")
              .font(.system(size: 16))
              .foregroundColor(.white.opacity(0.7))
          }
        }

        Spacer()

        // 底部控制按钮
        HStack(spacing: 40) {
          // 挂断按钮
          Button(action: {
            router.pop()
          }) {
            Image(systemName: "phone.down.fill")
              .font(.system(size: 24))
              .foregroundColor(.white)
              .frame(width: 60, height: 60)
              .background(Color.red)
              .clipShape(Circle())
          }
        }
        .padding(.bottom, 50)
      }
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    #if DEBUG
      .enableInjection()
    #endif
  }
}

// MARK: - Video Call ViewModel
@MainActor
class VideoCallViewModel: ObservableObject {
  @Published var otherUser: User?

  private let conversationId: String
  private let otherUserId: String
  private let authService: AuthenticationServiceProtocol

  init(
    conversationId: String,
    otherUserId: String,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared
  ) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    self.authService = authService
    loadOtherUser()
  }

  func loadOtherUser() {
    otherUser = authService.getUserById(otherUserId)
  }
}

// #Preview {
//   VideoCallView(conversationId: "conv_001", otherUserId: "user_002")
//     .environmentObject(Router())
//     .environmentObject(AuthenticationManager())
// }
