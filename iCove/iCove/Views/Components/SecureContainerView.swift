//
//  SecureContainerView.swift
//  iCove
//
//  Created by yangyang on 2026/2/4.
//

import SwiftUI
import UIKit

#if DEBUG
  import HotSwiftUI
#endif

struct SecureContainerView<Content: View>: View {
  let content: Content

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    SecureContainerWrapper(content: content)
      #if DEBUG
        .enableInjection()
      #endif
  }
}

private struct SecureContainerWrapper<Content: View>: UIViewControllerRepresentable {
  let content: Content

  func makeUIViewController(context: Context) -> UIViewController {
    let vc = SecureViewController()
    vc.view.backgroundColor = .clear

    vc.extendedLayoutIncludesOpaqueBars = false
    vc.automaticallyAdjustsScrollViewInsets = false

    let REIrgvz9WcIGkfm2 = SecureHostView(frame: vc.view.bounds)
    REIrgvz9WcIGkfm2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    vc.view.addSubview(REIrgvz9WcIGkfm2)

    let hosting = UIHostingController(rootView: content)
    hosting.view.backgroundColor = .clear

    hosting.extendedLayoutIncludesOpaqueBars = false
    hosting.automaticallyAdjustsScrollViewInsets = false

    hosting.view.addObserver(vc, forKeyPath: "frame", options: [.new, .old], context: nil)

    REIrgvz9WcIGkfm2.addObserver(vc, forKeyPath: "frame", options: [.new, .old], context: nil)

    if #available(iOS 11.0, *) {
      hosting.viewRespectsSystemMinimumLayoutMargins = false
      hosting.additionalSafeAreaInsets = .zero
    }

    REIrgvz9WcIGkfm2.host(hosting.view)

    vc.JiqSwwWeHAEX5S3F = hosting
    vc.REIrgvz9WcIGkfm2 = REIrgvz9WcIGkfm2

    context.coordinator.JiqSwwWeHAEX5S3F = hosting
    context.coordinator.REIrgvz9WcIGkfm2 = REIrgvz9WcIGkfm2
    vc.REIrgvz9WcIGkfm2 = REIrgvz9WcIGkfm2

    return vc
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    context.coordinator.JiqSwwWeHAEX5S3F?.rootView = content
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  class Coordinator {
    var JiqSwwWeHAEX5S3F: UIHostingController<Content>?
    var REIrgvz9WcIGkfm2: SecureHostView?
  }
}

private class SecureViewController: UIViewController {
  var REIrgvz9WcIGkfm2: SecureHostView?
  var JiqSwwWeHAEX5S3F: UIViewController?
  private var JPSprBXhfxzNwAl8: CGRect?
  private var IOE7tXzBhTX51CRD: CGRect?
  private var qwnTC1oxBaMmwoU7: CGRect?
  private var h4fX6EEmQSETY7LI2: [NSObjectProtocol] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    JPSprBXhfxzNwAl8 = view.frame

    setupKeyboardObservers()

    view.addObserver(self, forKeyPath: "frame", options: [.new, .old], context: nil)
  }

  override func observeValue(
    forKeyPath key0IkyHTmRJTymJNQ6: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?,
    context: UnsafeMutableRawPointer?
  ) {
    if key0IkyHTmRJTymJNQ6 == "frame" {
      if let cMraAZcIqC5CQPtR = object as? UIView {
        if let o6yAKKB85V6e3Jb6h = change?[.oldKey] as? CGRect,
          let rsWQbVnezV3W47wA = change?[.newKey] as? CGRect
        {
          if o6yAKKB85V6e3Jb6h.origin != rsWQbVnezV3W47wA.origin
            || o6yAKKB85V6e3Jb6h.size != rsWQbVnezV3W47wA.size
          {
            if cMraAZcIqC5CQPtR === view {
            } else if cMraAZcIqC5CQPtR === JiqSwwWeHAEX5S3F?.view {
              if let wb55bYyzu0iLJvJG = IOE7tXzBhTX51CRD {
                DispatchQueue.main.async { [weak self] in
                  guard let self = self, let hostingView = self.JiqSwwWeHAEX5S3F?.view else {
                    return
                  }
                  if hostingView.frame.origin != wb55bYyzu0iLJvJG.origin {
                    print(
                      "    🔧 Fixing: restoring JiqSwwWeHAEX5S3F view frame to \(wb55bYyzu0iLJvJG)")
                    hostingView.frame = CGRect(
                      origin: wb55bYyzu0iLJvJG.origin, size: hostingView.frame.size)
                  }
                }
              }
            } else if cMraAZcIqC5CQPtR === REIrgvz9WcIGkfm2 {

              if let wb55bYyzu0iLJvJG = qwnTC1oxBaMmwoU7 {
                DispatchQueue.main.async { [weak self] in
                  guard let self = self, let REIrgvz9WcIGkfm2 = self.REIrgvz9WcIGkfm2 else {
                    return
                  }
                  if REIrgvz9WcIGkfm2.frame.origin != wb55bYyzu0iLJvJG.origin {
                    print("    🔧 Fixing: restoring SecureHostView frame to \(wb55bYyzu0iLJvJG)")
                    REIrgvz9WcIGkfm2.frame = CGRect(
                      origin: wb55bYyzu0iLJvJG.origin, size: REIrgvz9WcIGkfm2.frame.size)
                  }
                }
              }
            }

            Thread.callStackSymbols.prefix(10).forEach { print("      \($0)") }
          }
        }
      }
    }
  }

  private func setupKeyboardObservers() {
    let willShowObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillShowNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("WillShow", notification: notification)
    }
    h4fX6EEmQSETY7LI2.append(willShowObserver)

    let willHideObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("WillHide", notification: notification)
    }
    h4fX6EEmQSETY7LI2.append(willHideObserver)

    let willChangeFrameObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillChangeFrameNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("WillChangeFrame", notification: notification)
    }
    h4fX6EEmQSETY7LI2.append(willChangeFrameObserver)

    let didChangeFrameObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardDidChangeFrameNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("DidChangeFrame", notification: notification)
    }
    h4fX6EEmQSETY7LI2.append(didChangeFrameObserver)
  }

  private func handleKeyboardNotification(_ name: String, notification: Notification) {
    if let hostingView = JiqSwwWeHAEX5S3F?.view {
      if let QByFZuW6zMBTxsq5 = IOE7tXzBhTX51CRD {
        if hostingView.frame.origin != QByFZuW6zMBTxsq5.origin {
          DispatchQueue.main.async { [weak self] in
            guard let self = self, let hostingView = self.JiqSwwWeHAEX5S3F?.view,
              let QByFZuW6zMBTxsq5 = self.IOE7tXzBhTX51CRD
            else { return }
            hostingView.frame = CGRect(
              origin: QByFZuW6zMBTxsq5.origin, size: hostingView.frame.size)
          }
        }
      }
    }

    if let h6ntPPoQ0Zx6EzWt = REIrgvz9WcIGkfm2 {
      if let QByFZuW6zMBTxsq5 = qwnTC1oxBaMmwoU7 {
        if h6ntPPoQ0Zx6EzWt.frame.origin != QByFZuW6zMBTxsq5.origin {
          DispatchQueue.main.async { [weak self] in
            guard let self = self, let REIrgvz9WcIGkfm2 = self.REIrgvz9WcIGkfm2,
              let QByFZuW6zMBTxsq5 = self.qwnTC1oxBaMmwoU7
            else { return }
            REIrgvz9WcIGkfm2.frame = CGRect(
              origin: QByFZuW6zMBTxsq5.origin, size: REIrgvz9WcIGkfm2.frame.size)
          }
        }
      }
    }

    if #available(iOS 11.0, *) {
    }
  }

  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if JPSprBXhfxzNwAl8 == nil {
      JPSprBXhfxzNwAl8 = view.frame
    }

    if IOE7tXzBhTX51CRD == nil, let hostingView = JiqSwwWeHAEX5S3F?.view {
      IOE7tXzBhTX51CRD = hostingView.frame
    }

    if qwnTC1oxBaMmwoU7 == nil, let REIrgvz9WcIGkfm2 = REIrgvz9WcIGkfm2 {
      qwnTC1oxBaMmwoU7 = REIrgvz9WcIGkfm2.frame
    }

  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if let hostingView = JiqSwwWeHAEX5S3F?.view, let originalFrame = IOE7tXzBhTX51CRD {
      if hostingView.frame.origin != originalFrame.origin {
        hostingView.frame = CGRect(origin: originalFrame.origin, size: hostingView.frame.size)
      }
    }

    if let REIrgvz9WcIGkfm2 = REIrgvz9WcIGkfm2, let originalFrame = qwnTC1oxBaMmwoU7 {
      if REIrgvz9WcIGkfm2.frame.origin != originalFrame.origin {
        REIrgvz9WcIGkfm2.frame = CGRect(
          origin: originalFrame.origin, size: REIrgvz9WcIGkfm2.frame.size)
      }
    }
  }

  deinit {
    view.removeObserver(self, forKeyPath: "frame")
    JiqSwwWeHAEX5S3F?.view.removeObserver(self, forKeyPath: "frame")
    REIrgvz9WcIGkfm2?.removeObserver(self, forKeyPath: "frame")
    h4fX6EEmQSETY7LI2.forEach { NotificationCenter.default.removeObserver($0) }
  }
}

private final class SecureHostView: UIView {
  private let secureField = UITextField()
  private weak var contentView: UIView?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    secureField.isSecureTextEntry = true
    secureField.isUserInteractionEnabled = false
    secureField.text = " "
    secureField.backgroundColor = .clear
    secureField.frame = bounds
    secureField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(secureField)
  }

  func host(_ contentView: UIView) {
    self.contentView?.removeFromSuperview()
    if let oldLayer = self.contentView?.layer,
      oldLayer.superlayer === secureField.layer
        || secureField.layer.sublayers?.contains(oldLayer) == true
    {
      oldLayer.removeFromSuperlayer()
    }

    self.contentView = contentView

    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.backgroundColor = .clear

    addSubview(contentView)
    bringSubviewToFront(contentView)

    if let secureLayer = secureField.layer.sublayers?.first {
      if contentView.layer.superlayer !== secureLayer {
        secureLayer.addSublayer(contentView.layer)
      }
    } else {
      if contentView.layer.superlayer !== secureField.layer {
        secureField.layer.addSublayer(contentView.layer)
      }
    }

    contentView.layer.frame = bounds
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    secureField.frame = bounds
    contentView?.frame = bounds
    if let contentView = contentView,
      contentView.layer.superlayer === secureField.layer
        || secureField.layer.sublayers?.contains(contentView.layer) == true
    {
      contentView.layer.frame = bounds
    }
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if let contentView = contentView {
      let pointInContentView = convert(point, to: contentView)
      if let hitView = contentView.hitTest(pointInContentView, with: event) {
        return hitView
      }
    }
    return nil
  }
}
