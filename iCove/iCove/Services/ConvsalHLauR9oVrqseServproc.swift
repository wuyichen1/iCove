//
//  ConvsalHLauR9oVrqseServ.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol ConvsalHLauR9oVrqseServproc {
  func lovsNlpHQLpsFndh7() -> [Conversation]
  func svHB7pq1gSf83pa(_ gYGmrAvxz5tv7: Conversation)
  func updlasttRKquUuueqEPU(fZBuFRrfS7Ykt: String, lmsg8sHptSNvHeyOl: String, IzNJBUmh7wV1o: Date)
  func updaSbnMC8iuKfxZ(_ XCAIrfQ183mlX: Conversation)
  func delcvsQHjORznHQ9t0g(_ cid9gCWhwsXUECOm: String)
}

class ConvsalHLauR9oVrqseServ: ConvsalHLauR9oVrqseServproc {
  static let shared = ConvsalHLauR9oVrqseServ()

  private let fX6dEKPGqB4yG = "conversations"
  private let AcKVFpTWrRwcD = UserDefaults.standard

  private init() {
    init8tjaHyHan6wJU()
  }

  func lovsNlpHQLpsFndh7() -> [Conversation] {
    guard let lcVSXZBHjdJXN = AcKVFpTWrRwcD.data(forKey: fX6dEKPGqB4yG),
      let c96l3oNvOsQssy = try? JSONDecoder().decode([Conversation].self, from: lcVSXZBHjdJXN)
    else {
      return []
    }
    return c96l3oNvOsQssy.sorted { conv1, conv2 in
      if conv1.isPinned != conv2.isPinned {
        return conv1.isPinned
      }
      return conv1.timestamp > conv2.timestamp
    }
  }

  func svHB7pq1gSf83pa(_ gYGmrAvxz5tv7: Conversation) {
    var c96l3oNvOsQssy = lovsNlpHQLpsFndh7()
    if let index = c96l3oNvOsQssy.firstIndex(where: { $0.id == gYGmrAvxz5tv7.id }) {
      c96l3oNvOsQssy[index] = gYGmrAvxz5tv7
    } else {
      c96l3oNvOsQssy.append(gYGmrAvxz5tv7)
    }
    saZuui5SgpAkOlv(c96l3oNvOsQssy)
  }

  func updlasttRKquUuueqEPU(fZBuFRrfS7Ykt: String, lmsg8sHptSNvHeyOl: String, IzNJBUmh7wV1o: Date) {
    var c96l3oNvOsQssy = lovsNlpHQLpsFndh7()
    if let index = c96l3oNvOsQssy.firstIndex(where: { $0.id == fZBuFRrfS7Ykt }) {
      c96l3oNvOsQssy[index].lastMessage = lmsg8sHptSNvHeyOl
      c96l3oNvOsQssy[index].timestamp = IzNJBUmh7wV1o
      saZuui5SgpAkOlv(c96l3oNvOsQssy)
    }
  }

  func updaSbnMC8iuKfxZ(_ gYGmrAvxz5tv7: Conversation) {
    svHB7pq1gSf83pa(gYGmrAvxz5tv7)
  }

  func delcvsQHjORznHQ9t0g(_ cid9gCWhwsXUECOm: String) {
    var c1El5jZFITLxw7 = lovsNlpHQLpsFndh7()
    c1El5jZFITLxw7.removeAll { $0.id == cid9gCWhwsXUECOm }
    saZuui5SgpAkOlv(c1El5jZFITLxw7)
  }

  private func saZuui5SgpAkOlv(_ c1El5jZFITLxw7: [Conversation]) {
    if let Zuui5SgpAkOlv = try? JSONEncoder().encode(c1El5jZFITLxw7) {
      AcKVFpTWrRwcD.set(Zuui5SgpAkOlv, forKey: fX6dEKPGqB4yG)
      AcKVFpTWrRwcD.synchronize()
    }
  }

  private func init8tjaHyHan6wJU() {
    guard AcKVFpTWrRwcD.data(forKey: fX6dEKPGqB4yG) == nil else { return }

    let HqIaOKudomhXU: [Conversation] = [
      Conversation(
        id: "conv_001",
        participantIds: ["user_001", "user_002"],
        lastMessage: "Hello. Nice to meet you",
        timestamp: Date().addingTimeInterval(-3600),
        unreadCount: 2,
        isUnread: true,
        isPinned: true
      ),
      Conversation(
        id: "conv_002",
        participantIds: ["user_001", "user_003"],
        lastMessage: "Spring collection is here!",
        timestamp: Date().addingTimeInterval(-3600 * 1.5),
        unreadCount: 0,
        isUnread: false,
        isPinned: true
      ),
    ]
    saZuui5SgpAkOlv(HqIaOKudomhXU)
  }
}
