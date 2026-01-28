//
//  ProfilekgwebDS4EgDnqView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct ProfilekgwebDS4EgDnqView: View {
  @ObservedObject var proVm92qjXCvXAr8i6: ProfSR8H1KflnDrj9Vmod
  @EnvironmentObject var d7nokg2HlCh2O: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss
  var sbacSTmLA8PZKM2AW: Bool = true
  @State private var sbioUMbu9lVGewxqE = false
  @State private var sretwmjJpTRjQbvyn = false
  @State private var dWGK5bUYeS2aC = false
  @State private var bouidSPG3NVxZahTZe: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    contftHVwODkBRFb8
      .sheet(isPresented: $sretwmjJpTRjQbvyn) {
        if let uid1V8JpaklpGHd2 = proVm92qjXCvXAr8i6.user?.id {
          ReportBlockBottomSheet(
            userId: uid1V8JpaklpGHd2,
            isPresented: $sretwmjJpTRjQbvyn,
            onBlock: {
              bouidSPG3NVxZahTZe = proVm92qjXCvXAr8i6.user?.id
              dWGK5bUYeS2aC = true
            }
          )
          .environmentObject(d7nokg2HlCh2O)
          .environmentObject(router)
          .presentationDetents([.height(240)])
          .presentationBackground(.clear)
          .presentationDragIndicator(.hidden)
        }
      }
      .blockDiaLcTUIAjgtcOHd(isPresented: $dWGK5bUYeS2aC, uidK1uO6OuOGNky0: bouidSPG3NVxZahTZe)
      .navigationBarHidden(true)
      .onChange(of: d7nokg2HlCh2O.currvj9QRUUPOWY4Ouser?.aG3hI5jK7lM9nO) { _, _ in
        if proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz {
          Task {
            await proVm92qjXCvXAr8i6.refresh()
          }
        }
      }
      .onChange(of: d7nokg2HlCh2O.currvj9QRUUPOWY4Ouser?.uX4yZ6aB8cD0eF) { _, _ in
        if proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz {
          Task {
            await proVm92qjXCvXAr8i6.refresh()
          }
        }
      }
      #if DEBUG
        .enableInjection()
      #endif
  }

  @ViewBuilder
  private var contftHVwODkBRFb8: some View {
    if proVm92qjXCvXAr8i6.l2z4XG5qy0RxI3 && proVm92qjXCvXAr8i6.user == nil {
      ProgressView("Loading...")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } else if let user = proVm92qjXCvXAr8i6.user {
      ZStack {
        Image("gY80sW7YXCRIPed2")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()

        ScrollView {
          VStack(spacing: 0) {
            headv30Z9ODhjRMGA(h6LZYZDfcNQ6wuser: user)
              .padding(.bottom, 26)

            worksQ1C9IJxy8YfiE(user: user)
              .padding(.horizontal, 20)
              .padding(.bottom, 100)
          }
        }
        .refreshable {
          await proVm92qjXCvXAr8i6.refresh()
        }
      }
    }
  }

  private func headv30Z9ODhjRMGA(h6LZYZDfcNQ6wuser: User) -> some View {
    ZStack {
      hbgnOIGnoEUJvFru(userCx2m3IMEYbKFx: h6LZYZDfcNQ6wuser)

      VStack(alignment: .leading, spacing: 12) {
        topBar

        HStack(alignment: .bottom, spacing: 16) {
          VStack(alignment: .leading, spacing: 20) {
            Text(h6LZYZDfcNQ6wuser.uX4yZ6aB8cD0eF)
              .font(.custom("FredokaOne-Regular", size: 22))
              .foregroundColor(.white)

            statsInline(uU4kgaDYChJq9C: h6LZYZDfcNQ6wuser)

            actionButtonsSection(user: h6LZYZDfcNQ6wuser)
              .padding(.top, 5)
          }

          Spacer()

          avaqymV9ds9RKiQv(u6olTxEbx2R0ej: h6LZYZDfcNQ6wuser)
        }
        .padding(.horizontal, 20)

      }
    }
  }

  private func hbgnOIGnoEUJvFru(userCx2m3IMEYbKFx: User) -> some View {
    let bgimgPK6UQbxg8zZcX = userCx2m3IMEYbKFx.aG3hI5jK7lM9nO ?? "icove_logo"
    return ZStack {
      DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: bgimgPK6UQbxg8zZcX)
        .scaledToFill()
        .blur(radius: 3)
        .clipped()

      LinearGradient(
        colors: [.clear, Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)],
        startPoint: .top,
        endPoint: .bottom
      )
    }
    .frame(width: .infinity, height: 260)
    .ignoresSafeArea(edges: .top)
  }

  private var topBar: some View {
    HStack {
      if !proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz {
        TopcCTKlwHKCaLhH(
          onBack: {
            dismiss()
          },
          onMore: {
            sretwmjJpTRjQbvyn = true
          }
        )
        .padding(.top, 46)
      } else {
        HStack {
          if sbacSTmLA8PZKM2AW {
            Button {
              dismiss()
            } label: {
              Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .overlay(
                  Image(systemName: "arrow.uturn.left")
                    .foregroundColor(Color("buttonPurple"))
                )
            }
          }
          Spacer()

          Button {
            if proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz {
              router.push(.settings)
            } else {
              sretwmjJpTRjQbvyn = true
            }
          } label: {
            Circle()
              .fill(Color.white)
              .frame(width: 40, height: 40)
              .overlay(
                Image(systemName: proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz ? "gearshape" : "ellipsis")
                  .foregroundColor(Color("buttonPurple"))
              )
          }
        }
        .padding(.top, 46)
        .padding(.horizontal, 20)
      }
    }

  }

  private func avaqymV9ds9RKiQv(u6olTxEbx2R0ej: User) -> some View {
    let avax6IzejdmTR54E = u6olTxEbx2R0ej.aG3hI5jK7lM9nO ?? "7X1p2a4Cu1Xn8nXt"
    return DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: avax6IzejdmTR54E)
      .frame(width: 116, height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 98, style: .continuous))
      .overlay(
        RoundedRectangle(cornerRadius: 98, style: .continuous)
          .stroke(Color("yinguanglv"), lineWidth: 3)
      )
      .shadow(radius: 10)
  }

  private func statsInline(uU4kgaDYChJq9C: User) -> some View {
    HStack(spacing: 32) {
      VStack(alignment: .leading, spacing: 4) {
        Text("\(uU4kgaDYChJq9C.followingCount)")
          .font(.custom("FredokaOne-Regular", size: 20))
          .bold()
          .foregroundColor(.white)
        Text("Following")
          .font(.subheadline)
          .foregroundColor(.white.opacity(0.8))
      }

      VStack(alignment: .leading, spacing: 4) {
        Text("\(uU4kgaDYChJq9C.followerCount)")
          .font(.custom("FredokaOne-Regular", size: 20))
          .bold()
          .foregroundColor(.white)
        Text("Followers")
          .font(.subheadline)
          .foregroundColor(.white.opacity(0.8))
      }
    }
  }

  private func worksQ1C9IJxy8YfiE(user: User) -> some View {
    VStack(alignment: .leading, spacing: 20) {
      ZStack(alignment: .center) {
        Image("TYRzuMytPGz0mCSA")
          .resizable()
          .scaledToFill()
          .frame(width: 110, height: 45)
          .clipped()

        StarTextThyUv3yWgSTcz(
          text: "Works",
          textColor: .black,
          textSize: 18
        )
      }

      if proVm92qjXCvXAr8i6.KtIKR8YgWCIGr.isEmpty {
        EmptyJYGRYC2t97Qi3()
          .frame(maxWidth: .infinity)
          .padding(.vertical, 40)
      } else {
        vdoGridqBmuYD9CtTIYR
      }
    }
  }

  private var vdoGridqBmuYD9CtTIYR: some View {
    let RxVCFOqW40CeC = UIScreen.main.bounds.width
    let EjUOdLxGTuIft = RxVCFOqW40CeC - 40
    let mQXBY8dZDtctA = (EjUOdLxGTuIft - 16) / 2

    return LazyVGrid(
      columns: [
        GridItem(.fixed(mQXBY8dZDtctA), spacing: 16),
        GridItem(.fixed(mQXBY8dZDtctA), spacing: 16),
      ], spacing: 16
    ) {
      ForEach(proVm92qjXCvXAr8i6.KtIKR8YgWCIGr) { video in
        workCardrCNblfKcj8QRY(video, carwGxraiAwd4LD8s: mQXBY8dZDtctA)
      }
    }
  }

  private func workCardrCNblfKcj8QRY(_ vdPp5gKZ0ZPzQ6O: l9O6Sz7QVA4SDVideoItem, carwGxraiAwd4LD8s: CGFloat)
    -> some View
  {
    Button {
      router.push(.vdodetfheedD4mgJl4V(vidROutctPY4KAW9: vdPp5gKZ0ZPzQ6O.id))
    } label: {
      ZStack(alignment: .center) {
        DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: vdPp5gKZ0ZPzQ6O.iM5aG7eN9aM1eN)
          .scaledToFill()
          .frame(width: carwGxraiAwd4LD8s, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
          .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
              .stroke(Color("buttonPurple"), lineWidth: 2)
          )

        Image("HTLmY1hsavuQ7Jn2")
          .resizable()
          .scaledToFill()
          .frame(width: 40, height: 40)
          .clipped()

        VStack(alignment: .leading, spacing: 0) {
          Spacer()
          Text(vdPp5gKZ0ZPzQ6O.tR3sT5uV7wX9yZ)
            .font(.footnote)
            .foregroundColor(.white)
            .lineLimit(2)
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
              Color.white.opacity(0.3)
                .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))

            )
        }
      }
    }
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func actionButtonsSection(user: User) -> some View {
    if proVm92qjXCvXAr8i6.isCurghxDEHCC3hzYz {
      Button(action: {
        router.push(.wallet)
      }) {
        HStack {
          Text("Balance: \(d7nokg2HlCh2O.currvj9QRUUPOWY4Ouser?.bP2qR4sT6uV8wX ?? 0)")
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
          Image("RDxEu2AHYnJdZ8zm")
            .resizable()
        )
      }
    } else {
      VStack(spacing: 12) {
        Button(action: {
          proVm92qjXCvXAr8i6.togPohodzYKFgGNl()
        }) {
          Text(proVm92qjXCvXAr8i6.x6tcllx6YBqkU ? "Following" : "Follow")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
              Image("RDxEu2AHYnJdZ8zm")
                .resizable()
            )
        }

        Button(action: {
          proVm92qjXCvXAr8i6.sendb9kzu5TB4hAkL(router: router)
        }) {
          Text("Message")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
              Image("yKWcYXzqIaPg4DDM")
                .resizable()
            )
        }
      }
    }
  }
}
