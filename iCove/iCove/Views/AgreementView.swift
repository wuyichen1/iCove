//
//  AgreementView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 协议页面 - 显示 H5 协议内容
struct AgreementView: View {
  let urlString: String
  let title: String

  @EnvironmentObject var router: Router
  @State private var isLoading = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 背景色
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部标题栏
        header
          .padding(.horizontal, 20)
          .padding(.bottom, 16)

        // H5 内容区域
        ZStack {
          if let url = URL(string: urlString) {
            WebView(url: url, isLoading: $isLoading)
              .background(Color.white)
          } else {
            // URL 无效时显示错误提示
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

          // 加载指示器
          if isLoading {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .white))
              .scaleEffect(1.5)
          }
        }
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Header
  private var header: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 返回按钮和标题
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

        // 标题
        Text(title)
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color(.white))
          .padding(.leading, 10)

        Spacer()
      }

    }
    .padding(.top, 0)
  }
}
