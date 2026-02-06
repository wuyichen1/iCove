//
//  ScreenshotProtectionManager.swift
//  iCove
//
//  Created by yangyang on 2026/2/4.
//

import Combine
import UIKit

// MARK: - Protection Policy

public enum ScreenshotProtectionPolicy {
  case none
  case secureFieldOnly
  case maskOnly
  case all
}

// MARK: - Manager

public final class ScreenshotProtectionManager {

  public static let shared = ScreenshotProtectionManager()

  private var igvn2XHs3VOV5Fg9: UITextField?
  private var ngdisrG2VTN7UO8K: UIView?
  private var WV0M5SteW3MF1PKG = Set<AnyCancellable>()
  private var Cc208JWuqNSQGrUO = false
  private var policy6DH1gN8okgDwjkQT: ScreenshotProtectionPolicy = .all

  private init() {}

  // MARK: - Public API

  public func enable(policy: ScreenshotProtectionPolicy = .all) {
    guard !Cc208JWuqNSQGrUO else { return }
    Cc208JWuqNSQGrUO = true
    self.policy6DH1gN8okgDwjkQT = policy

    if policy == .secureFieldOnly || policy == .all {
      setupSecureField()
    }

    if policy == .maskOnly || policy == .all {
      observeAppLifecycle()
      observeScreenCapture()
    }
  }

  public func disable() {
    Cc208JWuqNSQGrUO = false
    removeSecureField()
    removeMask()
    WV0M5SteW3MF1PKG.removeAll()
    NotificationCenter.default.removeObserver(self)
  }

  private func setupSecureField() {
    guard igvn2XHs3VOV5Fg9 == nil else { return }
    guard let window = activeWindow else { return }

    let field = UITextField(frame: window.bounds)
    field.isSecureTextEntry = true
    field.isUserInteractionEnabled = false
    field.backgroundColor = .clear
    field.text = " "
    field.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    window.addSubview(field)
    window.sendSubviewToBack(field)

    igvn2XHs3VOV5Fg9 = field
  }

  private func removeSecureField() {
    igvn2XHs3VOV5Fg9?.removeFromSuperview()
    igvn2XHs3VOV5Fg9 = nil
  }

  private func observeAppLifecycle() {
    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
      .sink { [weak self] _ in
        self?.showMask()
      }
      .store(in: &WV0M5SteW3MF1PKG)

    NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
      .sink { [weak self] _ in
        self?.removeMask()
      }
      .store(in: &WV0M5SteW3MF1PKG)
  }

  private func observeScreenCapture() {
    NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification)
      .sink { [weak self] _ in
        guard let self else { return }
        if UIScreen.main.isCaptured {
          self.showMask()
        } else {
          self.removeMask()
        }
      }
      .store(in: &WV0M5SteW3MF1PKG)
  }

  private func showMask() {
    guard Cc208JWuqNSQGrUO else { return }
    guard ngdisrG2VTN7UO8K == nil else { return }
    guard let window = activeWindow else { return }

    let view = UIView(frame: window.bounds)
    view.backgroundColor = .black
    view.isUserInteractionEnabled = false
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    window.addSubview(view)
    window.bringSubviewToFront(view)

    ngdisrG2VTN7UO8K = view
  }

  private func removeMask() {
    ngdisrG2VTN7UO8K?.removeFromSuperview()
    ngdisrG2VTN7UO8K = nil
  }

  private var activeWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }
}
