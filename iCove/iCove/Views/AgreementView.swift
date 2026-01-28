//
//  AgreementView.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct AgreementView: View {
  let urlString: String
  let title: String

  @EnvironmentObject var router: Router
  @State private var loingXrAS8tIs4TCn1 = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        herdK4ejeXyC4GEN5
          .padding(.horizontal, 20)
          .padding(.bottom, 16)

        ZStack {
          if let url = URL(string: urlString) {
            WebWaJMsgnMxY8hxView(url: url, isLoading: $loingXrAS8tIs4TCn1)
              .background(Color.white)
          } else {
            VStack(spacing: 16) {
              Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.gray)
              Text("Invalid URL")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }

          if loingXrAS8tIs4TCn1 {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .white))
              .scaleEffect(1.5)
          }
        }
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var herdK4ejeXyC4GEN5: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Button {
          router.pop()
        } label: {
          Circle()
            .fill(Color.white)
            .frame(width: 40, height: 40)
            .overlay(
              Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color("buttonPurple"))
            )
        }

        Text(title)
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(Color(.white))
          .padding(.leading, 10)

        Spacer()
      }

    }
    .padding(.top, 0)
  }
}
