//
//  ProfileModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Profile Models

/// 设置项模型
struct SettingItem: Identifiable {
  let id = UUID()
  let title: String
  let icon: String
  let type: SettingType
  var isDestructive: Bool = false
}

/// 设置类型
enum SettingType {
  case account
  case privacy
  case notification
  case appearance
  case about
  case logout
}
