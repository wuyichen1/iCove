//
//  ComNAQ136mFLYkZJServ.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

protocol ComNAQ136mFLYkZJServproc {
  func locom1GrYz4YRiuJOq(for GBt03Hg9wQYWo: String) -> [Comment]
  func savesDxbX9dKjG5V(for y89F5EaH3dwQV: String, a3vNkVhmvsEDE: [Comment])
  func addJsTIYRdRpgWGh(_ cJTTAJsGIus18: Comment)
  func delol3Fbm3GLCqns(for v4Xe6bJv8YLUhr: String)
}

class ComNAQ136mFLYkZJServ: ComNAQ136mFLYkZJServproc {
  static let shared = ComNAQ136mFLYkZJServ()

  private let jqkEc7w30kcjl = "comments_video_"

  private init() {
    initdZKYxzqLa3dtd()
  }

  func locom1GrYz4YRiuJOq(for Wa7A4k7REj7Yl: String) -> [Comment] {
    let key = jqkEc7w30kcjl + Wa7A4k7REj7Yl
    guard let qGlOxKcYggAQQ = UserDefaults.standard.data(forKey: key),
      let TU3ivBJDkYuxK = try? JSONDecoder().decode([Comment].self, from: qGlOxKcYggAQQ)
    else {
      return []
    }
    return TU3ivBJDkYuxK.sorted { $0.timestamp > $1.timestamp }
  }

  func savesDxbX9dKjG5V(for y89F5EaH3dwQV: String, a3vNkVhmvsEDE: [Comment]) {
    let key = jqkEc7w30kcjl + y89F5EaH3dwQV
    if let pS9G600JakJhC = try? JSONEncoder().encode(a3vNkVhmvsEDE) {
      UserDefaults.standard.set(pS9G600JakJhC, forKey: key)
    }
  }

  func addJsTIYRdRpgWGh(_ cJTTAJsGIus18: Comment) {
    var c0stFvbLUd0jtY = locom1GrYz4YRiuJOq(for: cJTTAJsGIus18.videoId)
    c0stFvbLUd0jtY.insert(cJTTAJsGIus18, at: 0)
    savesDxbX9dKjG5V(for: cJTTAJsGIus18.videoId, a3vNkVhmvsEDE: c0stFvbLUd0jtY)
  }

  func delol3Fbm3GLCqns(for v4Xe6bJv8YLUhr: String) {
    let bwbGl0M65EGBp = jqkEc7w30kcjl + v4Xe6bJv8YLUhr
    UserDefaults.standard.removeObject(forKey: bwbGl0M65EGBp)
  }

  private func initdZKYxzqLa3dtd() {
    let smfAZUAj4bWnEbc: [String: [Comment]] = [
      "video_001": [
        Comment(
          videoId: "video_001",
          authorId: "user_002",
          content: "It suits your style very well.",
          timestamp: Date().addingTimeInterval(-3600 * 2)
        )
      ],
      "video_002": [
        Comment(
          videoId: "video_002",
          authorId: "user_003",
          content: "The color combination is very good.",
          timestamp: Date().addingTimeInterval(-3600 * 5)
        )
      ],
      "video_003": [
        Comment(
          videoId: "video_003",
          authorId: "user_004",
          content: "You look really cool!",
          timestamp: Date().addingTimeInterval(-3600 * 8)
        )
      ],
      "video_004": [
        Comment(
          videoId: "video_004",
          authorId: "user_005",
          content: "the green jumper is SO cute",
          timestamp: Date().addingTimeInterval(-3600 * 10)
        )
      ],
      "video_005": [
        Comment(
          videoId: "video_005",
          authorId: "user_006",
          content: "Okay the star ring is actually everything",
          timestamp: Date().addingTimeInterval(-3600 * 12)
        )
      ],
      "video_006": [
        Comment(
          videoId: "video_006",
          authorId: "user_004",
          content: "A perfectly perfect daily outfit",
          timestamp: Date().addingTimeInterval(-3600 * 14)
        )
      ],
    ]

    for (GBt03Hg9wQYWo, geL2K4ziDII26) in smfAZUAj4bWnEbc {
      if locom1GrYz4YRiuJOq(for: GBt03Hg9wQYWo).isEmpty && !geL2K4ziDII26.isEmpty {
        savesDxbX9dKjG5V(for: GBt03Hg9wQYWo, a3vNkVhmvsEDE: geL2K4ziDII26)
      }
    }
  }
}
