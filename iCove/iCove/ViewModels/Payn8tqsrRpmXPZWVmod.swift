//
//  Payn8tqsrRpmXPZWVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
class Payn8tqsrRpmXPZWVmod: ObservableObject {
  @Published var pros1FessbjOCPZuE: [PayProdRVqoBpOpH] = []
  @Published var stuXwBv2xiiWPj4U: Psystus60ZmDMzftZSZw = .idle
  @Published var errlTB7VE3zUfXPr: String?
  @Published var lopingSfYVxI17xwzFY: Bool = false
  @Published var sele2p0Tz2CJngEqZidx: Int?

  private let hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc
  private var IS2i7T25V612b: AuthManagA645b8Y0Aod3aVmod
  private let GXSI49ebk5OUK: Authsdmd0VXzbAnDYServProc

  init(
    hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc? = nil,
    IS2i7T25V612b: AuthManagA645b8Y0Aod3aVmod,
    GXSI49ebk5OUK: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    autoInitialize: Bool = false
  ) {
    self.hbxFiWQcWP75Zserv = hbxFiWQcWP75Zserv ?? PayServnDaWE7QuyO56j.shared
    self.IS2i7T25V612b = IS2i7T25V612b
    self.GXSI49ebk5OUK = GXSI49ebk5OUK

    if autoInitialize {
      Task {
        await initZKQ7zcla5jX0Y()
      }
    }
  }

  func initZKQ7zcla5jX0Y() async {
    guard await hbxFiWQcWP75Zserv.isAvailjlkIs8sFhRyC5() else {
      seeqvT9pH0SFvSAU("Payment services unavailable")
      return
    }

    await clearUnfinishedTransactions()
    await loadzXWNROryo53Db()
  }

  func loadzXWNROryo53Db() async {
    guard !lopingSfYVxI17xwzFY else { return }

    lopingSfYVxI17xwzFY = true
    errlTB7VE3zUfXPr = nil
    stuXwBv2xiiWPj4U = .loadingProducts

    do {
      let h5GO1naWxliHh = try await hbxFiWQcWP75Zserv.querym7j0xNY0Nr6V3(
        productIds: proidsPxeTsOfse3oQ8)

      pros1FessbjOCPZuE = h5GO1naWxliHh
      stuXwBv2xiiWPj4U = .idle

      if pros1FessbjOCPZuE.isEmpty {
        errlTB7VE3zUfXPr = "No products found"
      }
    } catch {
      let pDGujAVRU3SQu =
        (error as? PayerryHmJFBwocwVuY)?.erdesniu2dZl1hSlti ?? error.localizedDescription
      errlTB7VE3zUfXPr = pDGujAVRU3SQu
      stuXwBv2xiiWPj4U = .failed(pDGujAVRU3SQu)
      pros1FessbjOCPZuE = []
    }

    lopingSfYVxI17xwzFY = false
  }

  func relpay7vImdn19ATr15(pidkxe68JHwzNP58: String) async {
    if pros1FessbjOCPZuE.isEmpty {
      await loadzXWNROryo53Db()
    }

    guard let V8mOwGXGDfQFF = pros1FessbjOCPZuE.first(where: { $0.id == pidkxe68JHwzNP58 }) else {
      seeqvT9pH0SFvSAU("Product not found")
      return
    }

    sele2p0Tz2CJngEqZidx = pros1FessbjOCPZuE.firstIndex(where: { $0.id == pidkxe68JHwzNP58 })

    guard await hbxFiWQcWP75Zserv.isAvailjlkIs8sFhRyC5() else {
      seeqvT9pH0SFvSAU("Payment services unavailable")
      return
    }

    await clearUnfinishedTransactions()
    await C5W2Ns5gH7vOQ(V8mOwGXGDfQFF)
  }

  private func C5W2Ns5gH7vOQ(_ V8mOwGXGDfQFF: PayProdRVqoBpOpH) async {
    stuXwBv2xiiWPj4U = .processing
    errlTB7VE3zUfXPr = nil

    do {
      let scuccEKHSEYWxGL7u = try await hbxFiWQcWP75Zserv.relpay7vImdn19ATr15(V8mOwGXGDfQFF)

      if scuccEKHSEYWxGL7u {
        await updjJwxHZYya4SMt(for: V8mOwGXGDfQFF)
        stuXwBv2xiiWPj4U = .success
        errlTB7VE3zUfXPr = nil
        await clearUnfinishedTransactions()
      } else {
        stuXwBv2xiiWPj4U = .canceled
        errlTB7VE3zUfXPr = "Purchase canceled"
      }
    } catch {
      herspEiEXYnTW2o(error)
      await clearUnfinishedTransactions()
    }
  }

  func restorePiBwOqacnYVqP() async {
    stuXwBv2xiiWPj4U = .processing
    errlTB7VE3zUfXPr = nil

    do {
      let restoredCount = try await hbxFiWQcWP75Zserv.restorePiBwOqacnYVqP()
      stuXwBv2xiiWPj4U = restoredCount > 0 ? .restored : .idle
      errlTB7VE3zUfXPr =
        restoredCount > 0
        ? "Restored \(restoredCount) purchases"
        : "No purchases to restore"
    } catch {
      herspEiEXYnTW2o(error)
    }
  }

  func redssf7ssJoNt3ObDB() {
    stuXwBv2xiiWPj4U = .idle
    errlTB7VE3zUfXPr = nil
    sele2p0Tz2CJngEqZidx = nil
  }

  private func updjJwxHZYya4SMt(for WSnW7yuASkL0k: PayProdRVqoBpOpH) async {
    IS2i7T25V612b.addbanxsQVAH9mAY0ZZ(WSnW7yuASkL0k.diaGDfiUAxvMX5uR)
    if let curYI7CMii2WiBmI = IS2i7T25V612b.currvj9QRUUPOWY4Ouser {
      GXSI49ebk5OUK.upd39Yrqyc7YxrPf(curYI7CMii2WiBmI)
    }
  }

  func updAuma7Cif2ltv9c65t(_ IS2i7T25V612b: AuthManagA645b8Y0Aod3aVmod) {
    self.IS2i7T25V612b = IS2i7T25V612b
  }

  private func clearUnfinishedTransactions() async {
    if let lrJ0tk8Qq83Sr = hbxFiWQcWP75Zserv as? PayServnDaWE7QuyO56j {
      await lrJ0tk8Qq83Sr.clearRG70yxJRihqqg()
    }
  }

  private func seeqvT9pH0SFvSAU(_ RkIDeGMRbt1Cq: String) {
    errlTB7VE3zUfXPr = RkIDeGMRbt1Cq
    stuXwBv2xiiWPj4U = .failed(RkIDeGMRbt1Cq)
  }

  private func herspEiEXYnTW2o(_ o5ueW4fsYLhpi: Error) {
    let er8FIM3GFksLmqm =
      (o5ueW4fsYLhpi as? PayerryHmJFBwocwVuY)?.erdesniu2dZl1hSlti
      ?? o5ueW4fsYLhpi.localizedDescription

    if er8FIM3GFksLmqm.lowercased().contains("cancel") {
      stuXwBv2xiiWPj4U = .canceled
      errlTB7VE3zUfXPr = "Purchase canceled"
    } else {
      stuXwBv2xiiWPj4U = .failed(er8FIM3GFksLmqm)
      errlTB7VE3zUfXPr = er8FIM3GFksLmqm
    }
  }
}
