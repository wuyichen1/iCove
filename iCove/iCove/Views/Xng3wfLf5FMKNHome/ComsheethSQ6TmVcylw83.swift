//
//  ComsheethSQ6TmVcylw83.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct ComsheethSQ6TmVcylw83: View {
  let vdoidD9HGYfeBdbb8g: String
  let blouidl77j5c0KC5XIJ: String
  var onrepec8s8iLFaxS8w: ((String) -> Void)? = nil
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var commVmq0MjQlJrqM7lc: Comshet6Zv0ZcOxmY14fVmod
  @State private var comtxtFNpc30NkkZAmp: String = ""
  @FocusState private var isfocusTN3GRBtL8yBZe: Bool

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(
    vdoidD9HGYfeBdbb8g: String, blouidl77j5c0KC5XIJ: String,
    onrepec8s8iLFaxS8w: ((String) -> Void)? = nil
  ) {
    self.vdoidD9HGYfeBdbb8g = vdoidD9HGYfeBdbb8g
    self.blouidl77j5c0KC5XIJ = blouidl77j5c0KC5XIJ
    self.onrepec8s8iLFaxS8w = onrepec8s8iLFaxS8w
    _commVmq0MjQlJrqM7lc = StateObject(
      wrappedValue: Comshet6Zv0ZcOxmY14fVmod(vdoidD9HGYfeBdbb8g: vdoidD9HGYfeBdbb8g))

  }

  var body: some View {
    ZStack {
      Image("f2YTqp3rK3ZgautI")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        HStack {
          Text("Comments")
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.black)

          Spacer()

          Button(action: {
            dismiss()
          }) {
            Image(systemName: "xmark")
              .font(.system(size: 16, weight: .semibold))
              .foregroundColor(.black)
              .frame(width: 26, height: 26)
              .clipShape(Circle())
              .overlay(
                Circle()
                  .stroke(Color.black, lineWidth: 1.5)
              )
          }
        }
        .padding(.horizontal, 20)
        .padding(.top, 26)
        .padding(.bottom, 10)

        ScrollView {
          LazyVStack(spacing: 20) {
            ForEach(commVmq0MjQlJrqM7lc.comts4oMmysR5908NJ) { comdecXqgnTjBZf3 in
              ComRowtbQX2Vx6D7P1X(
                commXyUfkhL61UsfP: comdecXqgnTjBZf3, onrepec8s8iLFaxS8w: onrepec8s8iLFaxS8w,
                onDismiss: {
                  dismiss()
                })
            }
          }
          .padding(.horizontal, 20)
          .padding(.top, 12)
        }

        HStack(spacing: 12) {
          ZStack(alignment: .leading) {
            if comtxtFNpc30NkkZAmp.isEmpty {
              Text("Say something...")
                .foregroundColor(.white.opacity(0.4))
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
            }
            TextField("", text: $comtxtFNpc30NkkZAmp)
              .textFieldStyle(.plain)
              .foregroundColor(.white)
              .padding(.horizontal, 16)
              .padding(.vertical, 15)
              .cornerRadius(15)
              .focused($isfocusTN3GRBtL8yBZe)
              .submitLabel(.done)
          }

          Button(action: {
            UIApplication.shared.sendAction(
              #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            sendWPnm5SxHY3TXN()
          }) {
            Image(systemName: "paperplane.fill")
              .font(.system(size: 20))
              .foregroundColor(Color("yinguanglv"))
              .frame(width: 44, height: 44)
              .clipShape(Circle())
              .padding(.trailing, 3)
          }
          .disabled(comtxtFNpc30NkkZAmp.isEmpty)
        }
        .background(Color(red: 25 / 255, green: 33 / 255, blue: 38 / 255))
        .cornerRadius(16)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
      }
    }
    .onAppear {
      commVmq0MjQlJrqM7lc.updElJ8PgaCm1Wv1(aumaEJ7EvQZ9Ow9Qt)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private func sendWPnm5SxHY3TXN() {
    guard !comtxtFNpc30NkkZAmp.isEmpty else { return }
    guard let uidzNUsLgwNBhkPV = aumaEJ7EvQZ9Ow9Qt.currvj9QRUUPOWY4Ouser?.id else {
      return
    }

    let commui4flLwFoDkRY = Comment(
      vI3dE5oI7dN9eN: vdoidD9HGYfeBdbb8g,
      aC9dE1fG3hI5jK: uidzNUsLgwNBhkPV,
      cL7mN9oP1qR3sT: comtxtFNpc30NkkZAmp,
      tK3lM5nO7pQ9rS: Date()
    )

    commVmq0MjQlJrqM7lc.addr9jkmimqGYIjL(commui4flLwFoDkRY)
    comtxtFNpc30NkkZAmp = ""
    isfocusTN3GRBtL8yBZe = false

    NotificationCenter.default.post(name: NSNotification.Name("CommentAdded"), object: nil)
  }
}

struct ComRowtbQX2Vx6D7P1X: View {
  let commXyUfkhL61UsfP: Comment
  var onrepec8s8iLFaxS8w: ((String) -> Void)? = nil
  var onDismiss: (() -> Void)? = nil
  @StateObject private var commVmq0MjQlJrqM7lc: CommentRowViewModel
  @EnvironmentObject var aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod

  init(
    commXyUfkhL61UsfP: Comment, onrepec8s8iLFaxS8w: ((String) -> Void)? = nil,
    onDismiss: (() -> Void)? = nil
  ) {
    self.commXyUfkhL61UsfP = commXyUfkhL61UsfP
    self.onrepec8s8iLFaxS8w = onrepec8s8iLFaxS8w
    self.onDismiss = onDismiss
    _commVmq0MjQlJrqM7lc = StateObject(
      wrappedValue: CommentRowViewModel(auidvPFJA8KR5FrlQ: commXyUfkhL61UsfP.aC9dE1fG3hI5jK))
  }

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      if let auVVhVZlC8YeUdr = commVmq0MjQlJrqM7lc.autG49bxkSZNTSoj {
        if let avatarName = auVVhVZlC8YeUdr.aG3hI5jK7lM9nO {
          DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: avatarName)
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(
              Circle()
                .stroke(Color.white, lineWidth: 2.5)
            )
        } else {
          Circle()
            .fill(Color.pink.opacity(0.3))
            .frame(width: 50, height: 50)
            .overlay {
              Text(String(auVVhVZlC8YeUdr.uX4yZ6aB8cD0eF.prefix(1)))
                .font(.headline)
                .foregroundColor(.pink)
            }
        }
      } else {
        Circle()
          .fill(Color.pink.opacity(0.3))
          .frame(width: 40, height: 40)
      }

      VStack(alignment: .leading, spacing: 4) {
        if let auVVhVZlC8YeUdr = commVmq0MjQlJrqM7lc.autG49bxkSZNTSoj {
          Text(auVVhVZlC8YeUdr.uX4yZ6aB8cD0eF)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black)
        }

        Text(commXyUfkhL61UsfP.cL7mN9oP1qR3sT)
          .font(.system(size: 14))
          .foregroundColor(.black.opacity(0.8))
          .fixedSize(horizontal: false, vertical: true)
      }

      Spacer()

      if aumaEJ7EvQZ9Ow9Qt.currvj9QRUUPOWY4Ouser?.id != commXyUfkhL61UsfP.aC9dE1fG3hI5jK {
        Button(action: {
          onDismiss?()
          onrepec8s8iLFaxS8w?(commXyUfkhL61UsfP.aC9dE1fG3hI5jK)
        }) {
          Image(systemName: "ellipsis")
            .font(.system(size: 16))
            .foregroundColor(.black.opacity(0.7))
        }
      }
    }
    .onAppear {
      commVmq0MjQlJrqM7lc.setauthGPLlm37lQUk83(aumaEJ7EvQZ9Ow9Qt)
    }
  }
}

// MARK: - Comment Row ViewModel
@MainActor
class CommentRowViewModel: ObservableObject {
  @Published var autG49bxkSZNTSoj: User?
  private let auserR3pj18n5NpYAk: Authsdmd0VXzbAnDYServProc
  private let auidvPFJA8KR5FrlQ: String
  private weak var aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod?

  init(
    auidvPFJA8KR5FrlQ: String,
    auserR3pj18n5NpYAk: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod? = nil
  ) {
    self.auserR3pj18n5NpYAk = auserR3pj18n5NpYAk
    self.auidvPFJA8KR5FrlQ = auidvPFJA8KR5FrlQ
    self.aumaEJ7EvQZ9Ow9Qt = aumaEJ7EvQZ9Ow9Qt
    loadPh9fIYKN4H1VK(auidMZ4GBtu2JcrNb: auidvPFJA8KR5FrlQ)

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor in
        guard let self = self,
          let updzUpvW7h0uhBrz = notification.userInfo?["user"] as? User,
          updzUpvW7h0uhBrz.id == self.auidvPFJA8KR5FrlQ
        else { return }
        self.autG49bxkSZNTSoj = updzUpvW7h0uhBrz
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setauthGPLlm37lQUk83(_ aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod) {
    self.aumaEJ7EvQZ9Ow9Qt = aumaEJ7EvQZ9Ow9Qt
    if autG49bxkSZNTSoj == nil {
      loadPh9fIYKN4H1VK(auidMZ4GBtu2JcrNb: auidvPFJA8KR5FrlQ)
    } else if let cur2PDO5bTwrgcV1 = aumaEJ7EvQZ9Ow9Qt.currvj9QRUUPOWY4Ouser,
      cur2PDO5bTwrgcV1.id == auidvPFJA8KR5FrlQ
    {
      autG49bxkSZNTSoj = cur2PDO5bTwrgcV1
    }
  }

  private func loadPh9fIYKN4H1VK(auidMZ4GBtu2JcrNb: String) {
    autG49bxkSZNTSoj = auserR3pj18n5NpYAk.getbyidQwpUuIWnzzs99(auidMZ4GBtu2JcrNb)

    if autG49bxkSZNTSoj == nil, let cur2PDO5bTwrgcV1 = aumaEJ7EvQZ9Ow9Qt?.currvj9QRUUPOWY4Ouser,
      cur2PDO5bTwrgcV1.id == auidMZ4GBtu2JcrNb
    {
      autG49bxkSZNTSoj = cur2PDO5bTwrgcV1
    }
  }
}

// MARK: - Comment Sheet ViewModel
@MainActor
class Comshet6Zv0ZcOxmY14fVmod: ObservableObject {
  @Published var comts4oMmysR5908NJ: [Comment] = []

  private let comserWiCuAnR5hJMER: ComNAQ136mFLYkZJServproc
  private let vdoidD9HGYfeBdbb8g: String
  private var aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod?

  init(
    vdoidD9HGYfeBdbb8g: String,
    comserWiCuAnR5hJMER: ComNAQ136mFLYkZJServproc = ComNAQ136mFLYkZJServ.shared
  ) {
    self.vdoidD9HGYfeBdbb8g = vdoidD9HGYfeBdbb8g
    self.comserWiCuAnR5hJMER = comserWiCuAnR5hJMER

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CommentAdded"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadZcvv3thwYzKoq()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadZcvv3thwYzKoq()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadZcvv3thwYzKoq()
      }
    }

    Task { @MainActor [weak self] in
      self?.loadZcvv3thwYzKoq()
    }
  }

  func updElJ8PgaCm1Wv1(_ aumaEJ7EvQZ9Ow9Qt: AuthManagA645b8Y0Aod3aVmod) {
    self.aumaEJ7EvQZ9Ow9Qt = aumaEJ7EvQZ9Ow9Qt
    loadZcvv3thwYzKoq()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func addr9jkmimqGYIjL(_ FVhF7Yo8gJ64W: Comment) {
    comserWiCuAnR5hJMER.addJsTIYRdRpgWGh(FVhF7Yo8gJ64W)
    loadZcvv3thwYzKoq()
  }

  private func loadZcvv3thwYzKoq() {
    let allyA1PHKFj6lXhZ = comserWiCuAnR5hJMER.locom1GrYz4YRiuJOq(for: vdoidD9HGYfeBdbb8g)
    comts4oMmysR5908NJ = flitercomjSELAiSQQVTWq(allyA1PHKFj6lXhZ)
  }

  private func flitercomjSELAiSQQVTWq(_ comts4oMmysR5908NJ: [Comment]) -> [Comment] {
    guard let bloUidsvYpWGX4L3qBuy = aumaEJ7EvQZ9Ow9Qt?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !bloUidsvYpWGX4L3qBuy.isEmpty
    else {
      return comts4oMmysR5908NJ
    }
    return comts4oMmysR5908NJ.filter { !bloUidsvYpWGX4L3qBuy.contains($0.aC9dE1fG3hI5jK) }
  }
}
