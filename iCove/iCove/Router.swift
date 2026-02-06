//
//  Router.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

class Router: ObservableObject {
  @Published var path = NavigationPath()

  var isAtRoot: Bool {
    path.count == 0
  }

  func push(_ route: Route) {
    path.append(route)
  }

  func pop() {
    if !path.isEmpty {
      path.removeLast()
    }
  }

  @MainActor
  func popToRoot() {
    if path.count > 0 {
      // 清空导航栈：创建一个新的 NavigationPath
      path = NavigationPath()
    }
  }
}
