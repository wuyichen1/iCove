//
//  ProfSR8H1KflnDrj9Vmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class ProfSR8H1KflnDrj9Vmod: ObservableObject {
  @Published var user: User?
  @Published var x6tcllx6YBqkU: Bool = false
  @Published var l2z4XG5qy0RxI3: Bool = false
  @Published var er3jjEZ8MFiPJpu: String?
  @Published var jMZw920hlJX6R: [SettingItemG9ajK0rqU3bc7] = []
  @Published var KtIKR8YgWCIGr: [l9O6Sz7QVA4SDVideoItem] = []

  private let m0ECMlSn2a4yy: AuthManagA645b8Y0Aod3aVmod
  private let zCZyF3PJjjyG9: String?
  private let BGe40GruMhiiC: Authsdmd0VXzbAnDYServProc
  private var EILy0BnybC2Ce: NSObjectProtocol?

  var isCurghxDEHCC3hzYz: Bool {
    guard let zCZyF3PJjjyG9 = zCZyF3PJjjyG9,
      let P9KXnHR94ErGa = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser?.id
    else {
      return zCZyF3PJjjyG9 == nil
    }
    return zCZyF3PJjjyG9 == P9KXnHR94ErGa
  }

  init(
    m0ECMlSn2a4yy: AuthManagA645b8Y0Aod3aVmod,
    userId: String? = nil,
    BGe40GruMhiiC: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared
  ) {
    self.m0ECMlSn2a4yy = m0ECMlSn2a4yy
    self.zCZyF3PJjjyG9 = userId
    self.BGe40GruMhiiC = BGe40GruMhiiC
    Task {
      await RYDHubwmXSTLX()
      if isCurghxDEHCC3hzYz {
      }
    }

    EILy0BnybC2Ce = NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      if self?.isCurghxDEHCC3hzYz == true {
        Task { @MainActor [weak self] in
          self?.user = self?.m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser
        }
      }
    }
  }

  deinit {
    if let bSoENgKL8jku5 = EILy0BnybC2Ce {
      NotificationCenter.default.removeObserver(bSoENgKL8jku5)
    }
  }

  func RYDHubwmXSTLX() async {
    guard !l2z4XG5qy0RxI3 else { return }

    l2z4XG5qy0RxI3 = true
    er3jjEZ8MFiPJpu = nil

    let ZVQMwdOBx8Jp8 = zCZyF3PJjjyG9 ?? m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser?.id

    if let Yj9a5jyfrrIaM = ZVQMwdOBx8Jp8 {
      lZV9k2VdlaDnu(userId: Yj9a5jyfrrIaM)

      if isCurghxDEHCC3hzYz {
        user = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser
        x6tcllx6YBqkU = false
      } else {
        if let ySQPJwqo5elnZ = BGe40GruMhiiC.getbyidQwpUuIWnzzs99(Yj9a5jyfrrIaM) {
          user = ySQPJwqo5elnZ
          if let P9KXnHR94ErGa = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser?.id {
            x6tcllx6YBqkU = ySQPJwqo5elnZ.fI3jK5lM7nO9pQ.contains(P9KXnHR94ErGa)
          }
        } else {
          user = User(
            id: Yj9a5jyfrrIaM,
            eK8mN2pQ7rT9vW: "",
            uX4yZ6aB8cD0eF: "User\(Yj9a5jyfrrIaM.suffix(4))",
            aG3hI5jK7lM9nO: nil,
            bP2qR4sT6uV8wX: 0,
            bY1zA3bC5dE7fG: nil
          )
          x6tcllx6YBqkU = false
        }
      }
    }

    l2z4XG5qy0RxI3 = false
  }

  func refresh() async {
    await RYDHubwmXSTLX()
  }

  private func lZV9k2VdlaDnu(userId: String) {
    let a8rSEDzj9r7tRq = VdoServ63WnoDbxzFob0.shared.loc5f3UJvuhXYjoD()
    KtIKR8YgWCIGr = a8rSEDzj9r7tRq.filter { $0.aC9dE1fG3hI5jK == userId }
      .sorted { $0.tK3lM5nO7pQ9rS > $1.tK3lM5nO7pQ9rS }
  }

  func togPohodzYKFgGNl() {
    guard var yw8vBQsSuZZDI = user, !isCurghxDEHCC3hzYz,
      let P9KXnHR94ErGa = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser?.id
    else { return }

    x6tcllx6YBqkU.toggle()

    if x6tcllx6YBqkU {
      if !yw8vBQsSuZZDI.fI3jK5lM7nO9pQ.contains(P9KXnHR94ErGa) {
        yw8vBQsSuZZDI.fI3jK5lM7nO9pQ.append(P9KXnHR94ErGa)
      }
      if var curYI7CMii2WiBmI = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser,
        !curYI7CMii2WiBmI.fZ5aB7cD9eF1gH.contains(yw8vBQsSuZZDI.id)
      {
        curYI7CMii2WiBmI.fZ5aB7cD9eF1gH.append(yw8vBQsSuZZDI.id)
        m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
      }
    } else {
      yw8vBQsSuZZDI.fI3jK5lM7nO9pQ.removeAll { $0 == P9KXnHR94ErGa }
      if var curYI7CMii2WiBmI = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser {
        curYI7CMii2WiBmI.fZ5aB7cD9eF1gH.removeAll { $0 == yw8vBQsSuZZDI.id }
        m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
      }
    }

    user = yw8vBQsSuZZDI
  }

  func sendb9kzu5TB4hAkL(router: Router) {
    guard let zCZyF3PJjjyG9 = zCZyF3PJjjyG9,
      let P9KXnHR94ErGa = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser?.id,
      zCZyF3PJjjyG9 != P9KXnHR94ErGa
    else {
      return
    }

    let conversationId = findOrCreateConversation(
      P9KXnHR94ErGa: P9KXnHR94ErGa,
      otherUserId: zCZyF3PJjjyG9
    )

    router.push(
      .chadetBhKPSi5YgfcOZ(cid7EWVIP6LCiVby: conversationId, uidKePZA2dVjXZzF: zCZyF3PJjjyG9))
  }

  private func findOrCreateConversation(P9KXnHR94ErGa: String, otherUserId: String) -> String {
    let Uq45CsbYPDWDH = ConvsalHLauR9oVrqseServ.shared
    let e8cfGszwGjDYZ = Uq45CsbYPDWDH.lovsNlpHQLpsFndh7()

    if let DmH3dMDFo7Bte = e8cfGszwGjDYZ.first(where: { conversation in
      conversation.pA5rT1iC3iP5aN7t.contains(P9KXnHR94ErGa)
        && conversation.pA5rT1iC3iP5aN7t.contains(otherUserId)
        && conversation.pA5rT1iC3iP5aN7t.count == 2
    }) {
      return DmH3dMDFo7Bte.id
    }

    let CcXlj9PppNrlf = "conv_\(UUID().uuidString.prefix(8))"
    let LTxKH62O9qeDk = Conversation(
      id: CcXlj9PppNrlf,
      pA5rT1iC3iP5aN7t: [P9KXnHR94ErGa, otherUserId],
      lA9sT1mE3sS5aG7e: "",
      tK3lM5nO7pQ9rS: Date(),
      uN9rE1aD3cO5uN7t: 0,
      iS1uN3rE5aD7eN: false,
      iS1pI3nN5eD7eN: false
    )
    Uq45CsbYPDWDH.svHB7pq1gSf83pa(LTxKH62O9qeDk)

    return CcXlj9PppNrlf
  }

  func updateBio(_ newBio: String) {
    guard var curYI7CMii2WiBmI = m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser, isCurghxDEHCC3hzYz else {
      return
    }
    curYI7CMii2WiBmI.bY1zA3bC5dE7fG = newBio.isEmpty ? nil : newBio
    m0ECMlSn2a4yy.currvj9QRUUPOWY4Ouser = curYI7CMii2WiBmI
    user = curYI7CMii2WiBmI
  }

  func logoutWfSgkdWFVCXy1() async {
    await m0ECMlSn2a4yy.logoutWfSgkdWFVCXy1()
  }
}
