//
//  ProfileImageView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

/// 带渐变边框的头像视图组件
struct ProfileImageView: View {
  let avatar: String?
  let username: String
  let size: CGFloat
  let subSize: CGFloat?
  let borderImageName: String?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  /// 初始化头像视图
  /// - Parameters:
  ///   - avatar: 头像图片名称（可选）
  ///   - username: 用户名（用于显示首字母占位符）
  ///   - size: 头像尺寸
  ///   - borderImageName: 边框图片名称（可选，如果提供则使用图片作为边框，否则使用渐变边框）
  init(
    avatar: String? = nil,
    username: String,
    size: CGFloat,
    subSize: CGFloat? = 16,
    borderImageName: String? = "7X1p2a4Cu1Xn8nXt"
  ) {
    self.avatar = avatar
    self.username = username
    self.size = size
    self.subSize = subSize
    self.borderImageName = borderImageName
  }

  var body: some View {
    ZStack {
      // 边框：优先使用图片边框，否则使用渐变边框
      if let borderImageName = borderImageName {
        Image(borderImageName)
          .resizable()
          .scaledToFill()
          .frame(width: size, height: size)
          .clipShape(Circle())
      } else {
        // 渐变边框圆环（带缺口效果，缺口在右侧）
        Circle()
          .trim(from: 0.0, to: 0.85)
          .stroke(
            LinearGradient(
              gradient: Gradient(colors: [
                Color.white,
                Color.purple.opacity(0.6),
                Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255),
              ]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            style: StrokeStyle(lineWidth: size > 80 ? 4 : 2.5, lineCap: .round)
          )
          .frame(width: size + (size > 80 ? 8 : 6), height: size + (size > 80 ? 8 : 6))
          .rotationEffect(.degrees(-90))
      }

      // 头像内容
      if let avatar = avatar {
        Image(avatar)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(
            width: size - (subSize ?? 16),
            height: size - (subSize ?? 16)
          )
          .clipShape(Circle())
      } else {
        Circle()
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [
                Color.pink.opacity(0.3),
                Color.purple.opacity(0.3),
              ]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
          .frame(width: size - 15, height: size - 15)
          .overlay {
            Text(String(username.prefix(1)))
              .font(.system(size: size * 0.4, weight: .bold))
              .foregroundColor(.pink)
          }
      }
    }
    .enableInjection()
  }
}

// #Preview {
//   VStack(spacing: 40) {
//     ProfileImageView(
//       avatar: nil,
//       username: "Maddison",
//       size: 120,
//       borderImageName: "7X1p2a4Cu1Xn8nXt"
//     )
//
//     ProfileImageView(
//       avatar: nil,
//       username: "Leonardo",
//       size: 50
//     )
//   }
//   .padding()
//   .background(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
// }
