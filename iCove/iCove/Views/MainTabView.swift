//
//  MainTabView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct MainTabView: View {
  @EnvironmentObject var aumaxK8ji8QR9Bmeq: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var paymentViewModel: Payn8tqsrRpmXPZWVmod
  @StateObject private var router = Router()
  @State private var selectedTab: TabHTktU05o5oj9w = .homeUD88N2NAslByu

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .bottom) {
      Group {
        switch selectedTab {
        case .homeUD88N2NAslByu:
          AppNavigationView {
            HomezE7Bdgz5RAm6FView()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        case .discZr9miG5MPFZ9y:
          AppNavigationView {
            DisceQwLbYkS3iDTTView()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        case .msgsVa78D1KK18Op4:
          AppNavigationView {
            MsgzLyr6EwJZs23eView()
          }
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(router)
          .environmentObject(paymentViewModel)
        case .profibW16jiY12DMmv:
          AppNavigationView {
            ProfileViewWrapper()
          }
          .environmentObject(router)
          .environmentObject(aumaxK8ji8QR9Bmeq)
          .environmentObject(paymentViewModel)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)

      if shouldShowTabBar {
        Tabaeg6yQD3b7PzGBar(selectedTab: $selectedTab)
      }
    }
    .ignoresSafeArea(edges: .bottom)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var shouldShowTabBar: Bool {
    if !router.isAtRoot {
      return false
    }
    return true
  }
}

struct ProfileViewWrapper: View {
  @EnvironmentObject var m0ECMlSn2a4yy: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  let userId: String?
  let showBackicon: Bool

  init(userId: String? = nil, showBackicon: Bool = false) {
    self.userId = userId
    self.showBackicon = showBackicon
  }

  var body: some View {
    ProfileViewContainer(m0ECMlSn2a4yy: m0ECMlSn2a4yy, userId: userId, showBackicon: showBackicon)
      .environmentObject(router)
  }
}

private struct ProfileViewContainer: View {
  let m0ECMlSn2a4yy: AuthManagA645b8Y0Aod3aVmod
  let userId: String?
  let showBackicon: Bool
  @StateObject private var viewModel: ProfSR8H1KflnDrj9Vmod

  init(m0ECMlSn2a4yy: AuthManagA645b8Y0Aod3aVmod, userId: String?, showBackicon: Bool = false) {
    self.m0ECMlSn2a4yy = m0ECMlSn2a4yy
    self.userId = userId
    self.showBackicon = showBackicon
    _viewModel = StateObject(
      wrappedValue: ProfSR8H1KflnDrj9Vmod(m0ECMlSn2a4yy: m0ECMlSn2a4yy, userId: userId))
  }

  var body: some View {
    ProfilekgwebDS4EgDnqView(proVm92qjXCvXAr8i6: viewModel, sbacSTmLA8PZKM2AW: showBackicon)
      .environmentObject(m0ECMlSn2a4yy)
  }
}

enum TabHTktU05o5oj9w {
  case homeUD88N2NAslByu
  case discZr9miG5MPFZ9y
  case msgsVa78D1KK18Op4
  case profibW16jiY12DMmv
}
