//
//  Podetopjh8lRqGBvnoView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct Podetopjh8lRqGBvnoView: View {
  let postId: String
  @EnvironmentObject var router: Router
  @EnvironmentObject var vHTdwVFoYw02E: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var pdVmA3OLH8q0XtIfY: PodetVmodelvjFnkult51bWe
  @State private var seleIdxtgKrO7Ui0lVyt: Int = 0
  @State private var blorepguS2V8VcOeQPJ = false
  @State private var blodia8kGMTTtIEQeQs = false
  @State private var blouido68FOsXDP7pbb: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(postId: String) {
    self.postId = postId
    _pdVmA3OLH8q0XtIfY = StateObject(
      wrappedValue: PodetVmodelvjFnkult51bWe(pidhJnCXP3N9yipf: postId))
  }

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        TopcCTKlwHKCaLhH(
          onBack: {
            router.pop()
          },
          isMoreVisible: vHTdwVFoYw02E.currvj9QRUUPOWY4Ouser?.id
            != pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk?.aC9dE1fG3hI5jK,
          onMore: {
            if pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk != nil {
              blorepguS2V8VcOeQPJ = true
            }
          },
          style: .whiteWithPurpleBorder
        )
        .frame(height: 54)

        if let postwGCoqwzwLkvNM = pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk {
          GeometryReader { geometry in
            let wdkxuti6H2q73bF = geometry.size.width
            let htM2CV5R4KR4NEh = geometry.size.height
            let lwiXORe1k66lKEk: CGFloat = 64
            let spaRaCypkoqeiNkj: CGFloat = 16
            let rw87ym5nqW8M0Vf = wdkxuti6H2q73bF - lwiXORe1k66lKEk - spaRaCypkoqeiNkj

            HStack(alignment: .top, spacing: spaRaCypkoqeiNkj) {
              VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                  VStack(spacing: 16) {
                    ForEach(Array(postwGCoqwzwLkvNM.iT1uV3wX5yZ7aB.enumerated()), id: \.offset) {
                      idxGL8MuMii50ADL, imgNAjvxKLTl4nSq in
                      thumbnailItemUps6rxSn5R7nY(
                        imgwf4vAT3rdxi99: imgNAjvxKLTl4nSq, index: idxGL8MuMii50ADL)
                    }
                  }
                  .padding(.top, 12)
                }

                Spacer(minLength: 20)

                Button(action: {
                  if let postwGCoqwzwLkvNM = pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk {
                    vHTdwVFoYw02E.toggleB2rGhFgSQb0qAcol(pid3rhTIg1jfRXQj: postwGCoqwzwLkvNM.id)
                  }
                }) {
                  ZStack {
                    Circle()
                      .fill(Color("buttonPurple"))
                      .frame(width: 54, height: 54)

                    Image(systemName: "star.fill")
                      .font(.system(size: 24))
                      .foregroundColor(
                        pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk != nil
                          && vHTdwVFoYw02E.isColBbbiJ8jXV5fKI(
                            pid3rhTIg1jfRXQj: pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk!.id)
                          ? .yellow
                          : .white
                      )
                  }
                }
                .padding(.bottom, 20)
              }
              .frame(width: lwiXORe1k66lKEk)
              .zIndex(1)

              VStack(spacing: 0) {
            if seleIdxtgKrO7Ui0lVyt < postwGCoqwzwLkvNM.iT1uV3wX5yZ7aB.count {
                  DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: postwGCoqwzwLkvNM.iT1uV3wX5yZ7aB[seleIdxtgKrO7Ui0lVyt])
                    .id(seleIdxtgKrO7Ui0lVyt)
                    .frame(width: rw87ym5nqW8M0Vf, height: max(0, htM2CV5R4KR4NEh - 160))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .contentShape(RoundedRectangle(cornerRadius: 20))
                }

                Text(postwGCoqwzwLkvNM.cL7mN9oP1qR3sT)
                  .font(.system(size: 14))
                  .foregroundColor(.white)
                  .lineLimit(nil)
                  .fixedSize(horizontal: false, vertical: true)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.vertical, 16)
              }
              .frame(width: rw87ym5nqW8M0Vf)
              .padding(.top, 12)
            }
          }
          .padding(.horizontal, 20)
        } else {
          ProgressView("Loading...")
            .foregroundColor(.white)
        }
      }
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    .sheet(isPresented: $blorepguS2V8VcOeQPJ) {
      if let postlWeuXB8KEw026 = pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk {
        ReportBlockBottomSheet(
          userId: postlWeuXB8KEw026.aC9dE1fG3hI5jK,
          isPresented: $blorepguS2V8VcOeQPJ,
          onBlock: {
            if let postlWeuXB8KEw026 = pdVmA3OLH8q0XtIfY.postJFUcoSpXHIudk {
              blouido68FOsXDP7pbb = postlWeuXB8KEw026.aC9dE1fG3hI5jK
              blodia8kGMTTtIEQeQs = true
            }
          }
        )
        .environmentObject(vHTdwVFoYw02E)
        .environmentObject(router)
        .presentationDetents([.height(240)])
        .presentationBackground(.clear)
        .presentationDragIndicator(.hidden)
      }
    }
    .blockDiaLcTUIAjgtcOHd(isPresented: $blodia8kGMTTtIEQeQs, uidK1uO6OuOGNky0: blouido68FOsXDP7pbb)
    #if DEBUG
      .enableInjection()
    #endif
    .onChange(of: vHTdwVFoYw02E.currvj9QRUUPOWY4Ouser?.cP9hI1jK3lM5nO) { _, _ in
    }
  }

  private func thumbnailItemUps6rxSn5R7nY(imgwf4vAT3rdxi99: String, index: Int) -> some View {
    ZStack {
      DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: imgwf4vAT3rdxi99)
        .frame(width: 62, height: 88)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .allowsHitTesting(false)

      RoundedRectangle(cornerRadius: 12)
        .stroke(
          seleIdxtgKrO7Ui0lVyt == index ? Color("yinguanglv") : Color.clear,
          lineWidth: 2
        )
        .frame(width: 62, height: 88)
        .allowsHitTesting(false)
    }
    .frame(width: 64, height: 88)
    .contentShape(Rectangle())
    .onTapGesture {
      seleIdxtgKrO7Ui0lVyt = index
      print("seleIdxtgKrO7Ui0lVyt: \(seleIdxtgKrO7Ui0lVyt)")
    }
  }
}

@MainActor
class PodetVmodelvjFnkult51bWe: ObservableObject {
  @Published var postJFUcoSpXHIudk: Post?

  private let pidhJnCXP3N9yipf: String
  private let poserOAQTiNKfztblq: PostServprocK4dfzEM6tLRcc

  init(
    pidhJnCXP3N9yipf: String,
    poserOAQTiNKfztblq: PostServprocK4dfzEM6tLRcc = PostServK4dfzEM6tLRcc.shared
  ) {
    self.pidhJnCXP3N9yipf = pidhJnCXP3N9yipf
    self.poserOAQTiNKfztblq = poserOAQTiNKfztblq
    loadXSK7SA4oCzsRz()
  }

  private func loadXSK7SA4oCzsRz() {
    postJFUcoSpXHIudk = poserOAQTiNKfztblq.gepoidnrfBTqdPsaCHv(pidhJnCXP3N9yipf)
  }
}
