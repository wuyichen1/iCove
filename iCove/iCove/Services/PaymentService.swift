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
  /// 启动交易更新监听
  /// 监听所有交易状态变化（包括购买、恢复、失败等）
  private func startTransactionListener() {
    updateListenerTask = Task {
      // 遍历所有交易更新
      for await result in Transaction.updates {
        do {
          // 验证交易
          let transaction = try checkVerified(result)

          // 处理交易（这里可以根据需要添加业务逻辑）
          // 例如：更新用户钻石数量、记录购买历史等
          await handleTransaction(transaction)

          // 完成交易（重要：必须调用，否则交易会一直挂起）
          await transaction.finish()
        } catch {
          // 交易验证失败，记录错误但不阻止其他交易
          // 静默处理，避免影响其他交易
        }
      }
    }
  }

  /// 处理交易
  /// - Parameter transaction: 已验证的交易对象
  private func handleTransaction(_ transaction: Transaction) async {
    // 注意：在实际应用中，建议在这里调用服务器 API 验证交易
    // 以确保交易的真实性和安全性
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
      // 使用 StoreKit 2.0 查询产品
      // 注意：productIds 必须与 App Store Connect 中配置的产品 ID 完全一致
      let storeProducts = try await Product.products(for: productIds)

      // 如果没有任何产品被找到，抛出错误
      if storeProducts.isEmpty {
        throw PaymentError.productQueryFailed("未找到任何产品，请检查 App Store Connect 配置")
      }

      // 将 StoreKit 的 Product 转换为我们的 PaymentProduct
      var paymentProducts: [PaymentProduct] = []

      for storeProduct in storeProducts {
        // 根据 productId 查找对应的钻石包配置
        if let package = diamondPackages.first(where: { $0.productId == storeProduct.id }) {
          let paymentProduct = PaymentProduct(
            from: storeProduct,
            diamonds: package.carrots
          )
          paymentProducts.append(paymentProduct)
        } else {
          // 如果找不到配置，使用默认值（0 钻石）
          let paymentProduct = PaymentProduct(
            from: storeProduct,
            diamonds: 0
          )
          paymentProducts.append(paymentProduct)
        }
      }

      // 按价格从低到高排序（与 Flutter 代码保持一致）
      paymentProducts.sort { $0.priceValue < $1.priceValue }

      // 更新缓存
      cachedProducts = paymentProducts

      return paymentProducts
    } catch let error as PaymentError {
      // 如果是我们自定义的错误，直接抛出
      throw error
    } catch {
      // 处理其他查询错误
      throw PaymentError.productQueryFailed(error.localizedDescription)
    }
  }

  // MARK: - Purchase Product
  /// 购买产品
  /// 发起 App Store 购买流程
  /// - Parameter product: 要购买的产品
  /// - Returns: 如果购买成功返回 true
  /// - Throws: PaymentError 如果购买失败
  func purchaseProduct(_ product: PaymentProduct) async throws -> Bool {
    // 首先需要获取 StoreKit 的 Product 对象
    // 因为 purchase() 方法需要 Product 对象，而不是我们的 PaymentProduct
    let storeProducts = try await Product.products(for: [product.id])

    guard let storeProduct = storeProducts.first else {
      throw PaymentError.productNotFound("产品未找到：\(product.id)")
    }

    do {
      // 发起购买
      // 这会显示 App Store 的购买确认对话框
      let result = try await storeProduct.purchase()

      // 处理购买结果
      switch result {
      case .success(let verification):
        // 购买成功，验证交易
        let transaction = try checkVerified(verification)

        // 处理交易（更新用户钻石等）
        await handleTransaction(transaction)

        // 完成交易（重要：必须调用）
        await transaction.finish()

        return true

      case .userCancelled:
        // 用户取消购买
        throw PaymentError.purchaseFailed("用户取消了购买")

      case .pending:
        // 购买待处理（例如：需要家长批准）
        // 这种情况下，交易会在稍后完成
        // 可以通过 Transaction.updates 监听交易状态变化
        throw PaymentError.purchaseFailed("购买待处理，请稍后查看")

      @unknown default:
        // 未知状态
        throw PaymentError.unknown("未知的购买状态")
      }
    } catch {
      // 处理购买错误
      let errorMessage = error.localizedDescription

      // 检测是否是 Sandbox 账户相关错误
      // StoreKit 在需要 Sandbox 账户时会返回特定错误
      if errorMessage.contains("sandbox") || errorMessage.contains("Sandbox")
        || errorMessage.contains("测试") || errorMessage.contains("test")
      {
        // Sandbox 账户相关错误
        throw PaymentError.purchaseFailed("需要 Sandbox 测试账户。购买时会自动提示登录 Sandbox 账户，请按照提示操作。")
      } else {
        // 其他购买错误
        if let paymentError = error as? PaymentError {
          throw paymentError
        } else {
          throw PaymentError.purchaseFailed(errorMessage)
        }
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
      // 遍历当前应用的所有交易
      // 只处理未完成的交易（即未调用 finish() 的交易）
      for await result in Transaction.currentEntitlements {
        let transaction = try checkVerified(result)

        // 处理恢复的交易
        await handleTransaction(transaction)

        // 完成交易
        await transaction.finish()

        restoredCount += 1
      }

      return restoredCount
    } catch {
      throw PaymentError.unknown("恢复购买失败: \(error.localizedDescription)")
    }
  }

  // MARK: - Finish Transaction
  /// 完成交易
  /// 告诉 App Store 交易已处理完成，可以移除
  /// - Parameter transaction: 要完成的交易对象
  func finishTransaction(_ transaction: Transaction) async {
    await transaction.finish()
  }

  // MARK: - Transaction Verification
  /// 验证交易
  /// 检查交易是否有效且未被撤销
  /// - Parameter result: 交易验证结果
  /// - Returns: 已验证的交易对象
  /// - Throws: PaymentError 如果验证失败
  private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    switch result {
    case .unverified(_, _):
      // 交易验证失败（可能是被篡改或无效）
      throw PaymentError.transactionVerificationFailed

    case .verified(let safe):
      // 交易验证成功
      return safe
    }
  }

  // MARK: - Clear Pending Transactions (iOS)
  /// 清理待处理的交易（iOS 专用）
  /// 在 iOS 上，如果有未完成的交易，需要先完成它们才能进行新的购买
  /// 这个方法对应 Flutter 代码中的 toisIOS() 函数
  func clearPendingTransactions() async {
    // 遍历所有未完成的交易
    for await result in Transaction.unfinished {
      do {
        let transaction = try checkVerified(result)

        // 完成交易
        await transaction.finish()
      } catch {
        // 如果验证失败，仍然尝试完成交易（避免阻塞）
        // 静默处理，避免影响其他交易
      }
    }
  }
}
