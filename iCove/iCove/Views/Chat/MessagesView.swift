//
//  MessagesView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct MessagesView: View {
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @StateObject private var msgVmF2Lqw623eNcEQ = MsgSE8UQxD8j7C19Vmod()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {
        headCtGXnfNzPOtB9

        if msgVmF2Lqw623eNcEQ.loingxwNUWZIYJTAOd && msgVmF2Lqw623eNcEQ.cs0ZOxgQsTkhaos.isEmpty {
          load3N0pekaWxcINz
        } else if msgVmF2Lqw623eNcEQ.filJwM7EaSVjAhts.isEmpty {
          empty3rBzY4NiLW8S0
        } else {
          contviewJmAAAY0uuWp2o
        }
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
    .onAppear {
      msgVmF2Lqw623eNcEQ.cuidjO17fn13slPB0 = authManager.currvj9QRUUPOWY4Ouser?.id
      Task {
        await msgVmF2Lqw623eNcEQ.MZ6eJcEBDp82N()
      }
      msgVmF2Lqw623eNcEQ.updAuma7Cif2ltv9c65t(authManager)
    }
    .onChange(of: authManager.currvj9QRUUPOWY4Ouser?.id) { _, newUserId in
      msgVmF2Lqw623eNcEQ.cuidjO17fn13slPB0 = newUserId
    }
    .onChange(of: router.path.count) { _, _ in
      // 当从聊天详情页返回时，刷新会话列表
      Task {
        await msgVmF2Lqw623eNcEQ.MZ6eJcEBDp82N()
      }
    }
  }

  // MARK: - Header Section
  private var headCtGXnfNzPOtB9: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Chat")
          .font(.custom("FredokaOne-Regular", size: 32))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.top, 50)
      .padding(.bottom, 24)

      if let cur2bmc2wWma30FM = authManager.currvj9QRUUPOWY4Ouser {
        VStack(spacing: 12) {
          ProfileImageView(
            avatar: cur2bmc2wWma30FM.avatar,
            username: cur2bmc2wWma30FM.username,
            size: 120,
            subSize: 32,
          )

          Text(cur2bmc2wWma30FM.username)
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.white)
        }
        .padding(.bottom, 24)
      }

      HStack {
        Text("Friends")
          .font(.custom("FredokaOne-Regular", size: 24))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
  }

  // MARK: - Content View
  private var contviewJmAAAY0uuWp2o: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(msgVmF2Lqw623eNcEQ.filJwM7EaSVjAhts) { conwmUe1XZOr9gjf in
          ConsrowKqezRbZ2wK891(con8BsmRqnI3CNXy: conwmUe1XZOr9gjf)
            .onTapGesture {
              msgVmF2Lqw623eNcEQ.markOihyOHcXCrdV7(conwmUe1XZOr9gjf)
              if let curidrkRFFpUdKgG15 = authManager.currvj9QRUUPOWY4Ouser?.id,
                let ohidzECAIqalKWo1v = conwmUe1XZOr9gjf.participantIds.first(where: {
                  $0 != curidrkRFFpUdKgG15
                })
              {
                router.push(
                  .chatDetail(conversationId: conwmUe1XZOr9gjf.id, otherUserId: ohidzECAIqalKWo1v))
              }
            }
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 130)
    }
  }

  // MARK: - Loading View
  private var load3N0pekaWxcINz: some View {
    VStack(spacing: 20) {
      Spacer()
      ProgressView()
        .scaleEffect(1.5)
        .tint(.white)

      Text("Loading...")
        .font(.system(size: 16))
        .foregroundColor(.white.opacity(0.8))
      Spacer()
    }
    .padding(.bottom, 100)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Empty State View
  private var empty3rBzY4NiLW8S0: some View {
    EmptyPlaceholderView()
      .padding(.bottom, 120)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

// MARK: - Conversation Row
struct ConsrowKqezRbZ2wK891: View {
  let con8BsmRqnI3CNXy: Conversation
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var msgVmF2Lqw623eNcEQ: ConversationRowViewModel

  init(con8BsmRqnI3CNXy: Conversation) {
    self.con8BsmRqnI3CNXy = con8BsmRqnI3CNXy
    _msgVmF2Lqw623eNcEQ = StateObject(
      wrappedValue: ConversationRowViewModel(consxrlKxXeyn3ZuZ: con8BsmRqnI3CNXy))
  }

  private var tf6EoNKpJDHIDsY: DateFormatter {
    let cTnvabJM8yhRC = DateFormatter()
    cTnvabJM8yhRC.dateFormat = "h:mma"
    cTnvabJM8yhRC.locale = Locale(identifier: "en_US_POSIX")
    cTnvabJM8yhRC.amSymbol = "AM"
    cTnvabJM8yhRC.pmSymbol = "PM"
    return cTnvabJM8yhRC
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      ZStack {
        Image("todrcOCVKxRfLanQ")
          .resizable()
          .frame(width: .infinity, height: 80)

        VStack(alignment: .leading, spacing: 12) {
          HStack {
            Text(msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.username ?? "Unknown")
              .font(.custom("FredokaOne-Regular", size: 16))
              .foregroundColor(.white)

            Spacer()

            Text(tf6EoNKpJDHIDsY.string(from: con8BsmRqnI3CNXy.timestamp))
              .font(.system(size: 12))
              .foregroundColor(.white.opacity(0.6))
          }

          Text(con8BsmRqnI3CNXy.lastMessage.isEmpty ? "" : con8BsmRqnI3CNXy.lastMessage)
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.7))
            .lineLimit(1)
        }
        .padding(.leading, 106)
        .padding(.trailing, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.top, 12)

      ProfileImageView(
        avatar: msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.avatar,
        username: msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.username ?? "Unknown",
        size: 62,
        subSize: 16,
      )
      .padding(.leading, 14)
    }
    .frame(maxWidth: .infinity)
    .onAppear {
      msgVmF2Lqw623eNcEQ.loadOthu4P6GoHUkqgY8y(
        curidfeXd1hpSLgFwU: authManager.currvj9QRUUPOWY4Ouser?.id)
    }
    .onChange(of: authManager.currvj9QRUUPOWY4Ouser?.id) { _, newUserId in
      msgVmF2Lqw623eNcEQ.loadOthu4P6GoHUkqgY8y(curidfeXd1hpSLgFwU: newUserId)
    }
  }
}

// MARK: - Conversation Row ViewModel
@MainActor
class ConversationRowViewModel: ObservableObject {
  @Published var otho3VTO7Iv2zruSuser: User?

  private let consuP2F0P4sZeUTr: Conversation
  private let auserssXbqBgILAt9v: Authsdmd0VXzbAnDYServProc

  init(
    consxrlKxXeyn3ZuZ: Conversation,
    auserssXbqBgILAt9v: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared
  ) {
    self.consuP2F0P4sZeUTr = consxrlKxXeyn3ZuZ
    self.auserssXbqBgILAt9v = auserssXbqBgILAt9v
  }

  func loadOthu4P6GoHUkqgY8y(curidfeXd1hpSLgFwU: String?) {
    guard let curidfeXd1hpSLgFwU = curidfeXd1hpSLgFwU else {
      otho3VTO7Iv2zruSuser = nil
      return
    }

    let ohidfT4K8ECeO6Xhc = consuP2F0P4sZeUTr.participantIds.first { $0 != curidfeXd1hpSLgFwU }

    if let ohidfT4K8ECeO6Xhc = ohidfT4K8ECeO6Xhc {
      otho3VTO7Iv2zruSuser = auserssXbqBgILAt9v.getbyidQwpUuIWnzzs99(ohidfT4K8ECeO6Xhc)
    } else {
      otho3VTO7Iv2zruSuser = nil
    }
  }
}

// #Preview {
//     MessagesView()
//         .environmentObject(AuthManagA645b8Y0Aod3aVmod())
// }
