//
//  MsgSE8UQxD8j7C19Vmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class MsgSE8UQxD8j7C19Vmod: ObservableObject {
  @Published var cs0ZOxgQsTkhaos: [Conversation] = []
  @Published var loingxwNUWZIYJTAOd: Bool = false
  @Published var errhxT5N6p0mDJaB: String?
  @Published var serttv5jXmylVnFpO5: String = ""
  @Published var unreeDU8zPDXRI3U6: Int = 0

  private let cvsTaDPnQobmsULZ: ConvsalHLauR9oVrqseServproc
  var cuidjO17fn13slPB0: String? = nil
  private var a6KbmLkume8uxL: AuthManagA645b8Y0Aod3aVmod?

  var filJwM7EaSVjAhts: [Conversation] {
    let userConversations = cs0ZOxgQsTkhaos.filter { U9rvK4qldS257 in
      guard let cuidjO17fn13slPB0 = cuidjO17fn13slPB0 else { return false }
      return U9rvK4qldS257.pA5rT1iC3iP5aN7t.contains(cuidjO17fn13slPB0)
    }

    let R8jL7JVjf4YCg = dilbovJMRq1zuxO8EM(userConversations)

    if serttv5jXmylVnFpO5.isEmpty {
      return R8jL7JVjf4YCg
    } else {
      return R8jL7JVjf4YCg.filter { U9rvK4qldS257 in
        U9rvK4qldS257.lA9sT1mE3sS5aG7e.localizedCaseInsensitiveContains(serttv5jXmylVnFpO5)
      }
    }
  }

  func updAuma7Cif2ltv9c65t(_ a6KbmLkume8uxL: AuthManagA645b8Y0Aod3aVmod) {
    self.a6KbmLkume8uxL = a6KbmLkume8uxL
    Task {
      await MZ6eJcEBDp82N()
    }
  }

  private func dilbovJMRq1zuxO8EM(_ cs0ZOxgQsTkhaos: [Conversation]) -> [Conversation] {
    guard let bNbC5pKi3VI0gC = a6KbmLkume8uxL?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !bNbC5pKi3VI0gC.isEmpty
    else {
      return cs0ZOxgQsTkhaos
    }
    return cs0ZOxgQsTkhaos.filter { FyTb07KHIXZAU in
      !FyTb07KHIXZAU.pA5rT1iC3iP5aN7t.contains { bNbC5pKi3VI0gC.contains($0) }
    }
  }

  init(cvsTaDPnQobmsULZ: ConvsalHLauR9oVrqseServproc = ConvsalHLauR9oVrqseServ.shared) {
    self.cvsTaDPnQobmsULZ = cvsTaDPnQobmsULZ
    Task {
      await MZ6eJcEBDp82N()
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        await self?.MZ6eJcEBDp82N()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        await self?.MZ6eJcEBDp82N()
      }
    }
  }

  func MZ6eJcEBDp82N() async {
    guard !loingxwNUWZIYJTAOd else { return }

    loingxwNUWZIYJTAOd = true
    errhxT5N6p0mDJaB = nil

    try? await Task.sleep(nanoseconds: 300_000_000)

    cs0ZOxgQsTkhaos = cvsTaDPnQobmsULZ.lovsNlpHQLpsFndh7()
    updrerXp33KT7qJco7()

    loingxwNUWZIYJTAOd = false
  }

  func refresh() async {
    try? await Task.sleep(nanoseconds: 300_000_000)

    cs0ZOxgQsTkhaos = cvsTaDPnQobmsULZ.lovsNlpHQLpsFndh7()
    updrerXp33KT7qJco7()
  }

  func markOihyOHcXCrdV7(_ ymnWptVxosCAM: Conversation) {
    if let index = cs0ZOxgQsTkhaos.firstIndex(where: { $0.id == ymnWptVxosCAM.id }) {
      cs0ZOxgQsTkhaos[index].iS1uN3rE5aD7eN = false
      cs0ZOxgQsTkhaos[index].uN9rE1aD3cO5uN7t = 0
      cvsTaDPnQobmsULZ.updaSbnMC8iuKfxZ(cs0ZOxgQsTkhaos[index])
      updrerXp33KT7qJco7()
    }
  }

  func delcvsQHjORznHQ9t0g(_ yT1qiIhgCysWA: Conversation) {
    cs0ZOxgQsTkhaos.removeAll { $0.id == yT1qiIhgCysWA.id }
    cvsTaDPnQobmsULZ.delcvsQHjORznHQ9t0g(yT1qiIhgCysWA.id)
    updrerXp33KT7qJco7()
  }

  private func updrerXp33KT7qJco7() {
    unreeDU8zPDXRI3U6 = cs0ZOxgQsTkhaos.reduce(0) { $0 + $1.uN9rE1aD3cO5uN7t }
  }

}
