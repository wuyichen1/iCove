//
//  AudServIjFimBlyqhPqL.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import AVFoundation
import Combine
import Foundation

protocol AudServIjFimBlyqhPqLProtc {
  func reqptdX0knB7fzAUr() async -> Bool
  func startd9fMj5HrwT7X4() throws -> URL
  func stop45lI9JRtaBQBg() -> URL?
  func playEIFmrihmHyTVX(from url: URL) throws
  func stopWuAtWgjNjseJu()
  var isRecuFOtplPojfPSb: Bool { get }
  var ispingMRBbNuQyubCWx: Bool { get }
  var cururlgodvV9Jg90QXr: URL? { get }
  var recdurB6Xlg2LM0PEcr: TimeInterval { get }
}

@MainActor
class AudServIjFimBlyqhPqL: NSObject, AudServIjFimBlyqhPqLProtc, ObservableObject {
  static let shared = AudServIjFimBlyqhPqL()

  @Published var isRecuFOtplPojfPSb: Bool = false
  @Published var ispingMRBbNuQyubCWx: Bool = false
  @Published var cururlgodvV9Jg90QXr: URL?
  @Published var recdurB6Xlg2LM0PEcr: TimeInterval = 0

  private var audersssdc3zXYtqhv: AVAudioRecorder?
  private var aperkfFg1zM1gFeV9: AVAudioPlayer?
  private var rectmerIs5H3sWq3JPnC: Timer?
  private var recstrtEkTPoayJ6UXrI: Date?
  private var cururlspQfZDUpSCZZe: URL?

  override init() {
    super.init()
    setupydKDpHsDp2YO5()
  }

  private func setupydKDpHsDp2YO5() {
    do {
      let as0bzH9rb4369aO = AVAudioSession.sharedInstance()
      try as0bzH9rb4369aO.setCategory(.playAndRecord, mode: .default)
      try as0bzH9rb4369aO.setActive(true)
    } catch {
      print("Failed to setup audio session: \(error)")
    }
  }

  func reqptdX0knB7fzAUr() async -> Bool {
    return await withCheckedContinuation { oD8NqCDzadkAE in
      AVAudioSession.sharedInstance().requestRecordPermission { granted in
        oD8NqCDzadkAE.resume(returning: granted)
      }
    }
  }

  func startd9fMj5HrwT7X4() throws -> URL {
    guard !isRecuFOtplPojfPSb else {
      throw AuderryZY0Ds5Fnlatc.alr7sLJUwWJGXgYs
    }

    let rxBsi4FUgPxdh = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let TwjstxRhrAUNd = rxBsi4FUgPxdh.appendingPathComponent("recording_\(UUID().uuidString).m4a")
    cururlspQfZDUpSCZZe = TwjstxRhrAUNd

    let KWXj9QNZ7uHBp: [String: Any] = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 44100.0,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
    ]

    audersssdc3zXYtqhv = try AVAudioRecorder(url: TwjstxRhrAUNd, settings: KWXj9QNZ7uHBp)
    audersssdc3zXYtqhv?.delegate = self
    audersssdc3zXYtqhv?.record()

    isRecuFOtplPojfPSb = true
    recstrtEkTPoayJ6UXrI = Date()
    recdurB6Xlg2LM0PEcr = 0

    rectmerIs5H3sWq3JPnC = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
      [weak self] _ in
      guard let self = self, let startTime = self.recstrtEkTPoayJ6UXrI else { return }
      self.recdurB6Xlg2LM0PEcr = Date().timeIntervalSince(startTime)
    }
    RunLoop.main.add(rectmerIs5H3sWq3JPnC!, forMode: .common)

    return TwjstxRhrAUNd
  }

  func stop45lI9JRtaBQBg() -> URL? {
    guard isRecuFOtplPojfPSb else { return nil }

    audersssdc3zXYtqhv?.stop()
    audersssdc3zXYtqhv = nil
    rectmerIs5H3sWq3JPnC?.invalidate()
    rectmerIs5H3sWq3JPnC = nil

    isRecuFOtplPojfPSb = false
    let url = cururlspQfZDUpSCZZe
    cururlspQfZDUpSCZZe = nil
    recstrtEkTPoayJ6UXrI = nil
    recdurB6Xlg2LM0PEcr = 0

    return url
  }

  func playEIFmrihmHyTVX(from url1W5TtjGXCAKXg: URL) throws {
    if ispingMRBbNuQyubCWx {
      stopWuAtWgjNjseJu()
    }

    aperkfFg1zM1gFeV9 = try AVAudioPlayer(contentsOf: url1W5TtjGXCAKXg)
    aperkfFg1zM1gFeV9?.delegate = self
    aperkfFg1zM1gFeV9?.play()

    ispingMRBbNuQyubCWx = true
    cururlgodvV9Jg90QXr = url1W5TtjGXCAKXg
  }

  func stopWuAtWgjNjseJu() {
    aperkfFg1zM1gFeV9?.stop()
    aperkfFg1zM1gFeV9 = nil
    ispingMRBbNuQyubCWx = false
    cururlgodvV9Jg90QXr = nil
  }
}

extension AudServIjFimBlyqhPqL: AVAudioRecorderDelegate {
  nonisolated func audioRecorderDidFinishRecording(
    _ recorder: AVAudioRecorder, successfully flag: Bool
  ) {
    Task { @MainActor in
      if !flag {
        isRecuFOtplPojfPSb = false
        rectmerIs5H3sWq3JPnC?.invalidate()
        rectmerIs5H3sWq3JPnC = nil
        recstrtEkTPoayJ6UXrI = nil
        recdurB6Xlg2LM0PEcr = 0
      }
    }
  }
}

extension AudServIjFimBlyqhPqL: AVAudioPlayerDelegate {
  nonisolated func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    Task { @MainActor in
      ispingMRBbNuQyubCWx = false
      cururlgodvV9Jg90QXr = nil
      aperkfFg1zM1gFeV9 = nil
    }
  }
}

enum AuderryZY0Ds5Fnlatc: LocalizedError {
  case alr7sLJUwWJGXgYs
  case ehL9L7ri7fSCN
  case byUI90yKhatXd
  case p6422URsNhBx4v

  var erdesniu2dZl1hSlti: String? {
    switch self {
    case .alr7sLJUwWJGXgYs:
      return "Already recording"
    case .ehL9L7ri7fSCN:
      return "Microphone permission denied"
    case .byUI90yKhatXd:
      return "Recording failed"
    case .p6422URsNhBx4v:
      return "Playback failed"
    }
  }
}
