//
//  ReportywNvhJra7xXCDView.swift
//  iCove
//
//  Created by yangyang on 2026/1/22.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

enum RepOpt99DIA5JdHxK8b: String, CaseIterable {
  case vulgarPornography = "Vulgar pornography"
  case violentBloody = "Violent and bloody"
  case infringementPlagiarism = "Infringement and plagiarism"
  case maliciousHarassment = "Malicious harassment"
  case others = "Others"

  var ywNvhJra7xXCD: String {
    return rawValue
  }
}

struct ReportywNvhJra7xXCDView: View {
  let userId: String
  @EnvironmentObject var router: Router
  @State private var selTziV60YH9YAzS: RepOpt99DIA5JdHxK8b? = RepOpt99DIA5JdHxK8b.allCases.first
  @State private var isbing5uHlkOkMVKDtt: Bool = false
  @State private var shsuctoZ6GV7gehCO1: Bool = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 0) {
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

        Text("Select the report option")
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color("btnpink"))
          .padding(.horizontal, 20)
          .padding(.top, 30)
          .padding(.bottom, 30)

        ScrollView {
          VStack(spacing: 18) {
            ForEach(RepOpt99DIA5JdHxK8b.allCases, id: \.self) { option in
              rebtn2CUT8jgtNlD58(optB63sHWmtfkfeI: option)
            }
          }
          .padding(.horizontal, 20)
        }

        Spacer()

        HStack {
          Spacer()

          Button(action: {
            submitU3cx9isAhohiY()
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
          .disabled(selTziV60YH9YAzS == nil || isbing5uHlkOkMVKDtt)
          .opacity(selTziV60YH9YAzS == nil ? 0.5 : 1.0)

          Spacer()

        }

      }
    }
    .alert(isPresented: $shsuctoZ6GV7gehCO1) {
      Alert(
        title: Text("Report submitted successfully"),
        message: nil,
        dismissButton: nil
      )
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private func rebtn2CUT8jgtNlD58(optB63sHWmtfkfeI: RepOpt99DIA5JdHxK8b) -> some View {
    Button(action: {
      selTziV60YH9YAzS = optB63sHWmtfkfeI
    }) {
      Text(optB63sHWmtfkfeI.ywNvhJra7xXCD)
        .font(.system(size: 16, weight: .medium))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(Color.white)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
              selTziV60YH9YAzS == optB63sHWmtfkfeI
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

  private func submitU3cx9isAhohiY() {
    isbing5uHlkOkMVKDtt = true

    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)

      await MainActor.run {
        isbing5uHlkOkMVKDtt = false
        shsuctoZ6GV7gehCO1 = true

        Task {
          try? await Task.sleep(nanoseconds: 1_500_000_000)
          await MainActor.run {
            shsuctoZ6GV7gehCO1 = false
            router.pop()
          }
        }
      }
    }
  }
}
