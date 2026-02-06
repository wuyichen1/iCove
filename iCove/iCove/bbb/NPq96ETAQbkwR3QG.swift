//
//  NPq96ETAQbkwR3QG.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import CommonCrypto
import Foundation

#if canImport(AdjustSdk)
  import AdjustSdk
#endif

// MARK: - String 扩展：AES 加密/解密
extension String {
  // AES 加密密钥
  private static let vY6sPt2wRv9hWIG9 = "518486he8pzgbjsk"  //qj232bvik4uquf25
  // AES IV
  private static let oCpgwaaL9A9dGU0v = "614436p28qzhkjsl"  //rvk2pc5zasf653s7

  /// AES 加密（CBC 模式）
  func Bbiq0CL12NgQVf8E() -> String {
    guard let data = self.data(using: .utf8),
      let keyData = Self.vY6sPt2wRv9hWIG9.data(using: .utf8),
      let ivData = Self.oCpgwaaL9A9dGU0v.data(using: .utf8)
    else {
      return ""
    }

    do {
      let encryptedData = try aesEncrypt(data: data, key: keyData, iv: ivData)
      return encryptedData.map { String(format: "%02x", $0) }.joined()
    } catch {
      print("Encryption error: \(error)")
      return ""
    }
  }

  /// AES 解密（CBC 模式）
  func KgSIFXgdBaO8wk5X() -> String {
    // 将十六进制字符串转换为 Data
    var hexData = Data()
    var index = self.startIndex
    while index < self.endIndex {
      let nextIndex = self.index(index, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
      let hexByte = String(self[index..<nextIndex])
      if let byte = UInt8(hexByte, radix: 16) {
        hexData.append(byte)
      }
      index = nextIndex
    }

    guard let keyData = Self.vY6sPt2wRv9hWIG9.data(using: .utf8),
      let ivData = Self.oCpgwaaL9A9dGU0v.data(using: .utf8)
    else {
      return ""
    }

    do {
      let decryptedData = try aesDecrypt(data: hexData, key: keyData, iv: ivData)
      return String(data: decryptedData, encoding: .utf8) ?? ""
    } catch {
      print("Decryption error: \(error)")
      return ""
    }
  }

  // MARK: - AES 加密/解密辅助方法

  private func aesEncrypt(data: Data, key: Data, iv: Data) throws -> Data {
    let keyLength = kCCKeySizeAES128
    let keyBytes = key.prefix(keyLength).withUnsafeBytes { Array($0) }
    let ivBytes = iv.prefix(kCCBlockSizeAES128).withUnsafeBytes { Array($0) }

    let bufferSize = data.count + kCCBlockSizeAES128
    var encryptedData = Data(count: bufferSize)
    var numBytesEncrypted: size_t = 0

    let dataBytes = data.withUnsafeBytes { Array($0) }
    let cryptStatus = encryptedData.withUnsafeMutableBytes { encryptedBytes in
      CCCrypt(
        CCOperation(kCCEncrypt),
        CCAlgorithm(kCCAlgorithmAES),
        CCOptions(kCCOptionPKCS7Padding),
        keyBytes,
        keyLength,
        ivBytes,
        dataBytes,
        data.count,
        encryptedBytes.baseAddress,
        bufferSize,
        &numBytesEncrypted
      )
    }

    guard cryptStatus == kCCSuccess else {
      throw NSError(domain: "AESError", code: Int(cryptStatus), userInfo: nil)
    }

    encryptedData.count = numBytesEncrypted
    return encryptedData
  }

  private func aesDecrypt(data: Data, key: Data, iv: Data) throws -> Data {
    let keyLength = kCCKeySizeAES128
    let keyBytes = key.prefix(keyLength).withUnsafeBytes { Array($0) }
    let ivBytes = iv.prefix(kCCBlockSizeAES128).withUnsafeBytes { Array($0) }

    let bufferSize = data.count + kCCBlockSizeAES128
    var decryptedData = Data(count: bufferSize)
    var numBytesDecrypted: size_t = 0

    let dataBytes = data.withUnsafeBytes { Array($0) }
    let cryptStatus = decryptedData.withUnsafeMutableBytes { decryptedBytes in
      CCCrypt(
        CCOperation(kCCDecrypt),
        CCAlgorithm(kCCAlgorithmAES),
        CCOptions(kCCOptionPKCS7Padding),
        keyBytes,
        keyLength,
        ivBytes,
        dataBytes,
        data.count,
        decryptedBytes.baseAddress,
        bufferSize,
        &numBytesDecrypted
      )
    }

    guard cryptStatus == kCCSuccess else {
      throw NSError(domain: "AESError", code: Int(cryptStatus), userInfo: nil)
    }

    decryptedData.count = numBytesDecrypted
    return decryptedData
  }
}

// MARK: - 网络异常类
class NPq96ETAQbkwR3QG: Error {
  let lByRLGtTGRxSHkAM: String
  let US5s2lA9Osw0tNR5: Int?

  init(_ message: String, statusCode: Int? = nil) {
    self.lByRLGtTGRxSHkAM = message
    self.US5s2lA9Osw0tNR5 = statusCode
  }

  var localizedDescription: String {
    return "NetworkException: \(lByRLGtTGRxSHkAM) (Status Code: \(US5s2lA9Osw0tNR5 ?? -1))"
  }
}

// MARK: - HTTP 响应处理
func S1j6wqPMoxGDffCrQ(_ response: HTTPURLResponse, data: Data) throws -> [String: Any] {
  switch response.statusCode {
  case 200, 201:
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      throw NPq96ETAQbkwR3QG("Invalid JSON response", statusCode: response.statusCode)
    }
    return jsonObject
  case 400:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw NPq96ETAQbkwR3QG("Bad request: \(body)", statusCode: response.statusCode)
  case 401:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw NPq96ETAQbkwR3QG("Unauthorized: \(body)", statusCode: response.statusCode)
  case 404:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw NPq96ETAQbkwR3QG("Not found: \(body)", statusCode: response.statusCode)
  case 500:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw NPq96ETAQbkwR3QG("Server error: \(body)", statusCode: response.statusCode)
  default:
    throw NPq96ETAQbkwR3QG(
      "Unexpected error: \(response.statusCode)", statusCode: response.statusCode)
  }
}

// MARK: - 网络请求类
class ABEA3gxIgOEym1RM {
  private let hj6h10XAV0cGQdis = UnfTdJMyy6tOB4gA.kTdeEbKen9DwkLXZ
  private let v4o6sUV2yGlZU7YJs: TimeInterval
  private let u53Kwz9HtTJgIaRQ: Int

  init(timeout: TimeInterval = 15, maxRetries: Int = 3) {
    self.v4o6sUV2yGlZU7YJs = timeout
    self.u53Kwz9HtTJgIaRQ = maxRetries
  }

  /// 执行 POST 请求（带重试机制）
  func zxBKcoOyJz34bI7X(
    _ endpoint: String,
    _ parameters: [String: Any]
  ) async throws -> [String: Any] {
    guard let url = URL(string: "\(hj6h10XAV0cGQdis)\(endpoint)") else {
      throw NPq96ETAQbkwR3QG("Invalid URL")
    }

    let headers = [
      "Content-Type": "application/json",
      "appVersion": UnfTdJMyy6tOB4gA.T5LSCMubhHpMlNKX,
      "deviceNo": FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.A9ey5jWayK2kXWSs,
      "pushToken": FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.mmnN2bMkxLm3iqBA,
      "loginToken": FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN,
      "appId": UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS,
    ]

    for attempt in 0..<u53Kwz9HtTJgIaRQ {
      do {
        let response = try await OBaTrDMSDsvKTy3q(
          url: url, headers: headers, parameters: parameters)
        return try S1j6wqPMoxGDffCrQ(response.0, data: response.1)
      } catch {
        print("Request Error (attempt \(attempt + 1)/\(u53Kwz9HtTJgIaRQ)): \(error)")

        if attempt == u53Kwz9HtTJgIaRQ - 1 {
          if let httpError = error as? NPq96ETAQbkwR3QG {
            throw NPq96ETAQbkwR3QG(
              "The system failed to execute the POST request to \(url)",
              statusCode: httpError.US5s2lA9Osw0tNR5
            )
          } else {
            throw NPq96ETAQbkwR3QG(
              "The system failed to execute the POST request to \(url)",
              statusCode: nil
            )
          }
        }

        // 延迟重试：2 * (attempt + 1) 秒
        try await Task.sleep(nanoseconds: UInt64(2 * (attempt + 1) * 1_000_000_000))
      }
    }

    throw NPq96ETAQbkwR3QG(
      "The process stopped after exceeding the allowed number of retry attempts.")
  }

  /// 执行 HTTP POST 请求
  private func OBaTrDMSDsvKTy3q(
    url: URL,
    headers: [String: String],
    parameters: [String: Any]
  ) async throws -> (HTTPURLResponse, Data) {
    // 将参数编码为 JSON
    guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
      throw NPq96ETAQbkwR3QG("Failed to encode JSON")
    }

    // 将 JSON 转换为字符串并加密
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
      throw NPq96ETAQbkwR3QG("Failed to convert JSON to string")
    }

    let encryptedBody = jsonString.Bbiq0CL12NgQVf8E()

    // 打印请求信息（调试用）
    for (key, value) in headers {
      print("  \(key): \(value)")
    }
    print("  j9MuELiuIEfs3VL1E: \(jsonString)")

    // 创建请求
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = encryptedBody.data(using: .utf8)

    // 设置请求头
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }

    // 执行请求（带超时）
    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      guard let httpResponse = response as? HTTPURLResponse else {
        throw NPq96ETAQbkwR3QG("Invalid response type")
      }

      return (httpResponse, data)
    } catch {
      if let urlError = error as? URLError, urlError.code == .timedOut {
        throw NPq96ETAQbkwR3QG("Request timeout", statusCode: nil)
      }
      throw error
    }
  }
}

// MARK: - API 调用函数

/// 登录/初始化接口
func kbTc9aWcyXAT6lMx() async -> [String: Any]? {
  let client = ABEA3gxIgOEym1RM()

  // 获取 Adjust Adid（Swift 版本）
  // 注意：根据 Adjust SDK 版本，adid() 可能是异步方法
  #if canImport(AdjustSdk)
    let adjustAdid = await Adjust.adid() ?? ""
  #else
    let adjustAdid = ""
  #endif

  var parameters: [String: Any] = [
    "AdjustAdida": adjustAdid,  //只有FB运营包包需要传
    "a8EgqOe3tZ811hndn": FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.A9ey5jWayK2kXWSs,
    "uxKHmC38tcShyr7dv": [
      "countryCode": sBXmGiE8yHF9iVi5.HjDS7QQbL0K1MJJI,
      "latitude": sBXmGiE8yHF9iVi5.iPsqpBxjiipgKmoA,
      "longitude": sBXmGiE8yHF9iVi5.uUZACsxOvs6NaVxR,
    ],
  ]

  // 如果密码不为空，添加到参数中
  if !FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.c307dPw24ADsTmm4.isEmpty {
    parameters["Ye1aQV1kRfB7zGTCd"] = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.c307dPw24ADsTmm4
  }

  do {
    var result = try await client.zxBKcoOyJz34bI7X("/opi/v1/w0OzRx8vMGORcSLfal", parameters)

    // 如果 result 字段是字符串，尝试解密并解析
    if let resultString = result["result"] as? String {
      let decrypted = resultString.KgSIFXgdBaO8wk5X()
      if let jsonData = decrypted.data(using: .utf8),
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
      {
        result["result"] = jsonObject
      }
    }

    return result
  } catch {
    print("kbTc9aWcyXAT6lMx error: \(error)")
    return nil
  }
}

/// 上报设备信息接口
func ls4bKxJfVocTsh5a(_ page: Int) async -> [String: Any]? {
  let client = ABEA3gxIgOEym1RM()

  let parameters: [String: Any] = [
    "useSimCard": 1,
    "useVpn": page,
    "language": kBeecYCHpzEIbBtR,
    "otherAppNames": ZDHLLBxofCahBpud,
    "timezonet": R9cLZIY6yOMykwp5,
    "keyboardsk": jKTDKbmOLjzrW6iT,
    "debug": 0,
      // "eBZvK99mZq7FK1GJd": 1,
      // "Rp4YZkFeIumsexyPn": page,
      // "gaQWnzPJSYW59o8Je": kBeecYCHpzEIbBtR,
      // "hwVuTWXN4Dz9Atfrs": ZDHLLBxofCahBpud,
      // "dyoOYgr5tNGu5vzHt": R9cLZIY6yOMykwp5,
      // "WisJMW6DfsaFftSIk": jKTDKbmOLjzrW6iT,
      // "T6pK5pchA9lptPg9g": 0,
  ]

  do {
    var result = try await client.zxBKcoOyJz34bI7X("/opi/v1/g0xk7AIKReR3NtVgo", parameters)

    // 如果 result 字段是字符串，尝试解密并解析
    if let resultString = result["result"] as? String {
      let decrypted = resultString.KgSIFXgdBaO8wk5X()
      if let jsonData = decrypted.data(using: .utf8),
        let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
      {
        result["result"] = jsonObject
      }
    }

    print("ls4bKxJfVocTsh5a decrypted result: \(result)")

    return result
  } catch {
    print("ls4bKxJfVocTsh5a error: \(error)")
    return nil
  }
}

/// 其他接口
func k0ylaZ679SYzEJSUT(_ parameter: String) async -> [String: Any]? {
  let client = ABEA3gxIgOEym1RM()

  let parameters: [String: Any] = [
    "lwMI5UF4xHhThyNOo": parameter
  ]

  do {
    return try await client.zxBKcoOyJz34bI7X("/opi/v1/h93zVfVzGe6vBHhQt", parameters)
  } catch {
    print("k0ylaZ679SYzEJSUT error: \(error)")
    return nil
  }
}

/// 支付验证接口
/// 对应 Flutter: Future<bool> vAWWpfx9YFkwV6Gn(PurchaseDetails qXOnFP7agDzDxVv5)
/// - Parameters:
///   - purchaseID: 购买ID，对应 Flutter: qXOnFP7agDzDxVv5.purchaseID
///   - serverVerificationData: 服务器验证数据，对应 Flutter: qXOnFP7agDzDxVv5.verificationData.serverVerificationData
///   - orderCode: 订单代码，对应 Flutter: FlW0vlw1jBvjx3hy().zU4ZT5YgrXaPLm7p
/// - Returns: 验证是否成功（code == "0000"）
func vAWWpfx9YFkwV6Gn(
  purchaseID: String?,
  serverVerificationData: String,
  orderCode: String
) async -> Bool {
  // 对应 Flutter: final N9QOopxG3Nz5Hh4M = ABEA3gxIgOEym1RM();
  let client = ABEA3gxIgOEym1RM()

  // 对应 Flutter: Map<String, dynamic> y46AIvf4wrajrT7C = {"orderCode": FlW0vlw1jBvjx3hy().zU4ZT5YgrXaPLm7p};
  let orderCodeDict: [String: Any] = ["orderCode": orderCode]

  // 对应 Flutter: jsonEncode(y46AIvf4wrajrT7C)
  // 将 orderCode 字典编码为 JSON 字符串
  guard let orderCodeJson = try? JSONSerialization.data(withJSONObject: orderCodeDict),
    let orderCodeString = String(data: orderCodeJson, encoding: .utf8)
  else {
    print("❌ [vAWWpfx9YFkwV6Gn] orderCode JSON 编码失败")
    return false
  }

  // 对应 Flutter: final Map<String, dynamic> WafcjTvxD8tTFtdZ = {
  //   "Vgl1hwz8pzJjgjrTt": zMDCweMG44SNT36J,
  //   "e9yJO0XcAThO1sIfdp": yQfs7fsh3WfRbS8Z.serverVerificationData,
  //   "n6sSXJeSKYkEIc05yc": jsonEncode(y46AIvf4wrajrT7C),
  // };
  let parameters: [String: Any] = [
    "Vgl1hwz8pzJjgjrTt": purchaseID ?? "",  // 对应 Flutter: zMDCweMG44SNT36J (purchaseID)
    "e9yJO0XcAThO1sIfdp": serverVerificationData,  // 对应 Flutter: yQfs7fsh3WfRbS8Z.serverVerificationData
    "n6sSXJeSKYkEIc05yc": orderCodeString,  // 对应 Flutter: jsonEncode(y46AIvf4wrajrT7C)
  ]

  print("🔍 [vAWWpfx9YFkwV6Gn] parameters: \(parameters)")

  // 对应 Flutter: final n5SC7IngyXHexm4l = await N9QOopxG3Nz5Hh4M.zxBKcoOyJz34bI7X('/opi/v1/xTHFBEEhPNGcB3NPp', WafcjTvxD8tTFtdZ);
  // 添加调试日志，查看实际发送的数据
  print("🔍 [vAWWpfx9YFkwV6Gn] 发送验证请求:")
  print("   - purchaseID: \(purchaseID ?? "nil")")
  print("   - serverVerificationData 长度: \(serverVerificationData.count) 字符")
  print("   - serverVerificationData 前100字符: \(String(serverVerificationData.prefix(100)))")
  print("   - orderCode: \(orderCode)")

  do {
    let result = try await client.zxBKcoOyJz34bI7X("/opi/v1/xTHFBEEhPNGcB3NPp", parameters)
    print(" 🔍 [vAWWpfx9YFkwV6Gn] result: \(result)")

    // 对应 Flutter: return n5SC7IngyXHexm4l['code'] == '0000';
    if let code = result["code"] as? String {
      let isValid = code == "0000"
      if isValid {
        print("✅ [vAWWpfx9YFkwV6Gn] 支付验证成功")
      } else {
        print("❌ [vAWWpfx9YFkwV6Gn] 支付验证失败，返回码: \(code)")
        // 打印服务器返回的详细信息（如果有）
        if let message = result["message"] as? String {
          print("   - 错误信息: \(message)")
        }
        if let data = result["data"] {
          print("   - 返回数据: \(data)")
        }
      }
      return isValid
    }

    print("❌ [vAWWpfx9YFkwV6Gn] 服务器返回格式错误，缺少 code 字段")
    return false
  } catch {
    // 对应 Flutter: catch (v7SvYeNlfnWHKoGaH) { return false; }
    print("❌ [vAWWpfx9YFkwV6Gn] 验证请求失败: \(error)")
    return false
  }
}
