//
//  AIView.swift
//  iCove
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

/// AI 服装助手页面
/// 第一步：填写场景、风格、季节和额外需求
/// 第二步：调用 AI（目前为本地生成占位文案）展示推荐结果
struct AIView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @Environment(\.dismiss) var dismiss

  // 输入字段
  @State private var scene: String = ""
  @State private var style: String = ""
  @State private var season: String = ""
  @State private var additionalRequirements: String = ""

  // 状态
  @State private var isGenerating: Bool = false
  @State private var showResult: Bool = false
  @State private var resultTitle: String = ""
  @State private var resultContent: String = ""

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  // 是否可以点击 Start
  private var canStart: Bool {
    // 至少保证前三个主要字段有值
    !scene.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      && !style.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      && !season.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  var body: some View {
    ZStack {
      Image("Qc4hYFPT1LVSkXq5")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      // 背景色
      // Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
      //   .ignoresSafeArea()
      VStack {
        // 顶部 AI 卡片区域
        headerCard(
          title:
            showResult
            ? "AI Clothing Assistant"
            : "To recommend the most suitable outfit plan for you, please fill in the following information.",
          fontSize: showResult ? 17 : 16
        )

        if showResult {
          VStack {
            resultView
              .padding(.bottom, 12)
            // One more time 按钮
            VStack(spacing: 0) {
              Button(action: {
                Task {
                  await generateRecommendation()
                }
              }) {
                ZStack {
                  RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color("buttonPurple"))
                    .frame(width: 240, height: 50)
                    .overlay(
                      RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 2)
                    )

                  if isGenerating {
                    ProgressView()
                      .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  } else {
                    Text("One more time")
                      .font(.custom("FredokaOne-Regular", size: 20))
                      .foregroundColor(.white)
                  }
                }
              }
              .padding(.bottom, 40)
            }
            .padding(.bottom, 24)
          }

        } else {
          inputFormView
        }

      }

    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          ZStack {
            Circle()
              .fill(Color.white)
              .frame(width: 40, height: 40)
            Image(systemName: "chevron.left")
              .foregroundColor(Color("buttonPurple"))
              .font(.system(size: 18, weight: .semibold))
          }
        }
      }
    }
    .enableInjection()
  }

  // MARK: - 输入表单视图
  private var inputFormView: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 24) {
        // 表单字段
        Group {
          inputSection(
            label: "Scene:",
            placeholder: "Input the target scene",
            text: $scene
          )

          inputSection(
            label: "Style:",
            placeholder: "Input style",
            text: $style
          )

          inputSection(
            label: "Season:",
            placeholder: "Input the season",
            text: $season
          )

          inputSection(
            label: "Additional requirements:",
            placeholder: "Enter...",
            text: $season
          )

          // VStack(alignment: .leading, spacing: 8) {
          //   Text("Additional requirements:")
          //     .font(.custom("FredokaOne-Regular", size: 20))
          //     .foregroundColor(.white)

          //   ZStack(alignment: .topLeading) {
          //     RoundedRectangle(cornerRadius: 18, style: .continuous)
          //       .fill(Color.white.opacity(0.06))
          //       .overlay(
          //         RoundedRectangle(cornerRadius: 18, style: .continuous)
          //           .stroke(Color.white.opacity(0.12), lineWidth: 1)
          //       )

          //     TextEditor(text: $additionalRequirements)
          //       .scrollContentBackground(.hidden)
          //       .padding(.horizontal, 16)
          //       .padding(.vertical, 10)
          //       .foregroundColor(.white)
          //       .font(.system(size: 15))

          //     if additionalRequirements.isEmpty {
          //       Text("Enter...")
          //         .foregroundColor(.white.opacity(0.35))
          //         .font(.system(size: 15))
          //         .padding(.horizontal, 20)
          //         .padding(.vertical, 14)
          //     }
          //   }
          //   .frame(height: 120)
          // }
        }

        // Start 按钮
        VStack(spacing: 16) {
          Button(action: {
            Task {
              await generateRecommendation()
            }
          }) {
            ZStack {
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                  Color("buttonPurple")
                  // LinearGradient(
                  //   colors: [
                  //     Color("buttonPurple"),
                  //     Color("btnpink"),
                  //   ],
                  //   startPoint: .leading,
                  //   endPoint: .trailing
                  // )
                )
                .frame(width: 240, height: 50)
                .overlay(
                  RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 2)
                )
              // .opacity(canStart ? 1.0 : 0.4)

              if isGenerating {
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
              } else {
                Text("Start")
                  .font(.custom("FredokaOne-Regular", size: 22))
                  .foregroundColor(.white)
              }
            }
          }
          .disabled(!canStart || isGenerating)

          // if !canStart {
          //   Text("Please fill in Scene, Style and Season first.")
          //     .font(.system(size: 13))
          //     .foregroundColor(.white.opacity(0.6))
          // }
        }
        .padding(.top, 12)
        .padding(.bottom, 40)
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 30)
    }
  }

  // MARK: - 结果视图
  private var resultView: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 24) {
        VStack(alignment: .leading, spacing: 16) {
          Text(resultTitle)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)

          Text(resultContent)
            .font(.system(size: 15))
            .foregroundColor(.white.opacity(0.9))
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 4)

      }
      .padding(.horizontal, 24)
      .padding(.bottom, 30)
    }
  }

  // MARK: - 公共头部卡片
  private func headerCard(title: String, fontSize: CGFloat = 16) -> some View {
    ZStack(alignment: .bottomTrailing) {
      HStack(alignment: .bottom) {
        Text(title)
          .font(.system(size: fontSize, weight: .medium))
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .frame(width: 180, height: 150, alignment: .center)
          .padding(.leading, 50)
          .padding(.bottom, 30)
          .padding(.top, 100)

        Spacer()
      }
      .padding(.trailing, 10)
    }
  }

  // MARK: - 单行输入区域
  private func inputSection(
    label: String,
    placeholder: String,
    text: Binding<String>
  ) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(label)
        .font(.custom("FredokaOne-Regular", size: 20))
        .foregroundColor(.white)
        .padding(.bottom, 8)

      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white.opacity(0.1))
        // .overlay(
        //   RoundedRectangle(cornerRadius: 16, style: .continuous)
        //     .stroke(Color.white.opacity(0.12), lineWidth: 1)
        // )

        TextField("", text: text)
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .foregroundColor(.white)
          .font(.system(size: 15))

        if text.wrappedValue.isEmpty {
          Text(placeholder)
            .foregroundColor(.white.opacity(0.35))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
        }
      }
      .frame(height: 55)
    }
  }

  // MARK: - 生成推荐文案（模拟 AI 调用）
  private func generateRecommendation() async {
    guard !isGenerating else { return }
    isGenerating = true

    // 模拟网络延迟，后续可在此处集成真实 AI 接口
    try? await Task.sleep(nanoseconds: 900_000_000)

    let trimmedScene = scene.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedStyle = style.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedSeason = season.trimmingCharacters(in: .whitespacesAndNewlines)
    let extra = additionalRequirements.trimmingCharacters(in: .whitespacesAndNewlines)

    // 标题
    resultTitle =
      "\(trimmedStyle.isEmpty ? "Stylish" : trimmedStyle) outfits for \(trimmedScene.isEmpty ? "your day" : trimmedScene.lowercased())"

    // 简单占位文案（可替换为后端返回的内容）
    var content = """
      Top: Choose a \(trimmedStyle.lowercased().isEmpty ? "clean and well-fitted" : trimmedStyle.lowercased()) top that matches the vibe of \(trimmedScene.lowercased().isEmpty ? "the occasion" : trimmedScene.lowercased()). Prefer breathable fabrics suitable for \(trimmedSeason.lowercased().isEmpty ? "the current season" : trimmedSeason.lowercased()), so that you can stay comfortable while looking polished.

      Bottom wear: Go for a silhouette that elongates the leg line and keeps the overall look balanced. High‑waisted straight‑leg trousers, midi skirts, or well‑cut jeans all work well depending on how formal \(trimmedScene.lowercased().isEmpty ? "the scene is" : trimmedScene.lowercased()) needs to be.

      Coat / Outerwear: Add a layer that refines the proportions of your shoulders and waist. A short jacket or blazer that hits around the waist can subtly enhance the body ratio and make the outfit look more intentional.

      Footwear: Pick shoes that are comfortable enough for the activities of the scene while still echoing the \(trimmedStyle.lowercased().isEmpty ? "overall style" : trimmedStyle.lowercased() + " style"). Slight heels, clean sneakers, or simple boots can all be good options as long as the color does not overpower the outfit.

      Accessories: Use 1‑2 highlight pieces, such as a delicate necklace, earrings, or a structured bag, to complete the look. Avoid too many competing focal points so that the overall outfit remains coherent and flattering.
      """

    if !extra.isEmpty {
      content += """

        Special notes based on your additional requirements: \(extra)
        The outfit suggestions above can be subtly adjusted in fabric, color, and accessories to better respond to these personal preferences.
        """
    }

    resultContent = content
    showResult = true
    isGenerating = false
  }
}
