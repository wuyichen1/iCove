//
//  DynamicImage.swift
//  iCove
//
//  Created by yangyang on 2026/1/21.
//

import SwiftUI

/// 动态图片视图 - 支持加载 asset 资源图片和本地文件图片
struct DynamicImage: View {
  let imageName: String
  var contentMode: ContentMode = .fill

  @State private var uiImage: UIImage?

  var body: some View {
    Group {
      if let uiImage = uiImage {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(contentMode: contentMode)
      } else if let assetImage = UIImage(named: imageName) {
        Image(uiImage: assetImage)
          .resizable()
          .aspectRatio(contentMode: contentMode)
      } else {
        // 占位图
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .overlay(
            Image(systemName: "photo")
              .font(.system(size: 30))
              .foregroundColor(.gray.opacity(0.6))
          )
      }
    }
    .onAppear {
      loadLocalImage()
    }
  }

  /// 尝试从本地文件系统加载图片
  private func loadLocalImage() {
    // 如果已经是 asset 图片，不需要加载
    if UIImage(named: imageName) != nil {
      return
    }

    // 尝试从用户上传的图片目录加载
    if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      .first
    {
      // 尝试从 UserImages 目录加载
      let userImagesURL = documentsPath.appendingPathComponent("UserImages")
        .appendingPathComponent(imageName)
      if FileManager.default.fileExists(atPath: userImagesURL.path),
        let image = UIImage(contentsOfFile: userImagesURL.path)
      {
        uiImage = image
        return
      }

      // 尝试从 VideoThumbnails 目录加载
      let thumbnailsURL = documentsPath.appendingPathComponent("VideoThumbnails")
        .appendingPathComponent(imageName)
      if FileManager.default.fileExists(atPath: thumbnailsURL.path),
        let image = UIImage(contentsOfFile: thumbnailsURL.path)
      {
        uiImage = image
        return
      }
    }
  }
}

/// 动态图片加载器 - 提供静态方法来加载图片
class DynamicImageLoader {
  static func loadImage(named imageName: String) -> UIImage? {
    // 首先尝试从 asset 加载
    if let assetImage = UIImage(named: imageName) {
      return assetImage
    }

    // 尝试从本地文件加载
    if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      .first
    {
      // 尝试从 UserImages 目录加载
      let userImagesURL = documentsPath.appendingPathComponent("UserImages")
        .appendingPathComponent(imageName)
      if FileManager.default.fileExists(atPath: userImagesURL.path),
        let image = UIImage(contentsOfFile: userImagesURL.path)
      {
        return image
      }

      // 尝试从 VideoThumbnails 目录加载
      let thumbnailsURL = documentsPath.appendingPathComponent("VideoThumbnails")
        .appendingPathComponent(imageName)
      if FileManager.default.fileExists(atPath: thumbnailsURL.path),
        let image = UIImage(contentsOfFile: thumbnailsURL.path)
      {
        return image
      }
    }

    return nil
  }
}
