//
//  EmptyPlaceholderView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

/// 空占位组件 - 用于显示空状态，包含占位图片和提示文字
struct EmptyPlaceholderView: View {
  /// 是否为系统图标
  let isSystemImage: Bool
  /// 提示文字
  let message: String
  /// 图片大小
  let imageSize: CGFloat
  /// 文字字体大小
  let fontSize: CGFloat
  /// 垂直间距
  let spacing: CGFloat

  init(
    isSystemImage: Bool = true,
    message: String = "No data available.",
    imageSize: CGFloat = 140,
    fontSize: CGFloat = 16,
    spacing: CGFloat = 16
  ) {
    self.isSystemImage = isSystemImage
    self.message = message
    self.imageSize = imageSize
    self.fontSize = fontSize
    self.spacing = spacing
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    VStack(spacing: spacing) {
      Image("RSBk5BClmhwCxL")
        .resizable()
        .scaledToFit()
        .frame(width: 140, height: 140)
        .foregroundColor(.secondary)

      // 提示文字
      Text(message)
        .font(.system(size: fontSize))
        .foregroundColor(.white.opacity(0.7))
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    #if DEBUG
      .enableInjection()
    #endif
  }
}

#Preview {
  EmptyPlaceholderView()
}

// #Preview("自定义样式") {
//   EmptyPlaceholderView(
//     imageName: "tray",
//     isSystemImage: true,
//     message: "这里还没有内容哦~",
//     imageSize: 100,
//     fontSize: 18,
//     spacing: 20
//   )
// }
