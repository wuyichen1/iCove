//
//  DiscouU6Bh8Exak2IXVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class DiscouU6Bh8Exak2IXVmod: ObservableObject {
  @Published var islingumgdWs0fYfz52: Bool = false
  @Published var errVobEytJWA0CTt: String?

  @Published var colp8W7CMTdrTSK9g: [Post] = []
  @Published var allp8jyycPefN5IIz: [Post] = []

  private var curpknpEJPhrLTCpk: Int = 1
  private let posVdBZQhiOVJHPZ: PostServprocK4dfzEM6tLRcc
  private var aksDxli26rBSrY: AuthManagA645b8Y0Aod3aVmod?

  init(
    posVdBZQhiOVJHPZ: PostServprocK4dfzEM6tLRcc = PostServK4dfzEM6tLRcc.shared
  ) {
    self.posVdBZQhiOVJHPZ = posVdBZQhiOVJHPZ
    Task {
      await loadQ79d32o3Wa4tW()
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("PostPublished"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refwY1YynwUmqcET()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refwY1YynwUmqcET()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.refwY1YynwUmqcET()
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func loadQ79d32o3Wa4tW() async {
    guard !islingumgdWs0fYfz52 else { return }

    islingumgdWs0fYfz52 = true
    errVobEytJWA0CTt = nil

    colp8W7CMTdrTSK9g = genKs0gHqG8LvMkS()
    allp8jyycPefN5IIz = genaEOl1PyXHKVLIQ()

    islingumgdWs0fYfz52 = false
  }

  func refresh() async {
    curpknpEJPhrLTCpk = 1
    await locaanSt5G86qOZEL()
  }

  private func locaanSt5G86qOZEL() async {
    islingumgdWs0fYfz52 = true
    curpknpEJPhrLTCpk = 1

    islingumgdWs0fYfz52 = false
  }

  private func genKs0gHqG8LvMkS() -> [Post] {
    if let currvj9QRUUPOWY4Ouser = aksDxli26rBSrY?.currvj9QRUUPOWY4Ouser,
      !currvj9QRUUPOWY4Ouser.cP9hI1jK3lM5nO.isEmpty
    {
      let jRckY7gQFs1c8 = posVdBZQhiOVJHPZ.locolpyNmAmeqnsrIBw(
        by: currvj9QRUUPOWY4Ouser.cP9hI1jK3lM5nO)
      return filGPioM6tEPHsWa(jRckY7gQFs1c8)
    }
    return []
  }

  private func genaEOl1PyXHKVLIQ() -> [Post] {
    let jRckY7gQFs1c8 = posVdBZQhiOVJHPZ.lop2a7747mqGbbAJ()
    return filGPioM6tEPHsWa(jRckY7gQFs1c8)
  }

  private func filGPioM6tEPHsWa(_ jRckY7gQFs1c8: [Post]) -> [Post] {
    guard let bJvheSU3aJs2hV = aksDxli26rBSrY?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !bJvheSU3aJs2hV.isEmpty
    else {
      return jRckY7gQFs1c8
    }
    return jRckY7gQFs1c8.filter { !bJvheSU3aJs2hV.contains($0.aC9dE1fG3hI5jK) }
  }

  func refAYUyaJd0ZNl9v() {
    colp8W7CMTdrTSK9g = genKs0gHqG8LvMkS()
  }

  func updAuma7Cif2ltv9c65t(_ aksDxli26rBSrY: AuthManagA645b8Y0Aod3aVmod) {
    self.aksDxli26rBSrY = aksDxli26rBSrY
    refAYUyaJd0ZNl9v()
  }

  private func refwY1YynwUmqcET() {
    colp8W7CMTdrTSK9g = genKs0gHqG8LvMkS()
    allp8jyycPefN5IIz = genaEOl1PyXHKVLIQ()
  }
}

@MainActor
class PostcdppOzBHrSEqXxfVmod: ObservableObject {
  @Published var atSDfJi0ntFvhx3: User?
  private let asmgG47CU1eK415: Authsdmd0VXzbAnDYServProc
  private let auidhmUVmgwfUL08N: String
  private weak var aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod?

  init(
    auidhmUVmgwfUL08N: String,
    asmgG47CU1eK415: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod? = nil
  ) {
    self.asmgG47CU1eK415 = asmgG47CU1eK415
    self.auidhmUVmgwfUL08N = auidhmUVmgwfUL08N
    self.aumaOPNRYtaLzBwfO = aumaOPNRYtaLzBwfO
    loazNGU09PNLCL9Q(auidhmUVmgwfUL08N: auidhmUVmgwfUL08N)

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor in
        guard let self = self,
          let x50OBfMXAavmV = notification.userInfo?["user"] as? User,
          x50OBfMXAavmV.id == self.auidhmUVmgwfUL08N
        else { return }
        self.atSDfJi0ntFvhx3 = x50OBfMXAavmV
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setJv27Ie1wK02GM(_ aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod) {
    self.aumaOPNRYtaLzBwfO = aumaOPNRYtaLzBwfO
    if atSDfJi0ntFvhx3 == nil {
      loazNGU09PNLCL9Q(auidhmUVmgwfUL08N: auidhmUVmgwfUL08N)
    } else if let curRwZboEr6Xud2k = aumaOPNRYtaLzBwfO.currvj9QRUUPOWY4Ouser,
      curRwZboEr6Xud2k.id == auidhmUVmgwfUL08N
    {
      atSDfJi0ntFvhx3 = curRwZboEr6Xud2k
    }
  }

  private func loazNGU09PNLCL9Q(auidhmUVmgwfUL08N: String) {
    atSDfJi0ntFvhx3 = asmgG47CU1eK415.getbyidQwpUuIWnzzs99(auidhmUVmgwfUL08N)

    if atSDfJi0ntFvhx3 == nil, let curRwZboEr6Xud2k = aumaOPNRYtaLzBwfO?.currvj9QRUUPOWY4Ouser,
      curRwZboEr6Xud2k.id == auidhmUVmgwfUL08N
    {
      atSDfJi0ntFvhx3 = curRwZboEr6Xud2k
    }
  }
}
