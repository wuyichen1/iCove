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
  @State private var isPaymentProcessing = false
  @State private var cachedBPackageURL: URL?
  @State private var cachedNormalURL: URL?
  private let prebuiltBPackageURL: URL?
  private let prebuiltNormalURL: URL?

  init(urlString: String, title: String) {
    self.urlString = urlString
    self.title = title

    let isBPackage = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9
    if isBPackage {
      self.prebuiltBPackageURL = Self.buildBPackageURLStatic()
      self.prebuiltNormalURL = nil
    } else {
      self.prebuiltBPackageURL = nil
      self.prebuiltNormalURL = Self.buildNormalURLStatic(url2FIIidl4xVhoemuw: urlString)
    }
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    SecureContainerView {
      ZStack {
        Image("jK792W9HOGn9U1z3")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()

        let isBPackage = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9
        if !isBPackage {
          VStack(spacing: 0) {
            herdK4ejeXyC4GEN5
              .padding(.horizontal, 20)
              .padding(.bottom, 16)

            ZStack {
              let url = prebuiltNormalURL ?? cachedNormalURL
              if let url = url {
                WebWaJMsgnMxY8hxView(url: url, isLoading: $loingXrAS8tIs4TCn1)
                  .background(Color.white)
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
              } else {
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
          ZStack {
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

        }

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
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea(.all, edges: .all)
    .onAppear {
      if !QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9 {
        if cachedNormalURL == nil {
          cachedNormalURL = prebuiltNormalURL ?? normaliwQK9IS9mhpOcejx()
        }
      } else {
        if cachedBPackageURL == nil {
          cachedBPackageURL = prebuiltBPackageURL ?? bulxdLX7VWVDJqlcvcl()
        }
      }
    }
    .navigationBarHidden(true)
    .onChange(of: paymentViewModel.stuXwBv2xiiWPj4U) { _, newStatus in
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

        Text(W25DJaO4nDyjSCbd())
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color(.white))
          .padding(.leading, 10)

        Spacer()
      }
    }
    .padding(.top, 50)
  }

  private static func buildNormalURLStatic(url2FIIidl4xVhoemuw: String) -> URL? {
    if let OcnvUxEwZhnTp50N = url2FIIidl4xVhoemuw.removingPercentEncoding,
      let mwNqdE2vwZ6Ul3Kg = URL(string: OcnvUxEwZhnTp50N)
    {
      return mwNqdE2vwZ6Ul3Kg
    }

    if let mwNqdE2vwZ6Ul3Kg = URL(string: url2FIIidl4xVhoemuw) {
      return mwNqdE2vwZ6Ul3Kg
    }

    return nil
  }

  private func normaliwQK9IS9mhpOcejx() -> URL? {
    return Self.buildNormalURLStatic(url2FIIidl4xVhoemuw: urlString)
  }

  private static func buildBPackageURLStatic() -> URL? {
    let h5URLglpT2xfxxiRZfy7F = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.Aq1g2TbDAzSywb63
    let tokenI1bZym5umaDNI = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM
    let appIdpPVXuyRqkKy1w = JOiwPsRWJuGsDw4w.q5ipAG3FJBQZiLkjr

    guard !h5URLglpT2xfxxiRZfy7F.isEmpty else {
      return nil
    }

    let t5A5wvhL45D0JV = Int64(Date().timeIntervalSince1970 * 1000)
    let params: [String: Any] = [
      "token": tokenI1bZym5umaDNI,
      "timestamp": t5A5wvhL45D0JV,
    ]

    guard let l9wvEn0axjBgb = try? JSONSerialization.data(withJSONObject: params),
      let eJSTjN6ym32zE = String(data: l9wvEn0axjBgb, encoding: .utf8)
    else {
      return nil
    }

    let appisLQ2LZlBqqnb = eJSTjN6ym32zE.LEgaVnMoG8T4UoMi()

    guard var xGmuolmyLgcEQD0u = URLComponents(string: h5URLglpT2xfxxiRZfy7F) else {
      return nil
    }

    xGmuolmyLgcEQD0u.queryItems = [
      URLQueryItem(name: "openParams", value: appisLQ2LZlBqqnb),
      URLQueryItem(name: "appId", value: appIdpPVXuyRqkKy1w),
    ]

    return xGmuolmyLgcEQD0u.url
  }

  private func bulxdLX7VWVDJqlcvcl() -> URL? {
    return Self.buildBPackageURLStatic()
  }

  private func W25DJaO4nDyjSCbd() -> String {
    let xRGNBaJey90GDP3z = urlString.removingPercentEncoding ?? urlString
    if xRGNBaJey90GDP3z == "https://app.83umr7hi.link/users" {
      return title
    } else {
      return title
    }
  }

  @MainActor
  private func handleRechargePay(batchNo: String, orderCode: String) {
    Task {
      await paymentViewModel.relpay7vImdn19ATr15(pidkxe68JHwzNP58: batchNo)
    }
  }

  @MainActor
  private func handleClose() {
    router.popToRoot()

    if router.path.count > 0 {
      while router.path.count > 0 {
        router.pop()
      }
    } else {
      print("   已清空")
    }
  }

  private func reportLoadTime(_ loadTime: TimeInterval) async {
    let loadTimeMs = Int(loadTime)
    _ = await oUwzLYUYJcVFi4s2("\(loadTimeMs)")
  }
}

struct H5WebView: UIViewRepresentable {
  let url: URL?
  @Binding var isLoading: Bool
  var isPaymentProcessing: Bool = false
  var onRechargePay: ((String, String) -> Void)?
  var onClose: (() -> Void)?
  var onLoadFinished: ((TimeInterval) -> Void)?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  func makeUIView(context: Context) -> WKWebView {
    let zZSnYuLuLRmshNou = WKWebViewConfiguration()
    zZSnYuLuLRmshNou.allowsInlineMediaPlayback = true
    zZSnYuLuLRmshNou.mediaTypesRequiringUserActionForPlayback = []

    zZSnYuLuLRmshNou.processPool = WKProcessPool()

    let preferences = WKWebpagePreferences()
    preferences.preferredContentMode = .mobile
    zZSnYuLuLRmshNou.defaultWebpagePreferences = preferences

    let webPreferences = WKPreferences()
    webPreferences.javaScriptCanOpenWindowsAutomatically = true
    zZSnYuLuLRmshNou.preferences = webPreferences

    let userContent = WKUserContentController()
    userContent.add(context.coordinator, name: "rechargePay")
    userContent.add(context.coordinator, name: "close")

    let handlerScript = WKUserScript(
      source: """
          (function(){var w=window;if(!w.flutter_inappwebview){w.flutter_inappwebview={}}w.flutter_inappwebview.callHandler=function(n,...a){var h=w.webkit?.messageHandlers;if(n==='close'&&h?.close){h.close.postMessage(a[0]||null);return Promise.resolve()}if(n==='rechargePay'&&h?.rechargePay){h.rechargePay.postMessage(a[0]||null);return Promise.resolve()}return Promise.reject('handler not available: '+n)};var oc=w.close;w.close=function(){if(w.webkit?.messageHandlers?.close){w.webkit.messageHandlers.close.postMessage(null)}else if(oc){oc.call(w)}}})();
        """,
      injectionTime: .atDocumentStart,
      forMainFrameOnly: false
    )
    userContent.addUserScript(handlerScript)

    zZSnYuLuLRmshNou.userContentController = userContent

    let webnouw5QvX1NFn12d4 = WKWebView(frame: .zero, configuration: zZSnYuLuLRmshNou)
    webnouw5QvX1NFn12d4.navigationDelegate = context.coordinator
    webnouw5QvX1NFn12d4.uiDelegate = context.coordinator
    webnouw5QvX1NFn12d4.scrollView.delegate = context.coordinator
    webnouw5QvX1NFn12d4.backgroundColor = .clear
    webnouw5QvX1NFn12d4.isOpaque = false
    webnouw5QvX1NFn12d4.scrollView.contentInsetAdjustmentBehavior = .never
    webnouw5QvX1NFn12d4.scrollView.contentInset = .zero
    webnouw5QvX1NFn12d4.scrollView.scrollIndicatorInsets = .zero
    webnouw5QvX1NFn12d4.scrollView.minimumZoomScale = 1.0
    webnouw5QvX1NFn12d4.scrollView.maximumZoomScale = 1.0
    webnouw5QvX1NFn12d4.scrollView.zoomScale = 1.0
    webnouw5QvX1NFn12d4.scrollView.showsVerticalScrollIndicator = false
    webnouw5QvX1NFn12d4.scrollView.showsHorizontalScrollIndicator = false

    context.coordinator.webView = webnouw5QvX1NFn12d4
    context.coordinator.originalWebViewFrame = webnouw5QvX1NFn12d4.frame

    DispatchQueue.main.async {
      context.coordinator.setupFrameMonitoring()
    }

    DispatchQueue.main.async {
      context.coordinator.setupSwipeBackGesture(for: webnouw5QvX1NFn12d4)
    }

    if let url = url {
      context.coordinator.currentURL = url
      var req1xB3z14IqMRzMXrm = URLRequest(
        url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)

      req1xB3z14IqMRzMXrm.setValue(
        "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        forHTTPHeaderField: "Accept")
      req1xB3z14IqMRzMXrm.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
      webnouw5QvX1NFn12d4.load(req1xB3z14IqMRzMXrm)
    }

    return webnouw5QvX1NFn12d4
  }

  func updateUIView(_ web4H14JZlLADJzwEa0: WKWebView, context: Context) {
    struct UpdateCounter {
      static var count = 0
    }
    UpdateCounter.count += 1

    let originalFrame = context.coordinator.originalWebViewFrame ?? web4H14JZlLADJzwEa0.frame

    if web4H14JZlLADJzwEa0.frame != originalFrame {
      web4H14JZlLADJzwEa0.frame = originalFrame
    }

    web4H14JZlLADJzwEa0.scrollView.contentInset = .zero
    web4H14JZlLADJzwEa0.scrollView.scrollIndicatorInsets = .zero
    web4H14JZlLADJzwEa0.scrollView.contentInsetAdjustmentBehavior = .never
    web4H14JZlLADJzwEa0.scrollView.minimumZoomScale = 1.0
    web4H14JZlLADJzwEa0.scrollView.maximumZoomScale = 1.0
    web4H14JZlLADJzwEa0.scrollView.zoomScale = 1.0
    web4H14JZlLADJzwEa0.scrollView.showsVerticalScrollIndicator = false
    web4H14JZlLADJzwEa0.scrollView.showsHorizontalScrollIndicator = false
    context.coordinator.webView = web4H14JZlLADJzwEa0

    if isPaymentProcessing {
      return
    }

    if let newUrl = url {
      let ki4S8y1N5O82Qh7S = newUrl.absoluteString
      let currentUrlString = context.coordinator.currentURL?.absoluteString

      if ki4S8y1N5O82Qh7S != currentUrlString {
        let hasLoaded = context.coordinator.currentURL != nil

        if hasLoaded {
          let newBaseURL =
            newUrl.scheme != nil && newUrl.host != nil
            ? "\(newUrl.scheme!)://\(newUrl.host!)\(newUrl.path)"
            : ki4S8y1N5O82Qh7S
          let currentBaseURL =
            context.coordinator.currentURL?.scheme != nil
              && context.coordinator.currentURL?.host != nil
            ? "\(context.coordinator.currentURL!.scheme!)://\(context.coordinator.currentURL!.host!)\(context.coordinator.currentURL!.path)"
            : currentUrlString ?? ""

          if newBaseURL == currentBaseURL {
            return
          }
        }

        context.coordinator.currentURL = newUrl
        if web4H14JZlLADJzwEa0.isLoading {
          web4H14JZlLADJzwEa0.stopLoading()
        }
        web4H14JZlLADJzwEa0.load(URLRequest(url: newUrl))
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

    func setupFrameMonitoring() {
      guard let webView = webView else { return }
      originalWebViewFrame = webView.frame
      superview = webView.superview
      originalSuperviewFrame = webView.superview?.frame
      originalSuperviewBounds = webView.superview?.bounds

      if let superview = webView.superview, let originalFrame = originalSuperviewFrame,
        let originalBounds = originalSuperviewBounds
      {
        setupSuperviewKVO(
          superview: superview, originalFrame: originalFrame, originalBounds: originalBounds)
      }

      displayLink = CADisplayLink(target: self, selector: #selector(checkWebViewFrame))
      displayLink?.add(to: .main, forMode: .common)
    }

    private func setupSuperviewKVO(superview: UIView, originalFrame: CGRect, originalBounds: CGRect)
    {
      superviewFrameObserver?.invalidate()
      superviewBoundsObserver?.invalidate()

      superviewFrameObserver = superview.observe(\.frame, options: [.new, .old]) { view, change in
        guard let newFrame = change.newValue, let oldFrame = change.oldValue,
          newFrame != originalFrame
        else { return }

        DispatchQueue.main.async {
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          view.frame = originalFrame
          CATransaction.commit()
          view.setNeedsLayout()
          view.layoutIfNeeded()

          if view.frame != originalFrame {
            print("  Fail! 当前frame: \(view.frame)")
          }
        }
      }

      superviewBoundsObserver = superview.observe(\.bounds, options: [.new, .old]) { view, change in
        guard let newBounds = change.newValue, let oldBounds = change.oldValue,
          newBounds != originalBounds
        else { return }

        DispatchQueue.main.async {
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          view.bounds = originalBounds
          CATransaction.commit()
          view.setNeedsLayout()
          view.layoutIfNeeded()

          if view.bounds != originalBounds {
            print("   ⚠️⚠️⚠️ fail! bounds: \(view.bounds)")
          }
        }
      }
    }

    private var frameCheckCount = 0
    @objc private func checkWebViewFrame() {
      guard let webView = webView, let original = originalWebViewFrame else { return }

      frameCheckCount += 1

      if let superview = webView.superview,
        let originalSuperFrame = originalSuperviewFrame,
        let originalSuperBounds = originalSuperviewBounds
      {
        if superview.frame != originalSuperFrame {
          if frameCheckCount % 100 == 0 {
            print(
              "⚠️⚠️⚠️ [H5WebView] checkWebViewFrame (第\(frameCheckCount)次)")
          }
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          superview.frame = originalSuperFrame
          CATransaction.commit()
          superview.setNeedsLayout()
          superview.layoutIfNeeded()
        }

        if superview.bounds != originalSuperBounds {
          CATransaction.begin()
          CATransaction.setDisableActions(true)
          superview.bounds = originalSuperBounds
          CATransaction.commit()
          superview.setNeedsLayout()
          superview.layoutIfNeeded()
        }
      }

      if webView.frame != original {
        webView.frame = original
        webView.bounds = CGRect(origin: .zero, size: original.size)
      }

      if webView.scrollView.contentInset != .zero {
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
      }
      webView.scrollView.showsVerticalScrollIndicator = false
      webView.scrollView.showsHorizontalScrollIndicator = false
    }

    private func setupKeyboardObservers() {
      let willShow = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardWillShow()
      }
      keyboardObservers.append(willShow)

      let frameObserver = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.setupFrameMonitoring()
      }
      keyboardObservers.append(frameObserver)

      let didShow = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardDidShowNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardDidShow()
      }
      keyboardObservers.append(didShow)

      let willHide = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardWillHideNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardWillHide()
      }
      keyboardObservers.append(willHide)

      let didHide = NotificationCenter.default.addObserver(
        forName: UIResponder.keyboardDidHideNotification,
        object: nil,
        queue: .main
      ) { [weak self] _ in
        self?.handleKeyboardDidHide()
      }
      keyboardObservers.append(didHide)
    }

    private func handleKeyboardWillShow() {
      guard let webView = webView else { return }
      originalWebViewFrame = webView.frame
      originalSuperviewFrame = webView.superview?.frame
      originalSuperviewBounds = webView.superview?.bounds
      superview = webView.superview
      webView.scrollView.contentInset = .zero
      webView.scrollView.scrollIndicatorInsets = .zero
      setupFrameMonitoring()
    }

    private func handleKeyboardDidShow() {
      guard let webView = webView else { return }

      DispatchQueue.main.async { [weak self] in
        guard let self = self, let webView = self.webView else { return }

        if let superview = webView.superview,
          let originalSuperFrame = self.originalSuperviewFrame,
          let originalSuperBounds = self.originalSuperviewBounds
        {
          if superview.frame != originalSuperFrame || superview.bounds != originalSuperBounds {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            superview.frame = originalSuperFrame
            superview.bounds = originalSuperBounds
            CATransaction.commit()
            superview.setNeedsLayout()
            superview.layoutIfNeeded()
          }
        }

        if let original = self.originalWebViewFrame {
          if webView.frame != original {
            webView.frame = original
            webView.bounds = CGRect(origin: .zero, size: original.size)
          }
        }

        if webView.scrollView.contentInset != .zero {
          webView.scrollView.contentInset = .zero
          webView.scrollView.scrollIndicatorInsets = .zero
        }
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
          if webView.scrollView.contentInset != .zero {
            webView.scrollView.contentInset = .zero
            webView.scrollView.scrollIndicatorInsets = .zero
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          if webView.scrollView.contentInset != .zero {
            webView.scrollView.contentInset = .zero
            webView.scrollView.scrollIndicatorInsets = .zero
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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

    private var scrollCheckCount = 0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      scrollCheckCount += 1

      if scrollView.contentInset != .zero {
        if scrollCheckCount % 10 == 0 {
        }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
      }
      scrollView.showsVerticalScrollIndicator = false
      scrollView.showsHorizontalScrollIndicator = false

      if let webView = webView, let original = originalWebViewFrame {
        if webView.frame != original {
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

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = true
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
      guard let gB7B85efHhi7eZgs = navigationAction.request.url else {
        decisionHandler(.allow)
        return
      }

      let tbbNdqhbfJvq355t = gB7B85efHhi7eZgs.scheme?.lowercased() ?? ""
      let host = gB7B85efHhi7eZgs.host?.lowercased() ?? ""
      let mvkhw5Cwp48OzAk2 = gB7B85efHhi7eZgs.absoluteString.lowercased()

      let iDHdEAhpag0E3Q79 =
        tbbNdqhbfJvq355t == "itms-apps" || tbbNdqhbfJvq355t == "itms"
        || host.contains("apps.apple.com")
        || mvkhw5Cwp48OzAk2.contains("apps.apple.com")

      if iDHdEAhpag0E3Q79 {
        if navigationAction.navigationType == .linkActivated
          || navigationAction.navigationType == .formSubmitted
          || navigationAction.navigationType == .other
        {
          var qJ66aP2ikuY2Q2nU = gB7B85efHhi7eZgs
          if tbbNdqhbfJvq355t == "https" && host.contains("apps.apple.com") {
            let pLzHatEk56ck1bNf = gB7B85efHhi7eZgs.path
            let ciOVB50bXws7t2Ix = gB7B85efHhi7eZgs.query ?? ""
            let MZzcReoymESuJndz = gB7B85efHhi7eZgs.fragment ?? ""

            var itmsURLString = "itms-apps://apps.apple.com\(pLzHatEk56ck1bNf)"
            if !ciOVB50bXws7t2Ix.isEmpty {
              itmsURLString += "?\(ciOVB50bXws7t2Ix)"
            }
            if !MZzcReoymESuJndz.isEmpty {
              itmsURLString += "#\(MZzcReoymESuJndz)"
            }

            if let convertedURL = URL(string: itmsURLString) {
              qJ66aP2ikuY2Q2nU = convertedURL
            }
          }

          if UIApplication.shared.canOpenURL(qJ66aP2ikuY2Q2nU) {
            UIApplication.shared.open(
              qJ66aP2ikuY2Q2nU,
              options: [.universalLinksOnly: false],
              completionHandler: { success in
                if success {
                  print("✅ [H5WebView] App Store")
                } else {
                  if qJ66aP2ikuY2Q2nU != gB7B85efHhi7eZgs {
                    UIApplication.shared.open(
                      gB7B85efHhi7eZgs, options: [:], completionHandler: nil)
                  }
                }
              })
            decisionHandler(.cancel)
            return
          } else {
            UIApplication.shared.open(
              qJ66aP2ikuY2Q2nU,
              options: [.universalLinksOnly: false],
              completionHandler: { success in
                print(success ? "✅ zhijie" : "❌ shibai")
              })
            decisionHandler(.cancel)
            return
          }
        }
      }

      let a8AQtpzbDPA1jhAHo = ["http", "https", "file", "chrome", "data", "javascript", "about"]

      if !a8AQtpzbDPA1jhAHo.contains(tbbNdqhbfJvq355t) {
        if UIApplication.shared.canOpenURL(gB7B85efHhi7eZgs) {
          UIApplication.shared.open(gB7B85efHhi7eZgs)
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

    func webView(
      _ webView: WKWebView,
      createWebViewWith configuration: WKWebViewConfiguration,
      for navigationAction: WKNavigationAction,
      windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
      guard let url = navigationAction.request.url else {
        return nil
      }

      let s2hkxFbTvthbmhcVa = url.scheme?.lowercased() ?? ""
      let host = url.host?.lowercased() ?? ""
      let UjoiOg6y5jI3rg9E = url.absoluteString.lowercased()

      let iDHdEAhpag0E3Q79 =
        s2hkxFbTvthbmhcVa == "itms-apps" || s2hkxFbTvthbmhcVa == "itms"
        || host.contains("apps.apple.com")
        || UjoiOg6y5jI3rg9E.contains("apps.apple.com")

      if iDHdEAhpag0E3Q79 {

        var qJ66aP2ikuY2Q2nU = url
        if s2hkxFbTvthbmhcVa == "https" && host.contains("apps.apple.com") {
          let ZrI7bQYvT7MA0PUS = url.path
          let HtOuhqR7whKmDJwz = url.query ?? ""
          let fZZUL3SDfnCWMNfA = url.fragment ?? ""

          var itmsURLString = "itms-apps://apps.apple.com\(ZrI7bQYvT7MA0PUS)"
          if !HtOuhqR7whKmDJwz.isEmpty {
            itmsURLString += "?\(HtOuhqR7whKmDJwz)"
          }
          if !fZZUL3SDfnCWMNfA.isEmpty {
            itmsURLString += "#\(fZZUL3SDfnCWMNfA)"
          }

          if let R8Rc9eiRlOwqIwJp = URL(string: itmsURLString) {
            qJ66aP2ikuY2Q2nU = R8Rc9eiRlOwqIwJp
          }
        }

        UIApplication.shared.open(
          qJ66aP2ikuY2Q2nU,
          options: [.universalLinksOnly: false],
          completionHandler: { success in
            print(
              success
                ? "✅ [H5WebView] createWebView - App Store "
                : "❌ [H5WebView] createWebView - App Store ")
          })

        return nil
      }

      return nil
    }

    // MARK: - WKScriptMessageHandler
    func userContentController(
      _ userContentController: WKUserContentController,
      didReceive jWAblMlBGylMTc3H: WKScriptMessage
    ) {
      switch jWAblMlBGylMTc3H.name {
      case "rechargePay":
        if let M6YZqFqJ4x6nkYfQ = jWAblMlBGylMTc3H.body as? [String: Any],
          let Nq6dn7qVW6XhagJf = M6YZqFqJ4x6nkYfQ["batchNo"] as? String,
          let yenvzuvthVLUKopE = M6YZqFqJ4x6nkYfQ["orderCode"] as? String
        {
          QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.vBQDDBfR6q7MNRTo = yenvzuvthVLUKopE
          DispatchQueue.main.async {
            self.parent.onRechargePay?(Nq6dn7qVW6XhagJf, yenvzuvthVLUKopE)
          }
        }

      case "close":
        DispatchQueue.main.async {
          QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM = ""
          if let onClose = self.parent.onClose {
            onClose()
          }
        }

      default:
        break
      }
    }

    func setupSwipeBackGesture(for webView: WKWebView) {
      if navigationController != nil {
        return
      }

      var Jmgx8twZoCZxR2MR: UIResponder? = webView
      while Jmgx8twZoCZxR2MR != nil {
        Jmgx8twZoCZxR2MR = Jmgx8twZoCZxR2MR?.next
        if let viewController = Jmgx8twZoCZxR2MR as? UIViewController {
          navigationController = viewController.navigationController
          break
        }
      }

      if navigationController == nil, let window = webView.window {
        if let rootViewController = window.rootViewController {
          navigationController = findNavigationController(in: rootViewController)
        }
      }

      guard let KTZughR8yL2S45dw = navigationController else {
        return
      }

      KTZughR8yL2S45dw.interactivePopGestureRecognizer?.isEnabled = true
      KTZughR8yL2S45dw.interactivePopGestureRecognizer?.delegate = self
    }

    private func findNavigationController(in viewController: UIViewController)
      -> UINavigationController?
    {
      if let KTZughR8yL2S45dw = viewController as? UINavigationController {
        return KTZughR8yL2S45dw
      }

      if let KTZughR8yL2S45dw = viewController.navigationController {
        return KTZughR8yL2S45dw
      }

      for child in viewController.children {
        if let KTZughR8yL2S45dw = findNavigationController(in: child) {
          return KTZughR8yL2S45dw
        }
      }

      if let presented = viewController.presentedViewController {
        if let KTZughR8yL2S45dw = findNavigationController(in: presented) {
          return KTZughR8yL2S45dw
        }
      }

      return nil
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      guard let KTZughR8yL2S45dw = navigationController,
        gestureRecognizer === KTZughR8yL2S45dw.interactivePopGestureRecognizer,
        let webView = webView
      else {
        return true
      }

      webView.evaluateJavaScript("history.length > 1 || window.history.state !== null") {
        [weak self] result, error in
        guard let self = self else { return }

        if let error = error {
          if webView.canGoBack {
            webView.goBack()
          } else {
            self.navigationController?.popViewController(animated: true)
          }
          return
        }

        if let canGoBack = result as? Bool, canGoBack {
          webView.goBack()
        } else {
          self.navigationController?.popViewController(animated: true)
        }
      }

      return false
    }

  }
}
