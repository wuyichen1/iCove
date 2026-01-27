//
//  WelcomeView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct WelcomeView: View {
  @EnvironmentObject var ayIqvfBR4TwQOWd: AuthenticationManager
  @EnvironmentObject var router: Router
  @State private var emloginYuHtY3QnSdwzD = false
  @State private var signupcu6miHNMEZWff = false
  @State private var agreesdFfu5VG1Fq89 = true
  @State private var shoAgraletFqT6q5c4OQ2pp = false
  @State private var quicloginVTaKp6fjNjPJH = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      bggrad7ERvGp4EvdAkM

      VStack(spacing: 0) {
        HStack(alignment: .top, spacing: 0) {
          VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 60)

            logo6rST6xtvmG83E
              .padding(.bottom, 60)
            Spacer()
          }
          Spacer()
        }
        .padding(.leading, 40)

        btnZwfu84XCjVrO8
          .padding(.horizontal, 24)
          .padding(.bottom, 24)

        botomfIWriUxbXHtw0
          .padding(.horizontal, 24)
          .padding(.bottom, 50)
      }
    }
    .fullScreenCover(isPresented: $emloginYuHtY3QnSdwzD) {
      AuthenticationView(initialMode: .signIn)
        .environmentObject(ayIqvfBR4TwQOWd)
    }
    .fullScreenCover(isPresented: $signupcu6miHNMEZWff) {
      AuthenticationView(initialMode: .signUp)
        .environmentObject(ayIqvfBR4TwQOWd)
    }
    .alert("Protocol Warning", isPresented: $shoAgraletFqT6q5c4OQ2pp) {
      Button("OK", role: .cancel) {}
    } message: {
      Text("Please agree to the user agreement and privacy policy before continuing")
    }

    #if DEBUG
      .enableInjection()
    #endif
  }

  private var bggrad7ERvGp4EvdAkM: some View {
    ZStack {
      Image("jK792W9HOGn9U1z3")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

    }
  }

  private var logo6rST6xtvmG83E: some View {
    VStack(spacing: 16) {
      Image("icove_logo")
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(radius: 5)

      Text("iCove")
        .font(.custom("FredokaOne-Regular", size: 26))
        .foregroundColor(.white)
    }
  }

  private var btnZwfu84XCjVrO8: some View {
    VStack(spacing: 16) {
      PrimaryButton(
        title: "Login by email",
        action: {
          hanloggvcL4pkeajAUk()
        },
        width: 260,
      )
      PrimaryButton(
        title: "I'm new",
        action: {
          hannew5V3fPnmA7jUU5()
        },
        isLoading: quicloginVTaKp6fjNjPJH,
        width: 260,
        backgroundColor: Color("btnpink"),
      )
    }
  }

  private var botomfIWriUxbXHtw0: some View {
    VStack(spacing: 60) {
      Button(action: {
        hanupHomtEiBw2T4Aq()
      }) {
        HStack(spacing: 4) {
          Text("Don't have an account?")
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(.trailing, 4)
          Text("Sign up")
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .underline()
        }
        .font(.system(size: 14))
      }

      HStack(spacing: 8) {
        Button(action: {
          agreesdFfu5VG1Fq89.toggle()
        }) {
          Image(systemName: agreesdFfu5VG1Fq89 ? "checkmark.square.fill" : "square")
            .foregroundColor(.white)
            .font(.system(size: 16))
        }

        HStack(spacing: 4) {
          Text("Agree with")
            .foregroundColor(.white)
            .font(.system(size: 12))

          Button(action: {
            router.push(
              .agreement(url: "https://app.li65pe2f.link/users", title: "User Agreement"))
          }) {
            Text("User Agreement")
              .foregroundColor(.white)
              .underline()
              .font(.system(size: 12))
          }

          Text("and")
            .foregroundColor(.white)
            .font(.system(size: 12))

          Button(action: {
            router.push(
              .agreement(url: "https://app.li65pe2f.link/privacy", title: "Privacy Policy"))
          }) {
            Text("Privacy Policy")
              .foregroundColor(.white)
              .underline()
              .font(.system(size: 12))
          }
        }
      }
    }
  }

  private func hanloggvcL4pkeajAUk() {
    if agreesdFfu5VG1Fq89 {
      emloginYuHtY3QnSdwzD = true
    } else {
      shoAgraletFqT6q5c4OQ2pp = true
    }
  }

  private func hanupHomtEiBw2T4Aq() {
    if agreesdFfu5VG1Fq89 {
      signupcu6miHNMEZWff = true
    } else {
      shoAgraletFqT6q5c4OQ2pp = true
    }
  }

  private func hannew5V3fPnmA7jUU5() {
    if agreesdFfu5VG1Fq89 {
      Task {
        quicloginVTaKp6fjNjPJH = true
        await hanquickC7Qqgoa8yAcW3()
        quicloginVTaKp6fjNjPJH = false
      }
    } else {
      shoAgraletFqT6q5c4OQ2pp = true
    }
  }

  private func hanquickC7Qqgoa8yAcW3() async {
    do {
      try await ayIqvfBR4TwQOWd.quickLogin()
    } catch {
      print("Quick login error: \(error)")
    }
  }
}

// #Preview {
//     WelcomeView()
//         .environmentObject(AuthenticationManager())
// }
