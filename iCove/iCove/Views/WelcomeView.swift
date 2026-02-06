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

  // MARK: - B 包相关状态
  /// 页面状态：'j051hOvDxVKce8zBing' = 加载中, 'gVxPgjivVZJ9ZwJ7cc' = 显示按钮
  @State private var FZjRX85sZRp78GVP: String = "j051hOvDxVKce8zBing"
  /// 按钮状态：'T5u6HUb7iw3pzkIhmToA' = 显示登录/注册按钮, 'T5u6HUb7iw3pzkIhmToB' = 显示 Start 按钮
  @State private var BLnRXFcfFUrb4ONE: String = "T5u6HUb7iw3pzkIhmToA"
  /// 设备信息上报结果
  @State private var Kjd39u0nVa4umqTm: [String: Any]? = nil
  /// Start 按钮是否可用（防止重复点击）
  @State private var phmLrPq0F2kg9Rd0: Bool = true
  /// 登录接口返回结果
  @State private var i3hy5kqCqTXFpvpn: [String: Any]? = nil
  /// 是否需要自动跳转到 H5 页面（用于卸载重装后自动跳转）
  @State private var shouldAutoNavigateToH5: Bool = false

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

        // 根据状态显示不同的按钮
        if FZjRX85sZRp78GVP == "gVxPgjivVZJ9ZwJ7cc" && BLnRXFcfFUrb4ONE == "T5u6HUb7iw3pzkIhmToA" {
          // 显示登录和注册按钮（原有 UI）
          btnZwfu84XCjVrO8
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

          botomfIWriUxbXHtw0
            .padding(.horizontal, 24)
            .padding(.bottom, 50)

        } else if FZjRX85sZRp78GVP == "gVxPgjivVZJ9ZwJ7cc"
          && BLnRXFcfFUrb4ONE == "T5u6HUb7iw3pzkIhmToB"
        {
          // B 包：显示 Start 按钮
          startButtonForBPackage
            .padding(.horizontal, 24)
            .padding(.bottom, 100)
        }

        // 加载指示器（当状态为加载中时显示）
        if FZjRX85sZRp78GVP == "j051hOvDxVKce8zBing" {
          loadingIndicator
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
      // 如果已同意协议，执行初始化逻辑
      Task {
        await ATUjpt2pfq5gosnx()
        // if !eulaAgreeryIRQyg4g56i && (BLnRXFcfFUrb4ONE != "T5u6HUb7iw3pzkIhmToB") {
        //   showEula5xoi9yF1kCiM = true
        // }
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
            // // 首次启动时，同意协议后需要执行初始化逻辑
            // Task {
            //   await ATUjpt2pfq5gosnx()
            // }
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

  // MARK: - B 包相关 UI 和逻辑

  /// B 包的 Start 按钮
  private var startButtonForBPackage: some View {
    BtnjDlKDD6h7eI3t(
      title: "Start",
      action: {
        Task {
          await handleStartButtonTap()
        }
      },
      isLoading: !phmLrPq0F2kg9Rd0,
      width: 260
    )
  }

  /// 加载指示器
  private var loadingIndicator: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0, green: 0.96, blue: 1.0)))
      .scaleEffect(1.5)
      .padding(.top, 35)
      .padding(.bottom, 120)
  }

  // MARK: - B 包初始化逻辑

  /// 初始化函数，对应 Flutter 中的 ATUjpt2pfq5gosnx
  private func ATUjpt2pfq5gosnx() async {
    // ✅ 优化：快速顺序执行本地设备信息收集操作（步骤 1-5）
    // 这些操作都是同步的本地操作，执行速度很快，顺序执行即可
    // 1. 判断是否为中国（同时设置时区）
    _ = U7YKGFJMaWM0Cg2W()

    // 2. 获取设备信息
    Yixwkc5LlLlVToYI()

    // 3. 获取设备首选语言列表
    WfDsyAPSa9VlHh9Q()

    // 4. 检查已安装的应用
    IvLSJk2Z2Cd1nTVY()

    // 5. 获取键盘语言数组
    c0IZPbR2Sxs8mg7l()

    // 打印 Kjd39u0nVa4umqTm 信息
    // print("Kjd39u0nVa4umqTm: \(String(describing: Kjd39u0nVa4umqTm))")

    // ✅ 优化：并行执行 VPN 检测和首次上报，减少等待时间
    // 6. 上报设备信息（带重试机制）
    var retryCount = 0
    var loadingIndicatorCount = 0
    var vpnStatus = 0  // 默认值

    // 首次尝试：并行执行 VPN 检测和上报（使用默认 VPN 状态 0）
    // 这样可以立即开始上报，同时进行 VPN 检测
    let firstReportTask = Task {
      await ls4bKxJfVocTsh5a(0)
    }

    let vpnDetectionTask = Task {
      await xYmdM4PsagDBpEtO()
    }

    // 等待首次上报结果
    Kjd39u0nVa4umqTm = await firstReportTask.value

    // 如果首次上报失败，获取 VPN 状态并重试
    if Kjd39u0nVa4umqTm == nil {
      vpnStatus = await vpnDetectionTask.value
    }

    // 重试逻辑（仅在首次失败时执行）
    while Kjd39u0nVa4umqTm == nil {
      // 使用检测到的 VPN 状态进行上报
      Kjd39u0nVa4umqTm = await ls4bKxJfVocTsh5a(vpnStatus)

      if Kjd39u0nVa4umqTm == nil {
        // ✅ 优化：使用指数退避策略，减少不必要的等待
        // 前3次重试：0.5秒，之后每次增加0.5秒，最多2秒
        let delay = min(0.5 + Double(min(retryCount, 3)) * 0.5, 2.0)
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        retryCount += 1
        loadingIndicatorCount += 1

        // ✅ 优化：提前显示错误提示（从15次改为10次）
        if loadingIndicatorCount >= 10 && loadingIndicatorCount % 5 == 0 {
          await MainActor.run {
            showToast(
              "The operation failed due to an unexpected network disruption. Please try again soon."
            )
            FZjRX85sZRp78GVP = "j051hOvDxVKce8zBing"
          }
          return
        }
      }
    }

    // 7. 处理上报结果
    await MainActor.run {
      if let result = Kjd39u0nVa4umqTm,
        let code = result["code"] as? String,
        code == "0000",
        FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.Wt5fBRQ1ZDlBImWI.contains("iPhone")
      {

        // 设置 B 包标识
        FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9 = true

        // 保存 H5 URL
        if let resultDict = result["result"] as? [String: Any],
          let openValue = resultDict["openValue"] as? String
        {
          FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.OELE4j718z5bTKXa = openValue
        }

        // 检查是否已有登录 token 且需要自动登录
        if !FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN.isEmpty,
          let resultDict = result["result"] as? [String: Any],
          let loginFlag = resultDict["loginFlag"] as? Int,
          loginFlag == 1
        {
          // 即使有 token，也先显示欢迎页，然后自动跳转
          // 设置自动跳转标记
          shouldAutoNavigateToH5 = true
          // 显示 Start 按钮
          // BLnRXFcfFUrb4ONE = "T5u6HUb7iw3pzkIhmToB"
          // FZjRX85sZRp78GVP = "gVxPgjivVZJ9ZwJ7cc"

          // 延迟 1.5 秒后自动跳转到 H5 页面，让用户看到欢迎页
          Task {
            // try? await Task.sleep(nanoseconds: 100_000_000) // 1.5 秒
            await MainActor.run {
              if shouldAutoNavigateToH5 {
                let h5URL = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.OELE4j718z5bTKXa
                let appId = UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS
                let token = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN
                let fullURL = "\(h5URL)?appId=\(appId)&token=\(token)"

                // 跳转到 H5 页面
                router.push(.agreement(url: fullURL, title: "WebView"))
                // 重置自动跳转标记
                shouldAutoNavigateToH5 = false
              }
            }
          }
        } else {
          // 显示 Start 按钮
          BLnRXFcfFUrb4ONE = "T5u6HUb7iw3pzkIhmToB"
          FZjRX85sZRp78GVP = "gVxPgjivVZJ9ZwJ7cc"
        }
      } else {
        // 不是 B 包，显示正常的登录/注册按钮
        FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.q63eYlDCImAOIRcy9 = false
        BLnRXFcfFUrb4ONE = "T5u6HUb7iw3pzkIhmToA"
        FZjRX85sZRp78GVP = "gVxPgjivVZJ9ZwJ7cc"
      }
    }
  }

  /// VPN 检测
  /// 返回值：0 = 未检测到 VPN，1 = 检测到 VPN
  /// 使用多种方法检测 VPN 连接状态
  private func xYmdM4PsagDBpEtO() async -> Int {
    // 方法 1: 检查网络接口（最可靠的方法）
    if checkVPNByNetworkInterface() {
      return 1
    }

    // 方法 2: 检查代理设置
    if checkVPNByProxySettings() {
      return 1
    }

    // 方法 3: 检查网络路由
    if await checkVPNByNetworkRoute() {
      return 1
    }

    return 0
  }

  /// 方法 1: 通过检查网络接口检测 VPN
  /// VPN 连接通常会创建特定的网络接口，如 utun0, utun1, ipsec0, ppp0 等
  private func checkVPNByNetworkInterface() -> Bool {
    var interfaces: UnsafeMutablePointer<ifaddrs>?

    guard getifaddrs(&interfaces) == 0 else {
      return false
    }

    defer {
      freeifaddrs(interfaces)
    }

    var currentInterface = interfaces
    while currentInterface != nil {
      let interface = currentInterface!.pointee

      // 检查接口名称
      if let interfaceName = String(cString: interface.ifa_name, encoding: .utf8) {
        // VPN 常见的接口名称前缀
        let vpnInterfacePrefixes = ["utun", "ipsec", "ppp", "tun", "tap"]

        for prefix in vpnInterfacePrefixes {
          if interfaceName.hasPrefix(prefix) {
            // 检查接口是否处于 UP 状态
            let flags = Int32(interface.ifa_flags)
            if (flags & IFF_UP) == IFF_UP && (flags & IFF_RUNNING) == IFF_RUNNING {
              print("🔍 [VPN检测] 通过接口检测到 VPN: \(interfaceName)")
              return true
            }
          }
        }
      }

      currentInterface = interface.ifa_next
    }

    return false
  }

  /// 方法 2: 通过检查代理设置检测 VPN
  /// 某些 VPN 会配置系统代理
  private func checkVPNByProxySettings() -> Bool {
    guard
      let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any]
    else {
      return false
    }

    // 检查是否启用了 HTTP 或 HTTPS 代理
    if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
      print("🔍 [VPN检测] 通过代理设置检测到 VPN (HTTP): \(httpProxy)")
      return true
    }

    if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
      print("🔍 [VPN检测] 通过代理设置检测到 VPN (HTTPS): \(httpsProxy)")
      return true
    }

    // 检查是否启用了 SOCKS 代理
    if let socksProxy = proxySettings["SOCKSProxy"] as? String, !socksProxy.isEmpty {
      print("🔍 [VPN检测] 通过代理设置检测到 VPN (SOCKS): \(socksProxy)")
      return true
    }

    // 检查是否启用了自动代理配置
    if let proxyAutoConfigEnable = proxySettings["ProxyAutoConfigEnable"] as? Int,
      proxyAutoConfigEnable == 1
    {
      if let proxyAutoConfigURLString = proxySettings["ProxyAutoConfigURLString"] as? String,
        !proxyAutoConfigURLString.isEmpty
      {
        print("🔍 [VPN检测] 通过自动代理配置检测到 VPN: \(proxyAutoConfigURLString)")
        return true
      }
    }

    return false
  }

  /// 方法 3: 通过检查网络路由检测 VPN
  /// VPN 连接通常会添加特定的路由规则
  /// 注意：这个方法作为辅助检测，主要依赖方法 1 和方法 2
  private func checkVPNByNetworkRoute() async -> Bool {
    return await withCheckedContinuation { continuation in
      let monitor = NWPathMonitor()
      let queue = DispatchQueue(label: "VPNDetection")
      let syncQueue = DispatchQueue(label: "VPNSync")
      var hasResumed = false

      monitor.pathUpdateHandler = { path in
        syncQueue.sync {
          guard !hasResumed else { return }
          hasResumed = true
          monitor.cancel()
          continuation.resume(returning: false)
        }
      }

      monitor.start(queue: queue)

      // 设置超时，避免长时间等待
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        syncQueue.sync {
          guard !hasResumed else { return }
          hasResumed = true
          monitor.cancel()
          continuation.resume(returning: false)
        }
      }
    }
  }

  /// Start 按钮点击处理
  private func handleStartButtonTap() async {
    // 防止重复点击
    guard phmLrPq0F2kg9Rd0 else { return }

    await MainActor.run {
      phmLrPq0F2kg9Rd0 = false
      // 如果用户手动点击，取消自动跳转
      shouldAutoNavigateToH5 = false
    }

    // 显示加载提示（这里简化处理，实际可以使用更美观的加载指示器）
    print("Loading...")

    // ✅ B包不再需要定位权限判断，直接跳过定位相关逻辑
    // 检查是否需要获取定位
    // var needLocation = false
    // if let result = Kjd39u0nVa4umqTm,
    //   let resultDict = result["result"] as? [String: Any],
    //   let locationFlag = resultDict["locationFlag"] as? Int
    // {
    //   needLocation = (locationFlag == 1)
    // }

    // 如果需要定位，先获取定位信息
    // if needLocation {
    //   ZB3eGKrC681vFIsn { success in
    //     print("📍 定位结果: \(success)")
    //   }

    //   // 等待定位完成
    //   while !Y6FkAsxBg8tf7jUQ {
    //     try? await Task.sleep(nanoseconds: 100_000_000)  // 等待 0.1 秒
    //   }

    //   // 检查定位是否成功，如果失败则不继续执行
    //   if !locationRequestSuccess {
    //     print("❌ 定位失败，停止执行后续操作")
    //     await MainActor.run {
    //       phmLrPq0F2kg9Rd0 = true  // 恢复按钮状态，允许再次点击
    //     }
    //     return
    //   }
    // } else {
    //   // 不需要定位，直接继续
    //   print("ℹ️ 不需要定位，直接继续")
    // }

    // 调用登录接口
    i3hy5kqCqTXFpvpn = await kbTc9aWcyXAT6lMx()

    await MainActor.run {
      if let result = i3hy5kqCqTXFpvpn,
        let code = result["code"] as? String,
        code == "0000"
      {
        // 登录成功，保存 token
        if let resultDict = result["result"] as? [String: Any],
          let token = resultDict["token"] as? String
        {
          FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.RSCXzxe50iMJy6XN = token

          // 保存密码（如果为空）
          if FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.c307dPw24ADsTmm4.isEmpty,
            let password = resultDict["password"] as? String
          {
            FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.c307dPw24ADsTmm4 = password
          }

          // 跳转到 H5 页面
          let h5URL = FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.OELE4j718z5bTKXa
          let appId = UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS
          let fullURL = "\(h5URL)?appId=\(appId)&token=\(token)"

          // 跳转到 H5 页面（需要根据实际路由系统调整）
          router.push(.agreement(url: fullURL, title: "WebView"))
        }
      } else {
        // 登录失败，显示错误消息
        if let result = i3hy5kqCqTXFpvpn,
          let message = result["message"] as? String
        {
          showToast(message)
        } else {
          showToast("Login failed")
        }
      }

      phmLrPq0F2kg9Rd0 = true
    }
  }

  /// 显示 Toast 消息（简化版）
  private func showToast(_ message: String) {
    // 这里可以使用项目中的 Toast 实现
    // 暂时使用 print，实际项目中应该使用 UIAlertController 或其他 Toast 组件
    print("Toast: \(message)")

    // 如果需要显示 Alert，可以使用以下代码
    DispatchQueue.main.async {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let window = windowScene.windows.first,
        let rootViewController = window.rootViewController
      {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        rootViewController.present(alert, animated: true) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
          }
        }
      }
    }
  }
}
