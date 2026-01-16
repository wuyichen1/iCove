//
//  Router.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

/// 路由管理器 - 统一管理页面跳转
class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    /// 是否在根页面（无二级页面）
    var isAtRoot: Bool {
        path.count == 0
    }
    
    /// 推入新页面
    /// - Parameter route: 目标路由
    func push(_ route: Route) {
        path.append(route)
    }
    
    /// 返回上一页
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// 返回到根页面
    func popToRoot() {
        path.removeLast(path.count)
    }
}