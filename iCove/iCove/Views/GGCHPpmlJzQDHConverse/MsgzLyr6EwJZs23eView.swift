//
//  MsgzLyr6EwJZs23eView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct MsgzLyr6EwJZs23eView: View {
  @EnvironmentObject var tq7s5nIv3nwgL: AuthManagA645b8Y0Aod3aVmod
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
    .navigationBarHiddenWithSwipeBack()
    #if DEBUG
      .enableInjection()
    #endif
    .onAppear {
      msgVmF2Lqw623eNcEQ.cuidjO17fn13slPB0 = tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser?.id
      Task {
        await msgVmF2Lqw623eNcEQ.MZ6eJcEBDp82N()
      }
      msgVmF2Lqw623eNcEQ.updAuma7Cif2ltv9c65t(tq7s5nIv3nwgL)
    }
    .onChange(of: tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser?.id) { _, newUserId in
      msgVmF2Lqw623eNcEQ.cuidjO17fn13slPB0 = newUserId
    }
    .onChange(of: router.path.count) { _, _ in
      Task {
        await msgVmF2Lqw623eNcEQ.MZ6eJcEBDp82N()
      }
    }
  }

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

      if let cur2bmc2wWma30FM = tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser {
        VStack(spacing: 12) {
          ProfileImageView(
            avatar: cur2bmc2wWma30FM.aG3hI5jK7lM9nO,
            username: cur2bmc2wWma30FM.uX4yZ6aB8cD0eF,
            size: 120,
            subSize: 32,
          )

          Text(cur2bmc2wWma30FM.uX4yZ6aB8cD0eF)
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

  private var contviewJmAAAY0uuWp2o: some View {
    ScrollView {
      LazyVStack(spacing: 16) {
        ForEach(msgVmF2Lqw623eNcEQ.filJwM7EaSVjAhts) { conwmUe1XZOr9gjf in
          ConsrowKqezRbZ2wK891(con8BsmRqnI3CNXy: conwmUe1XZOr9gjf)
            .onTapGesture {
              msgVmF2Lqw623eNcEQ.markOihyOHcXCrdV7(conwmUe1XZOr9gjf)
              if let curidrkRFFpUdKgG15 = tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser?.id,
                let ohidzECAIqalKWo1v = conwmUe1XZOr9gjf.pA5rT1iC3iP5aN7t.first(where: {
                  $0 != curidrkRFFpUdKgG15
                })
              {
                router.push(
                  .chadetBhKPSi5YgfcOZ(
                    cid7EWVIP6LCiVby: conwmUe1XZOr9gjf.id, uidKePZA2dVjXZzF: ohidzECAIqalKWo1v))
              }
            }
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 130)
    }
  }

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

  private var empty3rBzY4NiLW8S0: some View {
    EmptyJYGRYC2t97Qi3()
      .padding(.bottom, 120)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct ConsrowKqezRbZ2wK891: View {
  let con8BsmRqnI3CNXy: Conversation
  @EnvironmentObject var tq7s5nIv3nwgL: AuthManagA645b8Y0Aod3aVmod
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
            Text(msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.uX4yZ6aB8cD0eF ?? "Unknown")
              .font(.custom("FredokaOne-Regular", size: 16))
              .foregroundColor(.white)

            Spacer()

            Text(tf6EoNKpJDHIDsY.string(from: con8BsmRqnI3CNXy.tK3lM5nO7pQ9rS))
              .font(.system(size: 12))
              .foregroundColor(.white.opacity(0.6))
          }

          Text(con8BsmRqnI3CNXy.lA9sT1mE3sS5aG7e.isEmpty ? "" : con8BsmRqnI3CNXy.lA9sT1mE3sS5aG7e)
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
        avatar: msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.aG3hI5jK7lM9nO,
        username: msgVmF2Lqw623eNcEQ.otho3VTO7Iv2zruSuser?.uX4yZ6aB8cD0eF ?? "Unknown",
        size: 62,
        subSize: 16,
      )
      .padding(.leading, 14)
    }
    .frame(maxWidth: .infinity)
    .onAppear {
      msgVmF2Lqw623eNcEQ.loadOthu4P6GoHUkqgY8y(
        curidfeXd1hpSLgFwU: tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser?.id)
    }
    .onChange(of: tq7s5nIv3nwgL.currvj9QRUUPOWY4Ouser?.id) { _, newUserId in
      msgVmF2Lqw623eNcEQ.loadOthu4P6GoHUkqgY8y(curidfeXd1hpSLgFwU: newUserId)
    }
  }
}

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

    let ohidfT4K8ECeO6Xhc = consuP2F0P4sZeUTr.pA5rT1iC3iP5aN7t.first { $0 != curidfeXd1hpSLgFwU }

    if let ohidfT4K8ECeO6Xhc = ohidfT4K8ECeO6Xhc {
      otho3VTO7Iv2zruSuser = auserssXbqBgILAt9v.getbyidQwpUuIWnzzs99(ohidfT4K8ECeO6Xhc)
    } else {
      otho3VTO7Iv2zruSuser = nil
    }
  }
}
