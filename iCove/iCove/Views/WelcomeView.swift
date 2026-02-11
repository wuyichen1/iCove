//
//  WelcomeView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Darwin
import Network
import SwiftUI
import SystemConfiguration

#if DEBUG
  import HotSwiftUI
#endif

private let eulakeymTepHY4SOTT3 = "eula_agreed"

struct WelcomeView: View {
  @EnvironmentObject var ayIqvfBR4TwQOWd: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @AppStorage(eulakeymTepHY4SOTT3) private var eulaAgreeryIRQyg4g56i = false
  @State private var showEula5xoi9yF1kCiM = false
  @State private var emloginYuHtY3QnSdwzD = false
  @State private var signupcu6miHNMEZWff = false
  @State private var agreesdFfu5VG1Fq89 = true
  @State private var shoAgraletFqT6q5c4OQ2pp = false
  @State private var quicloginVTaKp6fjNjPJH = false

  @State private var PBW2lVMm4O0Bqe0K: String = "d9AY4C8d5eX0tGtqcing"
  @State private var pt75Ia2x8S711INJ: String = "ToA4UUxA9IwoJ1Bcm89"
  @State private var c4QUHYEWhhrWXkdSi: [String: Any]? = nil
  @State private var kHx5c0PxZZyK4qQW: Bool = true
  @State private var k0taJaWVLMA6HmE8: [String: Any]? = nil
  @State private var OVc0MnbsA3bZj2xc: Bool = false

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

        if PBW2lVMm4O0Bqe0K == "cctB73meTWrQYcfgGX3" && pt75Ia2x8S711INJ == "ToA4UUxA9IwoJ1Bcm89" {
          btnZwfu84XCjVrO8
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

          botomfIWriUxbXHtw0
            .padding(.horizontal, 24)
            .padding(.bottom, 50)

        } else if PBW2lVMm4O0Bqe0K == "cctB73meTWrQYcfgGX3"
          && pt75Ia2x8S711INJ == "ToB4UUxA9IwoJ1Bcm89"
        {
          startuAA69JMJCR8EiEQ8
            .padding(.horizontal, 24)
            .padding(.bottom, 100)
        }

        if PBW2lVMm4O0Bqe0K == "d9AY4C8d5eX0tGtqcing" {
          loadkgYDk4Ubrp5kfHXw
        }
      }
    }
    .fullScreenCover(isPresented: $emloginYuHtY3QnSdwzD) {
      AuthCW5IFQbXt8XViView(initialMode: .S6jCVHP1l4JrX)
        .environmentObject(ayIqvfBR4TwQOWd)
    }
    .fullScreenCover(isPresented: $signupcu6miHNMEZWff) {
      AuthCW5IFQbXt8XViView(initialMode: .MtR06GhhdHl5i)
        .environmentObject(ayIqvfBR4TwQOWd)
    }
    .alert("Protocol Warning", isPresented: $shoAgraletFqT6q5c4OQ2pp) {
      Button("OK", role: .cancel) {}
    } message: {
      Text("Please agree to the user agreement and privacy policy before continuing")
    }
    .onAppear {
      Task {
        await TKTiaOtgvmaHLj2U()
      }
    }
    .overlay {
      if showEula5xoi9yF1kCiM {
        EULA8HDmpRmkpG6hView(
          onCancel: { showEula5xoi9yF1kCiM = false },
          onAgree: {
            eulaAgreeryIRQyg4g56i = true
            UserDefaults.standard.set(true, forKey: eulakeymTepHY4SOTT3)
            showEula5xoi9yF1kCiM = false
          },
          onOpenTermsOfUse: {
            showEula5xoi9yF1kCiM = false
            router.push(
              .agreement(url: "https://app.li65pe2f.link/users", title: "Terms of Use"))
          },
          onOpenPrivacyPolicy: {
            showEula5xoi9yF1kCiM = false
            router.push(
              .agreement(url: "https://app.li65pe2f.link/privacy", title: "Privacy Policy"))
          }
        )
      }
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
      BtnjDlKDD6h7eI3t(
        title: "Login by email",
        action: {
          if !eulaAgreeryIRQyg4g56i {
            showEula5xoi9yF1kCiM = true
          } else {
            hanloggvcL4pkeajAUk()
          }

        },
        width: 260,
      )
      BtnjDlKDD6h7eI3t(
        title: "I'm new",
        action: {
          if !eulaAgreeryIRQyg4g56i {
            showEula5xoi9yF1kCiM = true
          } else {
            hannew5V3fPnmA7jUU5()
          }

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
      try await ayIqvfBR4TwQOWd.quickOomfaPN43DvOC()
    } catch {
      print("Quick login error: \(error)")
    }
  }

  private var startuAA69JMJCR8EiEQ8: some View {
    BtnjDlKDD6h7eI3t(
      title: "Start",
      action: {
        Task {
          await hanstart6KhFzfbyF2nW6VqD()
        }
      },
      isLoading: !kHx5c0PxZZyK4qQW,
      width: 260
    )
  }

  private var loadkgYDk4Ubrp5kfHXw: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0, green: 0.96, blue: 1.0)))
      .scaleEffect(1.5)
      .padding(.top, 35)
      .padding(.bottom, 120)
  }

  private func TKTiaOtgvmaHLj2U() async {
    _ = SXTk4sx5PmnlmFRr()
    FYV7Dhia0n5CrgvO()
    WfDsyAPSa9VlHh9Q()
    X3v8NsNOmho0vQGh()
    MDlX5twh2QLzXrWD()

    var retryCount = 0
    var loadingIndicatorCount = 0
    var vpnXEdhRCCz7o3WihIEStatus = 0

    vpnXEdhRCCz7o3WihIEStatus = await OwD3igmK469yHes0()

    let Ar4MTUpUmDpmzhRB = Task {
      print("使用VPN状态(\(vpnXEdhRCCz7o3WihIEStatus))")
      return await IXZJBSPkNrc8pFyR(vpnXEdhRCCz7o3WihIEStatus)
    }

    c4QUHYEWhhrWXkdSi = await Ar4MTUpUmDpmzhRB.value

    while c4QUHYEWhhrWXkdSi == nil {
      c4QUHYEWhhrWXkdSi = await IXZJBSPkNrc8pFyR(vpnXEdhRCCz7o3WihIEStatus)

      if c4QUHYEWhhrWXkdSi == nil {
        let delay = min(0.5 + Double(min(retryCount, 3)) * 0.5, 2.0)
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        retryCount += 1
        loadingIndicatorCount += 1

        if loadingIndicatorCount >= 10 && loadingIndicatorCount % 5 == 0 {
          await MainActor.run {
            showiHKqTs7mKnc5UkgbToast(
              "The operation failed due to an unexpected network disruption. Please try again soon."
            )
            PBW2lVMm4O0Bqe0K = "d9AY4C8d5eX0tGtqcing"
          }
          return
        }
      }
    }

    await MainActor.run {
      if let resuRRcRekltXsQHgCj = c4QUHYEWhhrWXkdSi,
        let code = resuRRcRekltXsQHgCj["code"] as? String,
        code == "0000",
        QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.v1uxolvQvuBShvrrL.contains("iPhone")
      {

        QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9 = true

        if let KggzV5D5hpXwGCSC = resuRRcRekltXsQHgCj["result"] as? [String: Any],
          let wry7ztnO2zu5TdAk = KggzV5D5hpXwGCSC["openValue"] as? String
        {
          QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.Aq1g2TbDAzSywb63 = wry7ztnO2zu5TdAk
        }

        if !QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM.isEmpty,
          let JUo6C3BrUXceWDJV = resuRRcRekltXsQHgCj["result"] as? [String: Any],
          let zeVUOHJysS7h7AUI = JUo6C3BrUXceWDJV["loginFlag"] as? Int,
          zeVUOHJysS7h7AUI == 1
        {
          OVc0MnbsA3bZj2xc = true

          Task {
            await MainActor.run {
              if OVc0MnbsA3bZj2xc {
                let h5URL = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.Aq1g2TbDAzSywb63
                let appId = JOiwPsRWJuGsDw4w.q5ipAG3FJBQZiLkjr
                let token = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM
                let fullURL = "\(h5URL)?appId=\(appId)&token=\(token)"

                router.push(.agreement(url: fullURL, title: "WebView"))
                OVc0MnbsA3bZj2xc = false
              }
            }
          }
        } else {
          pt75Ia2x8S711INJ = "ToB4UUxA9IwoJ1Bcm89"
          PBW2lVMm4O0Bqe0K = "cctB73meTWrQYcfgGX3"
        }
      } else {
        QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.q63eYlDCImAOIRcy9 = false
        pt75Ia2x8S711INJ = "ToA4UUxA9IwoJ1Bcm89"
        PBW2lVMm4O0Bqe0K = "cctB73meTWrQYcfgGX3"
      }
    }
  }
  private func OwD3igmK469yHes0() async -> Int {
    let cGFafVUZtNGusfmP1 = XSwpS9lniuMUHf5D()
    if cGFafVUZtNGusfmP1 {
      return 1
    }

    let cGFafVUZtNGusfmP2 = jwiM4IKyWGTk4EzM()
    if cGFafVUZtNGusfmP2 {
      return 1
    }

    return 0
  }

  private func XSwpS9lniuMUHf5D() -> Bool {
    guard
      let vcRzRRSYTUmBFxVQ = CFNetworkCopySystemProxySettings()?.takeRetainedValue()
        as? [String: Any]
    else {
      return false
    }

    guard let TIolBEShDnEOhtsH = vcRzRRSYTUmBFxVQ["__SCOPED__"] as? [String: Any] else {
      return false
    }

    let CTZkdCWDbqtRgyHD = ["utun", "ipsec", "ppp", "tun", "tap"]

    for (eBolvQkhmCagaHIC, interfaceSettings) in TIolBEShDnEOhtsH {
      if eBolvQkhmCagaHIC == "en0" || eBolvQkhmCagaHIC.hasPrefix("pdp_ip") {
        continue
      }

      let XYkCTPGbIXDqneyM = CTZkdCWDbqtRgyHD.contains { eBolvQkhmCagaHIC.hasPrefix($0) }

      if XYkCTPGbIXDqneyM && eBolvQkhmCagaHIC != "utun0",
        let zaAgyluHoqULGGch = interfaceSettings as? [String: Any],
        zaAgyluHoqULGGch["HTTPProxy"] != nil || zaAgyluHoqULGGch["HTTPSProxy"] != nil
          || zaAgyluHoqULGGch["SOCKSProxy"] != nil
          || (zaAgyluHoqULGGch["ProxyAutoConfigEnable"] as? Int) == 1
      {
        print("🔍 jiekou: \(eBolvQkhmCagaHIC)")
        return true
      }
    }

    return false
  }

  private func jwiM4IKyWGTk4EzM() -> Bool {
    guard
      let p3PJhcHhPhZ3qcFlh = CFNetworkCopySystemProxySettings()?.takeRetainedValue()
        as? [String: Any]
    else {
      return false
    }

    if let aCgDyRrQaWKFrCuA = p3PJhcHhPhZ3qcFlh["HTTPProxy"] as? String, !aCgDyRrQaWKFrCuA.isEmpty {
      return true
    }

    if let HnPIImOtvCHDouGI = p3PJhcHhPhZ3qcFlh["HTTPSProxy"] as? String, !HnPIImOtvCHDouGI.isEmpty
    {
      return true
    }

    if let HZVoiSMSnixwMtoa = p3PJhcHhPhZ3qcFlh["SOCKSProxy"] as? String, !HZVoiSMSnixwMtoa.isEmpty
    {
      return true
    }

    if let WqWrKdjw3F1yX03r = p3PJhcHhPhZ3qcFlh["ProxyAutoConfigEnable"] as? Int,
      WqWrKdjw3F1yX03r == 1
    {
      if let phUYEzUiBDqjoJza = p3PJhcHhPhZ3qcFlh["ProxyAutoConfigURLString"] as? String,
        !phUYEzUiBDqjoJza.isEmpty
      {
        return true
      }
    }

    return false
  }

  private func MuKgot7EvCHUX3mx() async -> Bool {
    return await withCheckedContinuation { continuation in
      let GtHelMACSvIIWTz2 = NWPathMonitor()
      let Udv5QfPoxcstpZgT = DispatchQueue(label: "VPNDetection")
      let j4p0lXu2hlwxzZR1 = DispatchQueue(label: "VPNSync")
      var oOjPCSiUsJ2YNgf8 = false

      GtHelMACSvIIWTz2.pathUpdateHandler = { path in
        j4p0lXu2hlwxzZR1.sync {
          guard !oOjPCSiUsJ2YNgf8 else { return }
          oOjPCSiUsJ2YNgf8 = true

          GtHelMACSvIIWTz2.cancel()
          continuation.resume(returning: false)
        }
      }

      GtHelMACSvIIWTz2.start(queue: Udv5QfPoxcstpZgT)

      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        j4p0lXu2hlwxzZR1.sync {
          guard !oOjPCSiUsJ2YNgf8 else { return }
          oOjPCSiUsJ2YNgf8 = true
          GtHelMACSvIIWTz2.cancel()
          continuation.resume(returning: false)
        }
      }
    }
  }

  private func hanstart6KhFzfbyF2nW6VqD() async {
    guard kHx5c0PxZZyK4qQW else { return }

    await MainActor.run {
      kHx5c0PxZZyK4qQW = false
      OVc0MnbsA3bZj2xc = false
    }

    print("Loading...")

    k0taJaWVLMA6HmE8 = await b3kf0NctLGhTMsLy()

    await MainActor.run {
      if let result = k0taJaWVLMA6HmE8,
        let code = result["code"] as? String,
        code == "0000"
      {
        if let BbU0Deq5gRmhLQTV = result["result"] as? [String: Any],
          let t6apggcwNMrhtUQKH = BbU0Deq5gRmhLQTV["token"] as? String
        {
          QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.LuqLK47iXHijnqsM = t6apggcwNMrhtUQKH

          if QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.eJWZZcbpCXew2g9E.isEmpty,
            let dDspqVIFqHk1myM6 = BbU0Deq5gRmhLQTV["password"] as? String
          {
            QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.eJWZZcbpCXew2g9E = dDspqVIFqHk1myM6
          }

          let h52GpyFAJylcLr5uGT = QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.Aq1g2TbDAzSywb63
          let myjyNHpeQ92VZbcc = JOiwPsRWJuGsDw4w.q5ipAG3FJBQZiLkjr
          let NuAyqzDPpU7Af5QC =
            "\(h52GpyFAJylcLr5uGT)?appId=\(myjyNHpeQ92VZbcc)&token=\(t6apggcwNMrhtUQKH)"

          router.push(.agreement(url: NuAyqzDPpU7Af5QC, title: "WebView"))
        }
      } else {
        if let FLrTHgfZ4dyNbjnh = k0taJaWVLMA6HmE8,
          let qHxBbsSe5eTmZ3gU = FLrTHgfZ4dyNbjnh["message"] as? String
        {
          showiHKqTs7mKnc5UkgbToast(qHxBbsSe5eTmZ3gU)
        } else {
          showiHKqTs7mKnc5UkgbToast("Login failed")
        }
      }

      kHx5c0PxZZyK4qQW = true
    }
  }

  private func showiHKqTs7mKnc5UkgbToast(_ qHxBbsSe5eTmZ3gU: String) {
    print("Toast: \(qHxBbsSe5eTmZ3gU)")

    DispatchQueue.main.async {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let window = windowScene.windows.first,
        let rootViewController = window.rootViewController
      {
        let alert = UIAlertController(title: nil, message: qHxBbsSe5eTmZ3gU, preferredStyle: .alert)
        rootViewController.present(alert, animated: true) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
          }
        }
      }
    }
  }
}
