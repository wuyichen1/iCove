//
//  BtnjDlKDD6h7eI3t.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct BtnjDlKDD6h7eI3t: View {
  let title: String
  let action: () -> Void
  var isLoading: Bool = false
  var isEnabled: Bool = true
  var width: CGFloat? = nil
  var height: CGFloat = 52
  var fontSize: CGFloat = 20
  var fontWeight: Font.Weight = .semibold
  var backgroundColor: Color = Color("buttonPurple")

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    Button(action: action) {
      HStack {
        if isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text(title)
            .font(.custom("FredokaOne-Regular", size: fontSize))
        }
      }
      .frame(width: width, height: height)
      .frame(maxWidth: width == nil ? .infinity : nil)
      .foregroundColor(.white)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(backgroundColor)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.white, lineWidth: 2)
      }
    }
    .disabled(!isEnabled || isLoading)
    #if DEBUG
      .enableInjection()
    #endif
    .fixedSize(horizontal: width != nil, vertical: false)
  }
}

struct SecondaryButton: View {
  let title: String
  let action: () -> Void
  var isLoading: Bool = false
  var isEnabled: Bool = true
  var height: CGFloat = 56
  var fontSize: CGFloat = 18
  var fontWeight: Font.Weight = .semibold
  var borderColor: Color = .white.opacity(0.5)
  var borderWidth: CGFloat = 1.5

  var body: some View {
    Button(action: action) {
      HStack {
        if isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text(title)
            .font(.system(size: fontSize, weight: fontWeight))
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: height)
      .foregroundColor(.white)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.clear)
      )
      .overlay {
        RoundedRectangle(cornerRadius: 16)
          .stroke(borderColor, lineWidth: borderWidth)
      }
    }
    .disabled(!isEnabled || isLoading)
    .opacity(isEnabled && !isLoading ? 1.0 : 0.6)
  }
}
