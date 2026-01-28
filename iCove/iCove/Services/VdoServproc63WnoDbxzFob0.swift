//
//  VdoServ63WnoDbxzFob0.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

protocol VdoServproc63WnoDbxzFob0 {
  func loc5f3UJvuhXYjoD() -> [l9O6Sz7QVA4SDVideoItem]
  func svSqlFE3ULuRtoH(_ rAIVHT5oIl1m4: [l9O6Sz7QVA4SDVideoItem])
  func addXIOHH83trw3Bg(_ b5tIDyhypErQ7: l9O6Sz7QVA4SDVideoItem)
  func upduCnYQ7R2p8zJ7(_ C2SXSxh6CnoId: l9O6Sz7QVA4SDVideoItem)
  func deldfb2Q12WwQ6hu(fxpCMTYSJuxny: String)
}

class VdoServ63WnoDbxzFob0: VdoServproc63WnoDbxzFob0 {
  static let shared = VdoServ63WnoDbxzFob0()

  private let vkey3l5k8ZxDbEMLR = "3wBCZp3nhICp3"

  private init() {
    if loc5f3UJvuhXYjoD().isEmpty {
      initCvRtb8OC1h22A()
    }

  }

  func loc5f3UJvuhXYjoD() -> [l9O6Sz7QVA4SDVideoItem] {
    guard let Bkim5OXjSIBcx = UserDefaults.standard.data(forKey: vkey3l5k8ZxDbEMLR),
      let TUJDU7IUMfgPE = try? JSONDecoder().decode([l9O6Sz7QVA4SDVideoItem].self, from: Bkim5OXjSIBcx)
    else {
      return []
    }
    return TUJDU7IUMfgPE
  }

  func svSqlFE3ULuRtoH(_ rAIVHT5oIl1m4: [l9O6Sz7QVA4SDVideoItem]) {
    if let vPdo3KPI1ginP = try? JSONEncoder().encode(rAIVHT5oIl1m4) {
      UserDefaults.standard.set(vPdo3KPI1ginP, forKey: vkey3l5k8ZxDbEMLR)
    }
  }

  func addXIOHH83trw3Bg(_ b5tIDyhypErQ7: l9O6Sz7QVA4SDVideoItem) {
    var rAIVHT5oIl1m4 = loc5f3UJvuhXYjoD()
    rAIVHT5oIl1m4.insert(b5tIDyhypErQ7, at: 0)
    svSqlFE3ULuRtoH(rAIVHT5oIl1m4)
  }

  func upduCnYQ7R2p8zJ7(_ C2SXSxh6CnoId: l9O6Sz7QVA4SDVideoItem) {
    var rAIVHT5oIl1m4 = loc5f3UJvuhXYjoD()
    if let index = rAIVHT5oIl1m4.firstIndex(where: { $0.id == C2SXSxh6CnoId.id }) {
      rAIVHT5oIl1m4[index] = C2SXSxh6CnoId
      svSqlFE3ULuRtoH(rAIVHT5oIl1m4)
    }
  }

  func deldfb2Q12WwQ6hu(fxpCMTYSJuxny: String) {
    var rAIVHT5oIl1m4 = loc5f3UJvuhXYjoD()
    rAIVHT5oIl1m4.removeAll { $0.id == fxpCMTYSJuxny }
    svSqlFE3ULuRtoH(rAIVHT5oIl1m4)
  }

  private func initCvRtb8OC1h22A() {
    let yzdyEklAn2P2n: [l9O6Sz7QVA4SDVideoItem] = [
      l9O6Sz7QVA4SDVideoItem(
        id: "video_001",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q1",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp1",
        tR3sT5uV7wX9yZ: "Today's outfit, what do you all think of it?",
        aC9dE1fG3hI5jK: "user_002",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 2),
        lI1kE3cO5uN7tN: 346,
        iS1lI3kE5dN7eN: false
      ),
      l9O6Sz7QVA4SDVideoItem(
        id: "video_002",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q2",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp2",
        tR3sT5uV7wX9yZ:
          "Today's outfit suggestion: You can refer to this one for your daily wear. It's very comfortable.",
        aC9dE1fG3hI5jK: "user_003",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 3),
        lI1kE3cO5uN7tN: 289,
        iS1lI3kE5dN7eN: false
      ),
      l9O6Sz7QVA4SDVideoItem(
        id: "video_003",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q3",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp3",
        tR3sT5uV7wX9yZ: "Some recent fits",
        aC9dE1fG3hI5jK: "user_004",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 4),
        lI1kE3cO5uN7tN: 512,
        iS1lI3kE5dN7eN: false
      ),
      l9O6Sz7QVA4SDVideoItem(
        id: "video_004",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q4",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp4",
        tR3sT5uV7wX9yZ:
          "my outfit of the day，literally wearing the same version of an outfit everyday because it’s so cold and I grab the first thing I see",
        aC9dE1fG3hI5jK: "user_005",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 5),
        lI1kE3cO5uN7tN: 423,
        iS1lI3kE5dN7eN: false
      ),
      l9O6Sz7QVA4SDVideoItem(
        id: "video_005",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q5",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp5",
        tR3sT5uV7wX9yZ: "I really love these accessories of mine. They are so beautiful!",
        aC9dE1fG3hI5jK: "user_006",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 6),
        lI1kE3cO5uN7tN: 678,
        iS1lI3kE5dN7eN: false
      ),
      l9O6Sz7QVA4SDVideoItem(
        id: "video_006",
        iM5aG7eN9aM1eN: "RClW0Qk7ObNtk86q6",
        vI3dE5oN7aM9eN: "YLXVqZ8wbqT0SSgp6",
        tR3sT5uV7wX9yZ: "Such a simple and casual outfit would be very suitable.",
        aC9dE1fG3hI5jK: "user_001",
        tK3lM5nO7pQ9rS: Date().addingTimeInterval(-86400 * 7),
        lI1kE3cO5uN7tN: 891,
        iS1lI3kE5dN7eN: false
      ),
    ]

    svSqlFE3ULuRtoH(yzdyEklAn2P2n)
  }
}
