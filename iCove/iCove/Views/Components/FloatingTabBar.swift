//
//  FloatingTabBar.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
    import HotSwiftUI
#endif

/// 悬浮底部导航栏
struct FloatingTabBar: View {
    @Binding var selectedTab: TabItem

    #if DEBUG
        @ObserveInjection var redraw
    #endif

    var body: some View {
        HStack(spacing: 0) {
            // 首页
            TabBarButton(
                icon: "1akQNNqBpWFE3YsJ0J",
                iconSelected: "1kQNNqBpWFE3YsJ0J",
                isSelected: selectedTab == .home
            ) {
                selectedTab = .home
            }

            Spacer()

            // 发现
            TabBarButton(
                icon: "2bnmWxXjHOykhJtNRF",
                iconSelected: "2nmWxXjHOykhJtNRF",
                isSelected: selectedTab == .discover
            ) {
                selectedTab = .discover
            }

            Spacer()

            // 消息
            TabBarButton(
                icon: "3cdKT1VeSfXcPS1lVn",
                iconSelected: "3dKT1VeSfXcPS1lVn",
                isSelected: selectedTab == .messages
            ) {
                selectedTab = .messages
            }

            Spacer()

            // 我的
            TabBarButton(
                icon: "4dv94xvRXwbcpHXAn1",
                iconSelected: "4v94xvRXwbcpHXAn1",
                isSelected: selectedTab == .profile
            ) {
                selectedTab = .profile
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 60)
                .fill(Color("buttonPurple"))
                .shadow(color: Color.white.opacity(0.3), radius: 2, x: 0, y: -2)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .enableInjection()
    }
}

/// 底部导航栏按钮
private struct TabBarButton: View {
    let icon: String
    let iconSelected: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(isSelected ? iconSelected : icon)
                    .resizable()
                    .frame(width: 45, height: 45)

            }
            // .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
