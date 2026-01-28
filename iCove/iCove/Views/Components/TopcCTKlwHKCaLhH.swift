//
//  TopcCTKlwHKCaLhH.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

enum TopcCTKlwHKCaLhHSty {
  case whiteWithPurpleBorder
  case whiteTransparent
}

struct TopcCTKlwHKCaLhH: View {
  let onBack: () -> Void
  var isMoreVisible: Bool = true
  var onMore: (() -> Void)? = nil
  var style: TopcCTKlwHKCaLhHSty = .whiteWithPurpleBorder
  var horizontalPadding: CGFloat = 20
  var topPadding: CGFloat = 20

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    VStack {
      HStack {
        backButton

        Spacer()

        if isMoreVisible && onMore != nil {
          moreButton(onMore: onMore!)
        }
      }
      .padding(.horizontal, horizontalPadding)

      Spacer()
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var backButton: some View {
    Button(action: onBack) {
      Group {
        switch style {
        case .whiteWithPurpleBorder:
          Image(systemName: "arrow.uturn.left")
            .foregroundColor(Color("buttonPurple"))
            .frame(width: 40, height: 40)
            .background(Color.white)
            .clipShape(Circle())

        case .whiteTransparent:
          Image(systemName: "arrowshape.backward.fill")
            .font(.system(size: 18))
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(Color.white.opacity(0.2))
            .clipShape(Circle())
        }
      }
    }
  }

  @ViewBuilder
  private func moreButton(onMore: @escaping () -> Void) -> some View {
    Button(action: onMore) {
      Group {
        switch style {
        case .whiteWithPurpleBorder:
          Image(systemName: "ellipsis")
            .font(.system(size: 18))
            .foregroundColor(Color("buttonPurple"))
            .frame(width: 40, height: 40)
            .background(Color.white)
            .clipShape(Circle())

        case .whiteTransparent:
          Image(systemName: "ellipsis")
            .font(.system(size: 18))
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(Color.white.opacity(0.2))
            .clipShape(Circle())
        }
      }
    }
  }
}
