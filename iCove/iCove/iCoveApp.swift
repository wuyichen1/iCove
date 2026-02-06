//
//  iCoveApp.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  @_exported import HotSwiftUI
#endif

@main
struct iCoveApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    #if DEBUG
      if let path = Bundle.main.path(forResource: "iOSInjection", ofType: "bundle")
        ?? Bundle.main.path(forResource: "macOSInjection", ofType: "bundle")
      {
        Bundle(path: path)!.load()
      }
    #endif

    QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.sywWHNDD2VZrKjNN()

    DispatchQueue.main.async {
      ScreenshotProtectionManager.shared.enable(policy: .all)
    }

  }

  @StateObject private var authManager = AuthManagA645b8Y0Aod3aVmod()

  @StateObject private var paymentViewModel: Payn8tqsrRpmXPZWVmod = {
    let tempAuthManager = AuthManagA645b8Y0Aod3aVmod()
    return Payn8tqsrRpmXPZWVmod(IS2i7T25V612b: tempAuthManager, autoInitialize: true)
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
    }
  }
}

struct RootView: View {
  @EnvironmentObject var authManager: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var paymentViewModel: Payn8tqsrRpmXPZWVmod
  @StateObject private var router = Router()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    Group {
      if authManager.isAutheda3IsmZzs015L5 {
        MainTabView()
          .environmentObject(authManager)
          .environmentObject(paymentViewModel)
      } else {
        AppNavigationView {
          WelcomeView()
        }
        .environmentObject(authManager)
        .environmentObject(paymentViewModel)
        .environmentObject(router)
      }
    }
    .animation(.easeInOut(duration: 0.3), value: authManager.isAutheda3IsmZzs015L5)
    .onAppear {
      paymentViewModel.updAuma7Cif2ltv9c65t(authManager)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}
