//
//  EmptyJYGRYC2t97Qi3.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct EmptyJYGRYC2t97Qi3: View {
  let isSystemImage: Bool
  let message: String
  let imageSize: CGFloat
  let fontSize: CGFloat
  let spacing: CGFloat

  init(
    isSystemImage: Bool = true,
    message: String = "No data available.",
    imageSize: CGFloat = 140,
    fontSize: CGFloat = 16,
    spacing: CGFloat = 16
  ) {
    self.isSystemImage = isSystemImage
    self.message = message
    self.imageSize = imageSize
    self.fontSize = fontSize
    self.spacing = spacing
  }

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    VStack(spacing: spacing) {
      Image("RSBk5BClmhwCxL")
        .resizable()
        .scaledToFit()
        .frame(width: 140, height: 140)
        .foregroundColor(.secondary)

      Text(message)
        .font(.system(size: fontSize))
        .foregroundColor(.white.opacity(0.7))
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    #if DEBUG
      .enableInjection()
    #endif
  }
}
