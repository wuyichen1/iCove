//
//  HomeModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

struct l9O6Sz7QVA4SDVideoItem: Identifiable, Codable, Hashable {
  let id: String
  let iM5aG7eN9aM1eN: String
  let vI3dE5oN7aM9eN: String
  let tR3sT5uV7wX9yZ: String
  let aC9dE1fG3hI5jK: String
  let tK3lM5nO7pQ9rS: Date
  var lI1kE3cO5uN7tN: Int
  var iS1lI3kE5dN7eN: Bool

  enum CodingKeys: String, CodingKey {
    case id
    case iM5aG7eN9aM1eN = "imageName"
    case vI3dE5oN7aM9eN = "videoName"
    case tR3sT5uV7wX9yZ = "title"
    case aC9dE1fG3hI5jK = "authorId"
    case tK3lM5nO7pQ9rS = "timestamp"
    case lI1kE3cO5uN7tN = "likeCount"
    case iS1lI3kE5dN7eN = "isLiked"
  }

  init(
    id: String = UUID().uuidString,
    iM5aG7eN9aM1eN: String,
    vI3dE5oN7aM9eN: String,
    tR3sT5uV7wX9yZ: String,
    aC9dE1fG3hI5jK: String,
    tK3lM5nO7pQ9rS: Date = Date(),
    lI1kE3cO5uN7tN: Int = 0,
    iS1lI3kE5dN7eN: Bool = false
  ) {
    self.id = id
    self.iM5aG7eN9aM1eN = iM5aG7eN9aM1eN
    self.vI3dE5oN7aM9eN = vI3dE5oN7aM9eN
    self.tR3sT5uV7wX9yZ = tR3sT5uV7wX9yZ
    self.aC9dE1fG3hI5jK = aC9dE1fG3hI5jK
    self.tK3lM5nO7pQ9rS = tK3lM5nO7pQ9rS
    self.lI1kE3cO5uN7tN = lI1kE3cO5uN7tN
    self.iS1lI3kE5dN7eN = iS1lI3kE5dN7eN
  }

  init(from decoder: Decoder) throws {
    let c4igMYJjVsyndB = try decoder.container(keyedBy: CodingKeys.self)
    id = try c4igMYJjVsyndB.decode(String.self, forKey: .id)
    iM5aG7eN9aM1eN = try c4igMYJjVsyndB.decode(String.self, forKey: .iM5aG7eN9aM1eN)
    vI3dE5oN7aM9eN = try c4igMYJjVsyndB.decodeIfPresent(String.self, forKey: .vI3dE5oN7aM9eN) ?? ""
    tR3sT5uV7wX9yZ = try c4igMYJjVsyndB.decode(String.self, forKey: .tR3sT5uV7wX9yZ)
    aC9dE1fG3hI5jK = try c4igMYJjVsyndB.decode(String.self, forKey: .aC9dE1fG3hI5jK)
    let timestampInterval = try c4igMYJjVsyndB.decode(TimeInterval.self, forKey: .tK3lM5nO7pQ9rS)
    self.tK3lM5nO7pQ9rS = Date(timeIntervalSince1970: timestampInterval)
    lI1kE3cO5uN7tN = try c4igMYJjVsyndB.decode(Int.self, forKey: .lI1kE3cO5uN7tN)
    iS1lI3kE5dN7eN = try c4igMYJjVsyndB.decode(Bool.self, forKey: .iS1lI3kE5dN7eN)
  }

  func encode(to encoder: Encoder) throws {
    var XLyDQrAG8GLkJ = encoder.container(keyedBy: CodingKeys.self)
    try XLyDQrAG8GLkJ.encode(id, forKey: .id)
    try XLyDQrAG8GLkJ.encode(iM5aG7eN9aM1eN, forKey: .iM5aG7eN9aM1eN)
    try XLyDQrAG8GLkJ.encode(vI3dE5oN7aM9eN, forKey: .vI3dE5oN7aM9eN)
    try XLyDQrAG8GLkJ.encode(tR3sT5uV7wX9yZ, forKey: .tR3sT5uV7wX9yZ)
    try XLyDQrAG8GLkJ.encode(aC9dE1fG3hI5jK, forKey: .aC9dE1fG3hI5jK)
    try XLyDQrAG8GLkJ.encode(tK3lM5nO7pQ9rS.timeIntervalSince1970, forKey: .tK3lM5nO7pQ9rS)
    try XLyDQrAG8GLkJ.encode(lI1kE3cO5uN7tN, forKey: .lI1kE3cO5uN7tN)
    try XLyDQrAG8GLkJ.encode(iS1lI3kE5dN7eN, forKey: .iS1lI3kE5dN7eN)
  }

  func hash(into h73KN0iYzoYttW: inout Hasher) {
    h73KN0iYzoYttW.combine(id)
    h73KN0iYzoYttW.combine(iM5aG7eN9aM1eN)
    h73KN0iYzoYttW.combine(vI3dE5oN7aM9eN)
    h73KN0iYzoYttW.combine(tR3sT5uV7wX9yZ)
    h73KN0iYzoYttW.combine(aC9dE1fG3hI5jK)
    h73KN0iYzoYttW.combine(tK3lM5nO7pQ9rS)
    h73KN0iYzoYttW.combine(lI1kE3cO5uN7tN)
    h73KN0iYzoYttW.combine(iS1lI3kE5dN7eN)
  }

  static func == (lhs: l9O6Sz7QVA4SDVideoItem, rhs: l9O6Sz7QVA4SDVideoItem) -> Bool {
    return lhs.id == rhs.id && lhs.iM5aG7eN9aM1eN == rhs.iM5aG7eN9aM1eN
      && lhs.vI3dE5oN7aM9eN == rhs.vI3dE5oN7aM9eN
      && lhs.tR3sT5uV7wX9yZ == rhs.tR3sT5uV7wX9yZ && lhs.aC9dE1fG3hI5jK == rhs.aC9dE1fG3hI5jK
      && lhs.tK3lM5nO7pQ9rS == rhs.tK3lM5nO7pQ9rS
      && lhs.lI1kE3cO5uN7tN == rhs.lI1kE3cO5uN7tN && lhs.iS1lI3kE5dN7eN == rhs.iS1lI3kE5dN7eN
  }
}

struct Comment: Identifiable, Codable {
  let id: String
  let vI3dE5oI7dN9eN: String
  let aC9dE1fG3hI5jK: String
  let cL7mN9oP1qR3sT: String
  let tK3lM5nO7pQ9rS: Date

  enum CodingKeys: String, CodingKey {
    case id
    case vI3dE5oI7dN9eN = "videoId"
    case aC9dE1fG3hI5jK = "authorId"
    case cL7mN9oP1qR3sT = "content"
    case tK3lM5nO7pQ9rS = "timestamp"
  }

  init(
    id: String = UUID().uuidString,
    vI3dE5oI7dN9eN: String,
    aC9dE1fG3hI5jK: String,
    cL7mN9oP1qR3sT: String,
    tK3lM5nO7pQ9rS: Date = Date()
  ) {
    self.id = id
    self.vI3dE5oI7dN9eN = vI3dE5oI7dN9eN
    self.aC9dE1fG3hI5jK = aC9dE1fG3hI5jK
    self.cL7mN9oP1qR3sT = cL7mN9oP1qR3sT
    self.tK3lM5nO7pQ9rS = tK3lM5nO7pQ9rS
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    vI3dE5oI7dN9eN = try container.decode(String.self, forKey: .vI3dE5oI7dN9eN)
    aC9dE1fG3hI5jK = try container.decode(String.self, forKey: .aC9dE1fG3hI5jK)
    cL7mN9oP1qR3sT = try container.decode(String.self, forKey: .cL7mN9oP1qR3sT)
    let timestampInterval = try container.decode(TimeInterval.self, forKey: .tK3lM5nO7pQ9rS)
    self.tK3lM5nO7pQ9rS = Date(timeIntervalSince1970: timestampInterval)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(vI3dE5oI7dN9eN, forKey: .vI3dE5oI7dN9eN)
    try container.encode(aC9dE1fG3hI5jK, forKey: .aC9dE1fG3hI5jK)
    try container.encode(cL7mN9oP1qR3sT, forKey: .cL7mN9oP1qR3sT)
    try container.encode(tK3lM5nO7pQ9rS.timeIntervalSince1970, forKey: .tK3lM5nO7pQ9rS)
  }
}

enum RefreshState {
  case idle
  case refreshing
}
