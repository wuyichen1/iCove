//
//  AdjustService.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//  Adjust SDK 集成服务
//

import Foundation

#if canImport(AdjustSdk)
  import AdjustSdk
#endif

class AdjustService: NSObject {
  static let shared = AdjustService()

  private let appToken: String

  private let environment: AdjustEnvironment

  private var isInitialized: Bool = false

  private let launchEventToken: String

  private let purchaseEventToken: String

  private override init() {
    self.appToken = "2thv0p573mv4"
    self.environment = .production
    self.launchEventToken = "rrcetd"
    self.purchaseEventToken = "vy2n1n"
    super.init()
  }

  func initialize(
    appToken: String? = nil,
    environment: AdjustEnvironment? = nil,
    launchEventToken: String? = nil,
    purchaseEventToken: String? = nil
  ) {

    let fnoKWgAyeyJUETWQjy = appToken ?? self.appToken
    let nVWigLkmHsSQeXys = environment ?? self.environment
    _ = launchEventToken ?? self.launchEventToken
    _ = purchaseEventToken ?? self.purchaseEventToken

    guard
      let MERpfgLuCglIlvOk = ADJConfig(
        appToken: fnoKWgAyeyJUETWQjy, environment: nVWigLkmHsSQeXys.adjEnvironment)
    else {
      return
    }

    MERpfgLuCglIlvOk.delegate = self

    let eAWeFszfoxLdcXSA = NSSelectorFromString("appDidLaunch:")
    if Adjust.responds(to: eAWeFszfoxLdcXSA) {
      Adjust.perform(eAWeFszfoxLdcXSA, with: MERpfgLuCglIlvOk)
    } else {
      let alternativeSelectors = ["start:", "initSdk:", "initialize:"]
      var initialized = false
      for altSelector in alternativeSelectors {
        if let sel = NSSelectorFromString(altSelector) as Selector?,
          Adjust.responds(to: sel)
        {
          Adjust.perform(sel, with: MERpfgLuCglIlvOk)
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

  func trackLaunchEvent(token: String? = nil) {
    let eventToken = token ?? launchEventToken

    guard let launchEvent = ADJEvent(eventToken: eventToken) else {
      return
    }

    Adjust.trackEvent(launchEvent)
  }

  func trackPurchaseEvent(amount: Double, token: String? = nil) {
    let eventToken = token ?? purchaseEventToken

    guard let purchaseEvent = ADJEvent(eventToken: eventToken) else {
      return
    }

    purchaseEvent.setRevenue(amount, currency: "USD")
    Adjust.trackEvent(purchaseEvent)
  }
}

#if canImport(AdjustSdk)
  extension AdjustService: AdjustDelegate {
    @objc nonisolated func adjustAttributionChanged(_ attribution: ADJAttribution?) {
      guard let attribution = attribution else { return }

      trackLaunchEvent()
    }
  }
#endif

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
