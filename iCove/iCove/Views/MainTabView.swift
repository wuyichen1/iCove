//
//  MainTabView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    
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
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(TabItem.profile)
        }
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
