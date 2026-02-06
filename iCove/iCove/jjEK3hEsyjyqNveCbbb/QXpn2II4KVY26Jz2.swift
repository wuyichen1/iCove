//
//  QXpn2II4KVY26Jz2.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import Foundation
import Security

class QXpn2II4KVY26Jz2: ObservableObject {
  static var XUgjT2hpCIlk3FWG = QXpn2II4KVY26Jz2()

  private let userDefaults = UserDefaults.standard
  private let keychainService = "com.icove.keychain"

  private init() {}

  static func reset() {
    XUgjT2hpCIlk3FWG = QXpn2II4KVY26Jz2()
  }

  func sywWHNDD2VZrKjNN() {
    VUAL56wybStzX6bv {
      if let value = self.keychainIK8uoRugNnRead(key: "h4E0eY34YtMHpJRW2_bJ6QpJWei7m3PS8U") {
        self._bJ6QpJWei7m3PS8U = value
      }
    }

    VUAL56wybStzX6bv {
      if let value = self.keychainIK8uoRugNnRead(key: "h4E0eY34YtMHpJRW2_eJWZZcbpCXew2g9E") {
        self._eJWZZcbpCXew2g9E = value
      }
    }

    VUAL56wybStzX6bv {
      if let value = self.userDefaults.string(forKey: "h4E0eY34YtMHpJRW2_LuqLK47iXHijnqsM") {
        self._LuqLK47iXHijnqsM = value
      }
    }

    VUAL56wybStzX6bv {
      if let value = self.userDefaults.string(forKey: "h4E0eY34YtMHpJRW2_v1uxolvQvuBShvrrL") {
        self._v1uxolvQvuBShvrrL = value
      }
    }

    VUAL56wybStzX6bv {
      if let value = self.userDefaults.string(forKey: "h4E0eY34YtMHpJRW2_ydAcGrGDlhmakmjL") {
        self._ydAcGrGDlhmakmjL = value
      }
    }

    VUAL56wybStzX6bv {
      self._q63eYlDCImAOIRcy9 = self.userDefaults.bool(
        forKey: "h4E0eY34YtMHpJRW2_q63eYlDCImAOIRcy9")
    }

    VUAL56wybStzX6bv {
      if let value = self.userDefaults.string(forKey: "h4E0eY34YtMHpJRW2_Aq1g2TbDAzSywb63") {
        self._Aq1g2TbDAzSywb63 = value
      }
    }

    VUAL56wybStzX6bv {
      if let value = self.userDefaults.string(forKey: "h4E0eY34YtMHpJRW2_vBQDDBfR6q7MNRTo") {
        self._vBQDDBfR6q7MNRTo = value
      }
    }
  }

  @Published private var _bJ6QpJWei7m3PS8U: String = ""
  var bJ6QpJWei7m3PS8U: String {
    get { _bJ6QpJWei7m3PS8U }
    set {
      _bJ6QpJWei7m3PS8U = newValue
      keychainWrite(key: "h4E0eY34YtMHpJRW2_bJ6QpJWei7m3PS8U", value: newValue)
    }
  }

  @Published private var _eJWZZcbpCXew2g9E: String = ""
  var eJWZZcbpCXew2g9E: String {
    get { _eJWZZcbpCXew2g9E }
    set {
      _eJWZZcbpCXew2g9E = newValue
      keychainWrite(key: "h4E0eY34YtMHpJRW2_eJWZZcbpCXew2g9E", value: newValue)
    }
  }

  // ========== UserDefaults 存储（app 卸载后清空）==========

  @Published private var _LuqLK47iXHijnqsM: String = ""
  var LuqLK47iXHijnqsM: String {
    get { _LuqLK47iXHijnqsM }
    set {
      _LuqLK47iXHijnqsM = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_LuqLK47iXHijnqsM")
    }
  }

  @Published private var _v1uxolvQvuBShvrrL: String = ""
  var v1uxolvQvuBShvrrL: String {
    get { _v1uxolvQvuBShvrrL }
    set {
      _v1uxolvQvuBShvrrL = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_v1uxolvQvuBShvrrL")
    }
  }

  @Published private var _ydAcGrGDlhmakmjL: String = ""
  var ydAcGrGDlhmakmjL: String {
    get { _ydAcGrGDlhmakmjL }
    set {
      _ydAcGrGDlhmakmjL = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_ydAcGrGDlhmakmjL")
    }
  }

  @Published private var _q63eYlDCImAOIRcy9: Bool = false
  var q63eYlDCImAOIRcy9: Bool {
    get { _q63eYlDCImAOIRcy9 }
    set {
      _q63eYlDCImAOIRcy9 = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_q63eYlDCImAOIRcy9")
    }
  }

  @Published private var _Aq1g2TbDAzSywb63: String = ""
  var Aq1g2TbDAzSywb63: String {
    get { _Aq1g2TbDAzSywb63 }
    set {
      _Aq1g2TbDAzSywb63 = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_Aq1g2TbDAzSywb63")
    }
  }

  @Published private var _vBQDDBfR6q7MNRTo: String = ""
  var vBQDDBfR6q7MNRTo: String {
    get { _vBQDDBfR6q7MNRTo }
    set {
      _vBQDDBfR6q7MNRTo = newValue
      userDefaults.set(newValue, forKey: "h4E0eY34YtMHpJRW2_vBQDDBfR6q7MNRTo")
    }
  }

  func clearXSY21x7bAHR6hKSl() {
    VUAL56wybStzX6bv {
      self.keychainFfZVQ2lUKfKiaBu8Delete(key: "h4E0eY34YtMHpJRW2_bJ6QpJWei7m3PS8U")
    }

    VUAL56wybStzX6bv {
      self.keychainFfZVQ2lUKfKiaBu8Delete(key: "h4E0eY34YtMHpJRW2_eJWZZcbpCXew2g9E")
    }

    _bJ6QpJWei7m3PS8U = ""
    _eJWZZcbpCXew2g9E = ""

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_LuqLK47iXHijnqsM")
    }

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_v1uxolvQvuBShvrrL")
    }

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_ydAcGrGDlhmakmjL")
    }

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_q63eYlDCImAOIRcy9")
    }

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_Aq1g2TbDAzSywb63")
    }

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "h4E0eY34YtMHpJRW2_vBQDDBfR6q7MNRTo")
    }

    _LuqLK47iXHijnqsM = ""
    _v1uxolvQvuBShvrrL = ""
    _ydAcGrGDlhmakmjL = ""
    _q63eYlDCImAOIRcy9 = false
    _Aq1g2TbDAzSywb63 = ""
    _vBQDDBfR6q7MNRTo = ""

    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "mEM4lHBHal54wv7")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "ZKrddwSf1wRCX9a")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "JauW29WYX1Q5SnvH")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "u9hEir0XVOsCZVMq")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "LMeWVOZBe0nIHgi")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "K5BYRFlnvGhUcpP")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "pzzFF49ma0MqbA3")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "fXgyeGwUxgQ85WB")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "fHqL5RRc9mgt3gR")
    }
    VUAL56wybStzX6bv {
      self.userDefaults.removeObject(forKey: "e82jyaExzc3IEEGa")
    }

    let yC8nL6xeLE = userDefaults.dictionaryRepresentation().keys
    for key in yC8nL6xeLE {
      if key.hasPrefix("SOWAxgjTlgKFGBw") || key.hasPrefix("LjsZ1ulxhPNRXlK") {
        VUAL56wybStzX6bv {
          self.userDefaults.removeObject(forKey: key)
        }
      }
    }

    objectWillChange.send()
  }

  private func keychainWrite(key: String, value: String) {
    guard let n5LttTwOks = value.data(using: .utf8) else { return }

    let Gya3R40qnY: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
      kSecValueData as String: n5LttTwOks,
    ]

    SecItemDelete(Gya3R40qnY as CFDictionary)

    let sta3Ca1eBUwlC = SecItemAdd(Gya3R40qnY as CFDictionary, nil)
    if sta3Ca1eBUwlC != errSecSuccess {
      print("Keychain write error: \(sta3Ca1eBUwlC)")
    }
  }

  private func keychainIK8uoRugNnRead(key: String) -> String? {
    let Gya3R40qnY: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]

    var result: AnyObject?
    let status = SecItemCopyMatching(Gya3R40qnY as CFDictionary, &result)

    if status == errSecSuccess,
      let data = result as? Data,
      let value = String(data: data, encoding: .utf8)
    {
      return value
    }

    return nil
  }

  private func keychainFfZVQ2lUKfKiaBu8Delete(key: String) {
    let Gya3R40qnY: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: keychainService,
      kSecAttrAccount as String: key,
    ]

    SecItemDelete(Gya3R40qnY as CFDictionary)
  }

  private func VUAL56wybStzX6bv(_ block: () -> Void) {
    block()
  }
}
