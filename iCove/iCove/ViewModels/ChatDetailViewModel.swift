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
  @Published var showAttachmentMenu: Bool = false
  @Published var showRecordingButton: Bool = false
  @Published var isRecording: Bool = false
  @Published var recordingDuration: TimeInterval = 0
  @Published var microphonePermissionGranted: Bool = false
  @Published var recordingErrorMessage: String?

  private let conversationId: String
  private let otherUserId: String
  private let authService: AuthenticationServiceProtocol
  private let messageService: MessageDataServiceProtocol
  private let audioService: AudioServiceProtocol
  private var recordingTimer: Timer?
  private var authManager: AuthenticationManager?

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

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadMessages()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadMessages()
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func updateAuthManager(_ authManager: AuthenticationManager) {
    self.authManager = authManager
    loadMessages()
  }

  func loadOtherUser() {
    otherUser = authService.getUserById(otherUserId)
  }

  func loadMessages() {
    isLoading = true
    Task {
      let allMessages = messageService.loadMessages(by: conversationId)
      messages = filterBlockedUsersMessages(allMessages)
      isLoading = false
    }
  }

  private func filterBlockedUsersMessages(_ messages: [Message]) -> [Message] {
    guard let blockedUserIds = authManager?.currentUser?.blockedUserIds, !blockedUserIds.isEmpty
    else {
      return messages
    }
    return messages.filter { !blockedUserIds.contains($0.senderId) }
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

    messageService.saveMessage(newMessage)

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

    messageService.saveMessage(newMessage)

    messages.append(newMessage)

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
      requestMicrophonePermissionIfNeeded { [weak self] granted in
        guard let self = self else { return }
        if granted {
          self.showRecordingButton = true
          self.showAttachmentMenu = false
        } else {
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
      showAttachmentMenu = false
    case .videoCall:
      showAttachmentMenu = false
    }
  }

  private func requestMicrophonePermissionIfNeeded(completion: @escaping (Bool) -> Void) {
    Task {
      let granted = await audioService.requestMicrophonePermission()
      await MainActor.run {
        microphonePermissionGranted = granted
        completion(granted)
      }
    }
  }

  func startRecording() {
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

  func stopRecording(currentUserId: String) {
    guard isRecording else { return }

    let duration = audioService.recordingDuration

    if duration < 0.5 {
      _ = audioService.stopRecording()
      isRecording = false
      recordingDuration = 0
      showRecordingButton = false
      stopRecordingTimer()

      recordingErrorMessage = "The recording is too short; please record again."

      Task {
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        await MainActor.run {
          recordingErrorMessage = nil
        }
      }
      return
    }

    if let audioURL = audioService.stopRecording() {
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

  func sendAudio(audioFileName: String, currentUserId: String) {
    let newMessage = Message(
      id: UUID().uuidString,
      conversationId: conversationId,
      senderId: currentUserId,
      content: audioFileName,
      messageType: .audio,
      timestamp: Date()
    )

    messageService.saveMessage(newMessage)

    messages.append(newMessage)
  }

  // MARK: - Private Methods

  private func saveAudioFile(from url: URL, userId: String) -> String? {
    let fileManager = FileManager.default
    let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let audioDir = documentsPath.appendingPathComponent("audio")

    try? fileManager.createDirectory(at: audioDir, withIntermediateDirectories: true)

    let fileName = "audio_\(userId)_\(UUID().uuidString).m4a"
    let destinationURL = audioDir.appendingPathComponent(fileName)

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

  private func startRecordingTimer() {
    stopRecordingTimer()
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

  private func stopRecordingTimer() {
    recordingTimer?.invalidate()
    recordingTimer = nil
  }

}

// MARK: - Attachment Option
enum AttachmentOption {
  case voice
  case image
  case videoCall
}
