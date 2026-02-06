//
//  PaymentModule.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//  支付模块 - 合并了模型、服务和 ViewModel，便于在其他项目中复用
//
//  ============================================
//  使用说明
//  ============================================
//
//  此文件包含了完整的支付功能模块，包括：
//  1. 支付模型（PayProdRVqoBpOpH, Psystus60ZmDMzftZSZw, PayerryHmJFBwocwVuY）
//  2. 支付服务（PayServnDaWE7QuyO56j）
//  3. 支付 ViewModel（PaymentViewModelBase）
//
//  在其他项目中使用：
//
//  1. 复制此文件到新项目
//  2. 修改产品配置（diaPckgscQLNBm8gVonHu）和产品ID列表（proidsPxeTsOfse3oQ8）
//  3. 实现 PaymentSuccessHandler 协议来处理支付成功后的业务逻辑
//  4. 创建 PaymentViewModelBase 实例：
//
//     class MyPaymentHandler: PaymentSuccessHandler {
//       func addBalance(_ amount: Int) {
//         // 处理增加余额的逻辑
//       }
//       func updateUser() {
//         // 更新用户信息
//       }
//     }
//
//     let handler = MyPaymentHandler()
//     let paymentVM = PaymentViewModelBase(successHandler: handler, autoInitialize: true)
//
//  5. 在 SwiftUI 中使用：
//     @StateObject private var paymentVM = PaymentViewModelBase(...)
//
//  Facebook 支付集成：
//  - 此模块已集成 Facebook App Events 购买事件记录
//  - 支付成功后会自动记录购买事件到 Facebook Analytics
//  - 需要在项目中添加 FBSDKCoreKit 依赖（可选，未添加时跳过记录）
//  - 已在 Info.plist 中配置 Facebook App ID 和 Client Token
//  - 对应 Flutter 代码：payFunc.dart 的 GR5wYUbrhgbHQovD 函数
//
//  ============================================
//

import Foundation
import StoreKit
import SwiftUI

// Facebook SDK - 用于记录支付事件
// 注意：需要在项目中添加 FBSDKCoreKit 依赖
// 可以通过 Swift Package Manager 添加：https://github.com/facebook/facebook-ios-sdk
#if canImport(FBSDKCoreKit)
  import FBSDKCoreKit
#endif

// MARK: - 支付模型

/// 支付产品模型
struct PayProdRVqoBpOpH: Identifiable, Equatable {
  let id: String
  let F3a0686zLgphO: String
  let C677GrOXFKrCz: String
  let BEdd9dgBlT2XI: Decimal
  let diaGDfiUAxvMX5uR: Int

  // StoreKit 2 初始化
  init(from V8mOwGXGDfQFF: Product, diaGDfiUAxvMX5uR: Int) {
    self.id = V8mOwGXGDfQFF.id
    self.F3a0686zLgphO = V8mOwGXGDfQFF.displayName
    self.C677GrOXFKrCz = V8mOwGXGDfQFF.description
    self.BEdd9dgBlT2XI = V8mOwGXGDfQFF.price
    self.diaGDfiUAxvMX5uR = diaGDfiUAxvMX5uR
  }
  
  // StoreKit 1 初始化
  init(id: String, F3a0686zLgphO: String, C677GrOXFKrCz: String, BEdd9dgBlT2XI: Decimal, diaGDfiUAxvMX5uR: Int) {
    self.id = id
    self.F3a0686zLgphO = F3a0686zLgphO
    self.C677GrOXFKrCz = C677GrOXFKrCz
    self.BEdd9dgBlT2XI = BEdd9dgBlT2XI
    self.diaGDfiUAxvMX5uR = diaGDfiUAxvMX5uR
  }
}

/// 支付状态枚举
enum Psystus60ZmDMzftZSZw: Equatable {
  case idle
  case loadingProducts
  case processing
  case success
  case failed(String)
  case canceled
  case restored
}

/// 支付错误枚举
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

/// 产品配置模型
struct PuroptWphPFw4mRa9N9: Identifiable {
  let id = UUID()
  let carrotsze1FZwh5WkpoW: Int
  let pricevsq55ZFkHtJBE: Double
  let pcodedDuCfV7Kep75r: String
}

// MARK: - 产品配置数据（可根据项目需要修改）

/// 产品配置列表
let diaPckgscQLNBm8gVonHu: [PuroptWphPFw4mRa9N9] = [
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 400, pricevsq55ZFkHtJBE: 0.99, pcodedDuCfV7Kep75r: "lvbsvhxcgcrvesor"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 800, pricevsq55ZFkHtJBE: 1.99, pcodedDuCfV7Kep75r: "dxismgcwewhrtezo"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 2450, pricevsq55ZFkHtJBE: 4.99, pcodedDuCfV7Kep75r: "khtxlcejaxmqcsra"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 3950, pricevsq55ZFkHtJBE: 7.99, pcodedDuCfV7Kep75r: "yadwwvxspgxwlndb"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 5150, pricevsq55ZFkHtJBE: 9.99, pcodedDuCfV7Kep75r: "qnrcuelbtiuflyky"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 10800, pricevsq55ZFkHtJBE: 19.99, pcodedDuCfV7Kep75r: "ymohxnvpkqxutvab"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 14900, pricevsq55ZFkHtJBE: 29.99, pcodedDuCfV7Kep75r: "hjykcaoxygywfq"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 29400, pricevsq55ZFkHtJBE: 49.99, pcodedDuCfV7Kep75r: "mnfprttfacargfjo"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 34500, pricevsq55ZFkHtJBE: 69.99, pcodedDuCfV7Kep75r: "gqyqcndprvmzsy"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 63700, pricevsq55ZFkHtJBE: 99.99, pcodedDuCfV7Kep75r: "bsacoassevtvnezx"),
]

/// 产品 ID 列表
let proidsPxeTsOfse3oQ8: [String] = diaPckgscQLNBm8gVonHu.map { $0.pcodedDuCfV7Kep75r }

// MARK: - 支付服务协议

/// 支付交易信息（用于验证）
/// StoreKit 1 版本：使用 SKPaymentTransaction
struct PaymentTransactionInfo {
  let transactionID: String
  let serverVerificationData: String
  let transaction: SKPaymentTransaction  // StoreKit 1 使用 SKPaymentTransaction
}

protocol PayServnDaWE7QuyO56jProc {
  func isAvailjlkIs8sFhRyC5() async -> Bool

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH]

  /// 发起支付，返回交易信息（不立即 finish，等待验证）
  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws
    -> PaymentTransactionInfo?

  func restorePiBwOqacnYVqP() async throws -> Int

  func finishvQzZS2oVkuJ9q(_ transaction: SKPaymentTransaction) async
}

// MARK: - 支付服务实现（StoreKit 1）

class PayServnDaWE7QuyO56j: NSObject, PayServnDaWE7QuyO56jProc, SKProductsRequestDelegate, SKPaymentTransactionObserver {
  static let shared = PayServnDaWE7QuyO56j()

  private var cachesbrDXeGxXqZEV: [PayProdRVqoBpOpH] = []
  
  // StoreKit 1 相关
  private var productsRequest: SKProductsRequest?
  private var pendingPurchase: PayProdRVqoBpOpH?
  private var purchaseContinuation: CheckedContinuation<PaymentTransactionInfo?, Error>?
  private var queryContinuation: CheckedContinuation<[PayProdRVqoBpOpH], Error>?
  private var restoreContinuation: CheckedContinuation<Int, Error>?

  private override init() {
    super.init()
    // 添加支付队列观察者
    SKPaymentQueue.default().add(self)
  }

  deinit {
    SKPaymentQueue.default().remove(self)
    productsRequest?.cancel()
  }

  func isAvailjlkIs8sFhRyC5() async -> Bool {
    return SKPaymentQueue.canMakePayments()
  }

  func querym7j0xNY0Nr6V3(productIds: [String]) async throws -> [PayProdRVqoBpOpH] {
    return try await withCheckedThrowingContinuation { continuation in
      self.queryContinuation = continuation
      
      let request = SKProductsRequest(productIdentifiers: Set(productIds))
      request.delegate = self
      self.productsRequest = request
      request.start()
    }
  }

  func relpay7vImdn19ATr15(_ bf4JVtL3lzVcq: PayProdRVqoBpOpH) async throws -> PaymentTransactionInfo? {
    // 先查询产品信息（这会缓存 SKProduct）
    _ = try await querym7j0xNY0Nr6V3(productIds: [bf4JVtL3lzVcq.id])
    
    // 从缓存中获取 SKProduct
    guard let skProduct = getCachedSKProduct(for: bf4JVtL3lzVcq.id) else {
      throw PayerryHmJFBwocwVuY.probofdRlDRbrMqv4WxD("SKProduct not found: \(bf4JVtL3lzVcq.id)")
    }
    
    // 发起支付
    return try await withCheckedThrowingContinuation { continuation in
      self.pendingPurchase = bf4JVtL3lzVcq
      self.purchaseContinuation = continuation
      
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
    // StoreKit 1 中，未完成的交易会自动通过观察者回调处理
    // 这里可以手动处理未完成的交易
    let transactions = SKPaymentQueue.default().transactions
    for transaction in transactions {
      await finishvQzZS2oVkuJ9q(transaction)
    }
  }
  
  // MARK: - SKProductsRequestDelegate
  
  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    let products = response.products
    var proGeqV1y368vfro: [PayProdRVqoBpOpH] = []
    
    for skProduct in products {
      let diamGpMnQnlkdmBMZ = diaPckgscQLNBm8gVonHu.first(where: { $0.pcodedDuCfV7Kep75r == skProduct.productIdentifier })?.carrotsze1FZwh5WkpoW ?? 0
      
      // 将 SKProduct 转换为 PayProdRVqoBpOpH
      let priceDecimal = NSDecimalNumber(decimal: skProduct.price.decimalValue).decimalValue
      let product = PayProdRVqoBpOpH(
        id: skProduct.productIdentifier,
        F3a0686zLgphO: skProduct.localizedTitle,
        C677GrOXFKrCz: skProduct.localizedDescription,
        BEdd9dgBlT2XI: priceDecimal,
        diaGDfiUAxvMX5uR: diamGpMnQnlkdmBMZ
      )
      
      // 缓存 SKProduct
      cacheSKProduct(skProduct)
      proGeqV1y368vfro.append(product)
    }
    
    proGeqV1y368vfro.sort { $0.BEdd9dgBlT2XI < $1.BEdd9dgBlT2XI }
    cachesbrDXeGxXqZEV = proGeqV1y368vfro
    
    if proGeqV1y368vfro.isEmpty {
      queryContinuation?.resume(throwing: PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh("No products found"))
    } else {
      queryContinuation?.resume(returning: proGeqV1y368vfro)
    }
    queryContinuation = nil
  }
  
  func request(_ request: SKRequest, didFailWithError error: Error) {
    if request is SKProductsRequest {
      queryContinuation?.resume(throwing: PayerryHmJFBwocwVuY.profialqxQdMUOkp7Lqh(error.localizedDescription))
      queryContinuation = nil
    }
  }
  
  // MARK: - SKPaymentTransactionObserver
  
  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
      case .purchased:
        handlePurchasedTransaction(transaction)
      case .failed:
        handleFailedTransaction(transaction)
      case .restored:
        handleRestoredTransaction(transaction)
      case .deferred:
        handleDeferredTransaction(transaction)
      case .purchasing:
        // 正在购买中，不需要处理
        break
      @unknown default:
        purchaseContinuation?.resume(throwing: PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI("Unknown transaction state"))
        purchaseContinuation = nil
      }
    }
  }
  
  func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
    let restoredCount = queue.transactions.filter { $0.transactionState == .restored }.count
    restoreContinuation?.resume(returning: restoredCount)
    restoreContinuation = nil
  }
  
  func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
    restoreContinuation?.resume(throwing: PayerryHmJFBwocwVuY.unkowniosjsupGLzzAI("Restore failed: \(error.localizedDescription)"))
    restoreContinuation = nil
  }
  
  // MARK: - 私有方法
  
  private func handlePurchasedTransaction(_ transaction: SKPaymentTransaction) {
    guard let purchase = pendingPurchase else {
      // 如果不是当前发起的购买，直接完成交易
      SKPaymentQueue.default().finishTransaction(transaction)
      return
    }
    
    // 获取交易ID
    let transactionID = transaction.transactionIdentifier ?? ""
    
    // 获取服务器验证数据（收据数据）
    // 对应 Flutter: yQfs7fsh3WfRbS8Z.serverVerificationData
    // 在 StoreKit 1 中，transactionReceipt 在 iOS 7+ 已废弃
    // 我们需要从应用收据中获取，或者使用交易ID
    // 注意：StoreKit 1 中，应该使用应用收据（App Receipt）进行验证
    let serverVerificationData: String
    
    // 尝试从应用收据获取数据
    if let receiptURL = Bundle.main.appStoreReceiptURL,
       let receiptData = try? Data(contentsOf: receiptURL) {
      // 将应用收据转换为 Base64 字符串
      // 这对应 Flutter 的 serverVerificationData
      serverVerificationData = receiptData.base64EncodedString()
      print("✅ [PayServnDaWE7QuyO56j] 使用应用收据作为验证数据")
    } else {
      // 如果没有收据数据，使用交易ID作为备用
      // 注意：这种情况下服务器可能无法验证，建议使用应用收据
      serverVerificationData = transactionID
      print("⚠️ [PayServnDaWE7QuyO56j] 应用收据不可用，使用 transactionID 作为备用: \(transactionID)")
    }
    
    let transactionInfo = PaymentTransactionInfo(
      transactionID: transactionID,
      serverVerificationData: serverVerificationData,
      transaction: transaction
    )
    
    purchaseContinuation?.resume(returning: transactionInfo)
    purchaseContinuation = nil
    pendingPurchase = nil
  }
  
  private func handleFailedTransaction(_ transaction: SKPaymentTransaction) {
    if let error = transaction.error {
      let errorMessage = error.localizedDescription
      if (error as NSError).code == SKError.paymentCancelled.rawValue {
        purchaseContinuation?.resume(throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("User canceled the purchase"))
      } else {
        purchaseContinuation?.resume(throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw(errorMessage))
      }
    } else {
      purchaseContinuation?.resume(throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("Purchase failed"))
    }
    purchaseContinuation = nil
    pendingPurchase = nil
    SKPaymentQueue.default().finishTransaction(transaction)
  }
  
  private func handleRestoredTransaction(_ transaction: SKPaymentTransaction) {
    // 恢复购买的处理
    SKPaymentQueue.default().finishTransaction(transaction)
  }
  
  private func handleDeferredTransaction(_ transaction: SKPaymentTransaction) {
    purchaseContinuation?.resume(throwing: PayerryHmJFBwocwVuY.purfail5irHyXdjwkSaw("Purchase pending, please check later"))
    purchaseContinuation = nil
    pendingPurchase = nil
  }
  
  // 辅助方法：缓存 SKProduct
  private var skProductsCache: [String: SKProduct] = [:]
  
  private func cacheSKProduct(_ product: SKProduct) {
    skProductsCache[product.productIdentifier] = product
  }
  
  private func getCachedSKProduct(for productId: String) -> SKProduct? {
    return skProductsCache[productId]
  }
}

// MARK: - 支付回调协议（用于解耦外部依赖）

/// 支付成功后的回调协议，用于更新用户余额等信息
/// 在其他项目中，可以实现此协议来处理支付成功后的业务逻辑
/// 注意：协议需要继承自 AnyObject 才能使用 weak 引用
@MainActor
protocol PaymentSuccessHandler: AnyObject {
  /// 支付成功后增加余额
  /// - Parameter amount: 增加的金额/积分
  func addBalance(_ amount: Int)

  /// 更新用户信息（可选）
  func updateUser()
}

// MARK: - Facebook 支付集成说明
//
// 此模块已集成 Facebook App Events 购买事件记录功能
//
// 功能说明：
// 1. 支付成功后，会根据 B 包模式判断是否需要验证购买
// 2. 验证通过后，自动记录 Facebook App Events 购买事件
// 3. 记录的信息包括：购买金额、货币、产品ID、产品名称等
//
// 使用要求：
// 1. 需要在项目中添加 Facebook SDK 依赖（FBSDKCoreKit）
// 2. 已在 Info.plist 中配置 Facebook App ID 和 Client Token
// 3. 如果未导入 Facebook SDK，购买事件记录会被跳过（不影响正常支付流程）
//
// 对应 Flutter 代码位置：
// - payFunc.dart 的 GR5wYUbrhgbHQovD 函数（第 275-309 行）
//

// MARK: - 支付 ViewModel（基础实现）

@MainActor
class PaymentViewModelBase: ObservableObject {
  @Published var pros1FessbjOCPZuE: [PayProdRVqoBpOpH] = []
  @Published var stuXwBv2xiiWPj4U: Psystus60ZmDMzftZSZw = .idle
  @Published var errlTB7VE3zUfXPr: String?
  @Published var lopingSfYVxI17xwzFY: Bool = false
  @Published var sele2p0Tz2CJngEqZidx: Int?

  private let hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc
  /// 支付成功处理器（可选，用于解耦外部依赖）
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
    // 立即设置 processing 状态，显示 loading
    stuXwBv2xiiWPj4U = .processing
    errlTB7VE3zUfXPr = nil
    
    // 如果产品列表为空，先加载产品（此时已经显示 loading）
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
    // 确保 processing 状态已设置（可能在 relpay7vImdn19ATr15 中已设置）
    // 如果还没有设置，这里再次设置以确保显示 loading
    if stuXwBv2xiiWPj4U != .processing {
      stuXwBv2xiiWPj4U = .processing
    }
    errlTB7VE3zUfXPr = nil

    do {
      // 发起支付，获取交易信息（不立即 finish）
      // 对应 Flutter: PurchaseDetails qNXm2HxkfygQcQvU
      let transactionInfo = try await hbxFiWQcWP75Zserv.relpay7vImdn19ATr15(V8mOwGXGDfQFF)

      guard let transactionInfo = transactionInfo else {
        stuXwBv2xiiWPj4U = .canceled
        errlTB7VE3zUfXPr = "Purchase canceled"
        return
      }

      // 处理支付成功（包括验证和 Facebook 事件记录）
      // 对应 Flutter: await GR5wYUbrhgbHQovD(qNXm2HxkfygQcQvU)
      let success = await updjJwxHZYya4SMt(
        for: V8mOwGXGDfQFF,
        transactionInfo: transactionInfo
      )

      if success {
        // 验证通过，finish transaction
        await hbxFiWQcWP75Zserv.finishvQzZS2oVkuJ9q(transactionInfo.transaction)
        stuXwBv2xiiWPj4U = .success
        errlTB7VE3zUfXPr = nil
        await clearUnfinishedTransactions()
      } else {
        // 验证失败，不 finish transaction（让用户稍后重试）
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

  /// 设置支付成功处理器
  func setSuccessHandler(_ handler: PaymentSuccessHandler?) {
    self.successHandler = handler
  }

  // -------支付更新---------
  /// 处理支付成功后的逻辑（验证、Facebook 事件记录、业务处理）
  /// 对应 Flutter: Future<void> GR5wYUbrhgbHQovD(PurchaseDetails qNXm2HxkfygQcQvU)
  /// - Parameters:
  ///   - WSnW7yuASkL0k: 支付产品信息
  ///   - transactionInfo: 交易信息（包含 purchaseID 和 serverVerificationData）
  /// - Returns: 是否验证成功
  private func updjJwxHZYya4SMt(
    for WSnW7yuASkL0k: PayProdRVqoBpOpH,
    transactionInfo: PaymentTransactionInfo
  ) async -> Bool {
    // MARK: - Facebook 支付集成
    // 对应 Flutter 代码：GR5wYUbrhgbHQovD 函数中的 Facebook App Events 记录

    // 1. 检查是否为 B 包模式，如果是则需要验证购买
    // 对应 Flutter: final bool RNOIvYDrtqGecxVX = FlW0vlw1jBvjx3hy().q63eYlDCImAOIRcy9 ? await vAWWpfx9YFkwV6Gn(qNXm2HxkfygQcQvU) : true;
    let isBPackage = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9
    var purchaseVerified = true

    // 如果是 B 包模式，需要验证购买
    // 对应 Flutter: await vAWWpfx9YFkwV6Gn(qNXm2HxkfygQcQvU)
    if isBPackage {
      // 获取 orderCode（对应 Flutter: FlW0vlw1jBvjx3hy().zU4ZT5YgrXaPLm7p）
      let orderCode = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.zU4ZT5YgrXaPLm7p

      // 调用服务器验证接口
      // 对应 Flutter: await vAWWpfx9YFkwV6Gn(qNXm2HxkfygQcQvU)
      // 参数对应关系：
      // - purchaseID: transactionInfo.transactionID (对应 Flutter: qXOnFP7agDzDxVv5.purchaseID)
      // - serverVerificationData: transactionInfo.serverVerificationData (对应 Flutter: qXOnFP7agDzDxVv5.verificationData.serverVerificationData)
      // - orderCode: FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.zU4ZT5YgrXaPLm7p (对应 Flutter: FlW0vlw1jBvjx3hy().zU4ZT5YgrXaPLm7p)
      purchaseVerified = await vAWWpfx9YFkwV6Gn(
        purchaseID: transactionInfo.transactionID,
        serverVerificationData: transactionInfo.serverVerificationData,
        orderCode: orderCode
      )
    }

    // 2. 如果验证通过，记录 Facebook App Events、Adjust 购买事件并处理购买
    // 对应 Flutter: if (RNOIvYDrtqGecxVX) { ... }
    if purchaseVerified {
      // 记录 Facebook App Events 购买事件
      // 对应 Flutter: await Yj13CDHFImgMtfHs.logPurchase(...)
      await logFacebookPurchaseEvent(product: WSnW7yuASkL0k)
      
      // 记录 Adjust 购买事件
      // 对应 Flutter: appPurchase(double dollar)
      await logAdjustPurchaseEvent(product: WSnW7yuASkL0k)

      // 3. 使用协议回调处理业务逻辑（增加余额、更新用户信息）
      // 对应 Flutter: CGjN9FLnkxYtpnWv(qNXm2HxkfygQcQvU);
      successHandler?.addBalance(WSnW7yuASkL0k.diaGDfiUAxvMX5uR)
      successHandler?.updateUser()

      return true
    } else {
      // 验证失败，设置错误状态
      // 对应 Flutter: Fluttertoast.showToast(msg: 'We were unable to confirm the purchase');
      errlTB7VE3zUfXPr = "We were unable to confirm the purchase"
      return false
    }
  }

  /// 记录 Facebook App Events 购买事件
  /// 对应 Flutter: await Yj13CDHFImgMtfHs.logPurchase(amount: e0Yw86siMyTlT7kCa, currency: 'USD', parameters: {'fb_mobile_purchase': 'true'})
  private func logFacebookPurchaseEvent(product: PayProdRVqoBpOpH) async {
    #if canImport(FBSDKCoreKit)
      // 获取产品价格（转换为 Double）
      // 对应 Flutter: double e0Yw86siMyTlT7kCa = p1fYA8tMl2NXEili[zF3X7Yv37gUMyY4C].otVxFTL18L21vA4K;
      let purchaseAmount = NSDecimalNumber(decimal: product.BEdd9dgBlT2XI).doubleValue

      print("📊 [PaymentModule] 记录 Facebook 购买事件 - 金额: \(purchaseAmount), 产品ID: \(product.id)")

      // 创建购买参数
      // 对应 Flutter: parameters: {'fb_mobile_purchase': 'true'}
      // 注意：Facebook SDK 要求参数键类型为 AppEvents.ParameterName
      // 可以使用 AppEvents.ParameterName(_:) 初始化器创建自定义参数名
      let parameters: [AppEvents.ParameterName: Any] = [
        AppEvents.ParameterName("fb_mobile_purchase"): "true",
        AppEvents.ParameterName("product_id"): product.id,
        AppEvents.ParameterName("product_name"): product.F3a0686zLgphO,
      ]

      // 记录购买事件到 Facebook App Events
      // 对应 Flutter: await Yj13CDHFImgMtfHs.logPurchase(amount: e0Yw86siMyTlT7kCa, currency: 'USD', parameters: {...})
      AppEvents.shared.logPurchase(
        amount: purchaseAmount,
        currency: "USD",
        parameters: parameters
      )

      // 刷新事件队列，确保事件被发送
      AppEvents.shared.flush()
    #else
      // 如果没有导入 Facebook SDK，只打印日志
      // 注意：要启用 Facebook App Events 记录，需要在项目中添加 FBSDKCoreKit 依赖
      // 详细步骤请参考项目根目录的 FACEBOOK_SDK_SETUP.md 文件
      print("⚠️ [PaymentModule] Facebook SDK 未导入，跳过购买事件记录")
      print("💡 提示：要启用 Facebook 购买事件记录，请添加 FBSDKCoreKit 依赖")
      print("📖 详细步骤请查看：FACEBOOK_SDK_SETUP.md")
    #endif
  }

  /// 记录 Adjust 购买事件
  /// 对应 Flutter: appPurchase(double dollar)
  private func logAdjustPurchaseEvent(product: PayProdRVqoBpOpH) async {
    // 获取产品价格（转换为 Double）
    // 对应 Flutter: double dollar = p1fYA8tMl2NXEili[zF3X7Yv37gUMyY4C].otVxFTL18L21vA4K;
    let purchaseAmount = NSDecimalNumber(decimal: product.BEdd9dgBlT2XI).doubleValue
    
    // 调用 AdjustService 跟踪购买事件
    // 对应 Flutter: appPurchase(dollar)
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
