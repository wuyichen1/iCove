//
//  AudioService.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import AVFoundation
import Combine
import Foundation

protocol AudioServiceProtocol {
  func requestMicrophonePermission() async -> Bool
  func startRecording() throws -> URL
  func stopRecording() -> URL?
  func playAudio(from url: URL) throws
  func stopPlaying()
  var isRecording: Bool { get }
  var isPlaying: Bool { get }
  var currentPlayingURL: URL? { get }
  var recordingDuration: TimeInterval { get }
}

/// 音频服务 - 负责音频录制和播放
@MainActor
class AudioService: NSObject, AudioServiceProtocol, ObservableObject {
  static let shared = AudioService()

  // MARK: - Published Properties
  @Published var isRecording: Bool = false
  @Published var isPlaying: Bool = false
  @Published var currentPlayingURL: URL?
  @Published var recordingDuration: TimeInterval = 0

  // MARK: - Private Properties
  private var audioRecorder: AVAudioRecorder?
  private var audioPlayer: AVAudioPlayer?
  private var recordingTimer: Timer?
  private var recordingStartTime: Date?
  private var currentRecordingURL: URL?

  // MARK: - Initialization
  override init() {
    super.init()
    setupAudioSession()
  }

  // MARK: - Audio Session Setup
  private func setupAudioSession() {
    do {
      let audioSession = AVAudioSession.sharedInstance()
      try audioSession.setCategory(.playAndRecord, mode: .default)
      try audioSession.setActive(true)
    } catch {
      print("Failed to setup audio session: \(error)")
    }
  }

  // MARK: - Permission
  func requestMicrophonePermission() async -> Bool {
    return await withCheckedContinuation { continuation in
      AVAudioSession.sharedInstance().requestRecordPermission { granted in
        continuation.resume(returning: granted)
      }
    }
  }

  // MARK: - Recording
  func startRecording() throws -> URL {
    guard !isRecording else {
      throw AudioServiceError.alreadyRecording
    }

    // 创建录音文件 URL
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let audioFilename = documentsPath.appendingPathComponent("recording_\(UUID().uuidString).m4a")
    currentRecordingURL = audioFilename

    // 配置录音设置
    let settings: [String: Any] = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 44100.0,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
    ]

    // 创建录音器
    audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
    audioRecorder?.delegate = self
    audioRecorder?.record()

    isRecording = true
    recordingStartTime = Date()
    recordingDuration = 0

    // 启动计时器（在主线程运行）
    recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      guard let self = self, let startTime = self.recordingStartTime else { return }
      self.recordingDuration = Date().timeIntervalSince(startTime)
    }
    RunLoop.main.add(recordingTimer!, forMode: .common)

    return audioFilename
  }

  func stopRecording() -> URL? {
    guard isRecording else { return nil }

    audioRecorder?.stop()
    audioRecorder = nil
    recordingTimer?.invalidate()
    recordingTimer = nil

    isRecording = false
    let url = currentRecordingURL
    currentRecordingURL = nil
    recordingStartTime = nil
    recordingDuration = 0

    return url
  }

  // MARK: - Playing
  func playAudio(from url: URL) throws {
    // 如果正在播放其他音频，先停止
    if isPlaying {
      stopPlaying()
    }

    // 创建播放器
    audioPlayer = try AVAudioPlayer(contentsOf: url)
    audioPlayer?.delegate = self
    audioPlayer?.play()

    isPlaying = true
    currentPlayingURL = url
  }

  func stopPlaying() {
    audioPlayer?.stop()
    audioPlayer = nil
    isPlaying = false
    currentPlayingURL = nil
  }
}

// MARK: - AVAudioRecorderDelegate
extension AudioService: AVAudioRecorderDelegate {
  nonisolated func audioRecorderDidFinishRecording(
    _ recorder: AVAudioRecorder, successfully flag: Bool
  ) {
    Task { @MainActor in
      if !flag {
        isRecording = false
        recordingTimer?.invalidate()
        recordingTimer = nil
        recordingStartTime = nil
        recordingDuration = 0
      }
    }
  }
}

// MARK: - AVAudioPlayerDelegate
extension AudioService: AVAudioPlayerDelegate {
  nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    Task { @MainActor in
      isPlaying = false
      currentPlayingURL = nil
      audioPlayer = nil
    }
  }
}

// MARK: - Errors
enum AudioServiceError: LocalizedError {
  case alreadyRecording
  case permissionDenied
  case recordingFailed
  case playbackFailed

  var errorDescription: String? {
    switch self {
    case .alreadyRecording:
      return "已经在录音中"
    case .permissionDenied:
      return "麦克风权限被拒绝"
    case .recordingFailed:
      return "录音失败"
    case .playbackFailed:
      return "播放失败"
    }
  }
}
