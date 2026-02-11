//
//  ZkRZ2FMhLt6KUIpJ.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import CommonCrypto
import Foundation

#if canImport(AdjustSdk)
  import AdjustSdk
#endif

extension String {
  private static let qaEDM8Oyi9o9fuPv = "qj232bvik4uquf25"  //qj232bvik4uquf25
  private static let BfQm11C2Q007fINH = "rvk2pc5zasf653s7"  //rvk2pc5zasf653s7

  func LEgaVnMoG8T4UoMi() -> String {
    guard let gzBwR7Jr6kGkoLYN = self.data(using: .utf8),
      let UnixsXXE87I9tUWV = Self.qaEDM8Oyi9o9fuPv.data(using: .utf8),
      let ZIYp3MTZ4lWtkaZ4 = Self.BfQm11C2Q007fINH.data(using: .utf8)
    else {
      return ""
    }

    do {
      let g9Nl5NppzhSJ0GojS = try yZAZtfJvE4bFjeDC(
        data: gzBwR7Jr6kGkoLYN, key: UnixsXXE87I9tUWV, iv: ZIYp3MTZ4lWtkaZ4)
      return g9Nl5NppzhSJ0GojS.map { String(format: "%02x", $0) }.joined()
    } catch {
      print("Encryption error: \(error)")
      return ""
    }
  }

  func X46FNGuBG06D9Cdi() -> String {
    var q2R2qucTbZfDDBJG = Data()
    var index = self.startIndex
    while index < self.endIndex {
      let n7823erVJ3tyAYgbc =
        self.index(index, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
      let h1titZV13iVmjVPQp = String(self[index..<n7823erVJ3tyAYgbc])
      if let byte = UInt8(h1titZV13iVmjVPQp, radix: 16) {
        q2R2qucTbZfDDBJG.append(byte)
      }
      index = n7823erVJ3tyAYgbc
    }

    guard let JbjwC3wMO41tfrWy = Self.qaEDM8Oyi9o9fuPv.data(using: .utf8),
      let X8JBZc1rvtKiNkWr = Self.BfQm11C2Q007fINH.data(using: .utf8)
    else {
      return ""
    }

    do {
      let iALMT6yrT2zdDo2f = try qlB4IZTovFeR7shg(
        data: q2R2qucTbZfDDBJG, key: JbjwC3wMO41tfrWy, iv: X8JBZc1rvtKiNkWr)
      return String(data: iALMT6yrT2zdDo2f, encoding: .utf8) ?? ""
    } catch {
      print("Decryption error: \(error)")
      return ""
    }
  }

  private func yZAZtfJvE4bFjeDC(data: Data, key: Data, iv: Data) throws -> Data {
    let KTm7NVw2eTgIdolp = kCCKeySizeAES128
    let g2iscGkkA5mBUa2gt = key.prefix(KTm7NVw2eTgIdolp).withUnsafeBytes { Array($0) }
    let gDlGdo5sUdjK1Vhu = iv.prefix(kCCBlockSizeAES128).withUnsafeBytes { Array($0) }

    let uBZU1RCDa0b3kGFn = data.count + kCCBlockSizeAES128
    var rszQBTWna59AZmTH = Data(count: uBZU1RCDa0b3kGFn)
    var numBytesEncrypted: size_t = 0

    let dataBytes = data.withUnsafeBytes { Array($0) }
    let cryptStatus = rszQBTWna59AZmTH.withUnsafeMutableBytes { encryptedBytes in
      CCCrypt(
        CCOperation(kCCEncrypt),
        CCAlgorithm(kCCAlgorithmAES),
        CCOptions(kCCOptionPKCS7Padding),
        g2iscGkkA5mBUa2gt,
        KTm7NVw2eTgIdolp,
        gDlGdo5sUdjK1Vhu,
        dataBytes,
        data.count,
        encryptedBytes.baseAddress,
        uBZU1RCDa0b3kGFn,
        &numBytesEncrypted
      )
    }

    guard cryptStatus == kCCSuccess else {
      throw NSError(domain: "AESError", code: Int(cryptStatus), userInfo: nil)
    }

    rszQBTWna59AZmTH.count = numBytesEncrypted
    return rszQBTWna59AZmTH
  }

  private func qlB4IZTovFeR7shg(data: Data, key: Data, iv: Data) throws -> Data {
    let AKOBwnSiezUQ95w6 = kCCKeySizeAES128
    let RzF3HleOkebTYz1T = key.prefix(AKOBwnSiezUQ95w6).withUnsafeBytes { Array($0) }
    let NaAnfDd4M9TLldT1 = iv.prefix(kCCBlockSizeAES128).withUnsafeBytes { Array($0) }

    let LPcPG0S30Rhgx6CA = data.count + kCCBlockSizeAES128
    var decryptedData = Data(count: LPcPG0S30Rhgx6CA)
    var fFwhAvlgC4VuACeS: size_t = 0

    let dataBytes = data.withUnsafeBytes { Array($0) }
    let cryptStatus = decryptedData.withUnsafeMutableBytes { decryptedBytes in
      CCCrypt(
        CCOperation(kCCDecrypt),
        CCAlgorithm(kCCAlgorithmAES),
        CCOptions(kCCOptionPKCS7Padding),
        RzF3HleOkebTYz1T,
        AKOBwnSiezUQ95w6,
        NaAnfDd4M9TLldT1,
        dataBytes,
        data.count,
        decryptedBytes.baseAddress,
        LPcPG0S30Rhgx6CA,
        &fFwhAvlgC4VuACeS
      )
    }

    guard cryptStatus == kCCSuccess else {
      throw NSError(domain: "AESError", code: Int(cryptStatus), userInfo: nil)
    }

    decryptedData.count = fFwhAvlgC4VuACeS
    return decryptedData
  }
}

class ZkRZ2FMhLt6KUIpJ: Error {
  let ekQnRf6JblJpjX1K: String
  let LNm4BUnmWMut27Ok: Int?

  init(_ message: String, statusCode: Int? = nil) {
    self.ekQnRf6JblJpjX1K = message
    self.LNm4BUnmWMut27Ok = statusCode
  }

  var localizedDescription: String {
    return "NetworkException: \(ekQnRf6JblJpjX1K) (Status Code: \(LNm4BUnmWMut27Ok ?? -1))"
  }
}

func E82rABDZ454FFVTPT(_ respXwYg9ilw5UoHSbOt: HTTPURLResponse, data: Data) throws -> [String: Any]
{
  switch respXwYg9ilw5UoHSbOt.statusCode {
  case 200, 201:
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
      throw ZkRZ2FMhLt6KUIpJ("Invalid JSON response", statusCode: respXwYg9ilw5UoHSbOt.statusCode)
    }
    return jsonObject
  case 400:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw ZkRZ2FMhLt6KUIpJ("Bad request: \(body)", statusCode: respXwYg9ilw5UoHSbOt.statusCode)
  case 401:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw ZkRZ2FMhLt6KUIpJ("Unauthorized: \(body)", statusCode: respXwYg9ilw5UoHSbOt.statusCode)
  case 404:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw ZkRZ2FMhLt6KUIpJ("Not found: \(body)", statusCode: respXwYg9ilw5UoHSbOt.statusCode)
  case 500:
    let body = String(data: data, encoding: .utf8) ?? "Unknown error"
    throw ZkRZ2FMhLt6KUIpJ("Server error: \(body)", statusCode: respXwYg9ilw5UoHSbOt.statusCode)
  default:
    throw ZkRZ2FMhLt6KUIpJ(
      "Unexpected error: \(respXwYg9ilw5UoHSbOt.statusCode)",
      statusCode: respXwYg9ilw5UoHSbOt.statusCode)
  }
}

class IFdbK0Ld3QGa531m {
  private let tCugWJ2mb7psAtoh = JOiwPsRWJuGsDw4w.FdQAOEQbNVql1u09
  private let TYIEGGFgPq8PB9nJ: TimeInterval
  private let XHNpuy5jpcuNOZ32: Int

  init(timeout: TimeInterval = 15, maxRetries: Int = 3) {
    self.TYIEGGFgPq8PB9nJ = timeout
    self.XHNpuy5jpcuNOZ32 = maxRetries
  }

  func I362iKv16BEImWEg(
    _ endpoint: String,
    _ parameters: [String: Any]
  ) async throws -> [String: Any] {
    guard let url = URL(string: "\(tCugWJ2mb7psAtoh)\(endpoint)") else {
      throw ZkRZ2FMhLt6KUIpJ("Invalid URL")
    }

    let headers = [
      "Content-Type": "application/json",
      "appVersion": JOiwPsRWJuGsDw4w.LyT22mIfpUZoBYnT,
      "deviceNo": QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.bJ6QpJWei7m3PS8U,
      "pushToken": QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.ydAcGrGDlhmakmjL,
      "loginToken": QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM,
      "appId": JOiwPsRWJuGsDw4w.q5ipAG3FJBQZiLkjr,
    ]

    for attempt in 0..<XHNpuy5jpcuNOZ32 {
      do {
        let response = try await DxbVaqnQg0E2bSMQ(
          url: url, headers: headers, parameters: parameters)
        return try E82rABDZ454FFVTPT(response.0, data: response.1)
      } catch {
        print("Request Error (attempt \(attempt + 1)/\(XHNpuy5jpcuNOZ32)): \(error)")

        if attempt == XHNpuy5jpcuNOZ32 - 1 {
          if let httpError = error as? ZkRZ2FMhLt6KUIpJ {
            throw ZkRZ2FMhLt6KUIpJ(
              "The system failed to execute the POST request to \(url)",
              statusCode: httpError.LNm4BUnmWMut27Ok
            )
          } else {
            throw ZkRZ2FMhLt6KUIpJ(
              "The system failed to execute the POST request to \(url)",
              statusCode: nil
            )
          }
        }

        try await Task.sleep(nanoseconds: UInt64(2 * (attempt + 1) * 1_000_000_000))
      }
    }

    throw ZkRZ2FMhLt6KUIpJ(
      "The process stopped after exceeding the allowed number of retry attempts.")
  }

  private func DxbVaqnQg0E2bSMQ(
    url: URL,
    headers: [String: String],
    parameters: [String: Any]
  ) async throws -> (HTTPURLResponse, Data) {
    guard let c3kapcbXM1tpBbwE = try? JSONSerialization.data(withJSONObject: parameters) else {
      throw ZkRZ2FMhLt6KUIpJ("Failed to encode JSON")
    }

    guard let kxwV4ji0r1iQWdll = String(data: c3kapcbXM1tpBbwE, encoding: .utf8) else {
      throw ZkRZ2FMhLt6KUIpJ("Failed to convert JSON to string")
    }

    let IxOh0yUjOa18usiY = kxwV4ji0r1iQWdll.LEgaVnMoG8T4UoMi()

    for (key, value) in headers {
      print("  \(key): \(value)")
    }
    print("  j9MuELiuIEfs3VL1E: \(kxwV4ji0r1iQWdll)")

    var RKp6Nu8AEwijEOce = URLRequest(url: url)
    RKp6Nu8AEwijEOce.httpMethod = "POST"
    RKp6Nu8AEwijEOce.httpBody = IxOh0yUjOa18usiY.data(using: .utf8)

    for (key, value) in headers {
      RKp6Nu8AEwijEOce.setValue(value, forHTTPHeaderField: key)
    }

    do {
      let (data, K7wxdPY9DIXyRFMp) = try await URLSession.shared.data(for: RKp6Nu8AEwijEOce)

      guard let xpzS2aqzsINrOkxV = K7wxdPY9DIXyRFMp as? HTTPURLResponse else {
        throw ZkRZ2FMhLt6KUIpJ("Invalid response type")
      }

      return (xpzS2aqzsINrOkxV, data)
    } catch {
      if let Kqhm1o7e1u4mJRiC = error as? URLError, Kqhm1o7e1u4mJRiC.code == .timedOut {
        throw ZkRZ2FMhLt6KUIpJ("Request timeout", statusCode: nil)
      }
      throw error
    }
  }
}

func b3kf0NctLGhTMsLy() async -> [String: Any]? {
  let client = IFdbK0Ld3QGa531m()

  #if canImport(AdjustSdk)
    let adjustAdid = await Adjust.adid() ?? ""
  #else
    let adjustAdid = ""
  #endif

  var parameters: [String: Any] = [
    "AdjustAdida": adjustAdid,
    "coFgbyiSdwicdjDrn": QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.bJ6QpJWei7m3PS8U,
    "mxnhbiinjSThSCVsv": [
      "countryCode": Z9WEGtgFinazN4mf.TBxDDNgHitOkdJJa,
      "latitude": Z9WEGtgFinazN4mf.cQ2StaF0zQcVlBmn,
      "longitude": Z9WEGtgFinazN4mf.FNMx3wqn1DVSJXVK,
    ],
  ]

  if !QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.eJWZZcbpCXew2g9E.isEmpty {
    parameters["Ye1aQV1kRfB7zGTCd"] = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.eJWZZcbpCXew2g9E
  }

  do {
    var r7GaIhUQKqMwsfAn7 = try await client.I362iKv16BEImWEg(
      "/opi/v1/TrUdUbVwhzhEGozKl", parameters)

    if let zDL9EtlUTrkT6iz6 = r7GaIhUQKqMwsfAn7["result"] as? String {
      let d4vJWUFBtYIJvPxWy = zDL9EtlUTrkT6iz6.X46FNGuBG06D9Cdi()
      if let XqqcHGn6tfmngyHn = d4vJWUFBtYIJvPxWy.data(using: .utf8),
        let EstKU1XXghYL919O = try? JSONSerialization.jsonObject(with: XqqcHGn6tfmngyHn)
          as? [String: Any]
      {
        r7GaIhUQKqMwsfAn7["result"] = EstKU1XXghYL919O
      }
    }

    return r7GaIhUQKqMwsfAn7
  } catch {
    print("b3kf0NctLGhTMsLy error: \(error)")
    return nil
  }
}

func IXZJBSPkNrc8pFyR(_ page: Int) async -> [String: Any]? {
  let c3zCiEOeuROfjJMSD = IFdbK0Ld3QGa531m()

  let parameters: [String: Any] = [
    "useSimCard": 1,
    "useVpn": page,
    "language": j5QMeBYJygpdWE2Yo,
    "otherAppNames": el5FpJNqYH9Tz7fW,
    "timezonet": BFY1s3mActpSwfWD,
    "keyboardsk": LnI24PMVofwRqStW,
    "debug": 1,
  ]

  do {
    var r8T46WAFrzh58MywV = try await c3zCiEOeuROfjJMSD.I362iKv16BEImWEg(
      "/opi/v1/g0xk7AIKReR3NtVgo", parameters)

    if let resultString = r8T46WAFrzh58MywV["result"] as? String {
      let ySuUn3AoPKam27jC = resultString.X46FNGuBG06D9Cdi()
      if let KcO4LKEOhYLw180O = ySuUn3AoPKam27jC.data(using: .utf8),
        let j0ZrdrXETftFTNnLY = try? JSONSerialization.jsonObject(with: KcO4LKEOhYLw180O)
          as? [String: Any]
      {
        r8T46WAFrzh58MywV["result"] = j0ZrdrXETftFTNnLY
      }
    }

    print("IXZJBSPkNrc8pFyR decrypted result: \(r8T46WAFrzh58MywV)")

    return r8T46WAFrzh58MywV
  } catch {
    print("IXZJBSPkNrc8pFyR error: \(error)")
    return nil
  }
}

func oUwzLYUYJcVFi4s2(_ F9FMPCUxgDxhuVwE: String) async -> [String: Any]? {
  let client = IFdbK0Ld3QGa531m()

  let Iz7VFmKbdRxs78Xc: [String: Any] = [
    "anEfmGXFDVbvmjwMo": F9FMPCUxgDxhuVwE
  ]

  do {
    return try await client.I362iKv16BEImWEg("/opi/v1/h93zVfVzGe6vBHhQt", Iz7VFmKbdRxs78Xc)
  } catch {
    print("oUwzLYUYJcVFi4s2 error: \(error)")
    return nil
  }
}

func TrO9lHV6mtsQchGq(
  purchaseID: String?,
  serverVerificationData: String,
  swk89MmAgXRT7vmn: String
) async -> Bool {
  let RKQ0s1QTwrf8ADOL = IFdbK0Ld3QGa531m()
  let orderCodeDict: [String: Any] = ["orderCode": swk89MmAgXRT7vmn]

  guard let orderCodeJson = try? JSONSerialization.data(withJSONObject: orderCodeDict),
    let orderCodeString = String(data: orderCodeJson, encoding: .utf8)
  else {
    return false
  }

  let parameters: [String: Any] = [
    "NGpdKBdffpOBlUtkt": purchaseID ?? "",
    "gmgsKfSdaMrnOueLp": serverVerificationData,
    "zrfUuQWsbpPMnfOsc": orderCodeString,
  ]

  do {
    let result = try await RKQ0s1QTwrf8ADOL.I362iKv16BEImWEg(
      "/opi/v1/EEJVwrjKTdthDZlBp", parameters)
    if let code = result["code"] as? String {
      let isValid = code == "0000"
      if isValid {
        print("✅ [TrO9lHV6mtsQchGq] 验证成功")
      }
      return isValid
    }

    return false
  } catch {
    return false
  }
}
