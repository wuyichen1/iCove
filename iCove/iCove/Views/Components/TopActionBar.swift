//
//  TopActionBar.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

/// 顶部操作栏样式配置
enum TopActionBarStyle {
    /// 白色背景 + 紫色边框（用于 VideoDetailView）
    case whiteWithPurpleBorder
    /// 白色半透明背景（用于 PostDetailView）
    case whiteTransparent
}

/// 顶部操作栏组件 - 可复用的顶部导航栏
struct TopActionBar: View {
    /// 返回按钮操作
    let onBack: () -> Void
    /// 更多操作按钮操作（可选）
    var onMore: (() -> Void)? = nil
    /// 样式配置
    var style: TopActionBarStyle = .whiteWithPurpleBorder
    /// 水平内边距
    var horizontalPadding: CGFloat = 20
    /// 顶部内边距
    var topPadding: CGFloat = 20
    
    var body: some View {
        VStack {
            HStack {
                // 返回按钮
                backButton
                
                Spacer()
                
                // 更多操作按钮（如果提供了回调）
                if let onMore = onMore {
                    moreButton(onMore: onMore)
                }
            }
            .padding(.horizontal, horizontalPadding)
            // .padding(.top, topPadding)
            
            Spacer()
        }
    }
    
    // MARK: - Back Button
    private var backButton: some View {
        Button(action: onBack) {
            Group {
                switch style {
                case .whiteWithPurpleBorder:
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("buttonPurple"))
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("buttonPurple"), lineWidth: 1.5)
                        )
                case .whiteTransparent:
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
    }
    
    // MARK: - More Button
    @ViewBuilder
    private func moreButton(onMore: @escaping () -> Void) -> some View {
        Button(action: onMore) {
            Group {
                switch style {
                case .whiteWithPurpleBorder:
                    // 三个圆点样式
                    HStack(spacing: 3) {
                        Circle()
                            .fill(Color("buttonPurple"))
                            .frame(width: 4, height: 4)
                        Circle()
                            .fill(Color("buttonPurple"))
                            .frame(width: 4, height: 4)
                        Circle()
                            .fill(Color("buttonPurple"))
                            .frame(width: 4, height: 4)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("buttonPurple"), lineWidth: 1.5)
                    )
                case .whiteTransparent:
                    // 省略号样式
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
    }
}
