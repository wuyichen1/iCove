//
//  ImageService.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import UIKit
import Foundation

/// 图片服务 - 提供图片保存功能
class ImageService {
  static let shared = ImageService()
  
  private init() {}
  
  /// 将图片保存到本地文档目录的 UserImages 子目录
  /// - Parameters:
  ///   - image: 要保存的图片
  ///   - prefix: 文件名前缀（例如 "avatar_" 或 "chat_"）
  ///   - userId: 用户ID（可选）
  /// - Returns: 文件名（不包含路径），如果保存失败返回 nil
  func saveImageToLocal(_ image: UIImage, prefix: String = "image", userId: String? = nil) -> String? {
    let timestamp = Int(Date().timeIntervalSince1970)
    let userIdPart = userId != nil ? "_\(userId!)" : ""
    let fileName = "\(prefix)\(userIdPart)_\(timestamp).jpg"
    
    guard let data = image.jpegData(compressionQuality: 0.8) else {
      return nil
    }
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let userImagesDirectory = documentsDirectory.appendingPathComponent("UserImages")
    
    // 确保 UserImages 目录存在
    try? FileManager.default.createDirectory(at: userImagesDirectory, withIntermediateDirectories: true, attributes: nil)
    
    // 保存到 UserImages 子目录
    let fileURL = userImagesDirectory.appendingPathComponent(fileName)
    
    do {
      try data.write(to: fileURL)
      // 返回文件名（不包含路径），这样可以被 DynamicImageLoader 识别
      return fileName
    } catch {
      print("Failed to save image: \(error)")
      return nil
    }
  }
}
