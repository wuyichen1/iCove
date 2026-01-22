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
  @Published var recordingDuration: TimeInterval = 0  // 录音时长
  @Published var microphonePermissionGranted: Bool = false  // 麦克风权限状态
  @Published var recordingErrorMessage: String?  // 录音错误提示

  private let conversationId: String
  private let otherUserId: String
  private let authService: AuthenticationServiceProtocol
  private let messageService: MessageDataServiceProtocol
  private let audioService: AudioServiceProtocol
  private var recordingTimer: Timer?

  init(
    conversationId: String,
    otherUserId: String,
    authService: AuthenticationServiceProtocol = AuthenticationService.shared,
    messageService: MessageDataServiceProtocol = MessageDataService.shared,
    audioService: AudioServiceProtocol = AudioService.shared
  ) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    self.authService = authService
    self.messageService = messageService
    self.audioService = audioService
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
      // 点击录音图标时请求麦克风权限
      requestMicrophonePermissionIfNeeded { [weak self] granted in
        guard let self = self else { return }
        if granted {
          self.showRecordingButton = true
          self.showAttachmentMenu = false
        } else {
          // 权限被拒绝，可以显示提示
          self.recordingErrorMessage = "Microphone permission is required to record audio."
          Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
              self.recordingErrorMessage = nil
            }
          }
        }
      }
    case .image:
      // 图片选择逻辑（这里可以打开图片选择器）
      showAttachmentMenu = false
    case .videoCall:
      // 视频通话跳转逻辑
      showAttachmentMenu = false
    }
  }

  /// 如果需要，请求麦克风权限
  private func requestMicrophonePermissionIfNeeded(completion: @escaping (Bool) -> Void) {
    Task {
      let granted = await audioService.requestMicrophonePermission()
      await MainActor.run {
        microphonePermissionGranted = granted
        completion(granted)
      }
    }
  }

  /// 开始录音
  func startRecording() {
    // 检查权限，如果没有权限则不开始录音
    guard microphonePermissionGranted else {
      print("Microphone permission not granted")
      return
    }

    do {
      _ = try audioService.startRecording()
      isRecording = true
      startRecordingTimer()
    } catch {
      print("Failed to start recording: \(error)")
      recordingErrorMessage = "Failed to start recording. Please try again."
      Task {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        await MainActor.run {
          recordingErrorMessage = nil
        }
      }
    }
  }

  /// 停止录音并发送
  func stopRecording(currentUserId: String) {
    guard isRecording else { return }

    // 获取录音时长
    let duration = audioService.recordingDuration

    // 检查录音时长，如果小于0.5秒则认为过短
    if duration < 0.5 {
      // 停止录音但不发送
      _ = audioService.stopRecording()
      isRecording = false
      recordingDuration = 0
      showRecordingButton = false
      stopRecordingTimer()

      // 显示错误提示
      recordingErrorMessage = "The recording is too short; please record again."

      // 1.5秒后清除错误提示
      Task {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        await MainActor.run {
          recordingErrorMessage = nil
        }
      }
      return
    }

    if let audioURL = audioService.stopRecording() {
      // 保存音频文件并发送消息
      if let audioFileName = saveAudioFile(from: audioURL, userId: currentUserId) {
        sendAudio(audioFileName: audioFileName, currentUserId: currentUserId)
      }
    }

    isRecording = false
    recordingDuration = 0
    showRecordingButton = false
    stopRecordingTimer()
    recordingErrorMessage = nil
  }

  /// 发送音频消息
  func sendAudio(audioFileName: String, currentUserId: String) {
    let newMessage = Message(
      id: UUID().uuidString,
      conversationId: conversationId,
      senderId: currentUserId,
      content: audioFileName,
      messageType: .audio,
      timestamp: Date()
    )

    // 保存到持久化存储
    messageService.saveMessage(newMessage)

    // 更新本地消息列表
    messages.append(newMessage)
  }

  // MARK: - Private Methods

  /// 保存音频文件到本地
  private func saveAudioFile(from url: URL, userId: String) -> String? {
    let fileManager = FileManager.default
    let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let audioDir = documentsPath.appendingPathComponent("audio")

    // 创建音频目录（如果不存在）
    try? fileManager.createDirectory(at: audioDir, withIntermediateDirectories: true)

    // 生成文件名
    let fileName = "audio_\(userId)_\(UUID().uuidString).m4a"
    let destinationURL = audioDir.appendingPathComponent(fileName)

    // 复制文件
    do {
      if fileManager.fileExists(atPath: destinationURL.path) {
        try fileManager.removeItem(at: destinationURL)
      }
      try fileManager.copyItem(at: url, to: destinationURL)
      return fileName
    } catch {
      print("Failed to save audio file: \(error)")
      return nil
    }
  }

  /// 启动录音计时器
  private func startRecordingTimer() {
    stopRecordingTimer()  // 先停止之前的计时器
    recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
      [weak self] timer in
      Task { @MainActor [weak self] in
        guard let self = self, self.isRecording else {
          timer.invalidate()
          return
        }
        self.recordingDuration = self.audioService.recordingDuration
      }
    }
  }

  /// 停止录音计时器
  private func stopRecordingTimer() {
    recordingTimer?.invalidate()
    recordingTimer = nil
  }

}

// MARK: - Attachment Option
enum AttachmentOption {
  case voice  // 录音
  case image  // 图片
  case videoCall  // 视频通话
}
