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
                case .discover:
                    AppNavigationView {
                        DiscoverView()
                    }
                    .environmentObject(router)
                case .messages:
                    MessagesView()
                case .profile:
                    ProfileViewWrapper()
                        .environmentObject(authManager)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 悬浮底部导航栏 - 只在主页面显示
            if shouldShowTabBar {
                FloatingTabBar(selectedTab: $selectedTab)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .enableInjection()
    }
    
    /// 是否显示底部导航栏
    private var shouldShowTabBar: Bool {
        // 如果不在 home tab，总是显示
        if selectedTab != .home {
            return true
        }
        // 如果在 home tab，只有在根页面（无二级页面）时才显示
        return router.isAtRoot
    }
}

/// ProfileView 包装器 - 用于正确初始化 ViewModel
struct ProfileViewWrapper: View {
    @EnvironmentObject var authManager: AuthenticationManager

    var body: some View {
        ProfileViewContainer(authManager: authManager)
    }
}

/// ProfileView 容器 - 创建并管理 ViewModel
private struct ProfileViewContainer: View {
    let authManager: AuthenticationManager
    @StateObject private var viewModel: ProfileViewModel

    init(authManager: AuthenticationManager) {
        self.authManager = authManager
        _viewModel = StateObject(wrappedValue: ProfileViewModel(authManager: authManager))
    }

    var body: some View {
        ProfileView(viewModel: viewModel)
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
