//
//  AppDelegate.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import UIKit
import UserNotifications

/// AppDelegate 用于处理应用生命周期和推送通知
class AppDelegate: NSObject, UIApplicationDelegate {

  // private var tempBlackOverlay: UIView?  // 临时黑屏覆盖层，用于防止应用切换器快照延迟

  // MARK: - 应用启动完成
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // 初始化 Adjust SDK
    // 对应 Flutter: adjustInit()
    // 注意：需要在 AdjustService.swift 中配置实际的 App Token 和事件 Token
    AdjustService.shared.initialize()

    // 注册推送通知
    registerForPushNotifications(application: application)

    // 设置屏幕方向锁定为竖屏
    setupScreenOrientation()

    // 启用截图保护
    // ScreenshotProtectionManager.shared.enable(policy: .all)

    return true
  }

  // MARK: - 推送通知注册
  /// 注册推送通知，对应 Flutter 中的 MethodChannel 处理
  private func registerForPushNotifications(application: UIApplication) {
    // 请求推送通知权限
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
      granted, _ in
      if granted {
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      }
    }
  }

  // MARK: - 推送 Token 处理
  /// 成功注册推送通知后，获取 device token
  /// 对应 Flutter 中 MethodChannel 的 'RetrographicSubpixelAntiAliasingReceived' 方法
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    // 将 device token 转换为字符串
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()

    print("Push token received: \(token)")

    // 保存推送 token 到持久化存储
    // 对应 Flutter 中的 FlW0vlw1jBvjx3hy().mmnN2bMkxLm3iqBA = p2JaMIqVMQCEjszQE
    FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.mmnN2bMkxLm3iqBA = token
  }

  /// 推送通知注册失败
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
  }

  // MARK: - 屏幕方向设置
  /// 设置屏幕方向锁定为竖屏
  /// 对应 Flutter 中的 SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  private func setupScreenOrientation() {
    // 在 iOS 中，屏幕方向通常在 Info.plist 中设置
    // 如果需要动态设置，可以使用以下代码（需要在支持的界面中设置）
    // 注意：SwiftUI 中通常通过 .preferredInterfaceOrientationForPresentation 或 Info.plist 设置
  }
}
