//
//  PrimaryButton.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 自定义主要按钮组件 - 带渐变背景
struct PrimaryButton: View {
  let title: String
  let action: () -> Void
  var isLoading: Bool = false
  var isEnabled: Bool = true
  var width: CGFloat? = nil
  var height: CGFloat = 52
  var fontSize: CGFloat = 20
  var fontWeight: Font.Weight = .semibold
  var backgroundColor: Color = Color("buttonPurple")

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    Button(action: action) {
      HStack {
        if isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text(title)
            .font(.custom("FredokaOne-Regular", size: fontSize))
          // Text(title)
          //     .font(.system(size: fontSize, weight: fontWeight))
        }
      }
      .frame(width: width, height: height)
      .frame(maxWidth: width == nil ? .infinity : nil)
      .foregroundColor(.white)  // 文本颜色
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(backgroundColor)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.white, lineWidth: 2)
      }
    }
    .disabled(!isEnabled || isLoading)
    // .opacity(isEnabled && !isLoading ? 1.0 : 0.6)
    #if DEBUG
      .enableInjection()
    #endif
    .fixedSize(horizontal: width != nil, vertical: false)  //设置了宽度时防止水平拉伸
  }
}

/// 自定义次要按钮组件 - 只有边框
struct SecondaryButton: View {
  let title: String
  let action: () -> Void
  var isLoading: Bool = false
  var isEnabled: Bool = true
  var height: CGFloat = 56
  var fontSize: CGFloat = 18
  var fontWeight: Font.Weight = .semibold
  var borderColor: Color = .white.opacity(0.5)
  var borderWidth: CGFloat = 1.5

  var body: some View {
    Button(action: action) {
      HStack {
        if isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text(title)
            .font(.system(size: fontSize, weight: fontWeight))
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: height)
      .foregroundColor(.white)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.clear)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(borderColor, lineWidth: borderWidth)
      }
    }
    .disabled(!isEnabled || isLoading)
    .opacity(isEnabled && !isLoading ? 1.0 : 0.6)
  }
}

// #Preview {
//     VStack(spacing: 20) {
//         PrimaryButton(title: "Primary Button", action: {})

//         PrimaryButton(
//             title: "Custom Color",
//             action: {},
//             backgroundColor: .blue
//         )

//         PrimaryButton(
//             title: "Custom Gradient",
//             action: {},
//             backgroundColor: Color(red: 0.6, green: 0.3, blue: 0.8)
//         )

//         PrimaryButton(title: "Loading...", action: {}, isLoading: true)

//         PrimaryButton(title: "Disabled", action: {}, isEnabled: false)

//         SecondaryButton(title: "Secondary Button", action: {})

//         SecondaryButton(title: "Loading...", action: {}, isLoading: true)

//         SecondaryButton(title: "Disabled", action: {}, isEnabled: false)
//     }
//     .padding()
//     .background(Color(red: 0.2, green: 0.1, blue: 0.3))
// }
