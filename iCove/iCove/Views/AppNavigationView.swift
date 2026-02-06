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

struct AppNavigationView<Content: View>: View {
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var paymentViewModel: Payn8tqsrRpmXPZWVmod
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
    .background(NavigationControllerEnabler())
    #if DEBUG
      .enableInjection()
    #endif
  }
  
  /// 用于全局启用侧滑返回手势的辅助视图
  private struct NavigationControllerEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
      let viewController = UIViewController()
      return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
      DispatchQueue.main.async {
        // 查找导航控制器并启用侧滑返回
        if let navigationController = uiViewController.navigationController {
          navigationController.interactivePopGestureRecognizer?.isEnabled = true
          navigationController.interactivePopGestureRecognizer?.delegate = nil
        }
        
        // 也检查父视图控制器
        var parent = uiViewController.parent
        while parent != nil {
          if let navController = parent as? UINavigationController {
            navController.interactivePopGestureRecognizer?.isEnabled = true
            navController.interactivePopGestureRecognizer?.delegate = nil
            break
          }
          parent = parent?.parent
        }
      }
    }
  }

  @ViewBuilder
  private func destinationView(for route: Route) -> some View {
    switch route {
    case .homeQMOFX4gLvyU3x:
      HomezE7Bdgz5RAm6FView()
    case .vdodetfheedD4mgJl4V(let vidROutctPY4KAW9):
      detailView(for: vidROutctPY4KAW9)
        .toolbar(.hidden, for: .tabBar)
    case .podeti0Gx1PwxsKGxM(let postId):
      Podetopjh8lRqGBvnoView(postId: postId)
        .environmentObject(router)
        .toolbar(.hidden, for: .tabBar)
    case .chadetBhKPSi5YgfcOZ(let conversationId, let otherUserId):
      ChatdethDMHn0xZmjWudView(conversationId: conversationId, otherUserId: otherUserId)
        .environmentObject(router)
        .toolbar(.hidden, for: .tabBar)
    case .videoCall(let conversationId, let otherUserId):
      VideoCallView(conversationId: conversationId, otherUserId: otherUserId)
        .environmentObject(router)
        .toolbar(.hidden, for: .tabBar)
    case .profibW16jiY12DMmv(let userId, let showBackicon):
      ProfileViewWrapper(userId: userId, showBackicon: showBackicon)
        .environmentObject(router)
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
        .toolbar(.hidden, for: .tabBar)
    case .settings:
      SettingscMKlqK4i3uZzcView()
        .environmentObject(router)
        .environmentObject(authManager)
        .toolbar(.hidden, for: .tabBar)
    case .editProfile:
      EditY3IAsBRQyIZ1dView()
        .environmentObject(router)
        .environmentObject(authManager)
        .toolbar(.hidden, for: .tabBar)
    case .blacklist:
      BlacklistMRH0iOPUaqaWKView()
        .environmentObject(router)
        .environmentObject(authManager)
        .toolbar(.hidden, for: .tabBar)
    case .wallet:
      WalletRvl5XPggWqS65View()
        .environmentObject(router)
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
        .toolbar(.hidden, for: .tabBar)
    case .ai:
      AIr0xPbmzogQH8YView()
        .environmentObject(authManager)
        .toolbar(.hidden, for: .tabBar)
    case .publish(let type):
      PubVypVDl0eHHL9jView(pubTypeWZOlcaTCZFIeL: type)
        .environmentObject(authManager)
        .toolbar(.hidden, for: .tabBar)
    case .report(let userId):
      ReportywNvhJra7xXCDView(userId: userId)
        .environmentObject(router)
        .toolbar(.hidden, for: .tabBar)
    case .agreement(let url, let title):
      AgreementView(urlString: url, title: title)
        .environmentObject(router)
        .environmentObject(paymentViewModel)
        .toolbar(.hidden, for: .tabBar)
        .interactiveDismissDisabled(true) // 禁止手势返回
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮，实现不可返回跳转
    }
  }

  @ViewBuilder
  private func detailView(for videoId: String) -> some View {
    let videos = VdoServ63WnoDbxzFob0.shared.loc5f3UJvuhXYjoD()
    if let video = videos.first(where: { $0.id == videoId }) {
      VdodetTEFxjaiTtBG5ZView(video: video)
        .environmentObject(router)
    } else {
      Text("Video not found")
        .foregroundColor(.secondary)
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}
