//
//  PaymentViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit
import SwiftUI

/// 支付视图模型
/// 管理支付相关的状态和业务逻辑
/// 对应 Flutter 代码中的支付功能
@MainActor
class PaymentViewModel: ObservableObject {
  // MARK: - Published Properties
  /// 产品列表（从 App Store 获取的产品信息）
  @Published var products: [PaymentProduct] = []

  /// 当前支付状态
  @Published var paymentStatus: PaymentStatus = .idle

  /// 错误消息（如果有）
  @Published var errorMessage: String?

  /// 是否正在加载产品
  @Published var isLoadingProducts: Bool = false

  /// 当前选中的产品索引（用于购买）
  @Published var selectedProductIndex: Int?

  // MARK: - Private Properties
  /// 支付服务实例
  private let paymentService: PaymentServiceProtocol

  /// 认证管理器（用于更新用户余额）
  /// 注意：这个属性应该是可变的，以便在 WalletView 中更新
  private var authManager: AuthenticationManager

  /// 认证服务（用于更新用户信息）
  private let authService: AuthenticationServiceProtocol

  // MARK: - Initialization
  /// 初始化支付视图模型
  /// - Parameters:
  ///   - paymentService: 支付服务实例（默认使用单例）
  ///   - authManager: 认证管理器（用于更新用户余额）
  ///   - authService: 认证服务（用于更新用户信息）
  init(
    paymentService: PaymentServiceProtocol? = nil,
    authManager: AuthenticationManager,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    autoInitialize: Bool = false
  ) {
    self.paymentService = paymentService ?? PaymentService.shared
    self.authManager = authManager
    self.authService = authService

    // 只有在明确要求时才自动初始化（用于 app 启动时的全局初始化）
    if autoInitialize {
      Task {
        await initializePayment()
      }
    }
  }

  // MARK: - Public Methods
  /// 初始化支付系统
  /// 对应 Flutter 代码中的 initailPurchase() 函数
  /// 1. 检查支付服务是否可用
  /// 2. 清理待处理的交易（iOS）
  /// 3. 加载产品列表
  func initializePayment() async {
    guard await paymentService.isPaymentServiceAvailable() else {
      paymentStatus = .failed("Payment services unavailable")
      errorMessage = "Payment services unavailable"
      return
    }

    // iOS 平台：清理待处理的交易
    // 对应 Flutter 代码中的 toisIOS() 函数
    if let paymentService = paymentService as? PaymentService {
      await paymentService.clearPendingTransactions()
    }

    await loadProducts()
  }

  func loadProducts() async {
    guard !isLoadingProducts else { return }

    isLoadingProducts = true
    errorMessage = nil
    paymentStatus = .loadingProducts

    do {
      let loadedProducts = try await paymentService.queryProducts(productIds: paymentProductIds)

      products = loadedProducts
      paymentStatus = .idle

      if products.isEmpty {
        errorMessage = "No products found"
      }
    } catch {
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription
      errorMessage = errorMsg
      paymentStatus = .failed(errorMsg)
      products = []
    }

    isLoadingProducts = false
  }

  /// 购买产品
  /// 对应 Flutter 代码中的 payRealfunc() 函数
  /// - Parameter productId: 要购买的产品 ID
  func purchaseProduct(productId: String) async {
    if products.isEmpty {
      await loadProducts()
    }

    guard let product = products.first(where: { $0.id == productId }) else {
      errorMessage = "Product not found"
      paymentStatus = .failed("Product not found")
      return
    }

    // 记录选中的产品索引（用于后续更新余额）
    selectedProductIndex = products.firstIndex(where: { $0.id == productId })

    guard await paymentService.isPaymentServiceAvailable() else {
      errorMessage = "Payment services unavailable"
      paymentStatus = .failed("Payment services unavailable")
      return
    }

    if let paymentService = paymentService as? PaymentService {
      await paymentService.clearPendingTransactions()
    }

    await performPurchase(product)
  }

  /// 执行购买操作
  /// - Parameter product: 要购买的产品
  private func performPurchase(_ product: PaymentProduct) async {
    paymentStatus = .processing
    errorMessage = nil

    do {
      let success = try await paymentService.purchaseProduct(product)

      if success {
        // 购买成功，更新用户余额
        await updateUserBalance(for: product)
        paymentStatus = .success
        errorMessage = nil

        if let paymentService = paymentService as? PaymentService {
          await paymentService.clearPendingTransactions()
        }
      } else {
        paymentStatus = .canceled
        errorMessage = "Purchase canceled"
      }
    } catch {
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription

      if errorMsg.lowercased().contains("cancel") {
        paymentStatus = .canceled
      } else {
        paymentStatus = .failed(errorMsg)
      }

      errorMessage = errorMsg

      if let paymentService = paymentService as? PaymentService {
        await paymentService.clearPendingTransactions()
      }
    }
  }

  /// 恢复购买
  /// 恢复用户之前购买的非消耗型产品和订阅
  func restorePurchases() async {
    paymentStatus = .processing
    errorMessage = nil

    do {
      let restoredCount = try await paymentService.restorePurchases()
      paymentStatus = restoredCount > 0 ? .restored : .idle
      errorMessage =
        restoredCount > 0 ? "Restored \(restoredCount) purchases" : "No purchases to restore"
    } catch {
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription
      paymentStatus = .failed(errorMsg)
      errorMessage = errorMsg
    }
  }

  func refreshProducts() async {
    await loadProducts()
  }

  func resetPaymentStatus() {
    paymentStatus = .idle
    errorMessage = nil
    selectedProductIndex = nil
  }

  // MARK: - Private Methods
  /// 更新用户余额
  /// 对应 Flutter 代码中的 updateLocal() 函数
  /// 购买成功后，根据产品对应的钻石数量更新用户余额
  /// - Parameter product: 购买的产品
  private func updateUserBalance(for product: PaymentProduct) async {
    authManager.addBalance(product.diamonds)
    if let currentUser = authManager.currentUser {
      authService.updateUser(currentUser)
    }
  }

  /// 根据产品 ID 获取产品
  /// - Parameter productId: 产品 ID
  /// - Returns: 产品对象，如果未找到返回 nil
  func getProduct(by productId: String) -> PaymentProduct? {
    return products.first { $0.id == productId }
  }

  /// 获取选中的产品 ID
  /// - Returns: 选中的产品 ID，如果未找到返回 nil
  func getSelectedProductId() -> String? {
    guard let index = selectedProductIndex, index < products.count else {
      return nil
    }
    return products[index].id
  }

  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
  }
}
