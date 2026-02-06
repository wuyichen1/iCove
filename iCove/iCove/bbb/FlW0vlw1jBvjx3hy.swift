//
//  FlW0vlw1jBvjx3hy.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import Foundation
import Security

class FlW0vlw1jBvjx3hy: ObservableObject {
  static var EN6tBVb4ZAvwC626 = FlW0vlw1jBvjx3hy()

  private let userDefaults = UserDefaults.standard
  private let keychainService = "com.icove.keychain"

  private init() {}

  static func reset() {
    EN6tBVb4ZAvwC626 = FlW0vlw1jBvjx3hy()
  }

  // MARK: - 初始化方法，从存储中加载数据
  func r38wmZLXCKtowlhOi() {
    // ========== Keychain 存储（app 卸载后保留）==========
    // deviceNo - 设备编号
    f5bTn6KcVxO9H2hnd {
      if let value = self.keychainRead(key: "lzfv9XjVb4TLWrcJ_A9ey5jWayK2kXWSs") {
        self._A9ey5jWayK2kXWSs = value
      }
    }

    // password - 密码
    f5bTn6KcVxO9H2hnd {
      if let value = self.keychainRead(key: "lzfv9XjVb4TLWrcJ_c307dPw24ADsTmm4") {
        self._c307dPw24ADsTmm4 = value
      }
    }

    // ========== UserDefaults 存储（app 卸载后清空）==========
    // loginToken - 登录令牌
    f5bTn6KcVxO9H2hnd {
      if let value = self.userDefaults.string(forKey: "lzfv9XjVb4TLWrcJ_RSCXzxe50iMJy6XN") {
        self._RSCXzxe50iMJy6XN = value
      }
    }

    // deviceName - 设备名称
    f5bTn6KcVxO9H2hnd {
      if let value = self.userDefaults.string(forKey: "lzfv9XjVb4TLWrcJ_Wt5fBRQ1ZDlBImWI") {
        self._Wt5fBRQ1ZDlBImWI = value
      }
    }

    // pushToken - 推送令牌
    f5bTn6KcVxO9H2hnd {
      if let value = self.userDefaults.string(forKey: "lzfv9XjVb4TLWrcJ_mmnN2bMkxLm3iqBA") {
        self._mmnN2bMkxLm3iqBA = value
      }
    }

    // isAorB - B 包标识
    f5bTn6KcVxO9H2hnd {
      self._q63eYlDCImAOIRcy9 = self.userDefaults.bool(forKey: "lzfv9XjVb4TLWrcJ_q63eYlDCImAOIRcy9")
    }

    // h5URL - H5 页面 URL
    f5bTn6KcVxO9H2hnd {
      if let value = self.userDefaults.string(forKey: "lzfv9XjVb4TLWrcJ_OELE4j718z5bTKXa") {
        self._OELE4j718z5bTKXa = value
      }
    }

    // orderCode - 订单代码
    f5bTn6KcVxO9H2hnd {
      if let value = self.userDefaults.string(forKey: "lzfv9XjVb4TLWrcJ_zU4ZT5YgrXaPLm7p") {
        self._zU4ZT5YgrXaPLm7p = value
      }
    }
  }

  // MARK: - 持久化变量定义

  // ========== Keychain 存储（app 卸载后保留）==========

  // MARK: - deviceNo
  /// 设备编号 - 存储在 Keychain，app 卸载后保留
  @Published private var _A9ey5jWayK2kXWSs: String = ""
  var A9ey5jWayK2kXWSs: String {
    get { _A9ey5jWayK2kXWSs }
    set {
      _A9ey5jWayK2kXWSs = newValue
      keychainWrite(key: "lzfv9XjVb4TLWrcJ_A9ey5jWayK2kXWSs", value: newValue)
    }
  }

  // MARK: - password
  /// 密码 - 存储在 Keychain，app 卸载后保留
  @Published private var _c307dPw24ADsTmm4: String = ""
  var c307dPw24ADsTmm4: String {
    get { _c307dPw24ADsTmm4 }
    set {
      _c307dPw24ADsTmm4 = newValue
      keychainWrite(key: "lzfv9XjVb4TLWrcJ_c307dPw24ADsTmm4", value: newValue)
    }
  }

  // ========== UserDefaults 存储（app 卸载后清空）==========

  // MARK: - loginToken
  /// 登录令牌 - 存储在 UserDefaults，app 卸载后清空
  @Published private var _RSCXzxe50iMJy6XN: String = ""
  var RSCXzxe50iMJy6XN: String {
    get { _RSCXzxe50iMJy6XN }
    set {
      _RSCXzxe50iMJy6XN = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_RSCXzxe50iMJy6XN")
    }
  }

  // MARK: - deviceName
  /// 设备名称 - 存储在 UserDefaults，app 卸载后清空
  @Published private var _Wt5fBRQ1ZDlBImWI: String = ""
  var Wt5fBRQ1ZDlBImWI: String {
    get { _Wt5fBRQ1ZDlBImWI }
    set {
      _Wt5fBRQ1ZDlBImWI = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_Wt5fBRQ1ZDlBImWI")
    }
  }

  // MARK: - pushToken
  /// 推送令牌 - 存储在 UserDefaults，app 卸载后清空
  @Published private var _mmnN2bMkxLm3iqBA: String = ""
  var mmnN2bMkxLm3iqBA: String {
    get { _mmnN2bMkxLm3iqBA }
    set {
      _mmnN2bMkxLm3iqBA = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_mmnN2bMkxLm3iqBA")
    }
  }

  // MARK: - isAorB
  /// B 包标识 - 存储在 UserDefaults，app 卸载后清空
  @Published private var _q63eYlDCImAOIRcy9: Bool = false
  var q63eYlDCImAOIRcy9: Bool {
    get { _q63eYlDCImAOIRcy9 }
    set {
      _q63eYlDCImAOIRcy9 = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_q63eYlDCImAOIRcy9")
    }
  }

  // MARK: - h5URL
  /// H5 页面 URL - 存储在 UserDefaults，app 卸载后清空
  @Published private var _OELE4j718z5bTKXa: String = ""
  var OELE4j718z5bTKXa: String {
    get { _OELE4j718z5bTKXa }
    set {
      _OELE4j718z5bTKXa = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_OELE4j718z5bTKXa")
    }
  }

  // MARK: - orderCode
  /// 订单代码 - 存储在 UserDefaults，app 卸载后清空
  @Published private var _zU4ZT5YgrXaPLm7p: String = ""
  var zU4ZT5YgrXaPLm7p: String {
    get { _zU4ZT5YgrXaPLm7p }
    set {
      _zU4ZT5YgrXaPLm7p = newValue
      userDefaults.set(newValue, forKey: "lzfv9XjVb4TLWrcJ_zU4ZT5YgrXaPLm7p")
    }
  }

  // MARK: - 清空所有持久化变量
  /// 清空所有持久化数据（包括 Keychain 和 UserDefaults）
  /// 注意：此方法会清空所有数据，包括正常情况下 app 卸载后保留的数据
  func clearAllPersistentData() {
    // ========== 清空 Keychain 中的数据（正常情况下 app 卸载后保留）==========
    // deviceNo
    f5bTn6KcVxO9H2hnd {
      self.keychainDelete(key: "lzfv9XjVb4TLWrcJ_A9ey5jWayK2kXWSs")
    }
    // password
    f5bTn6KcVxO9H2hnd {
      self.keychainDelete(key: "lzfv9XjVb4TLWrcJ_c307dPw24ADsTmm4")
    }

    // 重置内存中的 Keychain 变量
    _A9ey5jWayK2kXWSs = ""
    _c307dPw24ADsTmm4 = ""

    // ========== 清空 UserDefaults 中的数据（app 卸载后自动清空）==========
    // loginToken
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_RSCXzxe50iMJy6XN")
    }
    // deviceName
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_Wt5fBRQ1ZDlBImWI")
    }
    // pushToken
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_mmnN2bMkxLm3iqBA")
    }
    // isAorB
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_q63eYlDCImAOIRcy9")
    }
    // h5URL
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_OELE4j718z5bTKXa")
    }
    // orderCode
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "lzfv9XjVb4TLWrcJ_zU4ZT5YgrXaPLm7p")
    }

    // 重置内存中的 UserDefaults 变量
    _RSCXzxe50iMJy6XN = ""
    _Wt5fBRQ1ZDlBImWI = ""
    _mmnN2bMkxLm3iqBA = ""
    _q63eYlDCImAOIRcy9 = false
    _OELE4j718z5bTKXa = ""
    _zU4ZT5YgrXaPLm7p = ""

    // 清空 S8cv8K9JPIx0O81sStorage 中的所有数据
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "mEM4lHBHal54wv7")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "ZKrddwSf1wRCX9a")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "JauW29WYX1Q5SnvH")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "u9hEir0XVOsCZVMq")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "LMeWVOZBe0nIHgi")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "K5BYRFlnvGhUcpP")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "pzzFF49ma0MqbA3")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "fXgyeGwUxgQ85WB")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "fHqL5RRc9mgt3gR")
    }
    f5bTn6KcVxO9H2hnd {
      self.userDefaults.removeObject(forKey: "e82jyaExzc3IEEGa")
    }

    // 清空所有以 'SOWAxgjTlgKFGBw' 和 'LjsZ1ulxhPNRXlK' 开头的键
    let allKeys = userDefaults.dictionaryRepresentation().keys
    for key in allKeys {
      if key.hasPrefix("SOWAxgjTlgKFGBw") || key.hasPrefix("LjsZ1ulxhPNRXlK") {
        f5bTn6KcVxO9H2hnd {
          self.userDefaults.removeObject(forKey: key)
        }
      }
    }

    objectWillChange.send()
  }

  // MARK: - Keychain 操作方法
  /// 注意：Keychain 中存储的数据在 app 卸载后仍会保留（除非用户手动删除）

  /// 写入 Keychain
  /// 数据存储在 Keychain 中，app 卸载后仍会保留
  private func keychainWrite(key: String, value: String) {
    guard let data = value.data(using: .utf8) else { return }

    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
      kSecValueData as String: data,
    ]

    // 先删除旧值
    SecItemDelete(query as CFDictionary)

    // 添加新值
    let status = SecItemAdd(query as CFDictionary, nil)
    if status != errSecSuccess {
      print("Keychain write error: \(status)")
    }
  }

  /// 从 Keychain 读取
  private func keychainRead(key: String) -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]

    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)

    if status == errSecSuccess,
      let data = result as? Data,
      let value = String(data: data, encoding: .utf8)
    {
      return value
    }

    return nil
  }

  /// 从 Keychain 删除
  private func keychainDelete(key: String) {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
    ]

    SecItemDelete(query as CFDictionary)
  }

  // MARK: - 错误处理辅助方法
  private func f5bTn6KcVxO9H2hnd(_ block: () -> Void) {
    block()
  }
}
