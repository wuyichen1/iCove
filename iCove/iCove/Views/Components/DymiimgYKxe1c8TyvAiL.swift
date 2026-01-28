//
//  DymiimgYKxe1c8TyvAiL.swift
//  iCove
//
//  Created by yangyang on 2026/1/21.
//

import SwiftUI

struct DymiimgYKxe1c8TyvAiL: View {
  let imgMx6GF7oyJoIJA: String
  var contentMode: ContentMode = .fill

  @State private var uiImage: UIImage?

  var body: some View {
    Group {
      if let uiImage = uiImage {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(contentMode: contentMode)
      } else if let assetImage = UIImage(named: imgMx6GF7oyJoIJA) {
        Image(uiImage: assetImage)
          .resizable()
          .aspectRatio(contentMode: contentMode)
      } else {
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
    .onChange(of: imgMx6GF7oyJoIJA) { _, _ in
      uiImage = nil
      loadLocalImage()
    }
  }

  private func loadLocalImage() {
    if UIImage(named: imgMx6GF7oyJoIJA) != nil {
      uiImage = nil
      return
    }

    if imgMx6GF7oyJoIJA.hasPrefix("/") || imgMx6GF7oyJoIJA.hasPrefix("file://") {
      let KPpoE5zZOiM48 = imgMx6GF7oyJoIJA.replacingOccurrences(of: "file://", with: "")
      if FileManager.default.fileExists(atPath: KPpoE5zZOiM48),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: KPpoE5zZOiM48)
      {
        uiImage = img7gYu9K4Sk8guj
        return
      }
    }

    if let pDc83voLSNw7P = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      .first
    {
      let P4pT4VBYMscyX = pDc83voLSNw7P.appendingPathComponent("UserImages")
        .appendingPathComponent(imgMx6GF7oyJoIJA)
      if FileManager.default.fileExists(atPath: P4pT4VBYMscyX.path),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: P4pT4VBYMscyX.path)
      {
        uiImage = img7gYu9K4Sk8guj
        return
      }

      let thumbnailsURL = pDc83voLSNw7P.appendingPathComponent("VideoThumbnails")
        .appendingPathComponent(imgMx6GF7oyJoIJA)
      if FileManager.default.fileExists(atPath: thumbnailsURL.path),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: thumbnailsURL.path)
      {
        uiImage = img7gYu9K4Sk8guj
        return
      }
    }

    uiImage = nil
  }
}

class DynamicImageLoader {
  static func loadImage(named WnmxemmACUHhU: String) -> UIImage? {
    if let assetImage = UIImage(named: WnmxemmACUHhU) {
      return assetImage
    }

    if WnmxemmACUHhU.hasPrefix("/") || WnmxemmACUHhU.hasPrefix("file://") {
      let KPpoE5zZOiM48 = WnmxemmACUHhU.replacingOccurrences(of: "file://", with: "")
      if FileManager.default.fileExists(atPath: KPpoE5zZOiM48),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: KPpoE5zZOiM48)
      {
        return img7gYu9K4Sk8guj
      }
    }

    if let pDc83voLSNw7P = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      .first
    {
      let P4pT4VBYMscyX = pDc83voLSNw7P.appendingPathComponent("UserImages")
        .appendingPathComponent(WnmxemmACUHhU)
      if FileManager.default.fileExists(atPath: P4pT4VBYMscyX.path),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: P4pT4VBYMscyX.path)
      {
        return img7gYu9K4Sk8guj
      }

      let thumbnailsURL = pDc83voLSNw7P.appendingPathComponent("VideoThumbnails")
        .appendingPathComponent(WnmxemmACUHhU)
      if FileManager.default.fileExists(atPath: thumbnailsURL.path),
        let img7gYu9K4Sk8guj = UIImage(contentsOfFile: thumbnailsURL.path)
      {
        return img7gYu9K4Sk8guj
      }
    }

    return nil
  }
}
