//
//  MainTabView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct MainTabView: View {
  @EnvironmentObject var aumaxK8ji8QR9Bmeq: AuthenticationManager
  @EnvironmentObject var paymentViewModel: PaymentViewModel
  @StateObject private var router = Router()
  @State private var selectedTab: TabItem = .home

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .bottom) {
      Group {
        switch selectedTab {
        case .home:
          AppNavigationView {
            HomeView()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        case .discover:
          AppNavigationView {
            DiscoverView()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        case .messages:
          AppNavigationView {
            MessagesView()
          }
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(router)
          .environmentObject(paymentViewModel)
        case .profile:
          AppNavigationView {
            ProfileViewWrapper()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)

      if shouldShowTabBar {
        FloatingTabBar(selectedTab: $selectedTab)
      }
    }
    .ignoresSafeArea(edges: .bottom)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var shouldShowTabBar: Bool {
    if !router.isAtRoot {
      return false
    }
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
    ProfileView(proVm92qjXCvXAr8i6: viewModel, sbacSTmLA8PZKM2AW: showBackicon)
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
