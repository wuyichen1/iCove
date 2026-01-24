//
//  StarText.swift
//  iCove
//
//  Created by yangyang on 2026/1/21.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

/// 星星文本组件 - 在文本右上角显示两颗星星
struct StarText: View {
  let text: String
  var textColor: Color = .white
  var textSize: CGFloat = 20
  var starSize: CGFloat = 8

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .topTrailing) {
      Text(text)
        .font(.custom("FredokaOne-Regular", size: textSize))
        .foregroundColor(textColor)

      // 两颗星星在右上角
      HStack(spacing: 2) {
        Image(systemName: "sparkle")
          .font(.system(size: starSize))
          .foregroundColor(textColor)
          .padding(.bottom, 6)

        Image(systemName: "sparkle")
          .font(.system(size: starSize - 4))
          .foregroundColor(textColor)
      }
      .offset(x: 8, y: -6)  // 向上偏移，使星星位于文本右上角
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}

// MARK: - 预览
#Preview {
  VStack(spacing: 20) {
    // 自定义字体大小
    StarText(
      text: "Large Text",
      textColor: .purple,
      textSize: 22,
      starSize: 12
    )
  }
  .padding()
}
