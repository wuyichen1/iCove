//
//  ChatDetailViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation
import SwiftUI

@MainActor
class ChatDetailViewModel: ObservableObject {
  @Published var messages: [Message] = []
  @Published var isLoading: Bool = false
  @Published var otherUser: User?
  @Published var inputText: String = ""
  @Published var showAttachmentMenu: Bool = false  // 是否显示附件菜单
  @Published var showRecordingButton: Bool = false  // 是否显示录音按钮
  @Published var isRecording: Bool = false  // 是否正在录音

  private let conversationId: String
  private let otherUserId: String
  private let authService: AuthenticationServiceProtocol
  private let messageService: MessageDataServiceProtocol

  init(
    conversationId: String,
    otherUserId: String,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    messageService: MessageDataServiceProtocol = MessageDataService.shared
  ) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    self.authService = authService
    self.messageService = messageService
    loadOtherUser()
    loadMessages()
  }

  func loadOtherUser() {
    otherUser = authService.getUserById(otherUserId)
  }

  func loadMessages() {
    isLoading = true
    Task {
      // 从持久化存储加载消息
      messages = messageService.loadMessages(by: conversationId)
      isLoading = false
    }
  }

  func sendMessage(currentUserId: String) {
    guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

    let newMessage = Message(
      id: UUID().uuidString,
      conversationId: conversationId,
      senderId: currentUserId,
      content: inputText,
      messageType: .text,
      timestamp: Date()
    )

    // 保存到持久化存储
    messageService.saveMessage(newMessage)
    
    // 更新本地消息列表
    messages.append(newMessage)
    inputText = ""
  }

  func sendImage(imageName: String, currentUserId: String) {
    let newMessage = Message(
      id: UUID().uuidString,
      conversationId: conversationId,
      senderId: currentUserId,
      content: imageName,
      messageType: .image,
      timestamp: Date()
    )

    // 保存到持久化存储
    messageService.saveMessage(newMessage)
    
    // 更新本地消息列表
    messages.append(newMessage)
    
    // 发送图片后关闭菜单
    showAttachmentMenu = false
    showRecordingButton = false
  }
  
  func toggleAttachmentMenu() {
    showAttachmentMenu.toggle()
    if showAttachmentMenu {
      showRecordingButton = false
    }
  }
  
  func selectAttachmentOption(_ option: AttachmentOption) {
    switch option {
    case .voice:
      showRecordingButton = true
      showAttachmentMenu = false
    case .image:
      // 图片选择逻辑（这里可以打开图片选择器）
      showAttachmentMenu = false
    case .videoCall:
      // 视频通话跳转逻辑
      showAttachmentMenu = false
    }
  }
  
  func startRecording() {
    isRecording = true
  }
  
  func stopRecording() {
    isRecording = false
    showRecordingButton = false
  }

}

// MARK: - Attachment Option
enum AttachmentOption {
  case voice  // 录音
  case image  // 图片
  case videoCall  // 视频通话
}
