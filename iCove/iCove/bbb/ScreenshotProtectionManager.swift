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

  private var secureField: UITextField?
  private var maskView: UIView?
  private var cancellables = Set<AnyCancellable>()
  private var isEnabled = false
  private var policy: ScreenshotProtectionPolicy = .all

  private init() {}

  // MARK: - Public API

  public func enable(policy: ScreenshotProtectionPolicy = .all) {
    guard !isEnabled else { return }
    isEnabled = true
    self.policy = policy

    if policy == .secureFieldOnly || policy == .all {
      setupSecureField()
    }

    if policy == .maskOnly || policy == .all {
      observeAppLifecycle()
      observeScreenCapture()
    }
  }

  public func disable() {
    isEnabled = false
    removeSecureField()
    removeMask()
    cancellables.removeAll()
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Secure Field Layer (真正挡截图)

  private func setupSecureField() {
    guard secureField == nil else { return }
    guard let window = activeWindow else { return }

    let field = UITextField(frame: window.bounds)
    field.isSecureTextEntry = true
    field.isUserInteractionEnabled = false
    field.backgroundColor = .clear
    field.text = " "  // ⚠️ 必须有内容，否则部分系统不生效
    field.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    window.addSubview(field)
    window.sendSubviewToBack(field)

    secureField = field
  }

  private func removeSecureField() {
    secureField?.removeFromSuperview()
    secureField = nil
  }

  // MARK: - Mask Layer (后台 / 切前台)

  private func observeAppLifecycle() {
    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
      .sink { [weak self] _ in
        self?.showMask()
      }
      .store(in: &cancellables)

    NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
      .sink { [weak self] _ in
        self?.removeMask()
      }
      .store(in: &cancellables)
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
      .store(in: &cancellables)
  }

  private func showMask() {
    guard isEnabled else { return }
    guard maskView == nil else { return }
    guard let window = activeWindow else { return }

    let view = UIView(frame: window.bounds)
    view.backgroundColor = .black
    view.isUserInteractionEnabled = false
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    window.addSubview(view)
    window.bringSubviewToFront(view)

    maskView = view
  }

  private func removeMask() {
    maskView?.removeFromSuperview()
    maskView = nil
  }

  // MARK: - Window

  private var activeWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }
}

// import Combine
// import UIKit

// final class ScreenshotProtectionManager {

//   static let shared = ScreenshotProtectionManager()

//   private var maskView: UIView?
//   private var isEnabled: Bool = false
//   private var cancellables = Set<AnyCancellable>()

//   private init() {}

//   // MARK: - Public API

//   /// 开启防截图保护
//   func enable() {
//     guard !isEnabled else { return }
//     isEnabled = true

//     observeScreenshot()
//     observeScreenCapture()
//     observeAppLifecycle()
//   }

//   /// 关闭防截图保护
//   func disable() {
//     isEnabled = false
//     removeMask()
//     cancellables.removeAll()
//     NotificationCenter.default.removeObserver(self)
//   }

//   // MARK: - Observers

//   private func observeScreenshot() {
//     NotificationCenter.default.addObserver(
//       self,
//       selector: #selector(handleScreenshot),
//       name: UIApplication.userDidTakeScreenshotNotification,
//       object: nil
//     )
//   }

//   private func observeAppLifecycle() {
//     NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
//       .sink { [weak self] _ in
//         self?.showMask()
//       }
//       .store(in: &cancellables)

//     NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
//       .sink { [weak self] _ in
//         self?.removeMask()
//       }
//       .store(in: &cancellables)
//   }

//   private func observeScreenCapture() {
//     NotificationCenter.default.publisher(for: UIScreen.capturedDidChangeNotification)
//       .sink { [weak self] _ in
//         guard let self else { return }
//         if UIScreen.main.isCaptured {
//           self.showMask()
//         } else {
//           self.removeMask()
//         }
//       }
//       .store(in: &cancellables)
//   }

//   // MARK: - Actions

//   @objc private func handleScreenshot() {
//     showMask()
//     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//       self.removeMask()
//     }
//   }

//   // MARK: - Mask Control

//   private func showMask() {
//     guard isEnabled else { return }
//     guard maskView == nil else { return }

//     guard let window = activeWindow else { return }

//     let view = UIView(frame: window.bounds)
//     view.backgroundColor = .black
//     view.isUserInteractionEnabled = false
//     view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

//     window.addSubview(view)
//     window.bringSubviewToFront(view)

//     maskView = view
//   }

//   private func removeMask() {
//     maskView?.removeFromSuperview()
//     maskView = nil
//   }

//   private var activeWindow: UIWindow? {
//     UIApplication.shared.connectedScenes
//       .compactMap { $0 as? UIWindowScene }
//       .flatMap { $0.windows }
//       .first { $0.isKeyWindow }
//   }
// }
