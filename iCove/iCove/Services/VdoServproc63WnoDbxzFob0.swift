//
//  VdoServ63WnoDbxzFob0.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

protocol VdoServproc63WnoDbxzFob0 {
  func loc5f3UJvuhXYjoD() -> [VideoItem]
  func svSqlFE3ULuRtoH(_ rAIVHT5oIl1m4: [VideoItem])
  func addXIOHH83trw3Bg(_ b5tIDyhypErQ7: VideoItem)
  func upduCnYQ7R2p8zJ7(_ C2SXSxh6CnoId: VideoItem)
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

  func loc5f3UJvuhXYjoD() -> [VideoItem] {
    guard let Bkim5OXjSIBcx = UserDefaults.standard.data(forKey: vkey3l5k8ZxDbEMLR),
      let TUJDU7IUMfgPE = try? JSONDecoder().decode([VideoItem].self, from: Bkim5OXjSIBcx)
    else {
      return []
    }
    return TUJDU7IUMfgPE
  }

  func svSqlFE3ULuRtoH(_ rAIVHT5oIl1m4: [VideoItem]) {
    if let vPdo3KPI1ginP = try? JSONEncoder().encode(rAIVHT5oIl1m4) {
      UserDefaults.standard.set(vPdo3KPI1ginP, forKey: vkey3l5k8ZxDbEMLR)
    }
  }

  func addXIOHH83trw3Bg(_ b5tIDyhypErQ7: VideoItem) {
    var rAIVHT5oIl1m4 = loc5f3UJvuhXYjoD()
    rAIVHT5oIl1m4.insert(b5tIDyhypErQ7, at: 0)
    svSqlFE3ULuRtoH(rAIVHT5oIl1m4)
  }

  func upduCnYQ7R2p8zJ7(_ C2SXSxh6CnoId: VideoItem) {
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
    let yzdyEklAn2P2n: [VideoItem] = [
      VideoItem(
        id: "video_001",
        imageName: "RClW0Qk7ObNtk86q1",
        videoName: "YLXVqZ8wbqT0SSgp1",
        title: "Today's outfit, what do you all think of it?",
        authorId: "user_002",
        timestamp: Date().addingTimeInterval(-86400 * 2),
        likeCount: 346,
        isLiked: false
      ),
      VideoItem(
        id: "video_002",
        imageName: "RClW0Qk7ObNtk86q2",
        videoName: "YLXVqZ8wbqT0SSgp2",
        title:
          "Today's outfit suggestion: You can refer to this one for your daily wear. It's very comfortable.",
        authorId: "user_003",
        timestamp: Date().addingTimeInterval(-86400 * 3),
        likeCount: 289,
        isLiked: false
      ),
      VideoItem(
        id: "video_003",
        imageName: "RClW0Qk7ObNtk86q3",
        videoName: "YLXVqZ8wbqT0SSgp3",
        title: "Some recent fits",
        authorId: "user_004",
        timestamp: Date().addingTimeInterval(-86400 * 4),
        likeCount: 512,
        isLiked: false
      ),
      VideoItem(
        id: "video_004",
        imageName: "RClW0Qk7ObNtk86q4",
        videoName: "YLXVqZ8wbqT0SSgp4",
        title:
          "my outfit of the day，literally wearing the same version of an outfit everyday because it’s so cold and I grab the first thing I see",
        authorId: "user_005",
        timestamp: Date().addingTimeInterval(-86400 * 5),
        likeCount: 423,
        isLiked: false
      ),
      VideoItem(
        id: "video_005",
        imageName: "RClW0Qk7ObNtk86q5",
        videoName: "YLXVqZ8wbqT0SSgp5",
        title: "I really love these accessories of mine. They are so beautiful!",
        authorId: "user_006",
        timestamp: Date().addingTimeInterval(-86400 * 6),
        likeCount: 678,
        isLiked: false
      ),
      VideoItem(
        id: "video_006",
        imageName: "RClW0Qk7ObNtk86q6",
        videoName: "YLXVqZ8wbqT0SSgp6",
        title: "Such a simple and casual outfit would be very suitable.",
        authorId: "user_001",
        timestamp: Date().addingTimeInterval(-86400 * 7),
        likeCount: 891,
        isLiked: false
      ),
    ]

    svSqlFE3ULuRtoH(yzdyEklAn2P2n)
  }
}
