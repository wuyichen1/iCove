//
//  iCoveApp.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  @_exported import HotSwiftUI  // 全局导出 .enableInjection() 和 @ObserveInjection
#endif

@main
struct iCoveApp: App {
  // // 添加这个静态闭包（推荐方式，延迟加载且安全）
  // #if DEBUG
  // private static let loadInjection: Void = {
  //     // 加载 bundle（模拟器用 iOSInjection.bundle）
  //     Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()

  //     // 如果是 tvOS 项目，用 tvOSInjection.bundle
  //     // 如果是 macOS，用 macOSInjection.bundle
  // }()
  // #endif
  // 或者 //
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
  }

  @StateObject private var authManager = AuthenticationManager()

  // 创建全局的 PaymentViewModel，在 app 启动时初始化
  // 注意：这里先使用临时的 authManager，在 RootView 中会更新为实际的 authManager
  @StateObject private var paymentViewModel: PaymentViewModel = {
    let tempAuthManager = AuthenticationManager()
    return PaymentViewModel(authManager: tempAuthManager, autoInitialize: true)
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
    }
  }
}

/// 根视图 - 根据登录状态切换显示内容
struct RootView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var paymentViewModel: PaymentViewModel
  @StateObject private var router = Router()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    Group {
      if authManager.isAuthenticated {
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
    .animation(.easeInOut(duration: 0.3), value: authManager.isAuthenticated)
    .onAppear {
      // 更新 PaymentViewModel 中的 authManager
      paymentViewModel.updateAuthManager(authManager)
    }
    .enableInjection()
  }
}
