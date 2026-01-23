//
//  PaymentModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit

// MARK: - 支付产品模型
/// 支付产品信息模型
/// 用于存储从 App Store 获取的产品详情
struct PaymentProduct: Identifiable, Equatable {
  /// 产品 ID（与 App Store Connect 中配置的产品 ID 一致）
  let id: String

  /// 产品显示名称（从 App Store 获取）
  let displayName: String

  /// 产品描述（从 App Store 获取）
  let description: String

  /// 产品价格（本地化格式，例如：¥6.00）
  let price: String

  /// 产品价格数值（用于排序和计算）
  let priceValue: Decimal

  /// 产品对应的钻石数量（根据业务需求配置）
  let diamonds: Int

  /// 产品类型（消耗型、非消耗型、订阅型等）
  let productType: ProductType

  /// 从 StoreKit 的 Product 对象创建 PaymentProduct
  /// - Parameters:
  ///   - product: StoreKit 的 Product 对象
  ///   - diamonds: 该产品对应的钻石数量
  init(from product: Product, diamonds: Int) {
    self.id = product.id
    self.displayName = product.displayName
    self.description = product.description
    self.price = product.displayPrice
    self.priceValue = product.price
    self.diamonds = diamonds
    self.productType = ProductType(from: product.type)
  }
}

// MARK: - 产品类型枚举
/// 产品类型枚举
/// 对应 StoreKit 的产品类型
enum ProductType: String, Codable {
  /// 消耗型产品（Consumable）
  /// 用户购买后可以使用，用完后可以再次购买
  case consumable

  /// 非消耗型产品（Non-Consumable）
  /// 用户购买后永久拥有，不需要再次购买
  case nonConsumable

  /// 未知类型
  case unknown

  /// 从 StoreKit 的 Product.ProductType 创建 ProductType
  /// 注意：根据实际使用场景，这里主要处理消耗型和非消耗型产品
  /// 订阅类型产品需要单独处理
  init(from productType: Product.ProductType) {
    // 使用 if-else 来处理已知类型，避免 switch 的完整性检查问题
    if productType == .consumable {
      self = .consumable
    } else if productType == .nonConsumable {
      self = .nonConsumable
    } else {
      // 对于其他类型（如订阅），标记为未知
      self = .unknown
    }
  }
}

// MARK: - 支付状态枚举
/// 支付状态枚举
/// 用于表示支付流程的各个状态
enum PaymentStatus: Equatable {
  /// 空闲状态（未开始支付）
  case idle

  /// 正在加载产品信息
  case loadingProducts

  /// 正在处理支付
  case processing

  /// 支付成功
  case success

  /// 支付失败
  case failed(String)

  /// 支付已取消
  case canceled

  /// 支付已恢复（用于恢复购买）
  case restored
}

// MARK: - 支付错误枚举
/// 支付错误类型枚举
enum PaymentError: LocalizedError {
  /// 支付服务不可用（设备未登录 App Store 或网络问题）
  case serviceUnavailable

  /// 产品未找到（产品 ID 不存在或未在 App Store Connect 中配置）
  case productNotFound(String)

  /// 产品查询失败
  case productQueryFailed(String)

  /// 购买失败
  case purchaseFailed(String)

  /// 交易验证失败
  case transactionVerificationFailed

  /// 未知错误
  case unknown(String)

  var errorDescription: String? {
    switch self {
    case .serviceUnavailable:
      return "支付服务不可用，请检查网络连接或 App Store 登录状态"
    case .productNotFound(let productId):
      return "产品未找到：\(productId)"
    case .productQueryFailed(let message):
      return "产品查询失败：\(message)"
    case .purchaseFailed(let message):
      return "购买失败：\(message)"
    case .transactionVerificationFailed:
      return "交易验证失败"
    case .unknown(let message):
      return "未知错误：\(message)"
    }
  }
}

// MARK: - Purchase Option Model
/// 购买选项模型
struct PurchaseOption: Identifiable {
  /// 唯一标识符
  let id = UUID()

  /// 胡萝卜数量（对应钻石数量）
  let carrots: Int

  /// 价格（美元）
  let price: Double

  /// 产品 ID（App Store Connect 中的产品 ID，用于支付）
  /// 如果为 nil，则使用模拟支付（仅用于测试）
  let productId: String

  /// 初始化方法
  /// - Parameters:
  ///   - carrots: 胡萝卜数量
  ///   - price: 价格
  ///   - productId: 产品 ID（可选，如果为 nil 则使用模拟支付）
  init(carrots: Int, price: Double, productId: String) {
    self.carrots = carrots
    self.price = price
    self.productId = productId
  }
}

/// 钻石包配置列表
/// 根据 Flutter 代码中的 paycodeKeys 和业务需求配置
/// 注意：这里的钻石数量是示例，需要根据实际业务需求调整
let diamondPackages: [PurchaseOption] = [
  PurchaseOption(carrots: 400, price: 0.99, productId: "lvbsvhxcgcrvesor"),
  PurchaseOption(carrots: 800, price: 1.99, productId: "dxismgcwewhrtezo"),
  PurchaseOption(carrots: 2450, price: 4.99, productId: "khtxlcejaxmqcsra"),
  PurchaseOption(carrots: 3950, price: 7.99, productId: "yadwwvxspgxwlndb"),
  PurchaseOption(carrots: 5150, price: 9.99, productId: "qnrcuelbtiuflyky"),
  PurchaseOption(carrots: 10800, price: 19.99, productId: "ymohxnvpkqxutvab"),
  PurchaseOption(carrots: 14900, price: 29.99, productId: "hjykcaoxygywfq"),
  PurchaseOption(carrots: 29400, price: 49.99, productId: "mnfprttfacargfjo"),
  PurchaseOption(carrots: 34500, price: 69.99, productId: "gqyqcndprvmzsy"),
  PurchaseOption(carrots: 63700, price: 99.99, productId: "bsacoassevtvnezx"),
]

/// 产品 ID 列表
/// 从 App Store Connect 中配置的产品 ID
/// 这些 ID 需要与 diamondPackages 中的 productId 保持一致
let paymentProductIds: [String] = diamondPackages.map { $0.productId }
