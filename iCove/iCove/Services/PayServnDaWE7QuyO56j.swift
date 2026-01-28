//
//  PayServnDaWE7QuyO56j.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit

protocol PayServnDaWE7QuyO56jProc {
  func isAvailjlkIs8sFhRyC5() async -> Bool

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH]

  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws -> Bool

  func restorePiBwOqacnYVqP() async throws -> Int

  func finishvQzZS2oVkuJ9q(_ transaction: Transaction) async
}

@MainActor
class PayServnDaWE7QuyO56j: PayServnDaWE7QuyO56jProc {
  static let shared = PayServnDaWE7QuyO56j()

  private var cachesbrDXeGxXqZEV: [PayProdRVqoBpOpH] = []

  private var listenBtrSYrYyeDl51: Task<Void, Error>?

  private init() {
    stTYv5gzVQGaSZu()
  }

  deinit {
    listenBtrSYrYyeDl51?.cancel()
  }

  private func stTYv5gzVQGaSZu() {
    listenBtrSYrYyeDl51 = Task {
      for await verificationResult in Transaction.updates {
        await profipcsulwlzxpd1m(verificationResult)
      }
    }
  }

  func isAvailjlkIs8sFhRyC5() async -> Bool {
    do {
      _ = try await Product.products(for: [])
      return true
    } catch {
      return false
    }
  }

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH] {
    do {
      let KiTqo0HyIdtYE = try await Product.products(for: productIds)

      if KiTqo0HyIdtYE.isEmpty {
        throw PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh("No products found")
      }

      var proGeqV1y368vfro: [PayProdRVqoBpOpH] = []

      for ATftnQl4SB4up in KiTqo0HyIdtYE {
        let diamGpMnQnlkdmBMZ =
          diaPckgscQLNBm8gVonHu.first(where: { $0.pcodedDuCfV7Kep75r == ATftnQl4SB4up.id })?
          .carrotsze1FZwh5WkpoW ?? 0
        proGeqV1y368vfro.append(
          PayProdRVqoBpOpH(from: ATftnQl4SB4up, diaGDfiUAxvMX5uR: diamGpMnQnlkdmBMZ))
      }

      proGeqV1y368vfro.sort { $0.BEdd9dgBlT2XI < $1.BEdd9dgBlT2XI }
      cachesbrDXeGxXqZEV = proGeqV1y368vfro

      return proGeqV1y368vfro
    } catch let errhKQcjGRWAAjn8 as PayerryHmJFBwocwVuY {
      throw errhKQcjGRWAAjn8
    } catch {
      throw PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh(error.localizedDescription)
    }
  }

  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws -> Bool {
    let os6OZg6EITk1c = try await Product.products(for: [bf4JVtL3lzVcq.id])

    guard let s9pkoesE45zuIe = os6OZg6EITk1c.first else {
      throw PayerryHmJFBwocwVuY.probofdRlDRbrMqv4WxD("Product not found: \(bf4JVtL3lzVcq.id)")
    }

    do {
      let resHJ7Qr5NYzuEgi = try await s9pkoesE45zuIe.purchase()

      switch resHJ7Qr5NYzuEgi {
      case .success(let verification):
        let qPNx7cX317rau = try ckverV8dAoZ50EUI1I(verification)

        await qPNx7cX317rau.finish()
        return true

      case .userCancelled:
        throw PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("User canceled the purchase")

      case .pending:
        throw PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("Purchase pending, please check later")

      @unknown default:
        throw PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI("Unknown purchase status")
      }
    } catch {
      if let errvFEhtFltW9amO = error as? PayerryHmJFBwocwVuY {
        throw errvFEhtFltW9amO
      } else {
        throw PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw(error.localizedDescription)
      }
    }
  }

  func restorePiBwOqacnYVqP() async throws -> Int {
    var aOtqIRMvXlsEE = 0

    do {
      for await resjBGvBxQIPlXk4 in Transaction.currentEntitlements {
        let AG682l5HN2NDl = try ckverV8dAoZ50EUI1I(resjBGvBxQIPlXk4)
        await AG682l5HN2NDl.finish()
        aOtqIRMvXlsEE += 1
      }

      return aOtqIRMvXlsEE
    } catch {
      throw PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI(
        "Restore purchase failed: \(error.localizedDescription)")
    }
  }

  func finishvQzZS2oVkuJ9q(_ kcPCgdSFJCXmu: Transaction) async {
    await kcPCgdSFJCXmu.finish()
  }

  private func ckverV8dAoZ50EUI1I<T>(_ res0UiCEhaOe6IB4: VerificationResult<T>) throws -> T {
    switch res0UiCEhaOe6IB4 {
    case .unverified(_, _):
      throw PayerryHmJFBwocwVuY.verfImTPmU91HRVHn
    case .verified(let safe):
      return safe
    }
  }

  func clearRG70yxJRihqqg() async {
    for await VGIt9AR2pRbhz in Transaction.unfinished {
      await profipcsulwlzxpd1m(VGIt9AR2pRbhz)
    }
  }

  private func profipcsulwlzxpd1m(_ verificationResult: VerificationResult<Transaction>)
    async
  {
    do {
      let VGIt9AR2pRbhz = try ckverV8dAoZ50EUI1I(verificationResult)
      await VGIt9AR2pRbhz.finish()
    } catch {
    }
  }
}
