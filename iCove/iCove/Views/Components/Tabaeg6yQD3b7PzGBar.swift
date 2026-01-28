//
//  Tabaeg6yQD3b7PzGBar.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct Tabaeg6yQD3b7PzGBar: View {
  @Binding var selectedTab: TabHTktU05o5oj9w

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    HStack(spacing: 0) {
      TabBarButton(
        icon: "1akQNNqBpWFE3YsJ0J",
        iconSelected: "1kQNNqBpWFE3YsJ0J",
        isSelected: selectedTab == .homeUD88N2NAslByu
      ) {
        selectedTab = .homeUD88N2NAslByu
      }

      Spacer()

      TabBarButton(
        icon: "2bnmWxXjHOykhJtNRF",
        iconSelected: "2nmWxXjHOykhJtNRF",
        isSelected: selectedTab == .discZr9miG5MPFZ9y
      ) {
        selectedTab = .discZr9miG5MPFZ9y
      }

      Spacer()

      TabBarButton(
        icon: "3cdKT1VeSfXcPS1lVn",
        iconSelected: "3dKT1VeSfXcPS1lVn",
        isSelected: selectedTab == .msgsVa78D1KK18Op4
      ) {
        selectedTab = .msgsVa78D1KK18Op4
      }

      Spacer()

      TabBarButton(
        icon: "4dv94xvRXwbcpHXAn1",
        iconSelected: "4v94xvRXwbcpHXAn1",
        isSelected: selectedTab == .profibW16jiY12DMmv
      ) {
        selectedTab = .profibW16jiY12DMmv
      }
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 10)
    .background(
      RoundedRectangle(cornerRadius: 60)
        .fill(Color("buttonPurple"))
        .shadow(color: Color.white.opacity(0.3), radius: 2, x: 0, y: -2)
    )
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
    #if DEBUG
      .enableInjection()
    #endif
  }
}

private struct TabBarButton: View {
  let icon: String
  let iconSelected: String
  let isSelected: Bool
  let action: () -> Void
  var body: some View {
    Button(action: action) {
      VStack(spacing: 4) {
        Image(isSelected ? iconSelected : icon)
          .resizable()
          .frame(width: 45, height: 45)

      }
      .contentShape(Rectangle())
    }
    .buttonStyle(PlainButtonStyle())
  }
}
