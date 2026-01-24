//
//  ReportView.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// 举报选项枚举
enum ReportOption: String, CaseIterable {
  case vulgarPornography = "Vulgar pornography"
  case violentBloody = "Violent and bloody"
  case infringementPlagiarism = "Infringement and plagiarism"
  case maliciousHarassment = "Malicious harassment"
  case others = "Others"

  var displayName: String {
    return rawValue
  }
}

/// 举报页面
struct ReportView: View {
  let userId: String
  @EnvironmentObject var router: Router
  @State private var selectedOption: ReportOption? = ReportOption.allCases.first
  @State private var isSubmitting: Bool = false
  @State private var showSuccessMessage: Bool = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      // 背景色
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 0) {
        // 返回按钮
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
        .padding(.leading, 20)

        // 标题
        Text("Select the report option")
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color("btnpink"))
          .padding(.horizontal, 20)
          .padding(.top, 30)
          .padding(.bottom, 30)

        // 举报选项列表
        ScrollView {
          VStack(spacing: 18) {
            ForEach(ReportOption.allCases, id: \.self) { option in
              reportOptionButton(option: option)
            }
          }
          .padding(.horizontal, 20)
        }

        Spacer()

        HStack {
          Spacer()

          // 提交按钮
          Button(action: {
            submitReport()
          }) {
            Text("Submit")
              .font(.custom("FredokaOne-Regular", size: 20))
              .foregroundColor(.white)
              .frame(maxWidth: 240)
              .padding(.vertical, 15)
              .background(
                Color("buttonPurple")
              )
              .overlay(
                RoundedRectangle(cornerRadius: 15)
                  .stroke(Color.white, lineWidth: 4)
              )
              .cornerRadius(15)
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 30)
          .disabled(selectedOption == nil || isSubmitting)
          .opacity(selectedOption == nil ? 0.5 : 1.0)

          Spacer()

        }

      }
    }
    .overlay {
      if showSuccessMessage {
        successMessageView
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Report Option Button
  private func reportOptionButton(option: ReportOption) -> some View {
    Button(action: {
      selectedOption = option
    }) {
      Text(option.displayName)
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(Color.white)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
              selectedOption == option
                ? LinearGradient(
                  gradient: Gradient(colors: [
                    Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                    Color(red: 238 / 255, green: 137 / 255, blue: 243 / 255),
                  ]),
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                )
                : LinearGradient(
                  gradient: Gradient(colors: [
                    Color.white,
                    Color.white,
                  ]),
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                ),
              lineWidth: 4
            )
        )
        .cornerRadius(16)
    }
  }

  // MARK: - Success Message View
  private var successMessageView: some View {
    ZStack {
      // 半透明背景
      Color.black.opacity(0.5)
        .ignoresSafeArea()

      // 成功提示框
      VStack(spacing: 20) {
        Image(systemName: "checkmark.circle.fill")
          .font(.system(size: 60))
          .foregroundColor(.green)

        Text("Report submitted successfully")
          .font(.custom("FredokaOne-Regular", size: 20))
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
      }
      .padding(30)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(
            LinearGradient(
              gradient: Gradient(colors: [
                Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                Color(red: 238 / 255, green: 137 / 255, blue: 243 / 255),
              ]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 3
          )
      )
    }
  }

  // MARK: - Submit Report
  private func submitReport() {
    guard let option = selectedOption else { return }

    isSubmitting = true

    // 模拟提交举报
    Task {
      // 模拟网络请求延迟
      try? await Task.sleep(nanoseconds: 500_000_000)  // 0.5秒延迟

      await MainActor.run {
        isSubmitting = false
        // 显示成功提示
        showSuccessMessage = true

        // 1.5秒后自动返回
        Task {
          try? await Task.sleep(nanoseconds: 1_500_000_000)
          await MainActor.run {
            showSuccessMessage = false
            router.pop()
          }
        }
      }
    }
  }
}
