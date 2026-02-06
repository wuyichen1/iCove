//
//  PaymentModule.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit
import SwiftUI

#if canImport(FBSDKCoreKit)
  import FBSDKCoreKit
#endif

struct PayProdRVqoBpOpH: Identifiable, Equatable {
  let id: String
  let F3a0686zLgphO: String
  let C677GrOXFKrCz: String
  let BEdd9dgBlT2XI: Decimal
  let diaGDfiUAxvMX5uR: Int

  init(from V8mOwGXGDfQFF: Product, diaGDfiUAxvMX5uR: Int) {
    self.id = V8mOwGXGDfQFF.id
    self.F3a0686zLgphO = V8mOwGXGDfQFF.displayName
    self.C677GrOXFKrCz = V8mOwGXGDfQFF.description
    self.BEdd9dgBlT2XI = V8mOwGXGDfQFF.price
    self.diaGDfiUAxvMX5uR = diaGDfiUAxvMX5uR
  }

  init(
    id: String, F3a0686zLgphO: String, C677GrOXFKrCz: String, BEdd9dgBlT2XI: Decimal,
    diaGDfiUAxvMX5uR: Int
  ) {
    self.id = id
    self.F3a0686zLgphO = F3a0686zLgphO
    self.C677GrOXFKrCz = C677GrOXFKrCz
    self.BEdd9dgBlT2XI = BEdd9dgBlT2XI
    self.diaGDfiUAxvMX5uR = diaGDfiUAxvMX5uR
  }
}

enum Psystus60ZmDMzftZSZw: Equatable {
  case idle
  case loadingProducts
  case processing
  case success
  case failed(String)
  case canceled
  case restored
}

enum PayerryHmJFBwocwVuY: LocalizedError {
  case unavailAT9azcXBITovY
  case probofdRlDRbrMqv4WxD(String)
  case profialqxQdMUOkp7Lqh(String)
  case purfail5irHyXdjwkSaw(String)
  case verfImTPmU91HRVHn
  case unkowniosjsupGLzzAI(String)

  var erdesniu2dZl1hSlti: String? {
    switch self {
    case .unavailAT9azcXBITovY:
      return "Payment services unavailable"
    case .probofdRlDRbrMqv4WxD(let productId):
      return "Product not found: \(productId)"
    case .profialqxQdMUOkp7Lqh(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    case .purfail5irHyXdjwkSaw(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    case .verfImTPmU91HRVHn:
      return "Transaction verification failed"
    case .unkowniosjsupGLzzAI(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    }
  }
}

struct PuroptWphPFw4mRa9N9: Identifiable {
  let id = UUID()
  let carrotsze1FZwh5WkpoW: Int
  let pricevsq55ZFkHtJBE: Double
  let pcodedDuCfV7Kep75r: String
}

let diaPckgscQLNBm8gVonHu: [PuroptWphPFw4mRa9N9] = [
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 400, pricevsq55ZFkHtJBE: 0.99, pcodedDuCfV7Kep75r: "siuziwgdniidihel"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 800, pricevsq55ZFkHtJBE: 1.99, pcodedDuCfV7Kep75r: "chbctkbcootjmwln"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 2450, pricevsq55ZFkHtJBE: 4.99, pcodedDuCfV7Kep75r: "edvihpgcgfjqpuef"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 3950, pricevsq55ZFkHtJBE: 7.99, pcodedDuCfV7Kep75r: "otbtbbpbjycbcz"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 5150, pricevsq55ZFkHtJBE: 9.99, pcodedDuCfV7Kep75r: "plflnjyqoylgaebq"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 10800, pricevsq55ZFkHtJBE: 19.99, pcodedDuCfV7Kep75r: "dhizdtvygzuucyjk"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 14900, pricevsq55ZFkHtJBE: 29.99, pcodedDuCfV7Kep75r: "hjykcaoxygywfq"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 29400, pricevsq55ZFkHtJBE: 49.99, pcodedDuCfV7Kep75r: "mnfprttfacargfjo"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 34500, pricevsq55ZFkHtJBE: 69.99, pcodedDuCfV7Kep75r: "gqyqcndprvmzsy"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 63700, pricevsq55ZFkHtJBE: 99.99, pcodedDuCfV7Kep75r: "bsacoassevtvnezx"),
]

let proidsPxeTsOfse3oQ8: [String] = diaPckgscQLNBm8gVonHu.map { $0.pcodedDuCfV7Kep75r }

struct PaymentTransactionInfo {
  let transactionID: String
  let serverVerificationData: String
  let transaction: SKPaymentTransaction  // StoreKit 1 使用 SKPaymentTransaction
}

protocol PayServnDaWE7QuyO56jProc {
  func isAvailjlkIs8sFhRyC5() async -> Bool

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH]

  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws
    -> PaymentTransactionInfo?

  func restorePiBwOqacnYVqP() async throws -> Int

  func finishvQzZS2oVkuJ9q(_ transaction: SKPaymentTransaction) async
}

class PayServnDaWE7QuyO56j: NSObject, PayServnDaWE7QuyO56jProc, SKProductsRequestDelegate,
  SKPaymentTransactionObserver
{
  static let shared = PayServnDaWE7QuyO56j()

  private var cachesbrDXeGxXqZEV: [PayProdRVqoBpOpH] = []

  private var GhRtP0tFGbfqc4GJ: SKProductsRequest?
  private var PnFTplAZND3M7cji: PayProdRVqoBpOpH?
  private var NqFFMMu6yWEwWJOm: CheckedContinuation<PaymentTransactionInfo?, Error>?
  private var kR5SebDNi8x55k9F: CheckedContinuation<[PayProdRVqoBpOpH], Error>?
  private var restoreContinuation: CheckedContinuation<Int, Error>?

  private override init() {
    super.init()
    SKPaymentQueue.default().add(self)
  }

  deinit {
    SKPaymentQueue.default().remove(self)
    GhRtP0tFGbfqc4GJ?.cancel()
  }

  func isAvailjlkIs8sFhRyC5() async -> Bool {
    return SKPaymentQueue.canMakePayments()
  }

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH] {
    return try await withCheckedThrowingContinuation { continuation in
      self.kR5SebDNi8x55k9F = continuation

      let request = SKProductsRequest(productIdentifiers: Set(productIds))
      request.delegate = self
      self.GhRtP0tFGbfqc4GJ = request
      request.start()
    }
  }

  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws
    -> PaymentTransactionInfo?
  {
    _ = try await querym7j0xNY0Nr6V3(productIds: [bf4JVtL3lzVcq.id])

    guard let skProduct = getCachedSKProduct(for: bf4JVtL3lzVcq.id) else {
      throw PayerryHmJFBwocwVuY.probofdRlDRbrMqv4WxD("SKProduct not found: \(bf4JVtL3lzVcq.id)")
    }

    return try await withCheckedThrowingContinuation { continuation in
      self.PnFTplAZND3M7cji = bf4JVtL3lzVcq
      self.NqFFMMu6yWEwWJOm = continuation

      let payment = SKPayment(product: skProduct)
      SKPaymentQueue.default().add(payment)
    }
  }

  func restorePiBwOqacnYVqP() async throws -> Int {
    return try await withCheckedThrowingContinuation { continuation in
      self.restoreContinuation = continuation
      SKPaymentQueue.default().restoreCompletedTransactions()
    }
  }

  func finishvQzZS2oVkuJ9q(_ transaction: SKPaymentTransaction) async {
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  func clearRG70yxJRihqqg() async {
    let transactions = SKPaymentQueue.default().transactions
    for transaction in transactions {
      await finishvQzZS2oVkuJ9q(transaction)
    }
  }

  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    var proGeqV1y368vfro: [PayProdRVqoBpOpH] = []

    for skProduct in products {
      let diamGpMnQnlkdmBMZ =
        diaPckgscQLNBm8gVonHu.first(where: { $0.pcodedDuCfV7Kep75r == skProduct.productIdentifier }
        )?.carrotsze1FZwh5WkpoW ?? 0

      let U4aV7PrgfbgdnSOG = NSDecimalNumber(decimal: skProduct.price.decimalValue).decimalValue
      let wNnqOqwlatFUxbwy = PayProdRVqoBpOpH(
        id: skProduct.productIdentifier,
        F3a0686zLgphO: skProduct.localizedTitle,
        C677GrOXFKrCz: skProduct.localizedDescription,
        BEdd9dgBlT2XI: U4aV7PrgfbgdnSOG,
        diaGDfiUAxvMX5uR: diamGpMnQnlkdmBMZ
      )

      cacheSKProduct(skProduct)
      proGeqV1y368vfro.append(wNnqOqwlatFUxbwy)
    }

    proGeqV1y368vfro.sort { $0.BEdd9dgBlT2XI < $1.BEdd9dgBlT2XI }
    cachesbrDXeGxXqZEV = proGeqV1y368vfro

    if proGeqV1y368vfro.isEmpty {
      kR5SebDNi8x55k9F?.resume(
        throwing: PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh("No products found"))
    } else {
      kR5SebDNi8x55k9F?.resume(returning: proGeqV1y368vfro)
    }
    kR5SebDNi8x55k9F = nil
  }

  func request(_ request: SKRequest, didFailWithError error: Error) {
    if request is SKProductsRequest {
      kR5SebDNi8x55k9F?.resume(
        throwing: PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh(error.localizedDescription))
      kR5SebDNi8x55k9F = nil
    }
  }

  func paymentQueue(
    _ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]
  ) {
    for trasZ45tsPVpH in transactions {
      switch trasZ45tsPVpH.transactionState {
      case .purchased:
        handlePurchasedTransaction(trasZ45tsPVpH)
      case .failed:
        lmBeYLn6pX5Oal6F(trasZ45tsPVpH)
      case .restored:
        handleRestoredTransaction(trasZ45tsPVpH)
      case .deferred:
        handleDeferredTransaction(trasZ45tsPVpH)
      case .purchasing:
        break
      @unknown default:
        NqFFMMu6yWEwWJOm?.resume(
          throwing: PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI("Unknown transaction state"))
        NqFFMMu6yWEwWJOm = nil
      }
    }
  }

  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
    let restoredCount = queue.transactions.filter { $0.transactionState == .restored }.count
    restoreContinuation?.resume(returning: restoredCount)
    restoreContinuation = nil
  }

  func paymentQueue(
    _ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error
  ) {
    restoreContinuation?.resume(
      throwing: PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI(
        "Restore failed: \(error.localizedDescription)"))
    restoreContinuation = nil
  }

  private func handlePurchasedTransaction(_ AeUN7Lf0ljApau6k: SKPaymentTransaction) {
    guard let purchase = PnFTplAZND3M7cji else {
      SKPaymentQueue.default().finishTransaction(AeUN7Lf0ljApau6k)
      return
    }

    let trasIDW9IEMBcTk = AeUN7Lf0ljApau6k.transactionIdentifier ?? ""
    let TwiUG2esnnT9HoID: String

    if let reurlyhzsC3ViBFxg0xJw = Bundle.main.appStoreReceiptURL,
      let XFdU1nHGDUG36riy = try? Data(contentsOf: reurlyhzsC3ViBFxg0xJw)
    {
      TwiUG2esnnT9HoID = XFdU1nHGDUG36riy.base64EncodedString()
    } else {
      TwiUG2esnnT9HoID = trasIDW9IEMBcTk
    }

    let transactionInfo = PaymentTransactionInfo(
      transactionID: trasIDW9IEMBcTk,
      serverVerificationData: TwiUG2esnnT9HoID,
      transaction: AeUN7Lf0ljApau6k
    )

    NqFFMMu6yWEwWJOm?.resume(returning: transactionInfo)
    NqFFMMu6yWEwWJOm = nil
    PnFTplAZND3M7cji = nil
  }

  private func lmBeYLn6pX5Oal6F(_ transaction: SKPaymentTransaction) {
    if let kP794badAPAYkbho = transaction.error {
      let Y21tP2QdsGRXXZRM = kP794badAPAYkbho.localizedDescription
      if (kP794badAPAYkbho as NSError).code == SKError.paymentCancelled.rawValue {
        NqFFMMu6yWEwWJOm?.resume(
          throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("User canceled the purchase"))
      } else {
        NqFFMMu6yWEwWJOm?.resume(
          throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw(Y21tP2QdsGRXXZRM))
      }
    } else {
      NqFFMMu6yWEwWJOm?.resume(
        throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("Purchase failed"))
    }
    NqFFMMu6yWEwWJOm = nil
    PnFTplAZND3M7cji = nil
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func handleRestoredTransaction(_ transaction: SKPaymentTransaction) {
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func handleDeferredTransaction(_ transaction: SKPaymentTransaction) {
    NqFFMMu6yWEwWJOm?.resume(
      throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("Purchase pending, please check later"))
    NqFFMMu6yWEwWJOm = nil
    PnFTplAZND3M7cji = nil
  }

  private var skProductsCache: [String: SKProduct] = [:]

  private func cacheSKProduct(_ product: SKProduct) {
    skProductsCache[product.productIdentifier] = product
  }

  private func getCachedSKProduct(for productId: String) -> SKProduct? {
    return skProductsCache[productId]
  }
}

@MainActor
protocol PaymentSuccessHandler: AnyObject {
  func addBalance(_ amount: Int)

  func updateUser()
}

@MainActor
class PaymentViewModelBase: ObservableObject {
  @Published var pros1FessbjOCPZuE: [PayProdRVqoBpOpH] = []
  @Published var stuXwBv2xiiWPj4U: Psystus60ZmDMzftZSZw = .idle
  @Published var errlTB7VE3zUfXPr: String?
  @Published var lopingSfYVxI17xwzFY: Bool = false
  @Published var sele2p0Tz2CJngEqZidx: Int?

  private let hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc
  private weak var successHandler: PaymentSuccessHandler?

  init(
    hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc? = nil,
    successHandler: PaymentSuccessHandler? = nil,
    autoInitialize: Bool = false
  ) {
    self.hbxFiWQcWP75Zserv = hbxFiWQcWP75Zserv ?? PayServnDaWE7QuyO56j.shared
    self.successHandler = successHandler

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
    stuXwBv2xiiWPj4U = .processing
    errlTB7VE3zUfXPr = nil

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
    if stuXwBv2xiiWPj4U != .processing {
      stuXwBv2xiiWPj4U = .processing
    }
    errlTB7VE3zUfXPr = nil

    do {
      let transactionInfo = try await hbxFiWQcWP75Zserv.relpay7vImdn19ATr15(V8mOwGXGDfQFF)

      guard let transactionInfo = transactionInfo else {
        stuXwBv2xiiWPj4U = .canceled
        errlTB7VE3zUfXPr = "Purchase canceled"
        return
      }

      let success = await updjJwxHZYya4SMt(
        for: V8mOwGXGDfQFF,
        transactionInfo: transactionInfo
      )

      if success {
        await hbxFiWQcWP75Zserv.finishvQzZS2oVkuJ9q(transactionInfo.transaction)
        stuXwBv2xiiWPj4U = .success
        errlTB7VE3zUfXPr = nil
        await clearUnfinishedTransactions()
      } else {
        stuXwBv2xiiWPj4U = .failed("Purchase verification failed")
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

  func setSuccessHandler(_ handler: PaymentSuccessHandler?) {
    self.successHandler = handler
  }

  private func updjJwxHZYya4SMt(
    for WSnW7yuASkL0k: PayProdRVqoBpOpH,
    transactionInfo: PaymentTransactionInfo
  ) async -> Bool {

    let isBPackage = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9
    var purchaseVerified = true

    if isBPackage {
      let I2nQr9neeKj8uoFL = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.vBQDDBfR6q7MNRTo

      purchaseVerified = await TrO9lHV6mtsQchGq(
        purchaseID: transactionInfo.transactionID,
        serverVerificationData: transactionInfo.serverVerificationData,
        swk89MmAgXRT7vmn: I2nQr9neeKj8uoFL
      )
    }

    if purchaseVerified {
      await logFacebookPurchaseEvent(product: WSnW7yuASkL0k)
      await logAdjustPurchaseEvent(product: WSnW7yuASkL0k)

      successHandler?.addBalance(WSnW7yuASkL0k.diaGDfiUAxvMX5uR)
      successHandler?.updateUser()

      return true
    } else {
      errlTB7VE3zUfXPr = "We were unable to confirm the purchase"
      return false
    }
  }

  private func logFacebookPurchaseEvent(product: PayProdRVqoBpOpH) async {
    #if canImport(FBSDKCoreKit)
      let purchaseAmount = NSDecimalNumber(decimal: product.BEdd9dgBlT2XI).doubleValue

      let parameters: [AppEvents.ParameterName: Any] = [
        AppEvents.ParameterName("fb_mobile_purchase"): "true",
        AppEvents.ParameterName("product_id"): product.id,
        AppEvents.ParameterName("product_name"): product.F3a0686zLgphO,
      ]

      AppEvents.shared.logPurchase(
        amount: purchaseAmount,
        currency: "USD",
        parameters: parameters
      )

      AppEvents.shared.flush()
    #else
      print("⚠️ [PaymentModule] Facebook SDK 未导入")
    #endif
  }

  private func logAdjustPurchaseEvent(product: PayProdRVqoBpOpH) async {
    let purchaseAmount = NSDecimalNumber(decimal: product.BEdd9dgBlT2XI).doubleValue

    AdjustService.shared.trackPurchaseEvent(amount: purchaseAmount)
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
