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
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
    }

    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authManager)
        }
    }
}

/// 根视图 - 根据登录状态切换显示内容
struct RootView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(authManager)
            } else {
                WelcomeView()
                    .environmentObject(authManager)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: authManager.isAuthenticated)
        .enableInjection()
    }
}
