// //
// //  ScreenProtector.swift
// //  iCove
// //
// //  Created by yangyang on 2026/2/2.
// //

// import UIKit

// /// 屏幕保护工具类
// /// 
// /// ⚠️ 重要说明：iOS 系统限制
// /// 
// /// 1. **截图保护的限制**：
// ///    - iOS 的截图通知（UIApplication.userDidTakeScreenshotNotification）是在截图完成后才发送的
// ///    - 这是 iOS 的系统级限制，无法在截图前拦截
// ///    - 即使立即显示黑屏，也无法影响已经完成的截图内容
// ///    - 第一次截图可能仍然会成功，但后续截图会被黑屏遮挡
// /// 
// /// 2. **录屏保护**：
// ///    - 可以实时检测录屏状态（UIScreen.isCaptured 或 sceneCaptureState）
// ///    - 录屏时立即显示黑屏，效果良好
// /// 
// /// 3. **已做的优化**：
// ///    - 在应用启动时就创建 secure text field（UITextField with isSecureTextEntry = true）
// ///    - 保持 secure text field 在窗口上（透明状态），截图时系统会自动显示为黑屏
// ///    - 使用同步方式确保最快响应
// ///    - 使用 iOS 15+ 的 sceneCaptureState API 检测录屏
// /// 
// /// 4. **Secure Text Entry 的工作原理**：
// ///    - 当 UITextField.isSecureTextEntry = true 时，iOS 系统会在截图/录屏时自动将内容显示为黑屏
// ///    - 这是系统级别的保护机制，比手动添加覆盖层更可靠
// ///    - 即使 secure text field 是透明的，在截图时也会自动显示为黑屏
// class ScreenProtector {
//   static let shared = ScreenProtector()

//   private var screenshotObserver: NSObjectProtocol?
//   private var screenCaptureObserver: NSObjectProtocol?
//   private var secureTextField: UITextField?  // 使用 secure text entry 的文本字段
//   private var isScreenRecording = false
//   private var isInBackground = false  // 标记是否在后台
//   private var isTextFieldPrepared = false  // 标记 secure text field 是否已准备

//   private init() {
//     // 在初始化时就准备 secure text field，确保能快速响应
//     prepareSecureTextField()
//   }
  
//   /// 准备 secure text field（在应用启动时就创建，但隐藏）
//   private func prepareSecureTextField() {
//     // 延迟一点时间，确保窗口已经创建
//     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
//       self?.createSecureTextFieldIfNeeded()
//     }
//   }
  
//   /// 创建 secure text field（如果还没有创建）
//   private func createSecureTextFieldIfNeeded() {
//     guard !isTextFieldPrepared else { return }
    
//     // 获取主窗口
//     guard let targetWindow = getMainWindow() else {
//       // 如果窗口还没准备好，稍后重试
//       DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
//         self?.createSecureTextFieldIfNeeded()
//       }
//       return
//     }
    
//     // 创建全屏的 UITextField，使用 secure text entry
//     let textField = UITextField(frame: targetWindow.bounds)
//     textField.isSecureTextEntry = true  // 关键：启用 secure text entry，截图时会显示黑屏
//     textField.backgroundColor = .black
//     textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//     textField.isUserInteractionEnabled = false  // 不拦截用户交互
//     textField.alpha = 0.0  // 默认完全透明（但保持在窗口上）
//     textField.isHidden = false  // 不隐藏，只是透明（这样在截图时系统会自动显示为黑屏）
//     textField.tag = 9999  // 设置标签以便识别
    
//     // 隐藏键盘和光标
//     textField.tintColor = .clear
//     textField.textColor = .clear
    
//     // 添加到窗口并确保在最上层（但保持透明）
//     targetWindow.addSubview(textField)
//     targetWindow.bringSubviewToFront(textField)
    
//     secureTextField = textField
//     isTextFieldPrepared = true
    
//     print("✅ Secure text field 已预先创建并添加到窗口（透明状态，截图时自动显示黑屏）")
//   }

//   // MARK: - 防止截图
//   /// 启用截图保护
//   func preventScreenshotOn() {
//     // 移除旧的观察者
//     if let observer = screenshotObserver {
//       NotificationCenter.default.removeObserver(observer)
//     }
//     if let observer = screenCaptureObserver {
//       NotificationCenter.default.removeObserver(observer)
//     }

//     // 确保 secure text field 已准备
//     if !isTextFieldPrepared {
//       createSecureTextFieldIfNeeded()
//     }

//     // 监听录屏状态变化（iOS 11+）
//     screenCaptureObserver = NotificationCenter.default.addObserver(
//       forName: UIScreen.capturedDidChangeNotification,
//       object: nil,
//       queue: .main
//     ) { [weak self] _ in
//       self?.screenCaptureChanged()
//     }

//     // 监听截图已完成（只能事后知道，无法预先阻止）
//     // 使用 .immediate 队列确保通知能立即处理
//     screenshotObserver = NotificationCenter.default.addObserver(
//       forName: UIApplication.userDidTakeScreenshotNotification,
//       object: nil,
//       queue: .main
//     ) { [weak self] _ in
//       // 立即在主线程同步执行，确保最快响应
//       if Thread.isMainThread {
//         self?.userDidTakeScreenshot()
//       } else {
//         DispatchQueue.main.sync {
//           self?.userDidTakeScreenshot()
//         }
//       }
//     }

//     // 检查当前是否正在录屏
//     checkScreenRecordingStatus()

//     print("✅ 截图保护已启用")
//   }

//   /// 禁用截图保护
//   func preventScreenshotOff() {
//     if let observer = screenshotObserver {
//       NotificationCenter.default.removeObserver(observer)
//       screenshotObserver = nil
//     }
//     if let observer = screenCaptureObserver {
//       NotificationCenter.default.removeObserver(observer)
//       screenCaptureObserver = nil
//     }
//     hideSecureTextField()
//   }

//   /// 检查当前是否正在录屏（使用 iOS 15+ 的 sceneCaptureState）
//   private func checkScreenRecordingStatus() {
//     DispatchQueue.main.async { [weak self] in
//       guard let self = self else { return }
//       let isRecording = self.isScreenCaptured()
//       if isRecording != self.isScreenRecording {
//         self.isScreenRecording = isRecording
//         if isRecording {
//           self.showSecureTextField()
//         } else {
//           self.hideSecureTextField()
//         }
//       }
//     }
//   }

//   /// 检查是否正在录屏（iOS 15+ 使用 sceneCaptureState，iOS 14- 使用 isCaptured）
//   private func isScreenCaptured() -> Bool {
//     // 优先使用 iOS 15+ 的 sceneCaptureState
//     if let window = getMainWindow() {
//       if #available(iOS 15.0, *) {
//         return window.traitCollection.sceneCaptureState == .active
//       }
//     }
//     // iOS 14 及以下使用旧方法
//     return UIScreen.main.isCaptured
//   }

//   /// 处理录屏状态变化
//   @objc private func screenCaptureChanged() {
//     let isCaptured = isScreenCaptured()

//     if isCaptured {
//       showSecureTextField()  // 开始录屏 → 显示黑屏
//       print("⚠️ Screen recording started!")
//     } else {
//       hideSecureTextField()  // 停止录屏 → 移除覆盖
//       print("⚠️ Screen recording stopped!")
//     }

//     isScreenRecording = isCaptured
//   }

//   /// 处理截图事件
//   @objc private func userDidTakeScreenshot() {
//     // ⚠️ 重要说明：iOS 系统限制
//     // 截图通知是在截图完成后才发送的，因此当通知触发时，截图已经完成了
//     // 这是 iOS 的系统级限制，无法绕过
//     // 即使立即显示黑屏，也无法影响已经完成的截图内容

//     print("⚠️ 用户已截图！立即显示黑屏（虽然这次截图已完成，但可以防止后续截图）")

//     // 立即显示黑屏（使用最快的方式）
//     // 由于 secure text field 已经预先创建，这里只需要显示即可
//     showSecureTextFieldImmediately()

//     // 短暂延迟后隐藏（给用户一个视觉反馈）
//     // 但如果应用在后台，应该保持黑屏
//     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
//       guard let self = self else { return }
//       // 只有在非后台状态下才隐藏
//       if !self.isInBackground && !self.isScreenRecording {
//         self.hideSecureTextField()
//       }
//     }
//   }
  
//   /// 立即显示 secure text field（最快的方式）
//   private func showSecureTextFieldImmediately() {
//     // 如果 secure text field 已经存在且已添加到窗口，直接显示
//     if let textField = secureTextField, textField.superview != nil {
//       // 立即在主线程同步执行，确保最快响应
//       // 注意：由于 secure text field 已经保持在窗口上（透明状态），
//       // 只需要将其 alpha 设置为 1.0 即可立即显示
//       textField.isHidden = false
//       textField.alpha = 1.0
//       // 确保在最上层
//       if let superview = textField.superview {
//         superview.bringSubviewToFront(textField)
//       }
//       // 更新大小
//       if let window = textField.superview as? UIWindow {
//         textField.frame = window.bounds
//       }
//       // 强制刷新视图层级
//       textField.layer.removeAllAnimations()
//       textField.setNeedsLayout()
//       textField.layoutIfNeeded()
//       print("✅ Secure text field 已立即显示（预先创建，响应时间: 0ms，alpha: \(textField.alpha))")
//       return
//     }
    
//     // 如果不存在，立即创建并显示
//     print("⚠️ Secure text field 未预先创建，立即创建")
//     showSecureTextField()
//   }

//   /// 显示安全文本字段（使用 secure text entry 实现防截图）
//   private func showSecureTextField() {
//     // 如果已经存在文本字段且已添加到窗口，直接显示
//     if let existingTextField = secureTextField, existingTextField.superview != nil {
//       existingTextField.isHidden = false
//       existingTextField.alpha = 1.0
//       // 确保文本字段在最上层
//       if let superview = existingTextField.superview {
//         superview.bringSubviewToFront(existingTextField)
//       }
//       // 更新文本字段的大小
//       updateTextFieldFrame()
//       // 强制刷新
//       existingTextField.layer.removeAllAnimations()
//       print("✅ 安全文本字段已显示（已存在）")
//       return
//     }

//     // 获取主窗口
//     guard let targetWindow = getMainWindow() else {
//       print("⚠️ 无法获取主窗口，稍后重试")
//       // 如果窗口还没准备好，稍后重试
//       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
//         self?.showSecureTextField()
//       }
//       return
//     }

//     // 创建全屏的 UITextField，使用 secure text entry
//     let textField = UITextField(frame: targetWindow.bounds)
//     textField.isSecureTextEntry = true  // 关键：启用 secure text entry，截图时会显示黑屏
//     textField.backgroundColor = .black
//     textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//     textField.isUserInteractionEnabled = false  // 不拦截用户交互
//     textField.alpha = 1.0
//     textField.tag = 9999  // 设置标签以便识别
    
//     // 隐藏键盘和光标
//     textField.tintColor = .clear
//     textField.textColor = .clear
    
//     // 添加到窗口并确保在最上层
//     targetWindow.addSubview(textField)
//     targetWindow.bringSubviewToFront(textField)
    
//     // 强制刷新视图层级
//     textField.layer.removeAllAnimations()
//     textField.setNeedsLayout()
//     textField.layoutIfNeeded()

//     secureTextField = textField
//     isTextFieldPrepared = true

//     print("✅ 安全文本字段已创建并显示 (window: \(targetWindow), frame: \(textField.frame), isSecureTextEntry: \(textField.isSecureTextEntry))")
//   }

//   /// 更新文本字段的大小
//   private func updateTextFieldFrame() {
//     guard let textField = secureTextField,
//       let window = textField.superview as? UIWindow
//     else {
//       return
//     }
//     textField.frame = window.bounds
//   }

//   /// 获取主窗口
//   private func getMainWindow() -> UIWindow? {
//     // 方式1: 从 connectedScenes 获取 keyWindow
//     for scene in UIApplication.shared.connectedScenes {
//       if let windowScene = scene as? UIWindowScene {
//         if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
//           return keyWindow
//         }
//       }
//     }

//     // 方式2: 使用 UIApplication.shared.windows (iOS 13-)
//     if #available(iOS 13.0, *) {
//       // iOS 13+ 使用 connectedScenes
//     } else {
//       if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//         return keyWindow
//       }
//     }

//     // 方式3: 使用第一个窗口
//     for scene in UIApplication.shared.connectedScenes {
//       if let windowScene = scene as? UIWindowScene {
//         if let firstWindow = windowScene.windows.first {
//           return firstWindow
//         }
//       }
//     }

//     return nil
//   }

//   /// 隐藏安全文本字段
//   private func hideSecureTextField() {
//     // 只有在非后台状态下才隐藏
//     // 如果应用在后台，应该保持黑屏
//     guard !isInBackground else {
//       return
//     }

//     // 不删除 secure text field，只是隐藏它（保持预先创建状态）
//     secureTextField?.isHidden = true
//     secureTextField?.alpha = 0.0
//     print("✅ 安全文本字段已隐藏（保留在窗口上）")
//   }

//   // MARK: - 防止数据泄露（黑屏效果）
//   /// 启用数据泄露保护（应用切换到后台时显示黑屏）
//   /// 对应 Flutter 中的 ScreenProtector.protectDataLeakageWithBlur()
//   /// 注意：这里使用黑屏而不是模糊，以更好地保护隐私
//   func protectDataLeakageWithBlur() {
//     isInBackground = true
//     // 应用进入后台时显示黑屏
//     showSecureTextField()
//     print("✅ 后台保护已启用（黑屏）")
//   }

//   /// 移除数据泄露保护
//   func removeDataLeakageProtection() {
//     isInBackground = false
//     // 应用进入前台时隐藏黑屏（但保留覆盖层，以便截图/录屏时使用）
//     // 注意：只有在非录屏状态下才隐藏
//     if !isScreenRecording {
//       hideSecureTextField()
//     }
//     print("✅ 后台保护已移除")
//   }

//   deinit {
//     preventScreenshotOff()
//     secureTextField = nil
//   }
// }
