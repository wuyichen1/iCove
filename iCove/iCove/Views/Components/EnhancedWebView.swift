// //
// //  EnhancedWebView.swift
// //  iCove
// //
// //  Created by yangyang on 2026/2/2.
// //

// import SwiftUI
// import WebKit

// #if DEBUG
//   import HotSwiftUI
// #endif

// /// 增强版 WebView，支持 JavaScript 消息处理和 URL 拦截
// /// 用于 B 包的 H5 页面
// struct EnhancedWebView: UIViewRepresentable {
//   let url: URL?
//   @Binding var isLoading: Bool

//   // MARK: - JavaScript 消息处理回调
//   /// 支付回调：当 JavaScript 调用 rechargePay 时触发
//   var onRechargePay: ((String, String) -> Void)?  // batchNo, orderCode
//   /// 关闭回调：当 JavaScript 调用 close 时触发
//   var onClose: (() -> Void)?
//   /// 页面加载完成回调：用于上报加载时间
//   var onLoadFinished: ((TimeInterval) -> Void)?

//   #if DEBUG
//     @ObserveInjection var redraw
//   #endif

//   init(
//     url: URL?,
//     isLoading: Binding<Bool> = .constant(false),
//     onRechargePay: ((String, String) -> Void)? = nil,
//     onClose: (() -> Void)? = nil,
//     onLoadFinished: ((TimeInterval) -> Void)? = nil
//   ) {
//     self.url = url
//     self._isLoading = isLoading
//     self.onRechargePay = onRechargePay
//     self.onClose = onClose
//     self.onLoadFinished = onLoadFinished
//   }

//   func makeUIView(context: Context) -> WKWebView {
//     let configuration = WKWebViewConfiguration()

//     // 基本设置（对应 Flutter InAppWebViewSettings）
//     configuration.allowsInlineMediaPlayback = true
//     configuration.mediaTypesRequiringUserActionForPlayback = []

//     // 创建用户内容控制器
//     let userContentController = WKUserContentController()

//     // 注册 JavaScript 消息处理器
//     userContentController.add(context.coordinator, name: "rechargePay")
//     userContentController.add(context.coordinator, name: "close")

//     // 注入 JavaScript 代码，创建 Flutter InAppWebView 兼容的 callHandler 方法
//     let script = WKUserScript(
//       source: """
//           (function() {
//             if (!window.flutter_inappwebview) {
//               window.flutter_inappwebview = {};
//             }
            
//             window.flutter_inappwebview.callHandler = function(handlerName, ...args) {
//               if (handlerName === 'close' && window.webkit?.messageHandlers?.close) {
//                 window.webkit.messageHandlers.close.postMessage(args[0] || null);
//                 return Promise.resolve();
//               } else if (handlerName === 'rechargePay' && window.webkit?.messageHandlers?.rechargePay) {
//                 window.webkit.messageHandlers.rechargePay.postMessage(args[0] || null);
//                 return Promise.resolve();
//               }
//               return Promise.reject('handler not available: ' + handlerName);
//             };
            
//             // 重写 window.close
//             var originalClose = window.close;
//             window.close = function() {
//               if (window.webkit?.messageHandlers?.close) {
//                 window.webkit.messageHandlers.close.postMessage(null);
//               } else if (originalClose) {
//                 originalClose.call(window);
//               }
//             };
//           })();
//         """,
//       injectionTime: .atDocumentStart,
//       forMainFrameOnly: false
//     )
//     userContentController.addUserScript(script)

//     // 注入防止缩放和输入框滚动的代码（简化版）
//     let preventZoomScript = WKUserScript(
//       source: """
//           (function() {
//             // 设置 viewport
//             function setViewport() {
//               var viewport = document.querySelector('meta[name="viewport"]') || 
//                             document.createElement('meta');
//               if (!viewport.getAttribute('name')) {
//                 viewport.name = 'viewport';
//                 document.head.appendChild(viewport);
//               }
//               viewport.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
//             }
//             setViewport();
//             if (document.readyState === 'loading') {
//               document.addEventListener('DOMContentLoaded', setViewport);
//             }
            
//             // 防止输入框聚焦时页面滚动和内容被推上去
//             var savedScroll = { x: 0, y: 0 };
//             var isInputFocused = false;
            
//             function saveScroll() {
//               savedScroll.x = window.pageXOffset || document.documentElement.scrollLeft || 0;
//               savedScroll.y = window.pageYOffset || document.documentElement.scrollTop || 0;
//             }
            
//             function restoreScroll() {
//               requestAnimationFrame(() => {
//                 window.scrollTo(savedScroll.x, savedScroll.y);
//                 document.documentElement.scrollTop = savedScroll.y;
//                 document.body.scrollTop = savedScroll.y;
//               });
//             }
            
//             function setupInputHandlers() {
//               document.querySelectorAll('input, textarea, select').forEach(input => {
//                 // 检查是否已经添加过监听器（通过标记属性）
//                 if (input.dataset.scrollHandlerAdded) {
//                   return;
//                 }
//                 input.dataset.scrollHandlerAdded = 'true';
                
//                 // focus 事件：保存滚动位置并阻止默认行为
//                 input.addEventListener('focus', function(e) {
//                   isInputFocused = true;
//                   saveScroll();
//                   e.preventDefault();
//                   e.stopPropagation();
                  
//                   // 立即恢复滚动位置（多次尝试确保生效）
//                   setTimeout(restoreScroll, 0);
//                   setTimeout(restoreScroll, 50);
//                   setTimeout(restoreScroll, 100);
//                   setTimeout(restoreScroll, 200);
//                 }, true);
                
//                 // focusin 事件：更早捕获
//                 input.addEventListener('focusin', function(e) {
//                   saveScroll();
//                 }, true);
                
//                 // blur 事件：恢复状态
//                 input.addEventListener('blur', function() {
//                   isInputFocused = false;
//                 }, true);
//               });
//             }
            
//             // 监听全局滚动，如果输入框聚焦时发生滚动，立即恢复
//             var scrollTimer = null;
//             window.addEventListener('scroll', function() {
//               if (isInputFocused) {
//                 clearTimeout(scrollTimer);
//                 scrollTimer = setTimeout(function() {
//                   var currentY = window.pageYOffset || document.documentElement.scrollTop || 0;
//                   if (Math.abs(currentY - savedScroll.y) > 5) {
//                     restoreScroll();
//                   }
//                 }, 10);
//               }
//             }, { passive: false });
            
//             setupInputHandlers();
            
//             // 监听动态添加的输入框
//             new MutationObserver(setupInputHandlers).observe(document.body, {
//               childList: true,
//               subtree: true
//             });
//           })();
//         """,
//       injectionTime: .atDocumentEnd,
//       forMainFrameOnly: false
//     )
//     userContentController.addUserScript(preventZoomScript)

//     configuration.userContentController = userContentController

//     // 创建 WKWebView
//     let webView = WKWebView(frame: .zero, configuration: configuration)
//     webView.navigationDelegate = context.coordinator
//     webView.uiDelegate = context.coordinator
//     webView.scrollView.delegate = context.coordinator

//     // 基本属性设置
//     webView.backgroundColor = .clear
//     webView.isOpaque = false
//     webView.scrollView.contentInsetAdjustmentBehavior = .never
//     webView.scrollView.contentInset = .zero
//     webView.scrollView.scrollIndicatorInsets = .zero
//     webView.scrollView.minimumZoomScale = 1.0
//     webView.scrollView.maximumZoomScale = 1.0
//     webView.scrollView.zoomScale = 1.0
    
//     // 保存 webView 引用到 coordinator，用于键盘处理
//     context.coordinator.webView = webView

//     // 加载 URL
//     if let url = url {
//       context.coordinator.currentURL = url
//       webView.load(URLRequest(url: url))
//     }

//     return webView
//   }

//   func updateUIView(_ webView: WKWebView, context: Context) {
//     // 确保缩放设置和 contentInset
//     webView.scrollView.minimumZoomScale = 1.0
//     webView.scrollView.maximumZoomScale = 1.0
//     webView.scrollView.zoomScale = 1.0
//     webView.scrollView.contentInset = .zero
//     webView.scrollView.scrollIndicatorInsets = .zero
//     webView.scrollView.contentInsetAdjustmentBehavior = .never
    
//     // 更新 webView 引用
//     context.coordinator.webView = webView

//     // URL 更新处理
//     if let newUrl = url, context.coordinator.currentURL?.absoluteString != newUrl.absoluteString {
//       context.coordinator.currentURL = newUrl
//       if webView.isLoading {
//         webView.stopLoading()
//       }
//       webView.load(URLRequest(url: newUrl))
//     }
//   }

//   func makeCoordinator() -> Coordinator {
//     Coordinator(self)
//   }

//   // MARK: - Coordinator
//   class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler,
//     UIScrollViewDelegate
//   {
//     var parent: EnhancedWebView
//     private var loadStartTime: Date?
//     var currentURL: URL?
//     weak var webView: WKWebView?
//     private var keyboardObservers: [NSObjectProtocol] = []

//     init(_ parent: EnhancedWebView) {
//       self.parent = parent
//       super.init()
//       setupKeyboardObservers()
//     }
    
//     deinit {
//       keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
//     }
    
//     /// 设置键盘通知监听，防止键盘弹出时页面被推上去
//     private func setupKeyboardObservers() {
//       let willShowObserver = NotificationCenter.default.addObserver(
//         forName: UIResponder.keyboardWillShowNotification,
//         object: nil,
//         queue: .main
//       ) { [weak self] _ in
//         self?.handleKeyboardWillShow()
//       }
//       keyboardObservers.append(willShowObserver)
      
//       let willHideObserver = NotificationCenter.default.addObserver(
//         forName: UIResponder.keyboardWillHideNotification,
//         object: nil,
//         queue: .main
//       ) { [weak self] _ in
//         self?.handleKeyboardWillHide()
//       }
//       keyboardObservers.append(willHideObserver)
//     }
    
//     /// 处理键盘即将显示：防止页面被推上去
//     private func handleKeyboardWillShow() {
//       guard let webView = webView else { return }
//       // 保持 contentInset 为 0，防止页面被推上去
//       webView.scrollView.contentInset = .zero
//       webView.scrollView.scrollIndicatorInsets = .zero
//     }
    
//     /// 处理键盘即将隐藏：恢复设置
//     private func handleKeyboardWillHide() {
//       guard let webView = webView else { return }
//       // 确保 contentInset 保持为 0
//       webView.scrollView.contentInset = .zero
//       webView.scrollView.scrollIndicatorInsets = .zero
//     }

//     // MARK: - UIScrollViewDelegate
//     func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//       return nil
//     }

//     func scrollViewDidZoom(_ scrollView: UIScrollView) {
//       if scrollView.zoomScale != 1.0 {
//         scrollView.setZoomScale(1.0, animated: false)
//       }
//     }

//     // MARK: - WKNavigationDelegate

//     /// 页面开始加载（对应 Flutter onLoadStart）
//     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//       DispatchQueue.main.async {
//         self.parent.isLoading = true
//         self.loadStartTime = Date()
//       }
//     }

//     /// 页面加载完成（对应 Flutter onLoadStop）
//     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//       DispatchQueue.main.async {
//         self.parent.isLoading = false

//         // 计算加载时间并回调（对应 Flutter 的加载时间上报）
//         if let startTime = self.loadStartTime {
//           let loadTime = Date().timeIntervalSince(startTime) * 1000  // 毫秒
//           self.parent.onLoadFinished?(loadTime)
//         }

//         // 确保缩放设置和 contentInset
//         webView.scrollView.minimumZoomScale = 1.0
//         webView.scrollView.maximumZoomScale = 1.0
//         webView.scrollView.zoomScale = 1.0
//         webView.scrollView.contentInset = .zero
//         webView.scrollView.scrollIndicatorInsets = .zero
//       }
//     }

//     /// 页面加载失败
//     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//       if let urlError = error as? URLError, urlError.code.rawValue == -999 {
//         return  // 忽略取消错误
//       }
//       DispatchQueue.main.async {
//         self.parent.isLoading = false
//       }
//     }

//     func webView(
//       _ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
//       withError error: Error
//     ) {
//       if let urlError = error as? URLError, urlError.code.rawValue == -999 {
//         return
//       }
//       DispatchQueue.main.async {
//         self.parent.isLoading = false
//       }
//     }

//     /// URL 拦截处理（对应 Flutter shouldOverrideUrlLoading）
//     func webView(
//       _ webView: WKWebView,
//       decidePolicyFor navigationAction: WKNavigationAction,
//       decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
//     ) {
//       guard let url = navigationAction.request.url else {
//         decisionHandler(.allow)
//         return
//       }

//       let scheme = url.scheme?.lowercased() ?? ""
//       let allowedSchemes = ["http", "https", "file", "chrome", "data", "javascript", "about"]

//       if !allowedSchemes.contains(scheme) {
//         if UIApplication.shared.canOpenURL(url) {
//           UIApplication.shared.open(url)
//           decisionHandler(.cancel)
//           return
//         }
//       }

//       decisionHandler(.allow)
//     }

//     // MARK: - WKUIDelegate

//     /// 处理权限请求（对应 Flutter onPermissionRequest）
//     func webView(
//       _ webView: WKWebView,
//       requestMediaCapturePermissionFor origin: WKSecurityOrigin,
//       initiatedByFrame frame: WKFrameInfo,
//       type: WKMediaCaptureType,
//       decisionHandler: @escaping (WKPermissionDecision) -> Void
//     ) {
//       decisionHandler(.grant)
//     }

//     // MARK: - WKScriptMessageHandler

//     /// 处理 JavaScript 消息（对应 Flutter addJavaScriptHandler）
//     func userContentController(
//       _ userContentController: WKUserContentController,
//       didReceive message: WKScriptMessage
//     ) {
//       switch message.name {
//       case "rechargePay":
//         if let messageBody = message.body as? [String: Any],
//           let batchNo = messageBody["batchNo"] as? String,
//           let orderCode = messageBody["orderCode"] as? String
//         {
//           FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.zU4ZT5YgrXaPLm7p = orderCode
//           DispatchQueue.main.async {
//             self.parent.onRechargePay?(batchNo, orderCode)
//           }
//         }

//       case "close":
//         DispatchQueue.main.async {
//           FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN = ""
//           self.parent.onClose?()
//         }

//       default:
//         break
//       }
//     }
//   }
// }
