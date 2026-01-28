//
//  StarTextThyUv3yWgSTcz.swift
//  iCove
//
//  Created by yangyang on 2026/1/21.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct StarTextThyUv3yWgSTcz: View {
  let text: String
  var textColor: Color = .white
  var textSize: CGFloat = 20
  var starSize: CGFloat = 8

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .topTrailing) {
      Text(text)
        .font(.custom("FredokaOne-Regular", size: textSize))
        .foregroundColor(textColor)

      HStack(spacing: 2) {
        Image(systemName: "sparkle")
          .font(.system(size: starSize))
          .foregroundColor(textColor)
          .padding(.bottom, 6)

        Image(systemName: "sparkle")
          .font(.system(size: starSize - 4))
          .foregroundColor(textColor)
      }
      .offset(x: 8, y: -6)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}
