//
//  AppNavigationView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
    import HotSwiftUI
#endif

/// 导航容器视图 - 承载 NavigationStack
struct AppNavigationView<Content: View>: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var authManager: AuthenticationManager
    let content: () -> Content

    #if DEBUG
        @ObserveInjection var redraw
    #endif

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Route.self) { route in
                    destinationView(for: route)
                }
        }
        .enableInjection()
    }

    /// 根据路由返回对应的视图
    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .home:
            HomeView()
        // home 是主页面，保持底部导航栏显示
        case .detail(let id):
            detailView(for: id)
                // 详情页是二级页面，隐藏底部导航栏
                .toolbar(.hidden, for: .tabBar)
        case .postDetail(let postId):
            PostDetailView(postId: postId)
                .environmentObject(router)
                .toolbar(.hidden, for: .tabBar)
        case .chatDetail(let conversationId, let otherUserId):
            ChatDetailView(conversationId: conversationId, otherUserId: otherUserId)
                .environmentObject(router)
                .toolbar(.hidden, for: .tabBar)
        case .videoCall(let conversationId, let otherUserId):
            VideoCallView(conversationId: conversationId, otherUserId: otherUserId)
                .environmentObject(router)
                .toolbar(.hidden, for: .tabBar)
        case .profile(let userId):
            ProfileViewWrapper(userId: userId)
                .environmentObject(router)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .settings:
            SettingsView()
                .environmentObject(router)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .editProfile:
            EditProfileView()
                .environmentObject(router)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .blacklist:
            BlacklistView()
                .environmentObject(router)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .wallet:
            WalletView()
                .environmentObject(router)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .ai:
            AIView()
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .publish(let type):
            PublishView(publishType: type)
                .environmentObject(authManager)
                .toolbar(.hidden, for: .tabBar)
        case .report(let userId):
            ReportView(userId: userId)
                .environmentObject(router)
                .toolbar(.hidden, for: .tabBar)
        case .agreement(let url, let title):
            AgreementView(urlString: url, title: title)
                .environmentObject(router)
                .toolbar(.hidden, for: .tabBar)
        }
    }

    /// 根据视频 ID 创建详情页
    @ViewBuilder
    private func detailView(for videoId: String) -> some View {
        let videos = VideoDataService.shared.loadVideos()
        if let video = videos.first(where: { $0.id == videoId }) {
            VideoDetailView(video: video)
                .environmentObject(router)
        } else {
            // 如果找不到视频，显示错误页面或返回首页
            Text("视频不存在")
                .foregroundColor(.secondary)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
