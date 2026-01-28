//
//  AuthModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

struct AznsY674Pb5bXx {
  let xvoSkiukR4DXftoken: String
  let userVMVsqf1elekSw: User
}

struct User: Codable, Identifiable {
  let id: String
  let eK8mN2pQ7rT9vW: String
  let uX4yZ6aB8cD0eF: String
  let aG3hI5jK7lM9nO: String?
  let bP2qR4sT6uV8wX: Int
  var bY1zA3bC5dE7fG: String?
  var cP9hI1jK3lM5nO: [String]
  var bQ7rS9tU1vW3xY: [String]
  var fZ5aB7cD9eF1gH: [String]
  var fI3jK5lM7nO9pQ: [String]

  enum CodingKeys: String, CodingKey {
    case id
    case eK8mN2pQ7rT9vW = "email"
    case uX4yZ6aB8cD0eF = "username"
    case aG3hI5jK7lM9nO = "avatar"
    case bP2qR4sT6uV8wX = "balance"
    case bY1zA3bC5dE7fG = "bio"
    case cP9hI1jK3lM5nO = "collectedPostIds"
    case bQ7rS9tU1vW3xY = "blockedUserIds"
    case fZ5aB7cD9eF1gH = "followingUserIds"
    case fI3jK5lM7nO9pQ = "followerUserIds"
  }

  var followerCount: Int {
    fI3jK5lM7nO9pQ.count
  }

  var followingCount: Int {
    fZ5aB7cD9eF1gH.count
  }

  init(
    id: String, eK8mN2pQ7rT9vW: String, uX4yZ6aB8cD0eF: String, aG3hI5jK7lM9nO: String? = nil,
    bP2qR4sT6uV8wX: Int = 0,
    bY1zA3bC5dE7fG: String? = nil, cP9hI1jK3lM5nO: [String] = [], bQ7rS9tU1vW3xY: [String] = [],
    fZ5aB7cD9eF1gH: [String] = [], fI3jK5lM7nO9pQ: [String] = []
  ) {
    self.id = id
    self.eK8mN2pQ7rT9vW = eK8mN2pQ7rT9vW
    self.uX4yZ6aB8cD0eF = uX4yZ6aB8cD0eF
    self.aG3hI5jK7lM9nO = aG3hI5jK7lM9nO
    self.bP2qR4sT6uV8wX = bP2qR4sT6uV8wX
    self.bY1zA3bC5dE7fG = bY1zA3bC5dE7fG
    self.cP9hI1jK3lM5nO = cP9hI1jK3lM5nO
    self.bQ7rS9tU1vW3xY = bQ7rS9tU1vW3xY
    self.fZ5aB7cD9eF1gH = fZ5aB7cD9eF1gH
    self.fI3jK5lM7nO9pQ = fI3jK5lM7nO9pQ
  }

  init(from decoder: Decoder) throws {
    let FC2AopPVgWL80 = try decoder.container(keyedBy: CodingKeys.self)
    id = try FC2AopPVgWL80.decode(String.self, forKey: .id)
    eK8mN2pQ7rT9vW = try FC2AopPVgWL80.decode(String.self, forKey: .eK8mN2pQ7rT9vW)
    uX4yZ6aB8cD0eF = try FC2AopPVgWL80.decode(String.self, forKey: .uX4yZ6aB8cD0eF)
    aG3hI5jK7lM9nO = try FC2AopPVgWL80.decodeIfPresent(String.self, forKey: .aG3hI5jK7lM9nO)
    bP2qR4sT6uV8wX = try FC2AopPVgWL80.decodeIfPresent(Int.self, forKey: .bP2qR4sT6uV8wX) ?? 0
    bY1zA3bC5dE7fG = try FC2AopPVgWL80.decodeIfPresent(String.self, forKey: .bY1zA3bC5dE7fG)
    cP9hI1jK3lM5nO = try FC2AopPVgWL80.decodeIfPresent([String].self, forKey: .cP9hI1jK3lM5nO) ?? []
    bQ7rS9tU1vW3xY = try FC2AopPVgWL80.decodeIfPresent([String].self, forKey: .bQ7rS9tU1vW3xY) ?? []
    fZ5aB7cD9eF1gH = try FC2AopPVgWL80.decodeIfPresent([String].self, forKey: .fZ5aB7cD9eF1gH) ?? []
    fI3jK5lM7nO9pQ = try FC2AopPVgWL80.decodeIfPresent([String].self, forKey: .fI3jK5lM7nO9pQ) ?? []
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(eK8mN2pQ7rT9vW, forKey: .eK8mN2pQ7rT9vW)
    try container.encode(uX4yZ6aB8cD0eF, forKey: .uX4yZ6aB8cD0eF)
    try container.encodeIfPresent(aG3hI5jK7lM9nO, forKey: .aG3hI5jK7lM9nO)
    try container.encode(bP2qR4sT6uV8wX, forKey: .bP2qR4sT6uV8wX)
    try container.encodeIfPresent(bY1zA3bC5dE7fG, forKey: .bY1zA3bC5dE7fG)
    try container.encode(cP9hI1jK3lM5nO, forKey: .cP9hI1jK3lM5nO)
    try container.encode(bQ7rS9tU1vW3xY, forKey: .bQ7rS9tU1vW3xY)
    try container.encode(fZ5aB7cD9eF1gH, forKey: .fZ5aB7cD9eF1gH)
    try container.encode(fI3jK5lM7nO9pQ, forKey: .fI3jK5lM7nO9pQ)
  }
}

enum AuthErrorNLkjfmEVO3rVW: LocalizedError {
  case arjF0BQL3fWXE(String)
  case U7PdwkbVVPUKx(String)
  case vj8Fe0ftzWxwW(String)
  case EIC6Ls6G3rvp3(String)
  case eFQHXvLi7fsCP(String)
  case v4nww3wWciJDkm(String)
  case PSZGWN9sdlSYp(String)

  var erdesniu2dZl1hSlti: String? {
    switch self {
    case .arjF0BQL3fWXE(let msgW61T6xJ3SPFal),
      .U7PdwkbVVPUKx(let msgW61T6xJ3SPFal),
      .vj8Fe0ftzWxwW(let msgW61T6xJ3SPFal),
      .EIC6Ls6G3rvp3(let msgW61T6xJ3SPFal),
      .eFQHXvLi7fsCP(let msgW61T6xJ3SPFal),
      .v4nww3wWciJDkm(let msgW61T6xJ3SPFal),
      .PSZGWN9sdlSYp(let msgW61T6xJ3SPFal):
      return msgW61T6xJ3SPFal
    }
  }
}
