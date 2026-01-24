//
//  MainTabView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

struct MainTabView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var paymentViewModel: PaymentViewModel
  @StateObject private var router = Router()
  @State private var selectedTab: TabItem = .home

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .bottom) {
      // 页面内容
      Group {
        switch selectedTab {
        case .home:
          AppNavigationView {
            HomeView()
          }
          .environmentObject(router)
          .environmentObject(authManager)
          .environmentObject(paymentViewModel)
        case .discover:
          AppNavigationView {
            DiscoverView()
          }
          .environmentObject(router)
          .environmentObject(authManager)
          .environmentObject(paymentViewModel)
        case .messages:
          AppNavigationView {
            MessagesView()
          }
          .environmentObject(authManager)
          .environmentObject(router)
          .environmentObject(paymentViewModel)
        case .profile:
          AppNavigationView {
            ProfileViewWrapper()
          }
          .environmentObject(router)
          .environmentObject(authManager)
          .environmentObject(paymentViewModel)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)

      // 悬浮底部导航栏 - 只在主页面显示
      if shouldShowTabBar {
        FloatingTabBar(selectedTab: $selectedTab)
      }
    }
    .ignoresSafeArea(edges: .bottom)
    #if DEBUG
      .enableInjection()
    #endif
  }

  /// 是否显示底部导航栏
  private var shouldShowTabBar: Bool {
    // 如果有二级页面（不在根页面），隐藏底部导航栏
    if !router.isAtRoot {
      return false
    }
    // 在根页面时，始终显示底部导航栏
    return true
  }
}

/// ProfileView 包装器 - 用于正确初始化 ViewModel
struct ProfileViewWrapper: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router
  let userId: String?
  let showBackicon: Bool

  init(userId: String? = nil, showBackicon: Bool = false) {
    self.userId = userId
    self.showBackicon = showBackicon
  }

  var body: some View {
    ProfileViewContainer(authManager: authManager, userId: userId, showBackicon: showBackicon)
      .environmentObject(router)
  }
}

/// ProfileView 容器 - 创建并管理 ViewModel
private struct ProfileViewContainer: View {
  let authManager: AuthenticationManager
  let userId: String?
  let showBackicon: Bool
  @StateObject private var viewModel: ProfileViewModel

  init(authManager: AuthenticationManager, userId: String?, showBackicon: Bool = false) {
    self.authManager = authManager
    self.userId = userId
    self.showBackicon = showBackicon
    _viewModel = StateObject(
      wrappedValue: ProfileViewModel(authManager: authManager, userId: userId))
  }

  var body: some View {
    ProfileView(viewModel: viewModel, showBackicon: showBackicon)
      .environmentObject(authManager)
  }
}

// MARK: - Tab Item Enum
enum TabItem {
  case home
  case discover
  case messages
  case profile
}

// #Preview {
//     MainTabView()
// }
