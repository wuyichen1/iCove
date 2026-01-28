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
      if conv1.iS1pI3nN5eD7eN != conv2.iS1pI3nN5eD7eN {
        return conv1.iS1pI3nN5eD7eN
      }
      return conv1.tK3lM5nO7pQ9rS > conv2.tK3lM5nO7pQ9rS
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
      c96l3oNvOsQssy[index].lA9sT1mE3sS5aG7e = lmsg8sHptSNvHeyOl
      c96l3oNvOsQssy[index].tK3lM5nO7pQ9rS = IzNJBUmh7wV1o
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
        pA5rT1iC3iP5aN7t: ["user_001", "user_002"],
        lA9sT1mE3sS5aG7e: "Hello. Nice to meet you",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-3600),
        uN9rE1aD3cO5uN7t: 2,
        iS1uN3rE5aD7eN: true,
        iS1pI3nN5eD7eN: true
      ),
      Conversation(
        id: "conv_002",
        pA5rT1iC3iP5aN7t: ["user_001", "user_003"],
        lA9sT1mE3sS5aG7e: "Spring collection is here!",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-3600 * 1.5),
        uN9rE1aD3cO5uN7t: 0,
        iS1uN3rE5aD7eN: false,
        iS1pI3nN5eD7eN: true
      ),
    ]
    saZuui5SgpAkOlv(HqIaOKudomhXU)
  }
}
