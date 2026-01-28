//
//  AIservCkCeIgWDTOo9Q.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import Foundation

enum AIZaGBn9nKcg6zmrest<T> {
  case susccamK2ph7M7WkX(T)
  case failFdvRecB9dfUuQ(String)
}

protocol AIservCkCeIgWDTOo9Qproc {
  func fetchZo8oCPHSVeWHl(
    sceneU1K4wRfeNnrnI: String,
    styleXtwRAqUlv5bSD: String,
    seasonn6GCC7Kt1FsbA: String,
    additionalRequirements: String
  ) async -> AIZaGBn9nKcg6zmrest<String>
}

class AIservCkCeIgWDTOo9Q: AIservCkCeIgWDTOo9Qproc {
  static let shared = AIservCkCeIgWDTOo9Q()

  private let apiFrBEvNXBZmzC6 = "https://api.zxychat.link/api/dash/scope/textIssues"
  private let ykT576nkM2559: TimeInterval = 20

  private init() {}

  static func gentxtA4OiE2bjmpLop<T>(
    toutIoWys24TdCJy0: TimeInterval = 20,
    operMpiGCS2xAgoWs: @escaping () async throws -> T
  ) async -> AIZaGBn9nKcg6zmrest<T> {
    do {
      let resBzOnazX0vIfEY = try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask {
          try await operMpiGCS2xAgoWs()
        }

        group.addTask {
          try await Task.sleep(nanoseconds: UInt64(toutIoWys24TdCJy0 * 1_000_000_000))
          throw TouterrZ6GwfFCQXcniA(
            v7IrNjNH3D3cJ:
              "Just a sec—we're taking care of your request. Try again shortly.")
        }

        let resBzOnazX0vIfEY = try await group.next()!
        group.cancelAll()
        return resBzOnazX0vIfEY
      }

      return .susccamK2ph7M7WkX(resBzOnazX0vIfEY)
    } catch let iRep3OEi3nBt6 as TouterrZ6GwfFCQXcniA {
      return .failFdvRecB9dfUuQ(iRep3OEi3nBt6.v7IrNjNH3D3cJ)
    } catch {
      return .failFdvRecB9dfUuQ("Looks like a small hiccup—we're on it!")
    }
  }

  func fetchZo8oCPHSVeWHl(
    sceneU1K4wRfeNnrnI: String,
    styleXtwRAqUlv5bSD: String,
    seasonn6GCC7Kt1FsbA: String,
    additionalRequirements: String
  ) async -> AIZaGBn9nKcg6zmrest<String> {
    var izgRzel0M8Lqg = ""
    if !sceneU1K4wRfeNnrnI.isEmpty {
      izgRzel0M8Lqg += "Scene: \(sceneU1K4wRfeNnrnI). "
    }
    if !styleXtwRAqUlv5bSD.isEmpty {
      izgRzel0M8Lqg += "Style: \(styleXtwRAqUlv5bSD). "
    }
    if !seasonn6GCC7Kt1FsbA.isEmpty {
      izgRzel0M8Lqg += "Season: \(seasonn6GCC7Kt1FsbA). "
    }
    if !additionalRequirements.isEmpty {
      izgRzel0M8Lqg += "Additional requirements: \(additionalRequirements). "
    }

    let iptxthsypC1HbFCkZK = """
      You are a professional styling consultant. Based on the user's description of style and mood: "\(izgRzel0M8Lqg.trimmingCharacters(in: .whitespaces))", 
      please provide 4-5 specific and creative outfit suggestions. Format your response with clear line breaks between each idea. 
      Make your suggestions practical, inspiring, and detailed.
      """

    return await Self.gentxtA4OiE2bjmpLop(
      toutIoWys24TdCJy0: ykT576nkM2559,
      operMpiGCS2xAgoWs: {
        try await self.perSdqkiciLfie7e(iptZ1pu94nwnwzdS: iptxthsypC1HbFCkZK)
      }
    )
  }

  private func perSdqkiciLfie7e(iptZ1pu94nwnwzdS: String) async throws -> String {
    guard let urlW1Sz5jIBqEmVu = URL(string: apiFrBEvNXBZmzC6) else {
      throw AIError6SdgGXFRSY9Ol.frGZvqn2vm2Fy
    }

    let re8GxgfZYAnia8l: [String: Any] = [
      "dashScopeMessageDTOList": [
        [
          "role": "user",
          "content": iptZ1pu94nwnwzdS,
        ]
      ]
    ]

    guard let izN6oJIklwhdW = try? JSONSerialization.data(withJSONObject: re8GxgfZYAnia8l) else {
      throw AIError6SdgGXFRSY9Ol.z70TvDZrhjwqz
    }

    var ughIlKoh7KddD = URLRequest(url: urlW1Sz5jIBqEmVu)
    ughIlKoh7KddD.httpMethod = "POST"
    ughIlKoh7KddD.setValue("application/json", forHTTPHeaderField: "Content-Type")
    ughIlKoh7KddD.httpBody = izN6oJIklwhdW

    let (ijuehUBiZPpFt, response) = try await URLSession.shared.data(for: ughIlKoh7KddD)

    guard let htresNdocu0HDcqjAh = response as? HTTPURLResponse else {
      throw AIError6SdgGXFRSY9Ol.ir5870LgRlpAGNJ
    }

    guard htresNdocu0HDcqjAh.statusCode == 200 else {
      let erfrqoXpY7aiMOR = String(data: ijuehUBiZPpFt, encoding: .utf8) ?? "Unknown error"
      throw AIError6SdgGXFRSY9Ol.p2SAVBJMYA2tY(
        statusCode: htresNdocu0HDcqjAh.statusCode, message: erfrqoXpY7aiMOR)
    }

    guard
      let jaUp2EsznUDGN = try? JSONSerialization.jsonObject(with: ijuehUBiZPpFt) as? [String: Any],
      let resHsmxdfjm8tKGk = jaUp2EsznUDGN["result"] as? [String: Any],
      let othuCJvRmwu3B4H = resHsmxdfjm8tKGk["output"] as? [String: Any],
      let chHcijwSBoeOU19 = othuCJvRmwu3B4H["choices"] as? [[String: Any]],
      let frNdnMKBOVTmuNr = chHcijwSBoeOU19.first,
      let U0jP5ug6G1fqM = frNdnMKBOVTmuNr["message"] as? [String: Any],
      let pQp77wFxdPCQ1 = U0jP5ug6G1fqM["content"] as? String
    else {
      throw AIError6SdgGXFRSY9Ol.c81JUaOSJceUgu
    }

    return pQp77wFxdPCQ1
  }
}

enum AIError6SdgGXFRSY9Ol: Error {
  case frGZvqn2vm2Fy
  case z70TvDZrhjwqz
  case ir5870LgRlpAGNJ
  case p2SAVBJMYA2tY(statusCode: Int, message: String)
  case c81JUaOSJceUgu
}

struct TouterrZ6GwfFCQXcniA: Error {
  let v7IrNjNH3D3cJ: String
}
