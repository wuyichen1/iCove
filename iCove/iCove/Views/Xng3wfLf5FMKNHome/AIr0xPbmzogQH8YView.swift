//
//  AIr0xPbmzogQH8YView.swift
//  iCove
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct AIr0xPbmzogQH8YView: View {
  @EnvironmentObject var aumakZ0ElZwz9Rk1P: AuthManagA645b8Y0Aod3aVmod
  @Environment(\.dismiss) var dismiss

  @State private var sceneIq2MemYaRG9ID: String = ""
  @State private var style6ZDDe8xvnuVbx: String = ""
  @State private var seasonYY7u27U3XFDNo: String = ""
  @State private var adtionno35myNqcElag: String = ""

  @State private var geingig215odKvYEed: Bool = false
  @State private var shrestQx35QUFOxrN5W: Bool = false
  @State private var retit9IErXGV8ZjCC0: String = ""
  @State private var recoontRO20RvMt7XuLY: String = ""
  @State private var errWjQKNrKqeQuJe: String?

  @FocusState private var focusedField: Field?

  enum Field: Hashable {
    case sceneU1K4wRfeNnrnI
    case styleXtwRAqUlv5bSD
    case seasonn6GCC7Kt1FsbA
    case additionalRequirements
  }

  private let aiService: AIservCkCeIgWDTOo9Qproc = AIservCkCeIgWDTOo9Q.shared

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  private var canStart: Bool {
    !sceneIq2MemYaRG9ID.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      && !style6ZDDe8xvnuVbx.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      && !seasonYY7u27U3XFDNo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      && !adtionno35myNqcElag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  var body: some View {
    ZStack {
      Image("Qc4hYFPT1LVSkXq5")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack {
        hecaPexQq7FLrjERH(
          HPwYq5w5v2Rjktitle:
            shrestQx35QUFOxrN5W
            ? "AI Clothing Assistant"
            : "To recommend the most suitable outfit plan for you, please fill in the following information.",
          fontSize: shrestQx35QUFOxrN5W ? 17 : 16
        )

        if shrestQx35QUFOxrN5W {
          VStack {
            resultCEILK7YnufpZz
              .padding(.top, 18)
              .padding(.bottom, 12)

            VStack(spacing: 0) {
              Button(action: {
                Task {
                  await genX6r5asuaINMPK()
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

                  if geingig215odKvYEed {
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
          inptformPw1nLRdIAZI2j
            .padding(.top, 20)
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
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var inptformPw1nLRdIAZI2j: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(alignment: .center, spacing: 24) {
          Group {
            inptsecIqusgyeNL8dtD(
              YZlWXIABplnjSlabel: "Scene:",
              hintaCTgVS7aktd6U: "Input the target scene",
              txtqZ57rwDDnNFdO: $sceneIq2MemYaRG9ID,
              fieldq1JOqRF10s2z0: .sceneU1K4wRfeNnrnI
            )

            inptsecIqusgyeNL8dtD(
              YZlWXIABplnjSlabel: "Style:",
              hintaCTgVS7aktd6U: "Input style",
              txtqZ57rwDDnNFdO: $style6ZDDe8xvnuVbx,
              fieldq1JOqRF10s2z0: .styleXtwRAqUlv5bSD
            )

            inptsecIqusgyeNL8dtD(
              YZlWXIABplnjSlabel: "Season:",
              hintaCTgVS7aktd6U: "Input the season",
              txtqZ57rwDDnNFdO: $seasonYY7u27U3XFDNo,
              fieldq1JOqRF10s2z0: .seasonn6GCC7Kt1FsbA
            )

            inptsecIqusgyeNL8dtD(
              YZlWXIABplnjSlabel: "Additional requirements:",
              hintaCTgVS7aktd6U: "Enter...",
              txtqZ57rwDDnNFdO: $adtionno35myNqcElag,
              fieldq1JOqRF10s2z0: .additionalRequirements
            )
          }

          VStack(spacing: 16) {
            Button(action: {
              Task {
                await genX6r5asuaINMPK()
              }
            }) {
              ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                  .fill(
                    Color("buttonPurple")
                  )
                  .frame(width: 240, height: 50)
                  .overlay(
                    RoundedRectangle(cornerRadius: 16)
                      .stroke(Color.white, lineWidth: 2)
                  )

                if geingig215odKvYEed {
                  ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                  Text("Start")
                    .font(.custom("FredokaOne-Regular", size: 22))
                    .foregroundColor(.white)
                }
              }
            }
            .disabled(!canStart || geingig215odKvYEed)

            if let errWjQKNrKqeQuJe = errWjQKNrKqeQuJe {
              Text(errWjQKNrKqeQuJe)
                .font(.system(size: 13))
                .foregroundColor(.red.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            }
          }
          .padding(.top, 12)
          .padding(.bottom, 40)
          .id("bottom")
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 100)
      }
      .scrollDismissesKeyboard(.interactively)
      .onChange(of: focusedField) {
        if focusedField != nil {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.3)) {
              proxy.scrollTo("bottom", anchor: .bottom)
            }
          }
        }
      }
    }
  }

  private var resultCEILK7YnufpZz: some View {
    ScrollView {
      VStack(alignment: .center, spacing: 24) {
        VStack(alignment: .leading, spacing: 16) {
          Text(retit9IErXGV8ZjCC0)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)

          Text(recoontRO20RvMt7XuLY)
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

  private func hecaPexQq7FLrjERH(HPwYq5w5v2Rjktitle: String, fontSize: CGFloat = 16) -> some View {
    ZStack(alignment: .bottomTrailing) {
      HStack(alignment: .bottom) {
        Text(HPwYq5w5v2Rjktitle)
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

  private func inptsecIqusgyeNL8dtD(
    YZlWXIABplnjSlabel: String,
    hintaCTgVS7aktd6U: String,
    txtqZ57rwDDnNFdO: Binding<String>,
    fieldq1JOqRF10s2z0: Field
  ) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(YZlWXIABplnjSlabel)
        .font(.custom("FredokaOne-Regular", size: 20))
        .foregroundColor(.white)
        .padding(.bottom, 8)

      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white.opacity(0.1))

        TextField("", text: txtqZ57rwDDnNFdO)
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .foregroundColor(.white)
          .font(.system(size: 15))
          .submitLabel(.done)
          .focused($focusedField, equals: fieldq1JOqRF10s2z0)

        if txtqZ57rwDDnNFdO.wrappedValue.isEmpty {
          Text(hintaCTgVS7aktd6U)
            .foregroundColor(.white.opacity(0.35))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
        }
      }
      .frame(height: 55)
    }
  }

  private func genX6r5asuaINMPK() async {
    guard !geingig215odKvYEed else { return }
    geingig215odKvYEed = true
    errWjQKNrKqeQuJe = nil

    let trimmedScene = sceneIq2MemYaRG9ID.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedStyle = style6ZDDe8xvnuVbx.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedSeason = seasonYY7u27U3XFDNo.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedAdditional = adtionno35myNqcElag.trimmingCharacters(in: .whitespacesAndNewlines)

    let res10MQtQ9jzpM7M = await aiService.fetchZo8oCPHSVeWHl(
      sceneU1K4wRfeNnrnI: trimmedScene,
      styleXtwRAqUlv5bSD: trimmedStyle,
      seasonn6GCC7Kt1FsbA: trimmedSeason,
      additionalRequirements: trimmedAdditional
    )

    await MainActor.run {
      switch res10MQtQ9jzpM7M {
      case .susccamK2ph7M7WkX(let contC22Np8fwAm9wf):
        retit9IErXGV8ZjCC0 =
          "\(trimmedStyle.isEmpty ? "Stylish" : trimmedStyle) outfits for \(trimmedScene.isEmpty ? "your day" : trimmedScene.lowercased())"
        recoontRO20RvMt7XuLY = contC22Np8fwAm9wf
        shrestQx35QUFOxrN5W = true
        errWjQKNrKqeQuJe = nil
      case .failFdvRecB9dfUuQ(let erri1Unn32wHHJC9):
        errWjQKNrKqeQuJe = erri1Unn32wHHJC9
        shrestQx35QUFOxrN5W = false
      }
      geingig215odKvYEed = false
    }
  }
}
