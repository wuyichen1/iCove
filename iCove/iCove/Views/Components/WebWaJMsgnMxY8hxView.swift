//
//  WebWaJMsgnMxY8hxView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI
import WebKit

#if DEBUG
  import HotSwiftUI
#endif

struct WebWaJMsgnMxY8hxView: UIViewRepresentable {
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
    let webJfyREBIxLxV3B = WKWebView()
    webJfyREBIxLxV3B.navigationDelegate = context.coordinator
    
    if let url = url {
      let request = URLRequest(url: url)
      webJfyREBIxLxV3B.load(request)
    }
    
    return webJfyREBIxLxV3B
  }
  
  func updateUIView(_ webJfyREBIxLxV3B: WKWebView, context: Context) {
    if let aWEENyHcRWOEH = url, webJfyREBIxLxV3B.url != url {
      let request = URLRequest(url: aWEENyHcRWOEH)
      webJfyREBIxLxV3B.load(request)
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebWaJMsgnMxY8hxView
    
    init(_ parent: WebWaJMsgnMxY8hxView) {
      self.parent = parent
    }
    
    func webJfyREBIxLxV3B(_ webJfyREBIxLxV3B: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = true
      }
    }
    
    func webJfyREBIxLxV3B(_ webJfyREBIxLxV3B: WKWebView, didFinish navigation: WKNavigation!) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
    
    func webJfyREBIxLxV3B(_ webJfyREBIxLxV3B: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
    
    func webJfyREBIxLxV3B(_ webJfyREBIxLxV3B: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      DispatchQueue.main.async {
        self.parent.isLoading = false
      }
    }
  }
}
