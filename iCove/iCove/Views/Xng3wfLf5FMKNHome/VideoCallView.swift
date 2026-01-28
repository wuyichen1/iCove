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
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
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
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack {
        Spacer()

        if let otherUser = viewModel.otherUser {
          VStack(spacing: 16) {
            ProfileImageView(
              avatar: otherUser.aG3hI5jK7lM9nO,
              username: otherUser.uX4yZ6aB8cD0eF,
              size: 120
            )

            Text(otherUser.uX4yZ6aB8cD0eF)
              .font(.custom("FredokaOne-Regular", size: 24))
              .foregroundColor(.white)

            Text("Video call in progress...")
              .font(.system(size: 16))
              .foregroundColor(.white.opacity(0.7))
          }
        }

        Spacer()

        HStack(spacing: 40) {
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
  private let BGe40GruMhiiC: Authsdmd0VXzbAnDYServProc

  init(
    conversationId: String,
    otherUserId: String,
    BGe40GruMhiiC: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared
  ) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    self.BGe40GruMhiiC = BGe40GruMhiiC
    loadOtherUser()
  }

  func loadOtherUser() {
    otherUser = BGe40GruMhiiC.getbyidQwpUuIWnzzs99(otherUserId)
  }
}
