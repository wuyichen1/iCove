//
//  WebView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI
import WebKit

#if DEBUG
  import HotSwiftUI
#endif

/// WebView 组件 - WKWebView 的 SwiftUI 包装器
struct WebView: UIViewRepresentable {
  let url: URL?
  @Binding var isLoading: Bool
  
  #if DEBUG
    @ObserveInjection var redraw
  #endif
  
  init(url: URL?, isLoading: Binding<Bool> = .constant(false)) {
    self.url = url
    self._isLoading = isLoading
  }
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    
    // 加载 URL
    if let url = url {
      let request = URLRequest(url: url)
      webView.load(request)
    }
    
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
    // 如果 URL 改变，重新加载
    if let url = url, webView.url != url {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    
    init(_ parent: WebView) {
      self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = true
      }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
  }
}
