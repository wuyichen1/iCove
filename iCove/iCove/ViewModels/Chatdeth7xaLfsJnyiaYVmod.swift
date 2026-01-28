//
//  ChatDeth7xaLfsJnyiaYVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation
import SwiftUI

@MainActor
class ChatDeth7xaLfsJnyiaYVmod: ObservableObject {
  @Published var W9fdBCK2PwNT9: [Message] = []
  @Published var dingB5wfyHOUzpSul: Bool = false
  @Published var othWYFKvCmorLqVV: User?
  @Published var inpfBw841kKnHeft: String = ""
  @Published var xUUF5t6Gbyhne: Bool = false
  @Published var sBZVfHlN89O0Y: Bool = false
  @Published var recingqavn8VXVjnhFw: Bool = false
  @Published var pNC869CePvK2Nrecdur: TimeInterval = 0
  @Published var micCWJpinQimAQPL: Bool = false
  @Published var oQJFpzwEuhOCverr: String?

  private let cvidAQ11yFJplzflU: String
  private let ouid9I27rq3XslYVV: String
  private let bM6KHjGcjnHUI: Authsdmd0VXzbAnDYServProc
  private let vUvd1dnMLbay3: MsgServproyrV03Y9KZYZNL
  private let JrkMv9tSWZWj9: AudServIjFimBlyqhPqLProtc
  private var rectmerIs5H3sWq3JPnC: Timer?
  private var aL9SzSP1T91rB: AuthManagA645b8Y0Aod3aVmod?

  init(
    cvidAQ11yFJplzflU: String,
    ouid9I27rq3XslYVV: String,
    bM6KHjGcjnHUI: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    vUvd1dnMLbay3: MsgServproyrV03Y9KZYZNL = MsgServyrV03Y9KZYZNL.shared,
    JrkMv9tSWZWj9: AudServIjFimBlyqhPqLProtc = AudServIjFimBlyqhPqL.shared
  ) {
    self.cvidAQ11yFJplzflU = cvidAQ11yFJplzflU
    self.ouid9I27rq3XslYVV = ouid9I27rq3XslYVV
    self.bM6KHjGcjnHUI = bM6KHjGcjnHUI
    self.vUvd1dnMLbay3 = vUvd1dnMLbay3
    self.JrkMv9tSWZWj9 = JrkMv9tSWZWj9
    NEI7UZ3TIFTAP()
    ilvrt6m760vk8()

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.ilvrt6m760vk8()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.ilvrt6m760vk8()
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func updAuma7Cif2ltv9c65t(_ aL9SzSP1T91rB: AuthManagA645b8Y0Aod3aVmod) {
    self.aL9SzSP1T91rB = aL9SzSP1T91rB
    ilvrt6m760vk8()
  }

  func NEI7UZ3TIFTAP() {
    othWYFKvCmorLqVV = bM6KHjGcjnHUI.getbyidQwpUuIWnzzs99(ouid9I27rq3XslYVV)
  }

  func ilvrt6m760vk8() {
    dingB5wfyHOUzpSul = true
    Task {
      let jHgpMzRYQAyKQ = vUvd1dnMLbay3.lomghVKDAgQ8WGc0w(by: cvidAQ11yFJplzflU)
      W9fdBCK2PwNT9 = flitUdFCZVt3mDpW1(jHgpMzRYQAyKQ)
      dingB5wfyHOUzpSul = false
    }
  }

  private func flitUdFCZVt3mDpW1(_ W9fdBCK2PwNT9: [Message]) -> [Message] {
    guard let tdffhEvXi8cai = aL9SzSP1T91rB?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !tdffhEvXi8cai.isEmpty
    else {
      return W9fdBCK2PwNT9
    }
    return W9fdBCK2PwNT9.filter { !tdffhEvXi8cai.contains($0.sE5nD1eR3iD5eN) }
  }

  func sendb9kzu5TB4hAkL(cuidoM2I0g1VnXoXW: String) {
    guard !inpfBw841kKnHeft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

    let skggC9SSYCPwC = creayrDxa2iFGDOsM(
      cont9XHte1ZvqRmfG: inpfBw841kKnHeft,
      msgtypeY1H4JLL6sn0P8: .text,
      curDG75BaZ6CXH5D: cuidoM2I0g1VnXoXW
    )
    snfapdMYY7jVrGiqq3b(skggC9SSYCPwC)
    inpfBw841kKnHeft = ""
  }

  func sndimgTJyqAu4MxapC3(img02k8jBULdZ5To: String, cutaQz3mfJvoGWS: String) {
    let skggC9SSYCPwC = creayrDxa2iFGDOsM(
      cont9XHte1ZvqRmfG: img02k8jBULdZ5To,
      msgtypeY1H4JLL6sn0P8: .image,
      curDG75BaZ6CXH5D: cutaQz3mfJvoGWS
    )
    snfapdMYY7jVrGiqq3b(skggC9SSYCPwC)

    xUUF5t6Gbyhne = false
    sBZVfHlN89O0Y = false
  }

  func togzxj4RWZ5iWkLD() {
    xUUF5t6Gbyhne.toggle()
    if xUUF5t6Gbyhne {
      sBZVfHlN89O0Y = false
    }
  }

  func selex31VUBVkwrtCB(_ option4BeuwTqj8m01d: Opt7FeQh22R7fWxu) {
    switch option4BeuwTqj8m01d {
    case .voiceGR1jUIKQ73wI7:
      reqafPdqjhAPK2qv { [weak self] granted in
        guard let self = self else { return }
        if granted {
          self.sBZVfHlN89O0Y = true
          self.xUUF5t6Gbyhne = false
        } else {
          self.srevHsmljxifgVkR2(
            "Microphone permission is required to record audio.",
            durCFOgk7TfuauGN: 2_000_000_000
          )
        }
      }
    case .imageoZKoS97oHXa0L:
      xUUF5t6Gbyhne = false
    case .videoCallTg9iR4R71BwKK:
      xUUF5t6Gbyhne = false
    }
  }

  private func reqafPdqjhAPK2qv(completion: @escaping (Bool) -> Void) {
    Task {
      let granted = await JrkMv9tSWZWj9.reqptdX0knB7fzAUr()
      await MainActor.run {
        micCWJpinQimAQPL = granted
        completion(granted)
      }
    }
  }

  func startd9fMj5HrwT7X4() {
    guard micCWJpinQimAQPL else {
      return
    }

    do {
      _ = try JrkMv9tSWZWj9.startd9fMj5HrwT7X4()
      recingqavn8VXVjnhFw = true
      yZ63orMVzWMAE()
    } catch {
      srevHsmljxifgVkR2(
        "Failed to start recording. Please try again.",
        durCFOgk7TfuauGN: 2_000_000_000
      )
    }
  }

  func stop45lI9JRtaBQBg(c6GQKa0ch0YKY: String) {
    guard recingqavn8VXVjnhFw else { return }

    let PWKWWKlK2HMPd = JrkMv9tSWZWj9.recdurB6Xlg2LM0PEcr

    if PWKWWKlK2HMPd < 0.5 {
      _ = JrkMv9tSWZWj9.stop45lI9JRtaBQBg()
      recingqavn8VXVjnhFw = false
      pNC869CePvK2Nrecdur = 0
      sBZVfHlN89O0Y = false
      AAdCoPNWEvIgiastop()

      srevHsmljxifgVkR2(
        "The recording is too short; please record again.",
        durCFOgk7TfuauGN: 1_500_000_000
      )
      return
    }

    if let J2Vz2RQ3NfkOk = JrkMv9tSWZWj9.stop45lI9JRtaBQBg() {
      if let afv09T1r5rARQIcI = pkfb8if7m3yOK(from: J2Vz2RQ3NfkOk, uidVQAPPHlDQ3Mhn: c6GQKa0ch0YKY)
      {
        sndaudW2yXBjL2adoJm(afv09T1r5rARQIcI: afv09T1r5rARQIcI, hFvY59vrQAeoQ: c6GQKa0ch0YKY)
      }
    }

    recingqavn8VXVjnhFw = false
    pNC869CePvK2Nrecdur = 0
    sBZVfHlN89O0Y = false
    AAdCoPNWEvIgiastop()
    oQJFpzwEuhOCverr = nil
  }

  func sndaudW2yXBjL2adoJm(afv09T1r5rARQIcI: String, hFvY59vrQAeoQ: String) {
    let yDW6eE7dPFFVx = creayrDxa2iFGDOsM(
      cont9XHte1ZvqRmfG: afv09T1r5rARQIcI,
      msgtypeY1H4JLL6sn0P8: .audio,
      curDG75BaZ6CXH5D: hFvY59vrQAeoQ
    )
    snfapdMYY7jVrGiqq3b(yDW6eE7dPFFVx)
  }

  private func creayrDxa2iFGDOsM(
    cont9XHte1ZvqRmfG: String,
    msgtypeY1H4JLL6sn0P8: MtyWY6eefw4eu6Ve,
    curDG75BaZ6CXH5D: String
  ) -> Message {
    Message(
      id: UUID().uuidString,
      cO5nV1eR3sA5tI7oN: cvidAQ11yFJplzflU,
      sE5nD1eR3iD5eN: curDG75BaZ6CXH5D,
      cL7mN9oP1qR3sT: cont9XHte1ZvqRmfG,
      mE5sS1aG3eT5yP7e: msgtypeY1H4JLL6sn0P8,
      tK3lM5nO7pQ9rS: Date()
    )
  }

  private func snfapdMYY7jVrGiqq3b(_ msg0sTPfgGKjm5jH: Message) {
    vUvd1dnMLbay3.svmguzcUx3AXtBqom(msg0sTPfgGKjm5jH)
    W9fdBCK2PwNT9.append(msg0sTPfgGKjm5jH)
  }

  private func srevHsmljxifgVkR2(_ msg0sTPfgGKjm5jH: String, durCFOgk7TfuauGN: UInt64) {
    oQJFpzwEuhOCverr = msg0sTPfgGKjm5jH
    Task { [weak self] in
      try? await Task.sleep(nanoseconds: durCFOgk7TfuauGN)
      await MainActor.run {
        self?.oQJFpzwEuhOCverr = nil
      }
    }
  }

  private func pkfb8if7m3yOK(from urlWAqbkIy34XVa1: URL, uidVQAPPHlDQ3Mhn: String) -> String? {
    let fm6DqHyfttuFJEx = FileManager.default
    let FoA0mBPBNvMNE = fm6DqHyfttuFJEx.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let LkUA9tSjOqbHj = FoA0mBPBNvMNE.appendingPathComponent("audio")

    try? fm6DqHyfttuFJEx.createDirectory(at: LkUA9tSjOqbHj, withIntermediateDirectories: true)

    let fn2qba5QgRsrjAq = "audio_\(uidVQAPPHlDQ3Mhn)_\(UUID().uuidString).m4a"
    let a76PRuOrnYOXX = LkUA9tSjOqbHj.appendingPathComponent(fn2qba5QgRsrjAq)

    do {
      if fm6DqHyfttuFJEx.fileExists(atPath: a76PRuOrnYOXX.path) {
        try fm6DqHyfttuFJEx.removeItem(at: a76PRuOrnYOXX)
      }
      try fm6DqHyfttuFJEx.copyItem(at: urlWAqbkIy34XVa1, to: a76PRuOrnYOXX)
      return fn2qba5QgRsrjAq
    } catch {
      print("Failed to save audio file: \(error)")
      return nil
    }
  }

  private func yZ63orMVzWMAE() {
    AAdCoPNWEvIgiastop()
    rectmerIs5H3sWq3JPnC = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
      [weak self] timer in
      Task { @MainActor [weak self] in
        guard let self = self, self.recingqavn8VXVjnhFw else {
          timer.invalidate()
          return
        }
        self.pNC869CePvK2Nrecdur = self.JrkMv9tSWZWj9.recdurB6Xlg2LM0PEcr
      }
    }
  }

  private func AAdCoPNWEvIgiastop() {
    rectmerIs5H3sWq3JPnC?.invalidate()
    rectmerIs5H3sWq3JPnC = nil
  }

}

enum Opt7FeQh22R7fWxu {
  case voiceGR1jUIKQ73wI7
  case imageoZKoS97oHXa0L
  case videoCallTg9iR4R71BwKK
}
