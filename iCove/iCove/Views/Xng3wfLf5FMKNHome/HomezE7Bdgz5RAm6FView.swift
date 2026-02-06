//
//  HomezE7Bdgz5RAm6FView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct HomezE7Bdgz5RAm6FView: View {
  @StateObject private var homeVmjdlzoNirJwfU3 = Home8T3vLYQ252bVOVmod()
  @State private var unlocktNhKCw8OwGS0t = false
  @State private var bloHwHbzDrKcFZIB = false
  @State private var blouidlt760IOhzkW9F: String? = nil
  @EnvironmentObject var router: Router
  @EnvironmentObject var aumaCUWZltQs5HPyQ: AuthManagA645b8Y0Aod3aVmod

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Image("Qc4hYFPT1LVSkXq5")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {
        toplMOQuxo9IeDo4
          .padding(.top, 50)
          .padding(.horizontal, 20)

        popvdoloZf5BoonHb19
          .padding(.top, 20)
      }

      if unlocktNhKCw8OwGS0t {
        UnlockConfirmDialog(
          hasXybyb6HcnQYhh: (aumaCUWZltQs5HPyQ.currvj9QRUUPOWY4Ouser?.bP2qR4sT6uV8wX ?? 0) >= 200,
          onCancel: {
            unlocktNhKCw8OwGS0t = false
          },
          onConfirm: {
            unlocktNhKCw8OwGS0t = false
            let fGVDGutNgJkr8 = (aumaCUWZltQs5HPyQ.currvj9QRUUPOWY4Ouser?.bP2qR4sT6uV8wX ?? 0) >= 200
            if fGVDGutNgJkr8 {
              aumaCUWZltQs5HPyQ.dedPlf7hXe73EGoR(200)
              router.push(.ai)
            } else {
              router.push(.wallet)
            }
          },
        )
      }

    }
    .blockDiaLcTUIAjgtcOHd(isPresented: $bloHwHbzDrKcFZIB, uidK1uO6OuOGNky0: blouidlt760IOhzkW9F)
    .navigationBarHiddenWithSwipeBack()
    .onAppear {
      homeVmjdlzoNirJwfU3.updAuma7Cif2ltv9c65t(aumaCUWZltQs5HPyQ)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var toplMOQuxo9IeDo4: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("ICove")
        .font(.custom("FredokaOne-Regular", size: 32))
        .foregroundColor(.white)

      VStack(spacing: 0) {
        Spacer().frame(height: 60)
        VStack(alignment: .center, spacing: 16) {
          Text(
            "Hi ~ I'm your personal outfit partner! You can tell me your requirements and I'll tailor them to your needs."
          )
          .font(.system(size: 13, weight: .regular, design: .default)).italic()
          .foregroundColor(.white)

          Button(action: {
            unlocktNhKCw8OwGS0t = true
          }) {
            ZStack(alignment: .topTrailing) {
              VStack {
                HStack(spacing: 4) {
                  Text("Unlock now")
                    .font(.custom("FredokaOne-Regular", size: 14))
                    .foregroundColor(.black)
                  Image("jXFWhEc2SdV2UuW7")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)

                  Text("-200")
                    .font(.custom("FredokaOne-Regular", size: 14))
                    .foregroundColor(.black)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color("yinguanglv"))
                .cornerRadius(32)
              }
              .padding(.top, 10)

              Image("qTU6kHWx1MR2Ual5")
                .resizable()
                .scaledToFill()
                .frame(width: 26, height: 26)
                .clipped()
            }

          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
        .padding(.trailing, 130)
      }
    }
  }

  private var popvdoloZf5BoonHb19: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
          TopborpathQocmohrb0utCT(conradxrUXU0WJQ4cZU: 33)
            .stroke(Color.green, lineWidth: 2)
        )
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .padding(.top, 40)
        .padding(.bottom, 100)

      VStack(alignment: .leading, spacing: 16) {
        HStack {
          HStack(spacing: 8) {
            ZStack {
              Image("ZOVugBKGBc2g0HA3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 155, height: 48)
                .clipped()
                .cornerRadius(8)
              StarTextThyUv3yWgSTcz(
                text: "Popular videos",
                textColor: .black,
                textSize: 16
              )
            }
            .frame(height: 45)
          }
          .padding(.trailing, 20)

          Button(action: {
            router.push(.publish(type: .vdoSddWQll1w6vvS))
          }) {
            Image("Tz0wJDM3mdSWeD0Y")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 66, height: 43)
              .clipped()
          }
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)

        ScrollView {
          Group {
            if homeVmjdlzoNirJwfU3.vdosZ4quBSX4FRJNb.isEmpty {
              ProgressView("Loading...")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
            } else if homeVmjdlzoNirJwfU3.vdosZ4quBSX4FRJNb.isEmpty {
              EmptyJYGRYC2t97Qi3()
            } else {
              vdoGridCzet9yZf7eXm4
            }
          }
          .padding(.top, 12)
        }
        .refreshable {
          await homeVmjdlzoNirJwfU3.refresh()
        }
      }
    }
  }

  private var vdoGridCzet9yZf7eXm4: some View {
    let screenWidth = UIScreen.main.bounds.width
    let avawidE2XtbQrINuXRi = screenWidth - 40
    let cawdPvXk0Kj0Izw8a = (avawidE2XtbQrINuXRi - 20) / 2

    return LazyVGrid(
      columns: [
        GridItem(.fixed(cawdPvXk0Kj0Izw8a), spacing: 20),
        GridItem(.fixed(cawdPvXk0Kj0Izw8a), spacing: 20),
      ], spacing: 16
    ) {
      ForEach(homeVmjdlzoNirJwfU3.vdosZ4quBSX4FRJNb) { vdNFv9O0ej5hmqw in
        Vdocard7h6FK0PGkN3cd(
          cdwdrOSeXsSp0Ug3k: cawdPvXk0Kj0Izw8a,
          vdoVuG66awy9cJsL: vdNFv9O0ej5hmqw,
          onlikejlPDEZySX6stm: {
            homeVmjdlzoNirJwfU3.toliEdMtmZVDsInnP(for: vdNFv9O0ej5hmqw)
          },
          onp5mmhUnSEipCn: {
            router.push(.vdodetfheedD4mgJl4V(vidROutctPY4KAW9: vdNFv9O0ej5hmqw.id))
          },
          onBloIsLioTo3Y3fNs: {
            blouidlt760IOhzkW9F = vdNFv9O0ej5hmqw.aC9dE1fG3hI5jK
            bloHwHbzDrKcFZIB = true
          }
        )
        .frame(width: cawdPvXk0Kj0Izw8a)
      }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 130)
  }
}

struct Vdocard7h6FK0PGkN3cd: View {
  let cdwdrOSeXsSp0Ug3k: CGFloat
  let vdoVuG66awy9cJsL: l9O6Sz7QVA4SDVideoItem
  let onlikejlPDEZySX6stm: () -> Void
  var onp5mmhUnSEipCn: (() -> Void)? = nil
  var onBloIsLioTo3Y3fNs: (() -> Void)? = nil
  @EnvironmentObject var aumaCUWZltQs5HPyQ: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @State private var showingReportBlockSheet = false

  var body: some View {
    ZStack(alignment: .topLeading) {
      DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: vdoVuG66awy9cJsL.iM5aG7eN9aM1eN)
        .frame(width: cdwdrOSeXsSp0Ug3k, height: 220)
        .clipped()
        .cornerRadius(14)
        .overlay(
          RoundedRectangle(cornerRadius: 14)
            .stroke(Color("btnpink"), lineWidth: 4)
        )

      HStack(spacing: 4) {
        Button(action: onlikejlPDEZySX6stm) {
          Image(systemName: vdoVuG66awy9cJsL.iS1lI3kE5dN7eN ? "heart.fill" : "heart")
            .font(.system(size: 14))
            .foregroundColor(.white)
        }
        .buttonStyle(PlainButtonStyle())
        Text("\(vdoVuG66awy9cJsL.lI1kE3cO5uN7tN)")
          .font(.system(size: 12, weight: .medium))
          .foregroundColor(.white)
      }
      .padding(.horizontal, 8)
      .padding(.vertical, 4)
      .background(Color("buttonPurple"))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.white, lineWidth: 1.5)
      )
      .cornerRadius(8)
      .padding(8)

      if aumaCUWZltQs5HPyQ.currvj9QRUUPOWY4Ouser?.id != vdoVuG66awy9cJsL.aC9dE1fG3hI5jK {
        VStack {
          HStack {
            Spacer()
            Button(action: {
              showingReportBlockSheet = true
            }) {
              Image(systemName: "ellipsis")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
                .padding(8)
                .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(6)
          }
          Spacer()
        }
      }

      VStack {
        Spacer()
        VStack(alignment: .leading, spacing: 0) {
          Text(vdoVuG66awy9cJsL.tR3sT5uV7wX9yZ)
            .font(.system(size: 12))
            .foregroundColor(.white)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
          LinearGradient(
            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      onp5mmhUnSEipCn?()
    }
    .sheet(isPresented: $showingReportBlockSheet) {
      ReportBlockBottomSheet(
        userId: vdoVuG66awy9cJsL.aC9dE1fG3hI5jK,
        isPresented: $showingReportBlockSheet,
        onBlock: {
          onBloIsLioTo3Y3fNs?()
        }
      )
      .environmentObject(aumaCUWZltQs5HPyQ)
      .environmentObject(router)
      .presentationDetents([.height(240)])
      .presentationBackground(.clear)
      .presentationCornerRadius(0)
      .presentationDragIndicator(.hidden)
    }
  }
}

extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

struct TopborpathQocmohrb0utCT: Shape {
  var conradxrUXU0WJQ4cZU: CGFloat

  func path(in rect: CGRect) -> Path {
    var path9jM6m0KJy6kRl = Path()

    path9jM6m0KJy6kRl.move(to: CGPoint(x: 0, y: conradxrUXU0WJQ4cZU))

    path9jM6m0KJy6kRl.addArc(
      center: CGPoint(x: conradxrUXU0WJQ4cZU, y: conradxrUXU0WJQ4cZU),
      radius: conradxrUXU0WJQ4cZU,
      startAngle: Angle(degrees: 180),
      endAngle: Angle(degrees: 270),
      clockwise: false
    )

    path9jM6m0KJy6kRl.addLine(to: CGPoint(x: rect.width - conradxrUXU0WJQ4cZU, y: 0))

    path9jM6m0KJy6kRl.addArc(
      center: CGPoint(x: rect.width - conradxrUXU0WJQ4cZU, y: conradxrUXU0WJQ4cZU),
      radius: conradxrUXU0WJQ4cZU,
      startAngle: Angle(degrees: 270),
      endAngle: Angle(degrees: 360),
      clockwise: false
    )

    return path9jM6m0KJy6kRl
  }
}
