//
//  PaymentService.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit

// MARK: - 支付服务协议
/// 支付服务协议
/// 定义支付相关的接口，便于测试和替换实现
protocol PaymentServiceProtocol {
  /// 检查支付服务是否可用
  func isPaymentServiceAvailable() async -> Bool

  /// 查询产品详情
  /// - Parameter productIds: 产品 ID 列表
  /// - Returns: 产品详情列表
  func queryProducts(productIds: [String]) async throws -> [PaymentProduct]

  /// 购买产品
  /// - Parameter product: 要购买的产品
  /// - Returns: 购买结果（成功或失败）
  func purchaseProduct(_ product: PaymentProduct) async throws -> Bool

  /// 恢复购买
  /// - Returns: 恢复的购买数量
  func restorePurchases() async throws -> Int

  /// 完成交易
  /// - Parameter transaction: 交易对象
  func finishTransaction(_ transaction: Transaction) async
}

// MARK: - 支付服务实现
/// 支付服务实现类
/// 使用 StoreKit 2.0 实现 App Store 内购功能
/// 支持 Sandbox 模式和正式环境
@MainActor
class PaymentService: PaymentServiceProtocol {
  // MARK: - Singleton
  /// 单例实例
  static let shared = PaymentService()

  // MARK: - Private Properties
  /// 已加载的产品列表（缓存）
  private var cachedProducts: [PaymentProduct] = []

  /// 产品更新监听任务
  private var updateListenerTask: Task<Void, Error>?

  // MARK: - Initialization
  /// 私有初始化方法（单例模式）
  private init() {
    // 启动交易更新监听
    startTransactionListener()
  }

  deinit {
    // 取消监听任务
    updateListenerTask?.cancel()
  }

  // MARK: - Transaction Listener
  private func startTransactionListener() {
    updateListenerTask = Task {
      for await result in Transaction.updates {
        do {
          let transaction = try checkVerified(result)

          // 处理交易（这里可以根据需要添加业务逻辑）
          // 例如：更新用户钻石数量、记录购买历史等
          await handleTransaction(transaction)

          // 完成交易（重要：必须调用，否则交易会一直挂起）
          await transaction.finish()
        } catch {
          // 静默处理验证失败，避免影响其他交易
        }
      }
    }
  }

  private func handleTransaction(_ transaction: Transaction) async {
    // 可在此处添加服务器端交易验证逻辑
  }

  // MARK: - Payment Service Availability
  /// 检查支付服务是否可用
  /// - Returns: 如果支付服务可用返回 true，否则返回 false
  func isPaymentServiceAvailable() async -> Bool {
    // 检查设备是否支持内购
    // StoreKit 2.0 会自动处理，如果设备不支持会返回错误
    do {
      // 尝试查询一个空的产品列表来检查服务可用性
      // 如果服务不可用，会抛出错误
      _ = try await Product.products(for: [])
      return true
    } catch {
      return false
    }
  }

  // MARK: - Query Products
  /// 查询产品详情
  /// 从 App Store 获取指定产品 ID 的详细信息（价格、名称、描述等）
  /// - Parameter productIds: 产品 ID 列表
  /// - Returns: 产品详情列表，按价格从低到高排序
  /// - Throws: PaymentError 如果查询失败
  func queryProducts(productIds: [String]) async throws -> [PaymentProduct] {
    do {
      let storeProducts = try await Product.products(for: productIds)

      if storeProducts.isEmpty {
        throw PaymentError.productQueryFailed("No products found")
      }

      var paymentProducts: [PaymentProduct] = []

      for storeProduct in storeProducts {
        // 从 diamondPackages 中找到对应的钻石数量
        let diamonds =
          diamondPackages.first(where: { $0.productId == storeProduct.id })?.carrots ?? 0
        paymentProducts.append(PaymentProduct(from: storeProduct, diamonds: diamonds))
      }

      // 按价格从低到高排序（与 Flutter 代码保持一致）
      paymentProducts.sort { $0.priceValue < $1.priceValue }
      cachedProducts = paymentProducts

      return paymentProducts
    } catch let error as PaymentError {
      throw error
    } catch {
      throw PaymentError.productQueryFailed(error.localizedDescription)
    }
  }

  // MARK: - Purchase Product
  func purchaseProduct(_ product: PaymentProduct) async throws -> Bool {
    let storeProducts = try await Product.products(for: [product.id])

    guard let storeProduct = storeProducts.first else {
      throw PaymentError.productNotFound("Product not found: \(product.id)")
    }

    do {
      let result = try await storeProduct.purchase()

      switch result {
      case .success(let verification):
        let transaction = try checkVerified(verification)

        // 处理交易（更新用户钻石等）
        await handleTransaction(transaction)

        // 完成交易（重要：必须调用）
        await transaction.finish()
        return true

      case .userCancelled:
        throw PaymentError.purchaseFailed("User canceled the purchase")

      case .pending:
        // 购买待处理（例如：需要家长批准）
        // 这种情况下，交易会在稍后完成
        // 可以通过 Transaction.updates 监听交易状态变化
        throw PaymentError.purchaseFailed("Purchase pending, please check later")

      @unknown default:
        throw PaymentError.unknown("Unknown purchase status")
      }
    } catch {
      if let paymentError = error as? PaymentError {
        throw paymentError
      } else {
        throw PaymentError.purchaseFailed(error.localizedDescription)
      }
    }
  }

  // MARK: - Restore Purchases
  /// 恢复购买
  /// 恢复用户之前购买的非消耗型产品和订阅
  /// - Returns: 恢复的购买数量
  /// - Throws: PaymentError 如果恢复失败
  func restorePurchases() async throws -> Int {
    var restoredCount = 0

    do {
      for await result in Transaction.currentEntitlements {
        let transaction = try checkVerified(result)
        await handleTransaction(transaction)
        await transaction.finish()
        restoredCount += 1
      }

      return restoredCount
    } catch {
      throw PaymentError.unknown("Restore purchase failed: \(error.localizedDescription)")
    }
  }

  // MARK: - Finish Transaction
  func finishTransaction(_ transaction: Transaction) async {
    await transaction.finish()
  }

  // MARK: - Transaction Verification
  private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    switch result {
    case .unverified(_, _):
      throw PaymentError.transactionVerificationFailed
    case .verified(let safe):
      return safe
    }
  }

  // MARK: - Clear Pending Transactions
  func clearPendingTransactions() async {
    for await result in Transaction.unfinished {
      do {
        let transaction = try checkVerified(result)
        await transaction.finish()
      } catch {
        // 静默处理验证失败
      }
    }
  }
}
