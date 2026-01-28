//
//  MsgServyrV03Y9KZYZNL.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol MsgServproyrV03Y9KZYZNL {
  func lomghVKDAgQ8WGc0w(by f5uTWuJn1HSzE: String) -> [Message]
  func svmguzcUx3AXtBqom(_ Qu3MXKKFfpdEe: Message)
  func svSp4G7fX2WN7Zw(_ msq3BCvQgmRIJ: [Message], for pKZvX88I0ARtg: String)
  func del5Y00V3mLuHsdR(_ GxOzPRqdHYQqR: String, from c6uWL6adkKF6ln: String)
  func delfoiaBI3wrW9DqTE(_ OTJ6oQzebReM2: String)
}

class MsgServyrV03Y9KZYZNL: MsgServproyrV03Y9KZYZNL {
  static let shared = MsgServyrV03Y9KZYZNL()

  private let msgpre7PTpADVNNfb7D = "messages_"
  private let HhWcq93DQtFyZ = UserDefaults.standard
  private let FuT3sQXkCsMXX: ConvsalHLauR9oVrqseServproc

  private init(
    FuT3sQXkCsMXX: ConvsalHLauR9oVrqseServproc = ConvsalHLauR9oVrqseServ.shared
  ) {
    self.FuT3sQXkCsMXX = FuT3sQXkCsMXX
    init9wbd8LcBnqWbu()
  }

  func lomghVKDAgQ8WGc0w(by f5uTWuJn1HSzE: String) -> [Message] {
    let key = msgpre7PTpADVNNfb7D + f5uTWuJn1HSzE
    guard let F3jS5YKTZrlKL = HhWcq93DQtFyZ.data(forKey: key),
      let QwqmBRY0DmtAE = try? JSONDecoder().decode([Message].self, from: F3jS5YKTZrlKL)
    else {
      return []
    }
    return QwqmBRY0DmtAE.sorted { $0.timestamp < $1.timestamp }
  }

  func svmguzcUx3AXtBqom(_ Qu3MXKKFfpdEe: Message) {
    var msq3BCvQgmRIJ = lomghVKDAgQ8WGc0w(by: Qu3MXKKFfpdEe.conversationId)
    if !msq3BCvQgmRIJ.contains(where: { $0.id == Qu3MXKKFfpdEe.id }) {
      msq3BCvQgmRIJ.append(Qu3MXKKFfpdEe)
      svSp4G7fX2WN7Zw(msq3BCvQgmRIJ, for: Qu3MXKKFfpdEe.conversationId)

      let lsttxtmiC5rBSIvJSu9: String
      switch Qu3MXKKFfpdEe.messageType {
      case .image:
        lsttxtmiC5rBSIvJSu9 = "[Image]"
      case .audio:
        lsttxtmiC5rBSIvJSu9 = "[Audio]"
      case .text:
        lsttxtmiC5rBSIvJSu9 = Qu3MXKKFfpdEe.content
      }
      FuT3sQXkCsMXX.updlasttRKquUuueqEPU(
        fZBuFRrfS7Ykt: Qu3MXKKFfpdEe.conversationId,
        lmsg8sHptSNvHeyOl: lsttxtmiC5rBSIvJSu9,
        IzNJBUmh7wV1o: Qu3MXKKFfpdEe.timestamp
      )
    }
  }

  func svSp4G7fX2WN7Zw(_ msq3BCvQgmRIJ: [Message], for pKZvX88I0ARtg: String) {
    let key = msgpre7PTpADVNNfb7D + pKZvX88I0ARtg
    if let uYaDi9IXhYe0E = try? JSONEncoder().encode(msq3BCvQgmRIJ) {
      HhWcq93DQtFyZ.set(uYaDi9IXhYe0E, forKey: key)
      HhWcq93DQtFyZ.synchronize()
    }
  }

  func del5Y00V3mLuHsdR(_ GxOzPRqdHYQqR: String, from f5uTWuJn1HSzE: String) {
    var msq3BCvQgmRIJ = lomghVKDAgQ8WGc0w(by: f5uTWuJn1HSzE)
    msq3BCvQgmRIJ.removeAll { $0.id == GxOzPRqdHYQqR }
    svSp4G7fX2WN7Zw(msq3BCvQgmRIJ, for: f5uTWuJn1HSzE)
  }

  func delfoiaBI3wrW9DqTE(_ f5uTWuJn1HSzE: String) {
    let key = msgpre7PTpADVNNfb7D + f5uTWuJn1HSzE
    HhWcq93DQtFyZ.removeObject(forKey: key)
  }

  private func init9wbd8LcBnqWbu() {
    let cov1k0lirPUmzNoFZe = msgpre7PTpADVNNfb7D + "conv_001"
    if HhWcq93DQtFyZ.data(forKey: cov1k0lirPUmzNoFZe) == nil {
      let x4ydkdiQyGRQA: [Message] = [
        Message(
          id: "msg_001",
          conversationId: "conv_001",
          senderId: "user_002",
          content: "qC2VdAxOOOikJD6i11",
          messageType: .image,
          timestamp: Date().addingTimeInterval(-3600 * 2)
        ),
        Message(
          id: "msg_002",
          conversationId: "conv_001",
          senderId: "user_002",
          content: "Hello. Nice to meet you",
          messageType: .text,
          timestamp: Date().addingTimeInterval(-3600)
        ),
      ]
      svSp4G7fX2WN7Zw(x4ydkdiQyGRQA, for: "conv_001")
    }

    let con2aslDOa3VOJItY = msgpre7PTpADVNNfb7D + "conv_002"
    if HhWcq93DQtFyZ.data(forKey: con2aslDOa3VOJItY) == nil {
      let ta3RN2S1PyvlT: [Message] = [
        Message(
          id: "msg_003",
          conversationId: "conv_002",
          senderId: "user_003",
          content: "Spring collection is here!",
          messageType: .text,
          timestamp: Date().addingTimeInterval(-3600 * 1.5)
        )
      ]
      svSp4G7fX2WN7Zw(ta3RN2S1PyvlT, for: "conv_002")
    }
  }
}
