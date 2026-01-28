//
//  DiscoverModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

struct DiscitemMQE0TVcUSS7Z: Identifiable {
  let id: String
  let tR3sT5uV7wX9yZ: String
  let dA1bC3dE5fG7hI: String
  let iJ9kL1mN3oP5qR: String?
  let vS7tU9vW1xY3zA: Int
  let aB5cD7eF9gH1iJ: String
  let tK3lM5nO7pQ9rS: Date
}

struct Post: Identifiable, Codable, Hashable {
  let id: String
  let iT1uV3wX5yZ7aB: [String]
  let aC9dE1fG3hI5jK: String
  let cL7mN9oP1qR3sT: String
  let tK3lM5nO7pQ9rS: Date

  enum CodingKeys: String, CodingKey {
    case id
    case iT1uV3wX5yZ7aB = "imageNames"
    case aC9dE1fG3hI5jK = "authorId"
    case cL7mN9oP1qR3sT = "content"
    case tK3lM5nO7pQ9rS = "timestamp"
  }

  init(
    id: String = UUID().uuidString,
    iT1uV3wX5yZ7aB: [String],
    aC9dE1fG3hI5jK: String,
    cL7mN9oP1qR3sT: String,
    tK3lM5nO7pQ9rS: Date = Date()
  ) {
    self.id = id
    self.iT1uV3wX5yZ7aB = iT1uV3wX5yZ7aB
    self.aC9dE1fG3hI5jK = aC9dE1fG3hI5jK
    self.cL7mN9oP1qR3sT = cL7mN9oP1qR3sT
    self.tK3lM5nO7pQ9rS = tK3lM5nO7pQ9rS
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    iT1uV3wX5yZ7aB = try container.decode([String].self, forKey: .iT1uV3wX5yZ7aB)
    aC9dE1fG3hI5jK = try container.decode(String.self, forKey: .aC9dE1fG3hI5jK)
    cL7mN9oP1qR3sT = try container.decode(String.self, forKey: .cL7mN9oP1qR3sT)
    let timestampInterval = try container.decode(TimeInterval.self, forKey: .tK3lM5nO7pQ9rS)
    self.tK3lM5nO7pQ9rS = Date(timeIntervalSince1970: timestampInterval)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(iT1uV3wX5yZ7aB, forKey: .iT1uV3wX5yZ7aB)
    try container.encode(aC9dE1fG3hI5jK, forKey: .aC9dE1fG3hI5jK)
    try container.encode(cL7mN9oP1qR3sT, forKey: .cL7mN9oP1qR3sT)
    try container.encode(tK3lM5nO7pQ9rS.timeIntervalSince1970, forKey: .tK3lM5nO7pQ9rS)
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Post, rhs: Post) -> Bool {
    return lhs.id == rhs.id
  }
}
