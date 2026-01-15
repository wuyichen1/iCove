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
    @State private var selectedTab: TabItem = .home
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
                .tag(TabItem.home)
            
            DiscoverView()
                .tabItem {
                    Label("发现", systemImage: "magnifyingglass")
                }
                .tag(TabItem.discover)
            
            MessagesView()
                .tabItem {
                    Label("消息", systemImage: "message.fill")
                }
                .tag(TabItem.messages)
            
            ProfileViewWrapper()
                .environmentObject(authManager)
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(TabItem.profile)
        }
        .enableInjection()
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

#Preview {
    MainTabView()
}
