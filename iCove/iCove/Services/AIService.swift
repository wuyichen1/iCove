//
//  AIService.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import Foundation

enum AIServiceResult<T> {
  case success(T)
  case failure(String)

  var isSuccess: Bool {
    if case .success = self {
      return true
    }
    return false
  }

  var value: T? {
    if case .success(let value) = self {
      return value
    }
    return nil
  }

  var error: String? {
    if case .failure(let error) = self {
      return error
    }
    return nil
  }
}

/// AI 服务协议
protocol AIServiceProtocol {
  func fetchAIResponse(
    scene: String,
    style: String,
    season: String,
    additionalRequirements: String
  ) async -> AIServiceResult<String>
}

/// AI 服务实现
class AIService: AIServiceProtocol {
  static let shared = AIService()

  private let apiURL = "https://api.zxychat.link/api/dash/scope/textIssues"
  private let timeoutSeconds: TimeInterval = 20

  private init() {}

  /// 生成文本（带超时处理）
  static func generateText<T>(
    timeout: TimeInterval = 20,
    successMessage: String = "Generated successfully!",
    timeoutMessage: String =
      "We're working hard to handle your request! Please wait a moment and try again.",
    errorMessage: String = "We hit a small snag - our team is on it.",
    operation: @escaping () async throws -> T
  ) async -> AIServiceResult<T> {
    do {
      let result = try await withThrowingTaskGroup(of: T.self) { group in
        // 添加实际操作任务
        group.addTask {
          try await operation()
        }

        // 添加超时任务
        group.addTask {
          try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
          throw TimeoutError(message: timeoutMessage)
        }

        // 等待第一个完成的任务
        let result = try await group.next()!
        group.cancelAll()
        return result
      }

      return .success(result)
    } catch let error as TimeoutError {
      return .failure(error.message)
    } catch {
      return .failure(errorMessage)
    }
  }

  /// 获取 AI 回复
  func fetchAIResponse(
    scene: String,
    style: String,
    season: String,
    additionalRequirements: String
  ) async -> AIServiceResult<String> {
    // 构建用户输入文本
    var userInput = ""
    if !scene.isEmpty {
      userInput += "Scene: \(scene). "
    }
    if !style.isEmpty {
      userInput += "Style: \(style). "
    }
    if !season.isEmpty {
      userInput += "Season: \(season). "
    }
    if !additionalRequirements.isEmpty {
      userInput += "Additional requirements: \(additionalRequirements). "
    }

    let inputText = """
      You are a professional styling consultant. Based on the user's description of style and mood: "\(userInput.trimmingCharacters(in: .whitespaces))", 
      please provide 4-5 specific and creative outfit suggestions. Format your response with clear line breaks between each idea. 
      Make your suggestions practical, inspiring, and detailed.
      """

    return await Self.generateText(
      timeout: timeoutSeconds,
      operation: {
        try await self.performAPIRequest(inputText: inputText)
      }
    )
  }

  /// 执行 API 请求
  private func performAPIRequest(inputText: String) async throws -> String {
    guard let url = URL(string: apiURL) else {
      throw AIError.invalidURL
    }

    // 构建请求体
    let requestBody: [String: Any] = [
      "dashScopeMessageDTOList": [
        [
          "role": "user",
          "content": inputText,
        ]
      ]
    ]

    guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
      throw AIError.invalidRequestBody
    }

    // 创建请求
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    // 执行请求
    let (data, response) = try await URLSession.shared.data(for: request)

    // 检查响应状态码
    guard let httpResponse = response as? HTTPURLResponse else {
      throw AIError.invalidResponse
    }

    guard httpResponse.statusCode == 200 else {
      let errorBody = String(data: data, encoding: .utf8) ?? "Unknown error"
      throw AIError.httpError(statusCode: httpResponse.statusCode, message: errorBody)
    }

    // 解析响应
    guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
      let result = json["result"] as? [String: Any],
      let output = result["output"] as? [String: Any],
      let choices = output["choices"] as? [[String: Any]],
      let firstChoice = choices.first,
      let message = firstChoice["message"] as? [String: Any],
      let content = message["content"] as? String
    else {
      throw AIError.contentNotFound
    }

    return content
  }
}

// MARK: - 错误类型
enum AIError: Error {
  case invalidURL
  case invalidRequestBody
  case invalidResponse
  case httpError(statusCode: Int, message: String)
  case contentNotFound
}

struct TimeoutError: Error {
  let message: String
}
