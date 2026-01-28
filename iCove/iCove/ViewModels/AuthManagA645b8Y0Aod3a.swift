//
//  AuthManagA645b8Y0Aod3aVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class AuthManagA645b8Y0Aod3aVmod: ObservableObject {
  @Published var isAutheda3IsmZzs015L5: Bool = false
  @Published var currvj9QRUUPOWY4Ouser: User?
  @Published var autokYcXLsqlQWQWjK: String?
  @Published var isQuickGgcGDklj5hieh: Bool = false

  private let a2G6DEvVF1x8NJ: Authsdmd0VXzbAnDYServProc
  private let d9BK8LqsPffmR = "wc4TJXJmEFsLa"
  private let ukeyhWcukRIm8bWHi = "curRh4jjFXw2Ervz"
  private let lotyiOnF5ZgtcBbPw = "lotypeVJlzq4JPi7gDw"  // "normal" 或 "quick"

  init(a2G6DEvVF1x8NJ: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared) {
    self.a2G6DEvVF1x8NJ = a2G6DEvVF1x8NJ
    lseoyWJn9Bqevdv()
  }

  func logini2AfORx9Y0cOC(Yc7aEPUWtsLiC: String, dbCMz0ksUEfDw: String) async throws {
    let HjBi0UAqQcXyR = try await a2G6DEvVF1x8NJ.loginTtLI36OScTp84(
      e8MRjCPXAu0wXY: Yc7aEPUWtsLiC, IRqSrQCED3nMk: dbCMz0ksUEfDw)

    SU6eGysGPjLGu(
      Wj7OeGJq6cFOu: HjBi0UAqQcXyR.xvoSkiukR4DXftoken,
      ORHPJ5pDd59cU: HjBi0UAqQcXyR.userVMVsqf1elekSw, isQuickLogin: false)
  }

  func registerPAms88DfTLWMl(Qjhs1UuEXxKto: String, AYVm1fJqgpm5W: String, dTzVtlmF1dSnU: String)
    async throws
  {
    let re3yZ25gxw1bBvw = try await a2G6DEvVF1x8NJ.registerPAms88DfTLWMl(
      Lp2UI0faMaN0D: Qjhs1UuEXxKto, IRqSrQCED3nMk: AYVm1fJqgpm5W, DoH2qI10b8Ovo: dTzVtlmF1dSnU)

    SU6eGysGPjLGu(
      Wj7OeGJq6cFOu: re3yZ25gxw1bBvw.xvoSkiukR4DXftoken,
      ORHPJ5pDd59cU: re3yZ25gxw1bBvw.userVMVsqf1elekSw, isQuickLogin: false
    )
  }

  func logoutWfSgkdWFVCXy1() async {
    if let t9PTMd4Gbkzl1s = autokYcXLsqlQWQWjK {
      try? await a2G6DEvVF1x8NJ.logoutWfSgkdWFVCXy1(tokene7boa6IniylQI: t9PTMd4Gbkzl1s)
    }

    let E3HsaYgeh67XY = isQuickGgcGDklj5hieh

    autokYcXLsqlQWQWjK = nil
    currvj9QRUUPOWY4Ouser = nil
    isAutheda3IsmZzs015L5 = false
    isQuickGgcGDklj5hieh = false

    PiLCTlmXA1kCW(z7fB01MZ63Q3q: E3HsaYgeh67XY)
  }

  func quickOomfaPN43DvOC() async throws {
    let rep2i8aZuIKj9Yu = try await a2G6DEvVF1x8NJ.quickOomfaPN43DvOC()

    SU6eGysGPjLGu(
      Wj7OeGJq6cFOu: rep2i8aZuIKj9Yu.xvoSkiukR4DXftoken,
      ORHPJ5pDd59cU: rep2i8aZuIKj9Yu.userVMVsqf1elekSw, isQuickLogin: true)
  }

  func updunamespsqxOby9PquA(_ n6pTcgK3Tb42c7: String) {
    guard var utUelp445pyQf = currvj9QRUUPOWY4Ouser else { return }
    utUelp445pyQf = User(
      id: utUelp445pyQf.id,
      eK8mN2pQ7rT9vW: utUelp445pyQf.eK8mN2pQ7rT9vW,
      uX4yZ6aB8cD0eF: n6pTcgK3Tb42c7,
      aG3hI5jK7lM9nO: utUelp445pyQf.aG3hI5jK7lM9nO,
      bP2qR4sT6uV8wX: utUelp445pyQf.bP2qR4sT6uV8wX,
      bY1zA3bC5dE7fG: utUelp445pyQf.bY1zA3bC5dE7fG,
      cP9hI1jK3lM5nO: utUelp445pyQf.cP9hI1jK3lM5nO,
      bQ7rS9tU1vW3xY: utUelp445pyQf.bQ7rS9tU1vW3xY,
      fZ5aB7cD9eF1gH: utUelp445pyQf.fZ5aB7cD9eF1gH,
      fI3jK5lM7nO9pQ: utUelp445pyQf.fI3jK5lM7nO9pQ
    )
    currvj9QRUUPOWY4Ouser = utUelp445pyQf
    percurVJbMlrKYhlnUG()

    a2G6DEvVF1x8NJ.upd39Yrqyc7YxrPf(utUelp445pyQf)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": utUelp445pyQf]
    )
  }

  func updavaiyCs1j96Lelzs(_ dXiRo5tf9N67G: UIImage) {
    guard var ldNRkTlXX6bN0 = currvj9QRUUPOWY4Ouser else { return }

    let KAdBujrN6znHJ = saavaMittISSXcDfzz(dXiRo5tf9N67G, uidiuW3QAEqba3c0: ldNRkTlXX6bN0.id)

    ldNRkTlXX6bN0 = User(
      id: ldNRkTlXX6bN0.id,
      eK8mN2pQ7rT9vW: ldNRkTlXX6bN0.eK8mN2pQ7rT9vW,
      uX4yZ6aB8cD0eF: ldNRkTlXX6bN0.uX4yZ6aB8cD0eF,
      aG3hI5jK7lM9nO: KAdBujrN6znHJ,
      bP2qR4sT6uV8wX: ldNRkTlXX6bN0.bP2qR4sT6uV8wX,
      bY1zA3bC5dE7fG: ldNRkTlXX6bN0.bY1zA3bC5dE7fG,
      cP9hI1jK3lM5nO: ldNRkTlXX6bN0.cP9hI1jK3lM5nO,
      bQ7rS9tU1vW3xY: ldNRkTlXX6bN0.bQ7rS9tU1vW3xY,
      fZ5aB7cD9eF1gH: ldNRkTlXX6bN0.fZ5aB7cD9eF1gH,
      fI3jK5lM7nO9pQ: ldNRkTlXX6bN0.fI3jK5lM7nO9pQ
    )
    currvj9QRUUPOWY4Ouser = ldNRkTlXX6bN0
    percurVJbMlrKYhlnUG()

    a2G6DEvVF1x8NJ.upd39Yrqyc7YxrPf(ldNRkTlXX6bN0)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": ldNRkTlXX6bN0]
    )
  }

  func toggleB2rGhFgSQb0qAcol(pid3rhTIg1jfRXQj: String) {
    guard var fcwH4uRl7V8JA = currvj9QRUUPOWY4Ouser else { return }

    var col5vnqqpKbznnp6 = fcwH4uRl7V8JA.cP9hI1jK3lM5nO
    if col5vnqqpKbznnp6.contains(pid3rhTIg1jfRXQj) {
      col5vnqqpKbznnp6.removeAll { $0 == pid3rhTIg1jfRXQj }
    } else {
      col5vnqqpKbznnp6.append(pid3rhTIg1jfRXQj)
    }

    fcwH4uRl7V8JA = User(
      id: fcwH4uRl7V8JA.id,
      eK8mN2pQ7rT9vW: fcwH4uRl7V8JA.eK8mN2pQ7rT9vW,
      uX4yZ6aB8cD0eF: fcwH4uRl7V8JA.uX4yZ6aB8cD0eF,
      aG3hI5jK7lM9nO: fcwH4uRl7V8JA.aG3hI5jK7lM9nO,
      bP2qR4sT6uV8wX: fcwH4uRl7V8JA.bP2qR4sT6uV8wX,
      bY1zA3bC5dE7fG: fcwH4uRl7V8JA.bY1zA3bC5dE7fG,
      cP9hI1jK3lM5nO: col5vnqqpKbznnp6,
      bQ7rS9tU1vW3xY: fcwH4uRl7V8JA.bQ7rS9tU1vW3xY,
      fZ5aB7cD9eF1gH: fcwH4uRl7V8JA.fZ5aB7cD9eF1gH,
      fI3jK5lM7nO9pQ: fcwH4uRl7V8JA.fI3jK5lM7nO9pQ
    )
    currvj9QRUUPOWY4Ouser = fcwH4uRl7V8JA
    percurVJbMlrKYhlnUG()

    a2G6DEvVF1x8NJ.upd39Yrqyc7YxrPf(fcwH4uRl7V8JA)

    NotificationCenter.default.post(
      name: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      userInfo: ["user": fcwH4uRl7V8JA]
    )

    NotificationCenter.default.post(
      name: NSNotification.Name("PostCollectionUpdated"),
      object: nil,
      userInfo: [
        "postId": pid3rhTIg1jfRXQj, "isCollected": !col5vnqqpKbznnp6.contains(pid3rhTIg1jfRXQj),
      ]
    )
  }

  func isColBbbiJ8jXV5fKI(pid3rhTIg1jfRXQj: String) -> Bool {
    return currvj9QRUUPOWY4Ouser?.cP9hI1jK3lM5nO.contains(pid3rhTIg1jfRXQj) ?? false
  }

  private func saavaMittISSXcDfzz(_ XABaG0S2kDB0v: UIImage, uidiuW3QAEqba3c0: String) -> String {
    let DMdt8vb32U4lI = "avatar_\(uidiuW3QAEqba3c0)_\(Int(Date().timeIntervalSince1970)).jpg"

    if let J9s7kEL4EZUuc = XABaG0S2kDB0v.jpegData(compressionQuality: 0.8) {
      let S9ZgjIzNbftX4 = FileManager.default.urls(
        for: .documentDirectory, in: .userDomainMask
      ).first!
      let ORQrVpyYXqjC5 = S9ZgjIzNbftX4.appendingPathComponent("UserImages")

      try? FileManager.default.createDirectory(
        at: ORQrVpyYXqjC5, withIntermediateDirectories: true, attributes: nil)

      let oJZDA0GZx1BfR = ORQrVpyYXqjC5.appendingPathComponent(DMdt8vb32U4lI)

      try? J9s7kEL4EZUuc.write(to: oJZDA0GZx1BfR)

      return DMdt8vb32U4lI
    }

    return ""
  }

  func addbanxsQVAH9mAY0ZZ(_ c9QfLE0LEg8b0: Int) {
    guard var WE93Ba4kitdoo = currvj9QRUUPOWY4Ouser else { return }
    WE93Ba4kitdoo = User(
      id: WE93Ba4kitdoo.id,
      eK8mN2pQ7rT9vW: WE93Ba4kitdoo.eK8mN2pQ7rT9vW,
      uX4yZ6aB8cD0eF: WE93Ba4kitdoo.uX4yZ6aB8cD0eF,
      aG3hI5jK7lM9nO: WE93Ba4kitdoo.aG3hI5jK7lM9nO,
      bP2qR4sT6uV8wX: WE93Ba4kitdoo.bP2qR4sT6uV8wX + c9QfLE0LEg8b0,
      bY1zA3bC5dE7fG: WE93Ba4kitdoo.bY1zA3bC5dE7fG,
      cP9hI1jK3lM5nO: WE93Ba4kitdoo.cP9hI1jK3lM5nO,
      bQ7rS9tU1vW3xY: WE93Ba4kitdoo.bQ7rS9tU1vW3xY,
      fZ5aB7cD9eF1gH: WE93Ba4kitdoo.fZ5aB7cD9eF1gH,
      fI3jK5lM7nO9pQ: WE93Ba4kitdoo.fI3jK5lM7nO9pQ
    )
    currvj9QRUUPOWY4Ouser = WE93Ba4kitdoo
    percurVJbMlrKYhlnUG()
  }

  func dedPlf7hXe73EGoR(_ a9tnwfZU4sRwZF: Int) {
    guard var la5RRKhhNNKbc = currvj9QRUUPOWY4Ouser else { return }
    let newBalance = max(0, la5RRKhhNNKbc.bP2qR4sT6uV8wX - a9tnwfZU4sRwZF)
    la5RRKhhNNKbc = User(
      id: la5RRKhhNNKbc.id,
      eK8mN2pQ7rT9vW: la5RRKhhNNKbc.eK8mN2pQ7rT9vW,
      uX4yZ6aB8cD0eF: la5RRKhhNNKbc.uX4yZ6aB8cD0eF,
      aG3hI5jK7lM9nO: la5RRKhhNNKbc.aG3hI5jK7lM9nO,
      bP2qR4sT6uV8wX: newBalance,
      bY1zA3bC5dE7fG: la5RRKhhNNKbc.bY1zA3bC5dE7fG,
      cP9hI1jK3lM5nO: la5RRKhhNNKbc.cP9hI1jK3lM5nO,
      bQ7rS9tU1vW3xY: la5RRKhhNNKbc.bQ7rS9tU1vW3xY,
      fZ5aB7cD9eF1gH: la5RRKhhNNKbc.fZ5aB7cD9eF1gH,
      fI3jK5lM7nO9pQ: la5RRKhhNNKbc.fI3jK5lM7nO9pQ
    )
    currvj9QRUUPOWY4Ouser = la5RRKhhNNKbc
    percurVJbMlrKYhlnUG()
  }

  func adSN1KPLAOgyALw(_ n2xr80LYPoFeC: String) {
    guard var MZ2U76C2WtQuV = currvj9QRUUPOWY4Ouser else { return }
    if !MZ2U76C2WtQuV.bQ7rS9tU1vW3xY.contains(n2xr80LYPoFeC) {
      MZ2U76C2WtQuV.bQ7rS9tU1vW3xY.append(n2xr80LYPoFeC)
      currvj9QRUUPOWY4Ouser = MZ2U76C2WtQuV
      percurVJbMlrKYhlnUG()
      NotificationCenter.default.post(
        name: NSNotification.Name("UserBlocked"), object: nil,
        userInfo: ["blockedUserId": n2xr80LYPoFeC])
    }
  }

  func reNRhAhnjCSdO8F(_ n2xr80LYPoFeC: String) {
    guard var aKuzxZhWbrAfe = currvj9QRUUPOWY4Ouser else { return }
    aKuzxZhWbrAfe.bQ7rS9tU1vW3xY.removeAll { $0 == n2xr80LYPoFeC }
    currvj9QRUUPOWY4Ouser = aKuzxZhWbrAfe
    percurVJbMlrKYhlnUG()
    NotificationCenter.default.post(
      name: NSNotification.Name("UserUnblocked"), object: nil,
      userInfo: ["unblockedUserId": n2xr80LYPoFeC]
    )
  }

  func delGwzevOwddsi6i() async throws {
    guard let fEm2xqeJt0e4c = currvj9QRUUPOWY4Ouser?.id else { return }

    try await a2G6DEvVF1x8NJ.NECwwAXsDrlrV(uid7xnFp9WG31Lwa: fEm2xqeJt0e4c)

    autokYcXLsqlQWQWjK = nil
    currvj9QRUUPOWY4Ouser = nil
    isAutheda3IsmZzs015L5 = false
    isQuickGgcGDklj5hieh = false
    PiLCTlmXA1kCW(z7fB01MZ63Q3q: false)
  }

  func adcol6OWHYe8mGyn86(_ pid3rhTIg1jfRXQj: String) {
    guard var ORHPJ5pDd59cU = currvj9QRUUPOWY4Ouser else { return }
    if !ORHPJ5pDd59cU.cP9hI1jK3lM5nO.contains(pid3rhTIg1jfRXQj) {
      ORHPJ5pDd59cU.cP9hI1jK3lM5nO.append(pid3rhTIg1jfRXQj)
      currvj9QRUUPOWY4Ouser = ORHPJ5pDd59cU
      percurVJbMlrKYhlnUG()
    }
  }

  func removeCollectedPostId(_ pid3rhTIg1jfRXQj: String) {
    guard var ORHPJ5pDd59cU = currvj9QRUUPOWY4Ouser else { return }
    ORHPJ5pDd59cU.cP9hI1jK3lM5nO.removeAll { $0 == pid3rhTIg1jfRXQj }
    currvj9QRUUPOWY4Ouser = ORHPJ5pDd59cU
    percurVJbMlrKYhlnUG()
  }

  private func SU6eGysGPjLGu(Wj7OeGJq6cFOu: String, ORHPJ5pDd59cU: User, isQuickLogin: Bool) {
    autokYcXLsqlQWQWjK = Wj7OeGJq6cFOu
    currvj9QRUUPOWY4Ouser = ORHPJ5pDd59cU
    isAutheda3IsmZzs015L5 = true
    isQuickGgcGDklj5hieh = isQuickLogin

    s7TyrtvdxydnFM(
      Wj7OeGJq6cFOu: Wj7OeGJq6cFOu,
      sHaa1AqAMgKIC: ORHPJ5pDd59cU,
      loginType: isQuickLogin ? "quick" : "normal"
    )
  }

  private func percurVJbMlrKYhlnUG() {
    guard let currentUser = currvj9QRUUPOWY4Ouser else { return }

    s7TyrtvdxydnFM(
      Wj7OeGJq6cFOu: autokYcXLsqlQWQWjK ?? "",
      sHaa1AqAMgKIC: currentUser,
      loginType: isQuickGgcGDklj5hieh ? "quick" : "normal"
    )
  }

  private func s7TyrtvdxydnFM(Wj7OeGJq6cFOu: String, sHaa1AqAMgKIC: User, loginType: String) {
    UserDefaults.standard.set(Wj7OeGJq6cFOu, forKey: d9BK8LqsPffmR)
    UserDefaults.standard.set(loginType, forKey: lotyiOnF5ZgtcBbPw)

    if let mmNBjE6lxF8V8 = try? JSONEncoder().encode(sHaa1AqAMgKIC) {
      UserDefaults.standard.set(mmNBjE6lxF8V8, forKey: ukeyhWcukRIm8bWHi)
    }
  }

  private func lseoyWJn9Bqevdv() {
    if let Wj7OeGJq6cFOu = UserDefaults.standard.string(forKey: d9BK8LqsPffmR) {
      autokYcXLsqlQWQWjK = Wj7OeGJq6cFOu

      if let mmNBjE6lxF8V8 = UserDefaults.standard.data(forKey: ukeyhWcukRIm8bWHi),
        let kWli31mhBfNQf = try? JSONDecoder().decode(User.self, from: mmNBjE6lxF8V8)
      {
        currvj9QRUUPOWY4Ouser = kWli31mhBfNQf
        isAutheda3IsmZzs015L5 = true

        let loginType = UserDefaults.standard.string(forKey: lotyiOnF5ZgtcBbPw)
        isQuickGgcGDklj5hieh = (loginType == "quick")
      } else {
        PiLCTlmXA1kCW()
      }
    }
  }

  private func PiLCTlmXA1kCW(z7fB01MZ63Q3q: Bool = false) {
    UserDefaults.standard.removeObject(forKey: d9BK8LqsPffmR)
    UserDefaults.standard.removeObject(forKey: ukeyhWcukRIm8bWHi)

    if !z7fB01MZ63Q3q {
      UserDefaults.standard.removeObject(forKey: lotyiOnF5ZgtcBbPw)
    }
  }
}
