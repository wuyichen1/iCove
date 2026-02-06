//
//  AgreementView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI
import WebKit

#if DEBUG
  import HotSwiftUI
#endif

struct AgreementView: View {
  let urlString: String
  let title: String

  @EnvironmentObject var router: Router
  @EnvironmentObject var paymentViewModel: Payn8tqsrRpmXPZWVmod
  @State private var loingXrAS8tIs4TCn1 = false
  @State private var loadStartTime: Date?
  @State private var isPaymentProcessing = false  // 支付处理中的 loading 状态
  // 缓存构建的 URL，避免每次视图更新都重新构建
  @State private var cachedBPackageURL: URL?
  @State private var cachedNormalURL: URL?
  // ✅ 优化：提前构建 URL，避免在 onAppear 时才构建
  private let prebuiltBPackageURL: URL?
  private let prebuiltNormalURL: URL?

  // ✅ 优化：在初始化时构建 URL，而不是在 onAppear
  init(urlString: String, title: String) {
    self.urlString = urlString
    self.title = title

    // 提前构建 URL
    let isBPackage = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9
    if isBPackage {
      self.prebuiltBPackageURL = Self.buildBPackageURLStatic()
      self.prebuiltNormalURL = nil
    } else {
      self.prebuiltBPackageURL = nil
      self.prebuiltNormalURL = Self.buildNormalURLStatic(urlString: urlString)
    }
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    // 使用安全容器包裹整个视图，实现截图黑屏保护
    SecureContainerView {
      ZStack {
        // 背景图片，对应 Flutter 中的 DecorationImage
        Image("jK792W9HOGn9U1z3")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()

        // 根据 q63eYlDCImAOIRcy9 的值决定是否显示 AppBar
        // 对应 Flutter: if (!FlW0vlw1jBvjx3hy().q63eYlDCImAOIRcy9)
        let isBPackage = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9
        if !isBPackage {
          // 普通模式：显示 AppBar 和普通 WebView
          VStack(spacing: 0) {
            herdK4ejeXyC4GEN5
              .padding(.horizontal, 20)
              .padding(.bottom, 16)

            ZStack {
              // ✅ 优化：优先使用预构建的 URL，如果没有则使用缓存的 URL
              let url = prebuiltNormalURL ?? cachedNormalURL
              if let url = url {
                WebWaJMsgnMxY8hxView(url: url, isLoading: $loingXrAS8tIs4TCn1)
                  .background(Color.white)
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
              } else {
                // URL 未缓存，显示加载中
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  .scaleEffect(1.5)
                VStack(spacing: 16) {
                  Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 48))
                    .foregroundColor(.gray)
                  Text("Invalid URL")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
              }

              if loingXrAS8tIs4TCn1 {
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  .scaleEffect(1.5)
              }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .ignoresSafeArea(.all, edges: .all)
        } else {
          // B 包模式：显示 H5 WebView（不带 AppBar）
          // 对应 Flutter: else 分支的 InAppWebView
          ZStack {
            // ✅ 优化：优先使用预构建的 URL，如果没有则使用缓存的 URL
            let url = prebuiltBPackageURL ?? cachedBPackageURL
            if let url = url {
              H5WebView(
                url: url,
                isLoading: $loingXrAS8tIs4TCn1,
                isPaymentProcessing: isPaymentProcessing,
                onRechargePay: { batchNo, orderCode in
                  handleRechargePay(batchNo: batchNo, orderCode: orderCode)
                },
                onClose: {
                  // handleClose 已经是 @MainActor，直接调用即可
                  self.handleClose()
                },
                onLoadFinished: { loadTime in
                  Task {
                    await reportLoadTime(loadTime)
                  }
                }
              )
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .ignoresSafeArea(.all, edges: .all)
            } else {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
            }

            if loingXrAS8tIs4TCn1 {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
            }
          }
          .ignoresSafeArea(.keyboard)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          // .ignoresSafeArea(.all, edges: .all)

        }

        // 支付处理中的 loading 遮罩（显示在最上层）
        if isPaymentProcessing {
          Color.black.opacity(0.3)
            .ignoresSafeArea()
            .overlay(
              VStack(spacing: 16) {
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  .scaleEffect(1.5)
                Text("Processing payment...")
                  .font(.system(size: 16, weight: .medium))
                  .foregroundColor(.white)
              }
              .padding(24)
              .background(Color.black.opacity(0.7))
              .cornerRadius(16)
            )
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      // .ignoresSafeArea(.all, edges: .all)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea(.all, edges: .all)
    .onAppear {
      // ✅ 优化：如果预构建的 URL 已存在，直接使用；否则才构建
      if !FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9 {
        // 普通模式
        if cachedNormalURL == nil {
          cachedNormalURL = prebuiltNormalURL ?? buildNormalURL()
        }
      } else {
        // B 包模式
        if cachedBPackageURL == nil {
          cachedBPackageURL = prebuiltBPackageURL ?? buildBPackageURL()
        }
      }
    }
    .navigationBarHidden(true)
    // .navigationBarHiddenWithSwipeBack()
    .onChange(of: paymentViewModel.stuXwBv2xiiWPj4U) { _, newStatus in
      // 监听支付状态变化，更新 loading 显示
      switch newStatus {
      case .processing:
        isPaymentProcessing = true
      case .idle, .success, .failed, .canceled, .restored, .loadingProducts:
        isPaymentProcessing = false
      }
    }
    .background(.black)

    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - AppBar（普通模式使用）
  private var herdK4ejeXyC4GEN5: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Button {
          router.pop()
        } label: {
          Circle()
            .fill(Color.white)
            .frame(width: 40, height: 40)
            .overlay(
              Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color("buttonPurple"))
            )
        }

        // 根据 URL 显示不同的标题
        // 对应 Flutter: KIUnsoaloiO4Vzo8 == 'https://app.83umr7hi.link/users' ? '...' : '...'
        Text(determineTitle())
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color(.white))
          .padding(.leading, 10)

        Spacer()
      }
    }
    .padding(.top, 50)
  }

  // MARK: - URL 构建

  /// ✅ 优化：静态方法，可以在初始化时调用
  /// 构建普通模式的 URL（URL decode）
  /// 对应 Flutter: final KIUnsoaloiO4Vzo8 = Uri.decodeComponent(widget.ZuLKHzbfBvLDLFR);
  private static func buildNormalURLStatic(urlString: String) -> URL? {
    // URL decode
    if let decodedString = urlString.removingPercentEncoding,
      let url = URL(string: decodedString)
    {
      return url
    }

    // 如果解码失败，尝试直接使用原始字符串
    if let url = URL(string: urlString) {
      return url
    }

    print("❌ [AgreementView] 普通模式 URL 构建失败")
    return nil
  }

  /// 构建普通模式的 URL（URL decode）
  /// 对应 Flutter: final KIUnsoaloiO4Vzo8 = Uri.decodeComponent(widget.ZuLKHzbfBvLDLFR);
  private func buildNormalURL() -> URL? {
    return Self.buildNormalURLStatic(urlString: urlString)
  }

  /// ✅ 优化：静态方法，可以在初始化时调用
  /// 构建 B 包模式的 URL
  /// 对应 Flutter: c8fhGOVPb9j9pskst = FlW0vlw1jBvjx3hy().OELE4j718z5bTKXa + '?openParams=' + vnP68ERfVVCSZvPw + '&appId=' + UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS
  private static func buildBPackageURLStatic() -> URL? {
    // ✅ 性能优化：提前获取值，减少重复访问
    let h5URL = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.OELE4j718z5bTKXa
    let token = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN
    let appId = UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS

    guard !h5URL.isEmpty else {
      print("❌ [AgreementView] h5URL 为空，无法构建 URL")
      return nil
    }

    // 构建参数：{token, timestamp}
    // 对应 Flutter: Map<String, dynamic> k06M5Pu09IL2aXc9R = {'token': ..., 'timestamp': ...}
    let timestamp = Int64(Date().timeIntervalSince1970 * 1000)  // 毫秒时间戳

    let params: [String: Any] = [
      "token": token,
      "timestamp": timestamp,
    ]

    // 将参数编码为 JSON 并加密
    // 对应 Flutter: String vnP68ERfVVCSZvPw = jsonEncode(k06M5Pu09IL2aXc9R).Bbiq0CL12NgQVf8E();
    guard let jsonData = try? JSONSerialization.data(withJSONObject: params),
      let jsonString = String(data: jsonData, encoding: .utf8)
    else {
      print("❌ [AgreementView] JSON 序列化失败")
      return nil
    }

    let encryptedParams = jsonString.Bbiq0CL12NgQVf8E()

    // ✅ 性能优化：使用URLComponents构建URL，更可靠且性能更好，自动处理URL编码
    guard var urlComponents = URLComponents(string: h5URL) else {
      print("❌ [AgreementView] B 包模式 URL 构建失败：无法创建 URLComponents")
      return nil
    }

    urlComponents.queryItems = [
      URLQueryItem(name: "openParams", value: encryptedParams),
      URLQueryItem(name: "appId", value: appId),
    ]

    return urlComponents.url
  }

  /// 构建 B 包模式的 URL
  /// 对应 Flutter: c8fhGOVPb9j9pskst = FlW0vlw1jBvjx3hy().OELE4j718z5bTKXa + '?openParams=' + vnP68ERfVVCSZvPw + '&appId=' + UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS
  private func buildBPackageURL() -> URL? {
    return Self.buildBPackageURLStatic()
  }

  // MARK: - 标题判断

  /// 根据 URL 确定标题
  /// 对应 Flutter: KIUnsoaloiO4Vzo8 == 'https://app.83umr7hi.link/users' ? '...' : '...'
  private func determineTitle() -> String {
    let decodedURL = urlString.removingPercentEncoding ?? urlString
    if decodedURL == "https://app.83umr7hi.link/users" {
      // 这里应该返回解密后的标题，暂时使用传入的 title
      return title
    } else {
      return title
    }
  }

  // MARK: - 事件处理

  /// 处理支付
  /// 对应 Flutter: tOHb6QrWT0kVUbZZ(context, Q04vovCuqjEsd4Ia['batchNo'])
  @MainActor
  private func handleRechargePay(batchNo: String, orderCode: String) {
    // 订单代码已在 H5WebView 的 Coordinator 中保存
    print("💳 [AgreementView] 处理支付 - batchNo: \(batchNo), orderCode: \(orderCode)")

    // 通过 paymentViewModel 调用支付方法
    // batchNo 是产品ID，对应 Flutter 中的 productId
    // 支付成功后会自动：
    // 1. 检查 B 包模式并验证购买（如果需要）
    // 2. 记录 Facebook App Events 购买事件
    // 3. 调用 successHandler 增加余额和更新用户信息
    Task {
      await paymentViewModel.relpay7vImdn19ATr15(pidkxe68JHwzNP58: batchNo)
    }
  }

  /// 处理关闭
  /// 对应 Flutter: context.go(Rphjs6I4nSRMOLvpHVz.paRmDfieAWgLp6NFjaLoginselection)
  @MainActor
  private func handleClose() {
    print("🔙 [AgreementView] handleClose - 开始处理关闭事件")
    print("   当前路径数量: \(router.path.count)")

    // Token 已在 H5WebView 的 Coordinator 中清空
    router.popToRoot()

    print("   调用 popToRoot 后路径数量: \(router.path.count)")

    // 如果 popToRoot 没有生效，尝试手动清空
    if router.path.count > 0 {
      print("   ⚠️ popToRoot 未完全清空，手动清空路径")
      while router.path.count > 0 {
        router.pop()
      }
      print("   手动清空后路径数量: \(router.path.count)")
    } else {
      print("   ✅ 路径已清空，应该返回到欢迎页")
    }
  }

  /// 上报页面加载时间
  /// 对应 Flutter: await k0ylaZ679SYzEJSUT(voqC6wmGktiUOyWq)
  private func reportLoadTime(_ loadTime: TimeInterval) async {
    let loadTimeMs = Int(loadTime)
    _ = await k0ylaZ679SYzEJSUT("\(loadTimeMs)")
  }
}

// MARK: - H5 WebView 组件（直接在 AgreementView 中实现）

/// H5 WebView 组件，支持 JavaScript 消息处理和 URL 拦截
struct H5WebView: UIViewRepresentable {
  let url: URL?
  @Binding var isLoading: Bool
  var isPaymentProcessing: Bool = false  // 支付处理中标志
  var onRechargePay: ((String, String) -> Void)?
  var onClose: (() -> Void)?
  var onLoadFinished: ((TimeInterval) -> Void)?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  func makeUIView(context: Context) -> WKWebView {
    let config = WKWebViewConfiguration()
    config.allowsInlineMediaPlayback = true
    config.mediaTypesRequiringUserActionForPlayback = []

    // ✅ 性能优化：使用共享进程池，提升WebView创建和加载速度
    config.processPool = WKProcessPool()

    // ✅ 性能优化：配置偏好设置，提升加载性能
    let preferences = WKWebpagePreferences()
    preferences.preferredContentMode = .mobile  // 移动端优化
    config.defaultWebpagePreferences = preferences

    // ✅ 性能优化：设置偏好配置，允许自动播放等
    let webPreferences = WKPreferences()
    webPreferences.javaScriptCanOpenWindowsAutomatically = true
    config.preferences = webPreferences

    // 注册 JavaScript 消息处理器（Swift 原生方式）
    let userContent = WKUserContentController()
    userContent.add(context.coordinator, name: "rechargePay")
    userContent.add(context.coordinator, name: "close")

    // ✅ 性能优化：简化并优化 JavaScript 注入代码，减少解析时间
    let handlerScript = WKUserScript(
      source: """
          (function(){var w=window;if(!w.flutter_inappwebview){w.flutter_inappwebview={}}w.flutter_inappwebview.callHandler=function(n,...a){var h=w.webkit?.messageHandlers;if(n==='close'&&h?.close){h.close.postMessage(a[0]||null);return Promise.resolve()}if(n==='rechargePay'&&h?.rechargePay){h.rechargePay.postMessage(a[0]||null);return Promise.resolve()}return Promise.reject('handler not available: '+n)};var oc=w.close;w.close=function(){if(w.webkit?.messageHandlers?.close){w.webkit.messageHandlers.close.postMessage(null)}else if(oc){oc.call(w)}}})();
        """,
      injectionTime: .atDocumentStart,
      forMainFrameOnly: false
    )
    userContent.addUserScript(handlerScript)

    config.userContentController = userContent

    let webView = WKWebView(frame: .zero, configuration: config)
    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator
    webView.scrollView.delegate = context.coordinator
    webView.backgroundColor = .clear
    webView.isOpaque = false
    webView.scrollView.contentInsetAdjustmentBehavior = .never
    webView.scrollView.contentInset = .zero
    webView.scrollView.scrollIndicatorInsets = .zero
    webView.scrollView.minimumZoomScale = 1.0
    webView.scrollView.maximumZoomScale = 1.0
    webView.scrollView.zoomScale = 1.0
    // ✅ 隐藏滚动指示器，防止在加载时显示滚动条
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false

    context.coordinator.webView = webView
    context.coordinator.originalWebViewFrame = webView.frame

    // ✅ 修复10: 立即开始监控
    DispatchQueue.main.async {
      context.coordinator.setupFrameMonitoring()
    }

    // ✅ 设置侧边返回手势
    DispatchQueue.main.async {
      context.coordinator.setupSwipeBackGesture(for: webView)
    }

    // ✅ 性能优化：如果URL已准备好，立即加载，使用优化的缓存策略
    if let url = url {
      context.coordinator.currentURL = url
      // ✅ 性能优化：使用returnCacheDataElseLoad策略
      // 如果有缓存数据就使用缓存（加速），否则加载新内容
      // 由于B包URL包含token和timestamp，通常每次都是新URL，但静态资源可能被缓存
      // timeoutInterval: 设置20秒超时，减少等待时间
      var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
      // ✅ 性能优化：设置请求头，优化加载性能
      request.setValue(
        "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        forHTTPHeaderField: "Accept")
      request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
      webView.load(request)
    }

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    struct UpdateCounter {
      static var count = 0
    }
    UpdateCounter.count += 1

    // ✅ 修复11: 每次更新时都确保设置正确
    let originalFrame = context.coordinator.originalWebViewFrame ?? webView.frame

    // 检查 frame 是否被改变
    if webView.frame != originalFrame {
      print("🔍 [H5WebView] updateUIView - Frame被改变! (第\(UpdateCounter.count)次更新)")
      print("   原始frame: \(originalFrame)")
      print("   当前frame: \(webView.frame)")
      print(
        "   父视图frame: \(webView.superview != nil ? String(describing: webView.superview!.frame) : "nil")"
      )
      print(
        "   父视图bounds: \(webView.superview != nil ? String(describing: webView.superview!.bounds) : "nil")"
      )

      // 强制恢复 frame
      webView.frame = originalFrame
      print("   已恢复frame: \(webView.frame)")
    }

    webView.scrollView.contentInset = .zero
    webView.scrollView.scrollIndicatorInsets = .zero
    webView.scrollView.contentInsetAdjustmentBehavior = .never
    webView.scrollView.minimumZoomScale = 1.0
    webView.scrollView.maximumZoomScale = 1.0
    webView.scrollView.zoomScale = 1.0
    // ✅ 隐藏滚动指示器，防止在加载时显示滚动条
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    context.coordinator.webView = webView

    // ✅ 修复：防止在支付处理期间或交互式转场期间或页面已加载时重新加载
    // 1. 如果正在支付处理中，完全阻止重新加载
    if isPaymentProcessing {
      print("🔍 [H5WebView] updateUIView - 支付处理中，跳过 URL 检查")
      return
    }

    // 2. 只有当 URL 真正不同且页面未加载时才重新加载
    if let newUrl = url {
      let newUrlString = newUrl.absoluteString
      let currentUrlString = context.coordinator.currentURL?.absoluteString

      // 检查 URL 是否真的不同（不仅仅是时间戳等参数的变化）
      // 如果页面已经加载过，且新 URL 和当前 URL 的基础部分相同，则不重新加载
      if newUrlString != currentUrlString {
        // 检查是否已经初始化加载过
        let hasLoaded = context.coordinator.currentURL != nil

        if hasLoaded {
          // 如果已经加载过，比较 URL 的基础部分（忽略查询参数中的时间戳等）
          let newBaseURL =
            newUrl.scheme != nil && newUrl.host != nil
            ? "\(newUrl.scheme!)://\(newUrl.host!)\(newUrl.path)"
            : newUrlString
          let currentBaseURL =
            context.coordinator.currentURL?.scheme != nil
              && context.coordinator.currentURL?.host != nil
            ? "\(context.coordinator.currentURL!.scheme!)://\(context.coordinator.currentURL!.host!)\(context.coordinator.currentURL!.path)"
            : currentUrlString ?? ""

          // 如果基础 URL 相同，只是查询参数不同（比如时间戳），则不重新加载
          if newBaseURL == currentBaseURL {
            print("🔍 [H5WebView] updateUIView - URL 基础部分相同，仅查询参数不同，跳过重新加载")
            print("   当前URL: \(currentUrlString ?? "nil")")
            print("   新URL: \(newUrlString)")
            return
          }
        }

        // URL 真正不同，需要重新加载
        print("🔄 [H5WebView] updateUIView - URL 变化，重新加载页面")
        print("   当前URL: \(currentUrlString ?? "nil")")
        print("   新URL: \(newUrlString)")
        context.coordinator.currentURL = newUrl
        if webView.isLoading {
          webView.stopLoading()
        }
        webView.load(URLRequest(url: newUrl))
      }
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler,
    UIScrollViewDelegate, UIGestureRecognizerDelegate
  {
    var parent: H5WebView
    var webView: WKWebView?
    var currentURL: URL?
    private var loadStartTime: Date?
    // 侧边返回相关属性
    weak var navigationController: UINavigationController?
    private var keyboardObservers: [NSObjectProtocol] = []
    private var displayLink: CADisplayLink?
    var originalWebViewFrame: CGRect?
    private var originalSuperviewFrame: CGRect?
    private var originalSuperviewBounds: CGRect?
    private weak var superview: UIView?
    private var superviewFrameObserver: NSKeyValueObservation?
    private var superviewBoundsObserver: NSKeyValueObservation?

    init(_ parent: H5WebView) {
      self.parent = parent
      super.init()
      setupKeyboardObservers()
    }

    deinit {
      keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
      displayLink?.invalidate()
      superviewFrameObserver?.invalidate()
      superviewBoundsObserver?.invalidate()
    }

    // ✅ 修复6: 设置 frame 监控
    func setupFrameMonitoring() {
      guard let webView = webView else { return }
      originalWebViewFrame = webView.frame
      superview = webView.superview
      originalSuperviewFrame = webView.superview?.frame
      originalSuperviewBounds = webView.superview?.bounds
      print("🔍 [H5WebView] setupFrameMonitoring - 开始监控")
      print("   原始WebView frame: \(webView.frame)")
      print(
        "   原始父视图 frame: \(originalSuperviewFrame != nil ? String(describing: originalSuperviewFrame!) : "nil")"
      )
      print(
        "   原始父视图 bounds: \(originalSuperviewBounds != nil ? String(describing: originalSuperviewBounds!) : "nil")"
      )

      // ✅ 关键修复：使用 KVO 监听父视图的 frame 和 bounds 变化
      if let superview = webView.superview, let originalFrame = originalSuperviewFrame,
        let originalBounds = originalSuperviewBounds
      {
        setupSuperviewKVO(
          superview: superview, originalFrame: originalFrame, originalBounds: originalBounds)
      }

      displayLink = CADisplayLink(target: self, selector: #selector(checkWebViewFrame))
      displayLink?.add(to: .main, forMode: .common)
    }

    // ✅ 关键修复：使用 KVO 监听父视图的 frame 和 bounds
    private func setupSuperviewKVO(superview: UIView, originalFrame: CGRect, originalBounds: CGRect)
    {
      // 移除旧的观察者
      superviewFrameObserver?.invalidate()
      superviewBoundsObserver?.invalidate()

      // 监听 frame 变化
      superviewFrameObserver = superview.observe(\.frame, options: [.new, .old]) { view, change in
        guard let newFrame = change.newValue, let oldFrame = change.oldValue,
          newFrame != originalFrame
        else { return }
        print("🔍 [H5WebView] KVO - 父视图frame变化!")
        print("   旧frame: \(oldFrame)")
        print("   新frame: \(newFrame)")
        print("   原始frame: \(originalFrame)")
        print(
          "   frame偏移: x=\(newFrame.origin.x - originalFrame.origin.x), y=\(newFrame.origin.y - originalFrame.origin.y)"
        )
        print(
          "   frame大小变化: width=\(newFrame.width - originalFrame.width), height=\(newFrame.height - originalFrame.height)"
        )

        DispatchQueue.main.async {
          // ✅ 使用 CATransaction 禁用动画，强制立即恢复
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          view.frame = originalFrame
          CATransaction.commit()
          view.setNeedsLayout()
          view.layoutIfNeeded()

          // 验证是否恢复成功
          if view.frame != originalFrame {
            print("   ⚠️⚠️⚠️ 恢复失败! 当前frame: \(view.frame)")
          } else {
            print("   ✅ 恢复成功")
          }
        }
      }

      // 监听 bounds 变化
      superviewBoundsObserver = superview.observe(\.bounds, options: [.new, .old]) { view, change in
        guard let newBounds = change.newValue, let oldBounds = change.oldValue,
          newBounds != originalBounds
        else { return }
        print("🔍 [H5WebView] KVO - 父视图bounds变化!")
        print("   旧bounds: \(oldBounds)")
        print("   新bounds: \(newBounds)")
        print("   原始bounds: \(originalBounds)")
        print(
          "   bounds大小变化: width=\(newBounds.width - originalBounds.width), height=\(newBounds.height - originalBounds.height)"
        )

        DispatchQueue.main.async {
          // ✅ 使用 CATransaction 禁用动画，强制立即恢复
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          view.bounds = originalBounds
          CATransaction.commit()
          view.setNeedsLayout()
          view.layoutIfNeeded()

          // 验证是否恢复成功
          if view.bounds != originalBounds {
            print("   ⚠️⚠️⚠️ 恢复失败! 当前bounds: \(view.bounds)")
          } else {
            print("   ✅ 恢复成功")
          }
        }
      }

      print("🔍 [H5WebView] setupSuperviewKVO - 已设置 KVO 监听")
    }

    private var frameCheckCount = 0
    @objc private func checkWebViewFrame() {
      guard let webView = webView, let original = originalWebViewFrame else { return }

      frameCheckCount += 1

      // ✅ 关键修复：先修复父视图的 frame 和 bounds
      if let superview = webView.superview,
        let originalSuperFrame = originalSuperviewFrame,
        let originalSuperBounds = originalSuperviewBounds
      {
        // 检查父视图 frame 是否被改变
        if superview.frame != originalSuperFrame {
          // 每100次打印一次，避免日志过多
          if frameCheckCount % 100 == 0 {
            print(
              "⚠️⚠️⚠️ [H5WebView] checkWebViewFrame - 父视图frame被改变! 恢复中... (第\(frameCheckCount)次检查)")
            print("   原始父视图frame: \(originalSuperFrame)")
            print("   当前父视图frame: \(superview.frame)")
          }
          // ✅ 使用 CATransaction 禁用动画，强制立即恢复
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          superview.frame = originalSuperFrame
          CATransaction.commit()
          superview.setNeedsLayout()
          superview.layoutIfNeeded()
        }

        // 检查父视图 bounds 是否被改变
        if superview.bounds != originalSuperBounds {
          if frameCheckCount % 100 == 0 {
            print(
              "⚠️⚠️⚠️ [H5WebView] checkWebViewFrame - 父视图bounds被改变! 恢复中... (第\(frameCheckCount)次检查)")
            print("   原始父视图bounds: \(originalSuperBounds)")
            print("   当前父视图bounds: \(superview.bounds)")
          }
          // ✅ 使用 CATransaction 禁用动画，强制立即恢复
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          superview.bounds = originalSuperBounds
          CATransaction.commit()
          superview.setNeedsLayout()
          superview.layoutIfNeeded()
        }
      }

      // 监控 WebView frame
      if webView.frame != original {
        print("⚠️ [H5WebView] checkWebViewFrame - WebView Frame被改变! 恢复中... (第\(frameCheckCount)次检查)")
        print("   原始: \(original)")
        print("   当前: \(webView.frame)")
        webView.frame = original
        // 同时设置 bounds 和 frame
        webView.bounds = CGRect(origin: .zero, size: original.size)
      }

      // 持续重置 contentInset 并隐藏滚动指示器
      if webView.scrollView.contentInset != .zero {
        print("⚠️ [H5WebView] checkWebViewFrame - contentInset被改变! 恢复中...")
        print("   当前: \(webView.scrollView.contentInset)")
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
      }
      // ✅ 确保滚动指示器始终隐藏
      webView.scrollView.showsVerticalScrollIndicator = false
      webView.scrollView.showsHorizontalScrollIndicator = false
    }

    private func setupKeyboardObservers() {
      // ✅ 修复4: 监听 keyboardWillShow（提前设置）
      let willShow = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardWillShow()
      }
      keyboardObservers.append(willShow)

      // ✅ 修复7: 添加 frame 监控触发
      let frameObserver = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.setupFrameMonitoring()
      }
      keyboardObservers.append(frameObserver)

      // ✅ 修复5: 监听 keyboardDidShow（确保在系统调整后重置）
      let didShow = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardDidShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardDidShow()
      }
      keyboardObservers.append(didShow)

      // ✅ 修复6: 监听 keyboardWillHide
      let willHide = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillHideNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardWillHide()
      }
      keyboardObservers.append(willHide)

      // ✅ 修复7: 监听 keyboardDidHide
      let didHide = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardDidHideNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardDidHide()
      }
      keyboardObservers.append(didHide)
    }

    // ✅ 修复8: 增强键盘处理方法，同时监控 frame
    private func handleKeyboardWillShow() {
      guard let webView = webView else { return }
      print("🔍 [H5WebView] handleKeyboardWillShow - 键盘即将显示")
      originalWebViewFrame = webView.frame
      originalSuperviewFrame = webView.superview?.frame
      originalSuperviewBounds = webView.superview?.bounds
      superview = webView.superview
      print("   保存原始WebView frame: \(webView.frame)")
      print(
        "   保存原始父视图 frame: \(originalSuperviewFrame != nil ? String(describing: originalSuperviewFrame!) : "nil")"
      )
      print(
        "   保存原始父视图 bounds: \(originalSuperviewBounds != nil ? String(describing: originalSuperviewBounds!) : "nil")"
      )
      print("   WebView bounds: \(webView.bounds)")
      print("   父视图: \(webView.superview?.description ?? "nil")")
      print(
        "   父视图frame: \(webView.superview != nil ? String(describing: webView.superview!.frame) : "nil")"
      )
      print(
        "   父视图bounds: \(webView.superview != nil ? String(describing: webView.superview!.bounds) : "nil")"
      )
      print("   ScrollView contentInset: \(webView.scrollView.contentInset)")
      print("   ScrollView frame: \(webView.scrollView.frame)")
      // 提前设置，防止系统调整
      webView.scrollView.contentInset = .zero
      webView.scrollView.scrollIndicatorInsets = .zero
      setupFrameMonitoring()
    }

    private func handleKeyboardDidShow() {
      guard let webView = webView else { return }
      print("🔍 [H5WebView] handleKeyboardDidShow - 键盘已显示")
      print("   当前WebView frame: \(webView.frame)")
      print("   当前WebView bounds: \(webView.bounds)")
      print("   当前ScrollView contentInset: \(webView.scrollView.contentInset)")
      print("   当前ScrollView frame: \(webView.scrollView.frame)")
      print(
        "   原始frame: \(originalWebViewFrame != nil ? String(describing: originalWebViewFrame!) : "nil")"
      )

      // 在系统调整后，延迟重置（确保在系统调整之后执行）
      DispatchQueue.main.async { [weak self] in
        guard let self = self, let webView = self.webView else { return }

        print("🔍 [H5WebView] handleKeyboardDidShow - async执行")
        print("   async时WebView frame: \(webView.frame)")
        print("   async时ScrollView contentInset: \(webView.scrollView.contentInset)")

        // ✅ 关键修复：先恢复父视图的 frame 和 bounds
        if let superview = webView.superview,
          let originalSuperFrame = self.originalSuperviewFrame,
          let originalSuperBounds = self.originalSuperviewBounds
        {
          if superview.frame != originalSuperFrame || superview.bounds != originalSuperBounds {
            print("   ⚠️⚠️⚠️ 父视图frame/bounds不匹配，恢复中...")
            print("   原始父视图frame: \(originalSuperFrame)")
            print("   当前父视图frame: \(superview.frame)")
            print("   原始父视图bounds: \(originalSuperBounds)")
            print("   当前父视图bounds: \(superview.bounds)")
            // ✅ 使用 CATransaction 禁用动画，强制立即恢复
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            superview.frame = originalSuperFrame
            superview.bounds = originalSuperBounds
            CATransaction.commit()
            superview.setNeedsLayout()
            superview.layoutIfNeeded()
            print("   恢复后父视图frame: \(superview.frame)")
            print("   恢复后父视图bounds: \(superview.bounds)")
          }
        }

        // 恢复 WebView frame
        if let original = self.originalWebViewFrame {
          if webView.frame != original {
            print("   ⚠️ WebView Frame不匹配，恢复中...")
            webView.frame = original
            webView.bounds = CGRect(origin: .zero, size: original.size)
            print("   恢复后frame: \(webView.frame)")
          }
        }

        // 重置 contentInset 并隐藏滚动指示器
        if webView.scrollView.contentInset != .zero {
          print("   ⚠️ contentInset不为0，重置中...")
          webView.scrollView.contentInset = .zero
          webView.scrollView.scrollIndicatorInsets = .zero
          print("   重置后contentInset: \(webView.scrollView.contentInset)")
        }
        // ✅ 确保滚动指示器始终隐藏
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        // 多次延迟确保生效
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
          print("🔍 [H5WebView] handleKeyboardDidShow - 延迟0.05s检查")
          print("   WebView frame: \(webView.frame)")
          print("   ScrollView contentInset: \(webView.scrollView.contentInset)")
          if webView.scrollView.contentInset != .zero {
            webView.scrollView.contentInset = .zero
            webView.scrollView.scrollIndicatorInsets = .zero
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          print("🔍 [H5WebView] handleKeyboardDidShow - 延迟0.1s检查")
          print("   WebView frame: \(webView.frame)")
          print("   ScrollView contentInset: \(webView.scrollView.contentInset)")
          if webView.scrollView.contentInset != .zero {
            webView.scrollView.contentInset = .zero
            webView.scrollView.scrollIndicatorInsets = .zero
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          print("🔍 [H5WebView] handleKeyboardDidShow - 延迟0.2s检查")
          print("   WebView frame: \(webView.frame)")
          print("   ScrollView contentInset: \(webView.scrollView.contentInset)")
          if webView.scrollView.contentInset != .zero {
            webView.scrollView.contentInset = .zero
            webView.scrollView.scrollIndicatorInsets = .zero
          }
        }
      }
    }

    private func handleKeyboardWillHide() {
      guard let webView = webView else { return }
      webView.scrollView.contentInset = .zero
      webView.scrollView.scrollIndicatorInsets = .zero
    }

    private func handleKeyboardDidHide() {
      guard webView != nil else { return }
      DispatchQueue.main.async { [weak self] in
        self?.webView?.scrollView.contentInset = .zero
        self?.webView?.scrollView.scrollIndicatorInsets = .zero
      }
    }

    // --------

    // MARK: - UIScrollViewDelegate

    private var scrollCheckCount = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      scrollCheckCount += 1

      // ✅ 修复9: 持续监控 contentInset，如果被改变立即重置
      if scrollView.contentInset != .zero {
        // 每10次打印一次，避免日志过多
        if scrollCheckCount % 10 == 0 {
          print("🔍 [H5WebView] scrollViewDidScroll - contentInset不为0 (第\(scrollCheckCount)次)")
          print("   contentInset: \(scrollView.contentInset)")
        }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
      }
      // ✅ 确保滚动指示器始终隐藏
      scrollView.showsVerticalScrollIndicator = false
      scrollView.showsHorizontalScrollIndicator = false

      // ✅ 修复10: 如果 WebView frame 被改变，恢复它
      if let webView = webView, let original = originalWebViewFrame {
        if webView.frame != original {
          print("⚠️ [H5WebView] scrollViewDidScroll - WebView frame被改变!")
          print("   原始: \(original)")
          print("   当前: \(webView.frame)")
          webView.frame = original
        }
      }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return nil
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      if scrollView.zoomScale != 1.0 {
        scrollView.setZoomScale(1.0, animated: false)
      }
    }

    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = true
        // ✅ 性能优化：减少loading显示时间，从2.5秒降到1.0秒，提升用户体验
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
          self?.parent.isLoading = false
        }
        self.loadStartTime = Date()
      }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
        if let startTime = self.loadStartTime {
          let loadTime = Date().timeIntervalSince(startTime) * 1000
          self.parent.onLoadFinished?(loadTime)
        }
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
        webView.scrollView.zoomScale = 1.0
        // ✅ 隐藏滚动指示器，防止在加载完成后显示滚动条
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
      }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      if let urlError = error as? URLError, urlError.code.rawValue == -999 {
        return
      }
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }

    func webView(
      _ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!,
      withError error: Error
    ) {
      if let urlError = error as? URLError, urlError.code.rawValue == -999 {
        return
      }
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }

    func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationAction: WKNavigationAction,
      decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
      guard let url = navigationAction.request.url else {
        decisionHandler(.allow)
        return
      }

      let scheme = url.scheme?.lowercased() ?? ""
      let host = url.host?.lowercased() ?? ""
      let absoluteString = url.absoluteString.lowercased()

      // ✅ 检查是否是 App Store 相关链接
      // 支持格式：itms-apps://, itms://, https://apps.apple.com/
      let isAppStoreURL =
        scheme == "itms-apps" || scheme == "itms" || host.contains("apps.apple.com")
        || absoluteString.contains("apps.apple.com")

      if isAppStoreURL {
        print("🔗 [H5WebView] 检测到 App Store 链接: \(url.absoluteString)")
        print("   导航类型: \(navigationAction.navigationType.rawValue)")

        // 如果是用户点击链接（.linkActivated）或表单提交（.formSubmitted），拦截并打开
        if navigationAction.navigationType == .linkActivated
          || navigationAction.navigationType == .formSubmitted
          || navigationAction.navigationType == .other
        {

          // 如果是 https://apps.apple.com/ 格式，尝试转换为 itms-apps:// 格式
          var appStoreURL = url
          if scheme == "https" && host.contains("apps.apple.com") {
            // 提取路径和查询参数
            let path = url.path
            let query = url.query ?? ""
            let fragment = url.fragment ?? ""

            // 构建 itms-apps:// URL
            var itmsURLString = "itms-apps://apps.apple.com\(path)"
            if !query.isEmpty {
              itmsURLString += "?\(query)"
            }
            if !fragment.isEmpty {
              itmsURLString += "#\(fragment)"
            }

            if let convertedURL = URL(string: itmsURLString) {
              print("   ✅ 转换为 itms-apps 格式: \(itmsURLString)")
              appStoreURL = convertedURL
            }
          }

          // 尝试打开 App Store 链接
          if UIApplication.shared.canOpenURL(appStoreURL) {
            print("   ✅ 使用系统打开 App Store 链接")
            UIApplication.shared.open(
              appStoreURL,
              options: [.universalLinksOnly: false],
              completionHandler: { success in
                if success {
                  print("✅ [H5WebView] App Store 链接打开成功")
                } else {
                  print("❌ [H5WebView] App Store 链接打开失败")
                  // 如果 itms-apps 格式失败，尝试使用原始 https 链接
                  if appStoreURL != url {
                    print("   尝试使用原始 https 链接")
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                  }
                }
              })
            decisionHandler(.cancel)
            return
          } else {
            print("⚠️ [H5WebView] canOpenURL 返回 false，尝试直接打开")
            // 即使 canOpenURL 返回 false，也尝试打开（某些情况下可能仍然有效）
            UIApplication.shared.open(
              appStoreURL,
              options: [.universalLinksOnly: false],
              completionHandler: { success in
                print(success ? "✅ 直接打开成功" : "❌ 直接打开失败")
              })
            decisionHandler(.cancel)
            return
          }
        }
      }

      let allowedSchemes = ["http", "https", "file", "chrome", "data", "javascript", "about"]

      if !allowedSchemes.contains(scheme) {
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url)
          decisionHandler(.cancel)
          return
        }
      }

      decisionHandler(.allow)
    }

    // MARK: - WKUIDelegate
    func webView(
      _ webView: WKWebView,
      requestMediaCapturePermissionFor origin: WKSecurityOrigin,
      initiatedByFrame frame: WKFrameInfo,
      type: WKMediaCaptureType,
      decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
      decisionHandler(.grant)
    }

    /// 处理新窗口打开（对应 Flutter InAppWebView 的 onCreateWindow）
    /// 当 H5 页面使用 target="_blank" 或 window.open() 打开链接时触发
    func webView(
      _ webView: WKWebView,
      createWebViewWith configuration: WKWebViewConfiguration,
      for navigationAction: WKNavigationAction,
      windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
      // 检查是否是 App Store 链接
      guard let url = navigationAction.request.url else {
        return nil
      }

      let scheme = url.scheme?.lowercased() ?? ""
      let host = url.host?.lowercased() ?? ""
      let absoluteString = url.absoluteString.lowercased()

      let isAppStoreURL =
        scheme == "itms-apps" || scheme == "itms" || host.contains("apps.apple.com")
        || absoluteString.contains("apps.apple.com")

      if isAppStoreURL {
        print("🔗 [H5WebView] createWebView - 检测到 App Store 链接: \(url.absoluteString)")

        // 转换为 itms-apps 格式（如果是 https）
        var appStoreURL = url
        if scheme == "https" && host.contains("apps.apple.com") {
          let path = url.path
          let query = url.query ?? ""
          let fragment = url.fragment ?? ""

          var itmsURLString = "itms-apps://apps.apple.com\(path)"
          if !query.isEmpty {
            itmsURLString += "?\(query)"
          }
          if !fragment.isEmpty {
            itmsURLString += "#\(fragment)"
          }

          if let convertedURL = URL(string: itmsURLString) {
            appStoreURL = convertedURL
          }
        }

        // 使用系统打开 App Store 链接
        UIApplication.shared.open(
          appStoreURL,
          options: [.universalLinksOnly: false],
          completionHandler: { success in
            print(
              success
                ? "✅ [H5WebView] createWebView - App Store 链接打开成功"
                : "❌ [H5WebView] createWebView - App Store 链接打开失败")
          })

        // 返回 nil 表示不创建新窗口
        return nil
      }

      // 对于其他链接，返回 nil 让系统处理
      return nil
    }

    // MARK: - WKScriptMessageHandler
    func userContentController(
      _ userContentController: WKUserContentController,
      didReceive message: WKScriptMessage
    ) {
      switch message.name {
      case "rechargePay":
        if let body = message.body as? [String: Any],
          let batchNo = body["batchNo"] as? String,
          let orderCode = body["orderCode"] as? String
        {
          FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.zU4ZT5YgrXaPLm7p = orderCode
          DispatchQueue.main.async {
            self.parent.onRechargePay?(batchNo, orderCode)
          }
        }

      case "close":
        print("🔙 [H5WebView] 收到 close 消息")
        print("   消息体: \(message.body)")
        DispatchQueue.main.async {
          print("🔙 [H5WebView] 在主线程执行 close 处理")
          FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN = ""
          print("   Token 已清空")
          if let onClose = self.parent.onClose {
            print("   ✅ 调用 onClose 回调")
            onClose()
          } else {
            print("   ⚠️ onClose 回调为 nil")
          }
        }

      default:
        break
      }
    }

    // MARK: - 侧边返回手势处理

    /// 设置侧边返回手势
    func setupSwipeBackGesture(for webView: WKWebView) {
      // 如果已经设置过，不再重复设置
      if navigationController != nil {
        return
      }

      // 查找 navigationController
      // 方法1: 通过响应链查找
      var responder: UIResponder? = webView
      while responder != nil {
        responder = responder?.next
        if let viewController = responder as? UIViewController {
          navigationController = viewController.navigationController
          break
        }
      }

      // 方法2: 如果方法1失败，尝试通过 window 查找
      if navigationController == nil, let window = webView.window {
        if let rootViewController = window.rootViewController {
          navigationController = findNavigationController(in: rootViewController)
        }
      }

      guard let navController = navigationController else {
        print("⚠️ [H5WebView] 未找到 navigationController，无法设置侧边返回手势")
        return
      }

      // 启用全屏侧滑返回
      navController.interactivePopGestureRecognizer?.isEnabled = true
      navController.interactivePopGestureRecognizer?.delegate = self

      print("✅ [H5WebView] 侧边返回手势已设置")
    }

    /// 递归查找 navigationController
    private func findNavigationController(in viewController: UIViewController)
      -> UINavigationController?
    {
      if let navController = viewController as? UINavigationController {
        return navController
      }

      if let navController = viewController.navigationController {
        return navController
      }

      // 检查子视图控制器
      for child in viewController.children {
        if let navController = findNavigationController(in: child) {
          return navController
        }
      }

      // 检查 presented 视图控制器
      if let presented = viewController.presentedViewController {
        if let navController = findNavigationController(in: presented) {
          return navController
        }
      }

      return nil
    }

    /// 控制手势是否应该开始
    /// 检查 H5 是否有历史记录，决定是让 H5 后退还是原生 pop
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      guard let navController = navigationController,
        gestureRecognizer === navController.interactivePopGestureRecognizer,
        let webView = webView
      else {
        return true
      }

      // 核心判断：询问 H5 是否可以后退
      webView.evaluateJavaScript("history.length > 1 || window.history.state !== null") {
        [weak self] result, error in
        guard let self = self else { return }

        if let error = error {
          print("⚠️ [H5WebView] 检查历史记录失败: \(error.localizedDescription)")
          // 出错时，使用原生方法检查
          if webView.canGoBack {
            webView.goBack()
          } else {
            self.navigationController?.popViewController(animated: true)
          }
          return
        }

        if let canGoBack = result as? Bool, canGoBack {
          // H5 自己有历史记录 → 让 H5 后退
          print("🔙 [H5WebView] H5 有历史记录，执行 H5 后退")
          webView.goBack()
        } else {
          // H5 已经是第一页 → 原生 pop
          print("🔙 [H5WebView] H5 无历史记录，执行原生 pop")
          self.navigationController?.popViewController(animated: true)
        }
      }

      // 临时禁用手势，避免 evaluateJavaScript 期间冲突
      return false
    }

  }
}
