//
//  ProfileImageView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct ProfileImageView: View {
  let avatar: String?
  let avatarImage: UIImage?
  let username: String
  let size: CGFloat
  let subSize: CGFloat?
  let borderImageName: String?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(
    avatar: String? = nil,
    username: String,
    size: CGFloat,
    subSize: CGFloat? = 16,
    borderImageName: String? = "7X1p2a4Cu1Xn8nXt"
  ) {
    self.avatar = avatar
    self.avatarImage = nil
    self.username = username
    self.size = size
    self.subSize = subSize
    self.borderImageName = borderImageName
  }

  init(
    avatar: UIImage?,
    username: String,
    size: CGFloat,
    subSize: CGFloat? = 16,
    borderImageName: String? = "7X1p2a4Cu1Xn8nXt"
  ) {
    self.avatar = nil
    self.avatarImage = avatar
    self.username = username
    self.size = size
    self.subSize = subSize
    self.borderImageName = borderImageName
  }

  var body: some View {
    ZStack {
      if let borderImageName = borderImageName {
        Image(borderImageName)
          .resizable()
          .scaledToFill()
          .frame(width: size, height: size)
          .clipShape(Circle())
      } else {
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

      if let avatarImage = avatarImage {
        Image(uiImage: avatarImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(
            width: size - (subSize ?? 16),
            height: size - (subSize ?? 16)
          )
          .clipShape(Circle())
      } else if let avatar = avatar {
        if let loadedImage = DynamicImageLoader.loadImage(named: avatar) {
          Image(uiImage: loadedImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
              width: size - (subSize ?? 16),
              height: size - (subSize ?? 16)
            )
            .clipShape(Circle())
        } else {
          if avatar.hasPrefix("/") || avatar.hasPrefix("file://"),
            let uiImage = UIImage(
              contentsOfFile: avatar.replacingOccurrences(of: "file://", with: ""))
          {
            Image(uiImage: uiImage)
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
              .frame(width: size - (subSize ?? 16), height: size - (subSize ?? 16))
              .overlay {
                Text(String(username.prefix(1)))
                  .font(.system(size: (size - (subSize ?? 16)) * 0.4, weight: .bold))
                  .foregroundColor(.pink)
              }
          }
        }
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
    #if DEBUG
      .enableInjection()
    #endif
  }
}
