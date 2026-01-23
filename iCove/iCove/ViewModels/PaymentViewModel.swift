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
    // 检查支付服务是否可用
    let isAvailable = await paymentService.isPaymentServiceAvailable()
    if !isAvailable {
      paymentStatus = .failed("支付服务不可用，请检查网络连接或 App Store 登录状态")
      errorMessage = "支付服务不可用，请检查网络连接或 App Store 登录状态"
      return
    }

    // iOS 平台：清理待处理的交易
    // 对应 Flutter 代码中的 toisIOS() 函数
    if let paymentService = paymentService as? PaymentService {
      await paymentService.clearPendingTransactions()
    }

    // 加载产品列表
    await loadProducts()
  }

  /// 加载产品列表
  /// 对应 Flutter 代码中的 cunzaiPurchase() 函数
  /// 从 App Store 查询产品详情并更新本地产品列表
  func loadProducts() async {
    guard !isLoadingProducts else { return }

    isLoadingProducts = true
    errorMessage = nil
    paymentStatus = .loadingProducts

    do {
      // 查询产品详情
      // 使用 paymentProductIds（从 PaymentModels.swift 中定义的产品 ID 列表）
      let loadedProducts = try await paymentService.queryProducts(productIds: paymentProductIds)

      // 更新产品列表
      products = loadedProducts

      // 如果产品列表为空，显示警告
      if products.isEmpty {
        errorMessage = "未找到可用的产品，请检查 App Store Connect 配置"
        paymentStatus = .idle
      } else {
        paymentStatus = .idle
      }
    } catch {
      // 处理错误
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription
      errorMessage = errorMsg
      paymentStatus = .failed(errorMsg)
      products = []  // 清空产品列表
    }

    isLoadingProducts = false
  }

  /// 购买产品
  /// 对应 Flutter 代码中的 payRealfunc() 函数
  /// - Parameter productId: 要购买的产品 ID
  func purchaseProduct(productId: String) async {
    // 查找产品
    guard let product = products.first(where: { $0.id == productId }) else {
      errorMessage = "产品未找到：\(productId)"
      paymentStatus = .failed("产品未找到")
      return
    }

    // 记录选中的产品索引（用于后续更新余额）
    selectedProductIndex = products.firstIndex(where: { $0.id == productId })

    // 检查支付服务是否可用
    let isAvailable = await paymentService.isPaymentServiceAvailable()
    if !isAvailable {
      errorMessage = "支付服务不可用，请检查网络连接或 App Store 登录状态"
      paymentStatus = .failed("支付服务不可用")
      return
    }

    // iOS 平台：清理待处理的交易
    // 对应 Flutter 代码中的 toisIOS() 函数
    if let paymentService = paymentService as? PaymentService {
      await paymentService.clearPendingTransactions()
    }

    // 如果产品列表为空，先加载产品
    if products.isEmpty {
      await loadProducts()
      // 重新查找产品
      guard let updatedProduct = products.first(where: { $0.id == productId }) else {
        errorMessage = "产品未找到：\(productId)"
        paymentStatus = .failed("产品未找到")
        return
      }
      await performPurchase(updatedProduct)
    } else {
      await performPurchase(product)
    }
  }

  /// 执行购买操作
  /// - Parameter product: 要购买的产品
  private func performPurchase(_ product: PaymentProduct) async {
    paymentStatus = .processing
    errorMessage = nil

    do {
      // 发起购买
      let success = try await paymentService.purchaseProduct(product)

      if success {
        // 购买成功，更新用户余额
        await updateUserBalance(for: product)

        paymentStatus = .success
        errorMessage = nil

        // iOS 平台：清理待处理的交易
        // 对应 Flutter 代码中的 toisIOS() 函数
        if let paymentService = paymentService as? PaymentService {
          await paymentService.clearPendingTransactions()
        }
      } else {
        // 购买失败（但未抛出异常，可能是用户取消）
        paymentStatus = .canceled
        errorMessage = "购买已取消"
      }
    } catch {
      // 处理购买错误
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription

      // 判断是否是用户取消
      if errorMsg.contains("取消") || errorMsg.contains("cancelled") {
        paymentStatus = .canceled
      } else {
        paymentStatus = .failed(errorMsg)
      }

      errorMessage = errorMsg

      // iOS 平台：清理待处理的交易
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

      if restoredCount > 0 {
        paymentStatus = .restored
        errorMessage = "已恢复 \(restoredCount) 个购买"
      } else {
        paymentStatus = .idle
        errorMessage = "没有可恢复的购买"
      }
    } catch {
      let errorMsg = (error as? PaymentError)?.errorDescription ?? error.localizedDescription
      paymentStatus = .failed(errorMsg)
      errorMessage = errorMsg
    }
  }

  /// 刷新产品列表
  func refreshProducts() async {
    await loadProducts()
  }

  /// 重置支付状态
  /// 将支付状态重置为空闲状态
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
    // 获取产品对应的钻石数量
    let diamonds = product.diamonds

    // 更新用户余额
    // 使用 AuthenticationManager 的 addBalance 方法
    authManager.addBalance(diamonds)

    // 同步更新认证服务中的用户信息
    // 确保数据一致性
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

  /// 根据产品 ID 获取对应的钻石数量
  /// - Parameter productId: 产品 ID
  /// - Returns: 钻石数量，如果未找到返回 0
  func getDiamonds(for productId: String) -> Int {
    return getProduct(by: productId)?.diamonds ?? 0
  }

  /// 检查支付服务是否可用
  /// - Returns: 如果支付服务可用返回 true
  func checkPaymentServiceAvailable() async -> Bool {
    return await paymentService.isPaymentServiceAvailable()
  }

  /// 获取当前选中的产品 ID
  /// - Returns: 产品 ID，如果未选中返回 nil
  func getSelectedProductId() -> String? {
    guard let index = selectedProductIndex,
      index < products.count
    else {
      return nil
    }
    return products[index].id
  }

  /// 更新认证管理器
  /// 用于在 WalletView 中更新为 EnvironmentObject 中的 authManager
  /// - Parameter authManager: 新的认证管理器
  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
  }
}
