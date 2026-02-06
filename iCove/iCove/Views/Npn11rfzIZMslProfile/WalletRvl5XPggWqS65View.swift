//
//  WalletRvl5XPggWqS65View.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct WalletRvl5XPggWqS65View: View {
  @EnvironmentObject var a2pv1DU9eRMWzG: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @EnvironmentObject var payVmdEt8htQp1V38FI: Payn8tqsrRpmXPZWVmod

  @State private var payAlerto35gd3AGljvjh = false
  @State private var almsgYevgprGg8OOMT = ""
  @State private var procs4HE3zkNHwbOT2 = false

  @State private var selidx58gTTlEulUWHL: Int? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Image("KYECVROdZxhA1GUw")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {
        topae5fstR00vn56
          .padding(.top, 46)
          .padding(.horizontal, 20)
          .padding(.bottom, 24)

        ScrollView {
          LazyVGrid(
            columns: [
              GridItem(.flexible(), spacing: 16),
              GridItem(.flexible(), spacing: 16),
              GridItem(.flexible(), spacing: 16),
            ],
            spacing: 0
          ) {
            ForEach(Array(diaPckgscQLNBm8gVonHu.enumerated()), id: \.element.id) { index, option in
              prcardPaymentProduct(opt0WgonV2TGpPtW: option, index: index)
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 100)
        }
      }

      if procs4HE3zkNHwbOT2 {
        Color.black.opacity(0.3)
          .ignoresSafeArea()
          .overlay(
            ProgressView("Processing payment...")
              .padding()
              .background(Color.white)
              .cornerRadius(12)
          )
      }
    }
    .navigationBarHiddenWithSwipeBack()
    .onAppear {
      payVmdEt8htQp1V38FI.updAuma7Cif2ltv9c65t(a2pv1DU9eRMWzG)

      if payVmdEt8htQp1V38FI.pros1FessbjOCPZuE.isEmpty && !payVmdEt8htQp1V38FI.lopingSfYVxI17xwzFY {
        Task {
          await payVmdEt8htQp1V38FI.loadzXWNROryo53Db()
        }
      }
    }
    .alert("Payment", isPresented: $payAlerto35gd3AGljvjh) {
      Button("OK", role: .cancel) {
        payVmdEt8htQp1V38FI.redssf7ssJoNt3ObDB()
      }
    } message: {
      Text(almsgYevgprGg8OOMT)
    }
    .onChange(of: payVmdEt8htQp1V38FI.stuXwBv2xiiWPj4U) { _, newStatus in
      hanChangeeo7azSfT38yzY(newStatus)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var topae5fstR00vn56: some View {
    VStack(spacing: 16) {
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

        Spacer()
      }

      HStack {
        Text("Wallet")
          .font(.custom("FredokaOne-Regular", size: 24))
          .foregroundColor(.black)

        Spacer()

        HStack(spacing: 6) {
          Image("jXFWhEc2SdV2UuW7")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)

          Text("\(a2pv1DU9eRMWzG.currvj9QRUUPOWY4Ouser?.bP2qR4sT6uV8wX ?? 0)")
            .font(.custom("FredokaOne-Regular", size: 20))
            .foregroundColor(.black)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 14)
      .background(
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .fill(Color("yinguanglv"))
      )
      .frame(maxWidth: 230)
    }
  }

  private func prcardPaymentProduct(opt0WgonV2TGpPtW: PuroptWphPFw4mRa9N9, index: Int) -> some View
  {
    let setdiCWeSKqcQG0io = selidx58gTTlEulUWHL == index

    return Button {
      selidx58gTTlEulUWHL = index
      Task {
        await hanPurcR2z380uw1K6WH(w7JuZqW8xTmzuopt: opt0WgonV2TGpPtW, index: index)
      }
    } label: {
      ZStack {
        Image("hHBulkOHmM1uZi")
          .resizable()
          .overlay(
            Group {
              if setdiCWeSKqcQG0io {
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.white, lineWidth: 2)
              }
            }
          )
          .padding(2)
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 126)

        VStack(spacing: 0) {
          Image("jXFWhEc2SdV2UuW7")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .padding(.top, 5)

          Text("\(opt0WgonV2TGpPtW.carrotsze1FZwh5WkpoW)")
            .font(.custom("FredokaOne-Regular", size: 20))
            .foregroundColor(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.top, 5)

          Text("$\(String(format: "%.2f", opt0WgonV2TGpPtW.pricevsq55ZFkHtJBE))")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.black)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
              RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.white)
            )
            .padding(.top, 15)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
      }
      .clipped()

    }
    .buttonStyle(.plain)
    .disabled(procs4HE3zkNHwbOT2)
  }

  private func hanPurcR2z380uw1K6WH(w7JuZqW8xTmzuopt: PuroptWphPFw4mRa9N9, index: Int) async {
    await payVmdEt8htQp1V38FI.relpay7vImdn19ATr15(
      pidkxe68JHwzNP58: w7JuZqW8xTmzuopt.pcodedDuCfV7Kep75r)
  }

  private func hanChangeeo7azSfT38yzY(_ status: Psystus60ZmDMzftZSZw) {
    procs4HE3zkNHwbOT2 = false

    switch status {
    case .idle, .loadingProducts:
      break
    case .processing:
      procs4HE3zkNHwbOT2 = true
    case .success:
      payAlerto35gd3AGljvjh(msgHULVqjMvdvUU4: "Payment successful!")
    case .failed(let msgHULVqjMvdvUU4):
      payAlerto35gd3AGljvjh(msgHULVqjMvdvUU4: "Payment failed: \(msgHULVqjMvdvUU4)")
    case .canceled:
      payAlerto35gd3AGljvjh(msgHULVqjMvdvUU4: "Payment canceled")
    case .restored:
      payAlerto35gd3AGljvjh(msgHULVqjMvdvUU4: "Purchase restored")
    }
  }

  private func payAlerto35gd3AGljvjh(msgHULVqjMvdvUU4: String) {
    almsgYevgprGg8OOMT = msgHULVqjMvdvUU4
    payAlerto35gd3AGljvjh = true
  }
}
