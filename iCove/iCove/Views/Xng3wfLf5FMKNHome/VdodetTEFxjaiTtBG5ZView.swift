//
//  VdodetTEFxjaiTtBG5ZView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import AVKit
import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct VdodetTEFxjaiTtBG5ZView: View {
  let video: l9O6Sz7QVA4SDVideoItem
  @EnvironmentObject var router: Router
  @EnvironmentObject var fggp6oQ8ajgQJ: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var vdVmM7Y8nCqxkUdxr: VdoModRfABf7Hmv5B3L
  @State private var shocomxEwZWd9vW0DWQ = false
  @State private var shorepLN0qrzU93ezm5 = false
  @State private var bloYMGgfDIp3wRLn = false
  @State private var buidrzaotDzVu2tOT: String? = nil
  @State private var reuid1Hjpq9xSCefWC: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init(video: l9O6Sz7QVA4SDVideoItem) {
    self.video = video
    _vdVmM7Y8nCqxkUdxr = StateObject(wrappedValue: VdoModRfABf7Hmv5B3L(video: video))
  }

  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()

      VdoPlrqjvSRj9JYYRnbView(videoName: video.vI3dE5oN7aM9eN)
        .ignoresSafeArea()

      VStack(alignment: .leading) {
        Spacer()

        VStack(spacing: 16) {
          HStack {
            Spacer()
            VStack(spacing: 24) {
              Button(action: {
                vdVmM7Y8nCqxkUdxr.toglikesm6Xk6NVAHwlN()
              }) {
                VStack(spacing: 8) {
                  Image(
                    vdVmM7Y8nCqxkUdxr.vdowndXDeVKvaItC.iS1lI3kE5dN7eN
                      ? "zibeSwAfFlutEuhNml" : "beSwAfFlutEuhNml"
                  )
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 45, height: 45)
                  .clipped()

                  Text("\(vdVmM7Y8nCqxkUdxr.vdowndXDeVKvaItC.lI1kE3cO5uN7tN)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                }
                .frame(width: 50)
              }

              Button(action: {
                shocomxEwZWd9vW0DWQ = true
              }) {
                VStack(spacing: 8) {
                  Image("Qplz4ZYdXi5S8nP4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipped()

                  Text("\(vdVmM7Y8nCqxkUdxr.comcnt1yKL9CDOTbUPL)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                }
                .frame(width: 50)
              }
            }
          }

          HStack {
            VStack(alignment: .leading, spacing: 12) {
              if let auBNPseU9JjfhAD = vdVmM7Y8nCqxkUdxr.aue7tBYETD3uMWE {
                HStack(spacing: 12) {
                  if let avaD72PJPNFEnAPk = auBNPseU9JjfhAD.aG3hI5jK7lM9nO {
                    Button(action: {
                      if let auBNPseU9JjfhAD = vdVmM7Y8nCqxkUdxr.aue7tBYETD3uMWE {
                        router.push(
                          .profibW16jiY12DMmv(
                            uidmhh7e21b987RS: auBNPseU9JjfhAD.id,
                            showBackicon: true))
                      }
                    }) {
                      DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: avaD72PJPNFEnAPk)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .overlay(
                          Circle()
                            .stroke(Color("yinguanglv"), lineWidth: 1)
                        )
                    }

                  } else {
                    Circle()
                      .fill(Color.green.opacity(0.3))
                      .frame(width: 45, height: 45)
                      .overlay {
                        Text(String(auBNPseU9JjfhAD.uX4yZ6aB8cD0eF.prefix(1)))
                          .font(.headline)
                          .foregroundColor(.green)
                      }
                      .overlay(
                        Circle()
                          .stroke(Color.green, lineWidth: 2)
                      )
                  }

                  Text(auBNPseU9JjfhAD.uX4yZ6aB8cD0eF)
                    .font(.custom("FredokaOne-Regular", size: 18))
                    .foregroundColor(.white)
                }

                Text(video.tR3sT5uV7wX9yZ)
                  .font(.system(size: 14))
                  .foregroundColor(.white)
                  .lineLimit(3)
              }
            }
            Spacer()
          }

        }
        .padding(.horizontal, 20)
        .padding(.bottom, 0)
      }

      TopcCTKlwHKCaLhH(
        onBack: {
          router.pop()
        },
        isMoreVisible: fggp6oQ8ajgQJ.currvj9QRUUPOWY4Ouser?.id != video.aC9dE1fG3hI5jK,
        onMore: {
          reuid1Hjpq9xSCefWC = video.aC9dE1fG3hI5jK
          shorepLN0qrzU93ezm5 = true
        },
      )
    }
    .navigationBarHidden(true)
    .onAppear {
      vdVmM7Y8nCqxkUdxr.setau9acW6L3twRIdS(fggp6oQ8ajgQJ)
    }
    .sheet(isPresented: $shocomxEwZWd9vW0DWQ) {
      ComsheethSQ6TmVcylw83(
        vdoidD9HGYfeBdbb8g: video.id,
        blouidl77j5c0KC5XIJ: video.aC9dE1fG3hI5jK,
        onrepec8s8iLFaxS8w: { userId in
          shocomxEwZWd9vW0DWQ = false
          reuid1Hjpq9xSCefWC = userId
          DispatchQueue.main.asyncAfter(deadline: .now()) {
            shorepLN0qrzU93ezm5 = true
          }
        }
      )
      .environmentObject(router)
      .presentationDetents([.fraction(0.5)])
      .presentationBackground(.clear)
    }
    .sheet(isPresented: $shorepLN0qrzU93ezm5) {
      ReportBlockBottomSheet(
        userId: reuid1Hjpq9xSCefWC ?? video.aC9dE1fG3hI5jK,
        isPresented: $shorepLN0qrzU93ezm5,
        onBlock: {
          buidrzaotDzVu2tOT = reuid1Hjpq9xSCefWC ?? video.aC9dE1fG3hI5jK
          bloYMGgfDIp3wRLn = true
        }
      )
      .environmentObject(fggp6oQ8ajgQJ)
      .environmentObject(router)
      .presentationDetents([.height(240)])
      .presentationBackground(.clear)
      .presentationDragIndicator(.hidden)
    }
    .blockDiaLcTUIAjgtcOHd(isPresented: $bloYMGgfDIp3wRLn, uidK1uO6OuOGNky0: buidrzaotDzVu2tOT)
    #if DEBUG
      .enableInjection()
    #endif
  }
}

@MainActor
class VdoModRfABf7Hmv5B3L: ObservableObject {
  @Published var vdowndXDeVKvaItC: l9O6Sz7QVA4SDVideoItem
  @Published var aue7tBYETD3uMWE: User?
  @Published var comcnt1yKL9CDOTbUPL: Int = 0

  private let vdoserdoTQkhB26w63l: VdoServproc63WnoDbxzFob0
  private let comserPgOQJOSzvXa7g: ComNAQ136mFLYkZJServproc
  private let auser6aU9JT6MzLuR5: Authsdmd0VXzbAnDYServProc
  private weak var fggp6oQ8ajgQJ: AuthManagA645b8Y0Aod3aVmod?

  init(
    video: l9O6Sz7QVA4SDVideoItem,
    vdoserdoTQkhB26w63l: VdoServproc63WnoDbxzFob0 = VdoServ63WnoDbxzFob0.shared,
    comserPgOQJOSzvXa7g: ComNAQ136mFLYkZJServproc = ComNAQ136mFLYkZJServ.shared,
    auser6aU9JT6MzLuR5: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    fggp6oQ8ajgQJ: AuthManagA645b8Y0Aod3aVmod? = nil
  ) {
    self.vdowndXDeVKvaItC = video
    self.vdoserdoTQkhB26w63l = vdoserdoTQkhB26w63l
    self.comserPgOQJOSzvXa7g = comserPgOQJOSzvXa7g
    self.auser6aU9JT6MzLuR5 = auser6aU9JT6MzLuR5
    self.fggp6oQ8ajgQJ = fggp6oQ8ajgQJ

    loadauWIW09n9WMBwMK()
    loadcnttc3bFoIhvq1o2()

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CommentAdded"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.loadcnttc3bFoIhvq1o2()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserBlocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.loadcnttc3bFoIhvq1o2()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("UserUnblocked"),
      object: nil,
      queue: .main
    ) { [weak self] _ in
      Task { @MainActor in
        self?.loadcnttc3bFoIhvq1o2()
      }
    }

    NotificationCenter.default.addObserver(
      forName: NSNotification.Name("CurrentUserUpdated"),
      object: nil,
      queue: .main
    ) { [weak self] notification in
      Task { @MainActor [weak self] in
        guard let self = self,
          let updatedUser = notification.userInfo?["user"] as? User,
          updatedUser.id == self.vdowndXDeVKvaItC.aC9dE1fG3hI5jK
        else { return }
        self.aue7tBYETD3uMWE = updatedUser
      }
    }
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  func setau9acW6L3twRIdS(_ fggp6oQ8ajgQJ: AuthManagA645b8Y0Aod3aVmod) {
    self.fggp6oQ8ajgQJ = fggp6oQ8ajgQJ
    if let curcdUbPGWeWrHDn = fggp6oQ8ajgQJ.currvj9QRUUPOWY4Ouser,
      curcdUbPGWeWrHDn.id == vdowndXDeVKvaItC.aC9dE1fG3hI5jK
    {
      aue7tBYETD3uMWE = curcdUbPGWeWrHDn
    }
    loadcnttc3bFoIhvq1o2()
  }

  func toglikesm6Xk6NVAHwlN() {
    vdowndXDeVKvaItC.iS1lI3kE5dN7eN.toggle()
    if vdowndXDeVKvaItC.iS1lI3kE5dN7eN {
      vdowndXDeVKvaItC.lI1kE3cO5uN7tN += 1
    } else {
      vdowndXDeVKvaItC.lI1kE3cO5uN7tN = max(0, vdowndXDeVKvaItC.lI1kE3cO5uN7tN - 1)
    }
    vdoserdoTQkhB26w63l.upduCnYQ7R2p8zJ7(vdowndXDeVKvaItC)
  }

  private func loadauWIW09n9WMBwMK() {
    aue7tBYETD3uMWE = auser6aU9JT6MzLuR5.getbyidQwpUuIWnzzs99(vdowndXDeVKvaItC.aC9dE1fG3hI5jK)

    if aue7tBYETD3uMWE == nil, let curL5QaQqVhnOWsu = fggp6oQ8ajgQJ?.currvj9QRUUPOWY4Ouser,
      curL5QaQqVhnOWsu.id == vdowndXDeVKvaItC.aC9dE1fG3hI5jK
    {
      aue7tBYETD3uMWE = curL5QaQqVhnOWsu
    }
  }

  private func loadcnttc3bFoIhvq1o2() {
    let n6dXuVrxrkgzd = comserPgOQJOSzvXa7g.locom1GrYz4YRiuJOq(for: vdowndXDeVKvaItC.id)
    let HuOH8bJg0TF4q = flitb2TFkKz4FGj7N(n6dXuVrxrkgzd)
    comcnt1yKL9CDOTbUPL = HuOH8bJg0TF4q.count
  }

  private func flitb2TFkKz4FGj7N(_ cmtsEkOTgC4a9jVcO: [Comment]) -> [Comment] {
    guard let blouidMRw5H0CE3upXU = fggp6oQ8ajgQJ?.currvj9QRUUPOWY4Ouser?.bQ7rS9tU1vW3xY,
      !blouidMRw5H0CE3upXU.isEmpty
    else {
      return cmtsEkOTgC4a9jVcO
    }
    return cmtsEkOTgC4a9jVcO.filter { !blouidMRw5H0CE3upXU.contains($0.aC9dE1fG3hI5jK) }
  }
}
