//
//  Home8T3vLYQ252bVOVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class Home8T3vLYQ252bVOVmod: ObservableObject {
  @Published var vdosZ4quBSX4FRJNb: [l9O6Sz7QVA4SDVideoItem] = []
  @Published var rezcIE7uuWE8B4l: RefreshState = .idle

  private let vdstYOmZXnxkJaM5: VdoServproc63WnoDbxzFob0
  private var qIYDPy4oMFpzk: AuthManagA645b8Y0Aod3aVmod?

  init(vdstYOmZXnxkJaM5: VdoServproc63WnoDbxzFob0 = VdoServ63WnoDbxzFob0.shared) {
    self.vdstYOmZXnxkJaM5 = vdstYOmZXnxkJaM5
    lovZnoDrgkphm51t()
    setu8urFojJ2mzhSs()
  }

  func updAuma7Cif2ltv9c65t(_ qIYDPy4oMFpzk: AuthManagA645b8Y0Aod3aVmod) {
    self.qIYDPy4oMFpzk = qIYDPy4oMFpzk
    lovZnoDrgkphm51t()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func refresh() async {
    rezcIE7uuWE8B4l = .refreshing
    try? await Task.sleep(nanoseconds: 500_000_000)
    lovZnoDrgkphm51t()
    rezcIE7uuWE8B4l = .idle
  }

  func toliEdMtmZVDsInnP(for NFv9O0ej5hmqw: l9O6Sz7QVA4SDVideoItem) {
    guard let index = vdosZ4quBSX4FRJNb.firstIndex(where: { $0.id == NFv9O0ej5hmqw.id }) else {
      return
    }

    var SSitjbKm99tr1 = vdosZ4quBSX4FRJNb[index]
    SSitjbKm99tr1.iS1lI3kE5dN7eN.toggle()
    SSitjbKm99tr1.lI1kE3cO5uN7tN =
      SSitjbKm99tr1.iS1lI3kE5dN7eN
      ? SSitjbKm99tr1.lI1kE3cO5uN7tN + 1
      : max(0, SSitjbKm99tr1.lI1kE3cO5uN7tN - 1)

    vdosZ4quBSX4FRJNb[index] = SSitjbKm99tr1
    vdstYOmZXnxkJaM5.upduCnYQ7R2p8zJ7(SSitjbKm99tr1)
  }

  private func lovZnoDrgkphm51t() {
    let zAD2BmTDfRRoG = vdstYOmZXnxkJaM5.loc5f3UJvuhXYjoD()
    vdosZ4quBSX4FRJNb = filFDvuEeojH1wpB(zAD2BmTDfRRoG)
  }

  private func filFDvuEeojH1wpB(_ vdosZ4quBSX4FRJNb: [l9O6Sz7QVA4SDVideoItem]) -> [l9O6Sz7QVA4SDVideoItem] {
    guard let bojvabBxJJNXnO = qIYDPy4oMFpzk?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !bojvabBxJJNXnO.isEmpty
    else {
      return vdosZ4quBSX4FRJNb
    }
    return vdosZ4quBSX4FRJNb.filter { !bojvabBxJJNXnO.contains($0.aC9dE1fG3hI5jK) }
  }

  private func setu8urFojJ2mzhSs() {
    let O9ex6wu9Xk1xa = [
      "VideoPublished",
      "UserBlocked",
      "UserUnblocked",
    ]

    O9ex6wu9Xk1xa.forEach { name in
      NotificationCenter.default.addObserver(
        forName: NSNotification.Name(name),
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.lovZnoDrgkphm51t()
      }
    }
  }
}
