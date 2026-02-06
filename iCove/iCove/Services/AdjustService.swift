//
//  AdjustService.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//  Adjust SDK 集成服务
//
//  ============================================
//  使用说明
//  ============================================
//
//  此文件包含了 Adjust SDK 的完整集成，包括：
//  1. Adjust SDK 初始化配置
//  2. 归因回调处理
//  3. 安装事件跟踪（appLaunch）
//  4. 购买事件跟踪（appPurchase）
//
//  对应 Flutter 代码：
//   - adjustInit() - 初始化 Adjust SDK
//   - appLaunch() - 安装事件跟踪
//   - appPurchase() - 购买事件跟踪
//
//  ============================================

import Foundation

// Adjust SDK - 用于归因和事件跟踪
#if canImport(AdjustSdk)
  import AdjustSdk
#endif

/// Adjust SDK 服务类
/// 对应 Flutter 中的 adjustInit、appLaunch、appPurchase 函数
class AdjustService: NSObject {
  /// 单例实例
  static let shared = AdjustService()

  /// App Token
  private let appToken: String

  /// 环境配置（生产环境或沙盒环境）
  private let environment: AdjustEnvironment

  /// 是否已初始化
  private var isInitialized: Bool = false

  /// 初始化事件 Token
  private let launchEventToken: String

  /// 购买事件 Token
  private let purchaseEventToken: String

  /// 私有初始化方法
  private override init() {
    self.appToken = "2thv0p573mv4"
    self.environment = .production
    self.launchEventToken = "rrcetd"  // 安装事件 Token
    self.purchaseEventToken = "vy2n1n"  // 购买事件 Token
    super.init()
  }

  // MARK: - 初始化 Adjust SDK

  /// 初始化 Adjust SDK
  /// 对应 Flutter: adjustInit()
  func initialize(
    appToken: String? = nil,
    environment: AdjustEnvironment? = nil,
    launchEventToken: String? = nil,
    purchaseEventToken: String? = nil
  ) {

    let finalAppToken = appToken ?? self.appToken
    let finalEnvironment = environment ?? self.environment
    _ = launchEventToken ?? self.launchEventToken
    _ = purchaseEventToken ?? self.purchaseEventToken

    // 创建 Adjust 配置
    guard
      let adjustConfig = ADJConfig(
        appToken: finalAppToken, environment: finalEnvironment.adjEnvironment)
    else {
      return
    }

    adjustConfig.delegate = self

    let selector = NSSelectorFromString("appDidLaunch:")
    if Adjust.responds(to: selector) {
      Adjust.perform(selector, with: adjustConfig)
    } else {
      let alternativeSelectors = ["start:", "initSdk:", "initialize:"]
      var initialized = false
      for altSelector in alternativeSelectors {
        if let sel = NSSelectorFromString(altSelector) as Selector?,
          Adjust.responds(to: sel)
        {
          Adjust.perform(sel, with: adjustConfig)
          initialized = true
          break
        }
      }
      if !initialized {
        return
      }
    }

    isInitialized = true

  }

  // MARK: - 事件跟踪

  /// 跟踪安装事件
  /// 对应 Flutter: appLaunch(String launch_token)
  func trackLaunchEvent(token: String? = nil) {
    let eventToken = token ?? launchEventToken

    guard let launchEvent = ADJEvent(eventToken: eventToken) else {
      return
    }

    Adjust.trackEvent(launchEvent)
  }

  /// 跟踪购买事件
  /// 对应 Flutter: appPurchase(double dollar)
  func trackPurchaseEvent(amount: Double, token: String? = nil) {
    let eventToken = token ?? purchaseEventToken

    guard let purchaseEvent = ADJEvent(eventToken: eventToken) else {
      return
    }

    purchaseEvent.setRevenue(amount, currency: "USD")
    Adjust.trackEvent(purchaseEvent)
  }
}

// MARK: - AdjustDelegate (归因回调)

#if canImport(AdjustSdk)
  extension AdjustService: AdjustDelegate {
    @objc nonisolated func adjustAttributionChanged(_ attribution: ADJAttribution?) {
      guard let attribution = attribution else { return }

      print("📊 [AdjustService] 归因信息更新:")
      print("   - Tracker Token: \(attribution.trackerToken ?? "nil")")
      print("   - Tracker Name: \(attribution.trackerName ?? "nil")")
      print("   - Network: \(attribution.network ?? "nil")")
      print("   - Campaign: \(attribution.campaign ?? "nil")")
      print("   - Adgroup: \(attribution.adgroup ?? "nil")")
      print("   - Creative: \(attribution.creative ?? "nil")")
      print("   - Click Label: \(attribution.clickLabel ?? "nil")")

      // 应用安装事件
      trackLaunchEvent()
    }
  }
#endif

// MARK: - Adjust Environment 枚举

enum AdjustEnvironment {
  case production
  case sandbox

  var adjEnvironment: String {
    switch self {
    case .production:
      #if canImport(AdjustSdk)
        return ADJEnvironmentProduction
      #else
        return "production"
      #endif
    case .sandbox:
      #if canImport(AdjustSdk)
        return ADJEnvironmentSandbox
      #else
        return "sandbox"
      #endif
    }
  }
}
