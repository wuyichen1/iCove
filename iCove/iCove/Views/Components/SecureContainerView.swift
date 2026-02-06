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

/// 安全容器视图，使用系统 Secure 容器实现截图黑屏保护
///
/// 原理：将内容视图的 layer 添加到 `isSecureTextEntry = true` 的 UITextField 的 layer 中
/// iOS 系统在截图时会自动将包含 secure text entry 的视图显示为黑屏
/// 这是系统级别的保护机制，比手动添加覆盖层更可靠
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

/// 安全容器包装器，使用 UIViewControllerRepresentable 实现
private struct SecureContainerWrapper<Content: View>: UIViewControllerRepresentable {
  let content: Content

  func makeUIViewController(context: Context) -> UIViewController {
    let vc = SecureViewController()
    vc.view.backgroundColor = .clear

    // ✅ 修复1: 禁用自动调整
    vc.extendedLayoutIncludesOpaqueBars = false
    vc.automaticallyAdjustsScrollViewInsets = false

    // Secure 宿主
    let secureHost = SecureHostView(frame: vc.view.bounds)
    secureHost.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    vc.view.addSubview(secureHost)

    // SwiftUI -> UIKit
    let hosting = UIHostingController(rootView: content)
    hosting.view.backgroundColor = .clear

    // ✅ 修复2: 在 UIHostingController 层面禁用自动调整
    hosting.extendedLayoutIncludesOpaqueBars = false
    hosting.automaticallyAdjustsScrollViewInsets = false
    
    // 🔍 调试：监听 UIHostingController 的 view frame 变化
    hosting.view.addObserver(vc, forKeyPath: "frame", options: [.new, .old], context: nil)
    
    // 🔍 调试：监听 SecureHostView 的 frame 变化
    secureHost.addObserver(vc, forKeyPath: "frame", options: [.new, .old], context: nil)
    
    // ✅ 修复：iOS 11+ 禁用键盘避让
    if #available(iOS 11.0, *) {
      hosting.viewRespectsSystemMinimumLayoutMargins = false
      hosting.additionalSafeAreaInsets = .zero
    }

    // ⚠️ 关键：不要 addSubview 到 vc.view，而是通过 secureHost.host() 添加
    secureHost.host(hosting.view)
    
    // 🔍 调试：保存 hosting 引用以便调试
    vc.hostingController = hosting
    vc.secureHost = secureHost

    // 保存引用，避免被释放
    context.coordinator.hostingController = hosting
    context.coordinator.secureHost = secureHost
    vc.secureHost = secureHost
    // 注意：hostingController 类型不匹配，但不影响功能，因为已经通过 coordinator 保存了引用

    return vc
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    // 更新 SwiftUI 视图内容
    context.coordinator.hostingController?.rootView = content
  }

  func makeCoordinator() -> Coordinator {
    Coordinator()
  }

  class Coordinator {
    var hostingController: UIHostingController<Content>?
    var secureHost: SecureHostView?
  }
}

/// 自定义 UIViewController
private class SecureViewController: UIViewController {
  var secureHost: SecureHostView?
  var hostingController: UIViewController?  // 使用 UIViewController 类型避免泛型问题
  
  // 🔍 调试：追踪 frame 变化
  private var originalViewFrame: CGRect?
  private var originalHostingViewFrame: CGRect?
  private var originalSecureHostFrame: CGRect?
  private var keyboardObservers: [NSObjectProtocol] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    originalViewFrame = view.frame
    print("🔍 [SecureViewController] viewDidLoad - frame: \(view.frame)")
    
    // 🔍 调试：监听键盘通知
    setupKeyboardObservers()
    
    // 🔍 调试：监听 frame 变化
    view.addObserver(self, forKeyPath: "frame", options: [.new, .old], context: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "frame" {
      if let observedView = object as? UIView {
        if let oldFrame = change?[.oldKey] as? CGRect,
           let newFrame = change?[.newKey] as? CGRect {
          if oldFrame.origin != newFrame.origin || oldFrame.size != newFrame.size {
            // 判断是哪个 view
            if observedView === view {
              print("🔍 [SecureViewController] View frame changed - old: \(oldFrame), new: \(newFrame)")
            } else if observedView === hostingController?.view {
              print("🔍 [SecureViewController] HostingController view frame changed - old: \(oldFrame), new: \(newFrame)")
              print("    ⚠️ HostingController view is being adjusted by the system")
              
              // 🔧 修复：强制恢复 hostingController view 的 frame
              if let originalFrame = originalHostingViewFrame {
                DispatchQueue.main.async { [weak self] in
                  guard let self = self, let hostingView = self.hostingController?.view else { return }
                  if hostingView.frame.origin != originalFrame.origin {
                    print("    🔧 Fixing: restoring hostingController view frame to \(originalFrame)")
                    hostingView.frame = CGRect(origin: originalFrame.origin, size: hostingView.frame.size)
                  }
                }
              }
            } else if observedView === secureHost {
              print("🔍 [SecureViewController] SecureHostView frame changed - old: \(oldFrame), new: \(newFrame)")
              print("    ⚠️ SecureHostView is being adjusted by the system!")
              
              // 🔧 修复：强制恢复 SecureHostView 的 frame
              if let originalFrame = originalSecureHostFrame {
                DispatchQueue.main.async { [weak self] in
                  guard let self = self, let secureHost = self.secureHost else { return }
                  if secureHost.frame.origin != originalFrame.origin {
                    print("    🔧 Fixing: restoring SecureHostView frame to \(originalFrame)")
                    secureHost.frame = CGRect(origin: originalFrame.origin, size: secureHost.frame.size)
                  }
                }
              }
            }
            
            print("    Origin changed: \(oldFrame.origin) -> \(newFrame.origin)")
            print("    Size changed: \(oldFrame.size) -> \(newFrame.size)")
            
            // 打印调用栈
            print("    Call stack:")
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
    keyboardObservers.append(willShowObserver)
    
    let willHideObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("WillHide", notification: notification)
    }
    keyboardObservers.append(willHideObserver)
    
    let willChangeFrameObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillChangeFrameNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("WillChangeFrame", notification: notification)
    }
    keyboardObservers.append(willChangeFrameObserver)
    
    let didChangeFrameObserver = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardDidChangeFrameNotification,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      self?.handleKeyboardNotification("DidChangeFrame", notification: notification)
    }
    keyboardObservers.append(didChangeFrameObserver)
  }
  
  private func handleKeyboardNotification(_ name: String, notification: Notification) {
    print("🔍 [SecureViewController] Keyboard \(name)")
    
    if let userInfo = notification.userInfo {
      if let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
        print("    Keyboard frame: \(frame)")
      }
      if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
        print("    Animation duration: \(duration)")
      }
      if let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
        print("    Animation curve: \(curve)")
      }
    }
    
    print("    View frame: \(view.frame)")
    print("    View bounds: \(view.bounds)")
    print("    View center: \(view.center)")
    if let originalFrame = originalViewFrame {
      print("    Original frame: \(originalFrame)")
      if view.frame.origin != originalFrame.origin {
        print("    ⚠️ Frame origin changed!")
      }
    }
    
    // 🔍 检查 hostingController view
    if let hostingView = hostingController?.view {
      print("    HostingController view frame: \(hostingView.frame)")
      print("    HostingController view bounds: \(hostingView.bounds)")
      if let originalFrame = originalHostingViewFrame {
        print("    Original hostingController view frame: \(originalFrame)")
        if hostingView.frame.origin != originalFrame.origin {
          print("    ⚠️ HostingController view frame origin changed!")
          
          // 🔧 修复：立即恢复
          DispatchQueue.main.async { [weak self] in
            guard let self = self, let hostingView = self.hostingController?.view,
                  let originalFrame = self.originalHostingViewFrame else { return }
            print("    🔧 Fixing: restoring hostingController view frame to \(originalFrame)")
            hostingView.frame = CGRect(origin: originalFrame.origin, size: hostingView.frame.size)
          }
        }
      }
    }
    
    // 🔍 检查 SecureHostView
    if let secureHost = secureHost {
      print("    SecureHostView frame: \(secureHost.frame)")
      print("    SecureHostView bounds: \(secureHost.bounds)")
      if let originalFrame = originalSecureHostFrame {
        print("    Original SecureHostView frame: \(originalFrame)")
        if secureHost.frame.origin != originalFrame.origin {
          print("    ⚠️ SecureHostView frame origin changed!")
          
          // 🔧 修复：立即恢复
          DispatchQueue.main.async { [weak self] in
            guard let self = self, let secureHost = self.secureHost,
                  let originalFrame = self.originalSecureHostFrame else { return }
            print("    🔧 Fixing: restoring SecureHostView frame to \(originalFrame)")
            secureHost.frame = CGRect(origin: originalFrame.origin, size: secureHost.frame.size)
          }
        }
      }
    }
    
    // 检查父视图
    if let superview = view.superview {
      print("    Superview frame: \(superview.frame)")
      print("    Superview bounds: \(superview.bounds)")
    }
    
    // 检查安全区域
    if #available(iOS 11.0, *) {
      print("    Safe area insets: \(view.safeAreaInsets)")
      print("    Additional safe area insets: \(additionalSafeAreaInsets)")
    }
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if originalViewFrame == nil {
      originalViewFrame = view.frame
      print("🔍 [SecureViewController] viewWillLayoutSubviews - saved original frame: \(view.frame)")
    }
    
    // 🔍 保存 hostingController view 的原始 frame
    if originalHostingViewFrame == nil, let hostingView = hostingController?.view {
      originalHostingViewFrame = hostingView.frame
      print("🔍 [SecureViewController] viewWillLayoutSubviews - saved original hostingController view frame: \(hostingView.frame)")
    }
    
    // 🔍 保存 SecureHostView 的原始 frame
    if originalSecureHostFrame == nil, let secureHost = secureHost {
      originalSecureHostFrame = secureHost.frame
      print("🔍 [SecureViewController] viewWillLayoutSubviews - saved original SecureHostView frame: \(secureHost.frame)")
    }
    
    print("🔍 [SecureViewController] viewWillLayoutSubviews - current frame: \(view.frame)")
    if let hostingView = hostingController?.view {
      print("    HostingController view frame: \(hostingView.frame)")
    }
    if let secureHost = secureHost {
      print("    SecureHostView frame: \(secureHost.frame)")
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print("🔍 [SecureViewController] viewDidLayoutSubviews - frame: \(view.frame)")
    if let originalFrame = originalViewFrame, view.frame.origin != originalFrame.origin {
      print("    ⚠️ Frame origin changed in viewDidLayoutSubviews!")
    }
    
    // 🔧 修复：强制恢复 hostingController view 的 frame
    if let hostingView = hostingController?.view, let originalFrame = originalHostingViewFrame {
      if hostingView.frame.origin != originalFrame.origin {
        print("    🔧 Fixing: restoring hostingController view frame in viewDidLayoutSubviews")
        hostingView.frame = CGRect(origin: originalFrame.origin, size: hostingView.frame.size)
      }
    }
    
    // 🔧 修复：强制恢复 SecureHostView 的 frame
    if let secureHost = secureHost, let originalFrame = originalSecureHostFrame {
      if secureHost.frame.origin != originalFrame.origin {
        print("    🔧 Fixing: restoring SecureHostView frame in viewDidLayoutSubviews")
        secureHost.frame = CGRect(origin: originalFrame.origin, size: secureHost.frame.size)
      }
    }
  }
  
  deinit {
    view.removeObserver(self, forKeyPath: "frame")
    hostingController?.view.removeObserver(self, forKeyPath: "frame")
    secureHost?.removeObserver(self, forKeyPath: "frame")
    keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
  }
}

/// Secure 宿主视图，使用 UITextField 的 secure text entry 实现截图保护
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
    secureField.isSecureTextEntry = true  // 关键：启用 secure text entry
    secureField.isUserInteractionEnabled = false  // 不拦截用户交互
    secureField.text = " "  // ⚠️ 必须有内容，否则部分系统不生效
    secureField.backgroundColor = .clear
    secureField.frame = bounds
    secureField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(secureField)
  }

  /// 把外部 view 挂进 secure layer
  /// 关键：既要将 layer 添加到 secureField.layer 中（用于截图保护），
  /// 也要将视图添加到视图层级中（用于交互）
  func host(_ contentView: UIView) {
    // 移除旧的内容视图
    self.contentView?.removeFromSuperview()
    // 如果旧视图的 layer 在 secureField.layer 中，也需要移除
    if let oldLayer = self.contentView?.layer,
      oldLayer.superlayer === secureField.layer
        || secureField.layer.sublayers?.contains(oldLayer) == true
    {
      oldLayer.removeFromSuperlayer()
    }

    // 保存引用
    self.contentView = contentView

    // 设置内容视图的属性
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.backgroundColor = .clear

    // 1. 将内容视图添加到视图层级中（用于交互）
    // 添加到 secureField 之上，确保能接收触摸事件
    addSubview(contentView)
    bringSubviewToFront(contentView)

    // 2. 将内容视图的 layer 也添加到 secureField.layer 中（用于截图保护）
    // 注意：UIView 的 layer 可以同时存在于视图层级和另一个 layer 的 sublayers 中
    // 但是需要确保 layer 的 frame 正确
    // 如果 secureField.layer 已经有子 layer，添加到第一个子 layer 中
    // 否则直接添加到 secureField.layer
    if let secureLayer = secureField.layer.sublayers?.first {
      // 检查是否已经添加过
      if contentView.layer.superlayer !== secureLayer {
        secureLayer.addSublayer(contentView.layer)
      }
    } else {
      // 检查是否已经添加过
      if contentView.layer.superlayer !== secureField.layer {
        secureField.layer.addSublayer(contentView.layer)
      }
    }

    // 确保 layer 的 frame 正确
    contentView.layer.frame = bounds
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    // 确保 secureField 的 frame 始终填满整个视图
    secureField.frame = bounds
    // 确保内容视图的 frame 也正确
    contentView?.frame = bounds
    // 确保 layer 的 frame 也正确（如果 layer 在 secureField.layer 中）
    if let contentView = contentView,
      contentView.layer.superlayer === secureField.layer
        || secureField.layer.sublayers?.contains(contentView.layer) == true
    {
      contentView.layer.frame = bounds
    }
  }

  // 重写 hitTest，确保触摸事件能正确传递到内容视图
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    // 先检查内容视图是否能处理触摸事件
    if let contentView = contentView {
      let pointInContentView = convert(point, to: contentView)
      if let hitView = contentView.hitTest(pointInContentView, with: event) {
        return hitView
      }
    }
    // 如果内容视图没有处理，返回 nil（不拦截事件）
    return nil
  }
}
