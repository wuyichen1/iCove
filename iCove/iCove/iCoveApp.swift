//
//  iCoveApp.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  @_exported import HotSwiftUI
#endif

@main
struct iCoveApp: App {
  // MARK: - AppDelegate 用于处理应用生命周期和推送通知
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    // #if DEBUG
    // Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
    // #endif
    // 升级 InjectionNext 加载方式（推荐，自动找 bundle）
    #if DEBUG
      if let path = Bundle.main.path(forResource: "iOSInjection", ofType: "bundle")
        ?? Bundle.main.path(forResource: "macOSInjection", ofType: "bundle")
      {
        Bundle(path: path)!.load()
      }
    #endif

    // MARK: - 应用启动初始化
    // 对应 Flutter main() 函数中的初始化逻辑

    // 1. 初始化持久化数据（从存储中加载数据）
    // 对应 Flutter: await FlW0vlw1jBvjx3hy().r38wmZLXCKtowlhOi()
    FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.r38wmZLXCKtowlhOi()

    // 注意：Flutter 代码中有 clearAllPersistentData()，这通常是测试代码
    // 生产环境中不应该在启动时清空所有数据，所以这里注释掉
    // 如果需要清空数据，可以在特定场景下调用
    // FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.clearAllPersistentData()

    // 2. 启用屏幕保护（防止截图）
    // ScreenProtector.shared.preventScreenshotOn()

    // ScreenshotProtectionManager.shared.enable(policy: .all)
    DispatchQueue.main.async {
      ScreenshotProtectionManager.shared.enable(policy: .all)
    }

    // 3. 启用数据泄露保护（应用切换到后台时模糊）
    // 注意：这个功能在 AppDelegate 的 applicationDidEnterBackground 中实现
    // 这里不需要重复调用，因为会在应用进入后台时自动触发
  }

  @StateObject private var authManager = AuthManagA645b8Y0Aod3aVmod()

  // 创建全局的 Payn8tqsrRpmXPZWVmod，在 app 启动时初始化
  // 注意：这里先使用临时的 authManager，在 RootView 中会更新为实际的 authManager
  @StateObject private var paymentViewModel: Payn8tqsrRpmXPZWVmod = {
    let tempAuthManager = AuthManagA645b8Y0Aod3aVmod()
    return Payn8tqsrRpmXPZWVmod(IS2i7T25V612b: tempAuthManager, autoInitialize: true)
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
      // 设置屏幕方向锁定为竖屏
      // 对应 Flutter: SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      // 注意：屏幕方向主要在 Info.plist 中设置，这里只是补充
    }
  }
}

struct RootView: View {
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var paymentViewModel: Payn8tqsrRpmXPZWVmod
  @StateObject private var router = Router()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    Group {
      if authManager.isAutheda3IsmZzs015L5 {
        MainTabView()
          .environmentObject(authManager)
          .environmentObject(paymentViewModel)
      } else {
        AppNavigationView {
          WelcomeView()
        }
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
        .environmentObject(router)
      }
    }
    .animation(.easeInOut(duration: 0.3), value: authManager.isAutheda3IsmZzs015L5)
    .onAppear {
      paymentViewModel.updAuma7Cif2ltv9c65t(authManager)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}
