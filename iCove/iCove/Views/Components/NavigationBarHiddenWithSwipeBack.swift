//
//  NavigationBarHiddenWithSwipeBack.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

/// 一个 ViewModifier，用于隐藏导航栏同时保持侧滑返回手势可用
struct NavigationBarHiddenWithSwipeBack: ViewModifier {
  func body(content: Content) -> some View {
    content
      .navigationBarHidden(true)
      .background(NavigationControllerConfigurator())
  }
}

/// 用于配置导航控制器的辅助视图
private struct NavigationControllerConfigurator: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UIViewController {
    let viewController = UIViewController()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    DispatchQueue.main.async {
      // 方法1: 直接从当前视图控制器获取导航控制器
      if let navigationController = uiViewController.navigationController {
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
      }
      
      // 方法2: 通过父视图控制器查找
      var parent = uiViewController.parent
      while parent != nil {
        if let navController = parent as? UINavigationController {
          navController.interactivePopGestureRecognizer?.isEnabled = true
          navController.interactivePopGestureRecognizer?.delegate = nil
          break
        }
        parent = parent?.parent
      }
      
      // 方法3: 通过视图层次结构向上查找
      var responder: UIResponder? = uiViewController.view
      while responder != nil {
        if let viewController = responder as? UIViewController,
           let navController = viewController.navigationController {
          navController.interactivePopGestureRecognizer?.isEnabled = true
          navController.interactivePopGestureRecognizer?.delegate = nil
        }
        responder = responder?.next
      }
    }
  }
}

extension View {
  /// 隐藏导航栏但保持侧滑返回手势可用的便捷方法
  /// 用于替换 .navigationBarHidden(true)，以保持侧滑返回功能
  func navigationBarHiddenWithSwipeBack() -> some View {
    self.modifier(NavigationBarHiddenWithSwipeBack())
  }
}

