//
//  WalletView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct WalletView: View {
  @EnvironmentObject var a2pv1DU9eRMWzG: AuthenticationManager
  @EnvironmentObject var router: Router
  @EnvironmentObject var payVmdEt8htQp1V38FI: PaymentViewModel

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
            ForEach(Array(diamondPackages.enumerated()), id: \.element.id) { index, option in
              purchaseCard(option: option, index: index)
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
    .navigationBarHidden(true)
    .onAppear {
      payVmdEt8htQp1V38FI.updateAuthManager(a2pv1DU9eRMWzG)

      if payVmdEt8htQp1V38FI.products.isEmpty && !payVmdEt8htQp1V38FI.isLoadingProducts {
        Task {
          await payVmdEt8htQp1V38FI.loadProducts()
        }
      }
    }
    .alert("Payment", isPresented: $payAlerto35gd3AGljvjh) {
      Button("OK", role: .cancel) {
        payVmdEt8htQp1V38FI.resetPaymentStatus()
      }
    } message: {
      Text(almsgYevgprGg8OOMT)
    }
    .onChange(of: payVmdEt8htQp1V38FI.paymentStatus) { _, newStatus in
      hanChangeeo7azSfT38yzY(newStatus)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Header
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

          Text("\(a2pv1DU9eRMWzG.currentUser?.balance ?? 0)")
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

  // MARK: - Purchase Card
  private func purchaseCard(option: PurchaseOption, index: Int) -> some View {
    let isSelected = selidx58gTTlEulUWHL == index

    return Button {
      selidx58gTTlEulUWHL = index
      Task {
        await hanPurcR2z380uw1K6WH(w7JuZqW8xTmzuopt: option, index: index)
      }
    } label: {
      ZStack {
        Image("hHBulkOHmM1uZi")
          .resizable()
          .overlay(
            Group {
              if isSelected {
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

          Text("\(option.carrots)")
            .font(.custom("FredokaOne-Regular", size: 20))
            .foregroundColor(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.top, 5)

          Text("$\(String(format: "%.2f", option.price))")
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

  private func hanPurcR2z380uw1K6WH(w7JuZqW8xTmzuopt: PurchaseOption, index: Int) async {
    if payVmdEt8htQp1V38FI.products.isEmpty {
      await payVmdEt8htQp1V38FI.loadProducts()
    }
    await payVmdEt8htQp1V38FI.purchaseProduct(productId: w7JuZqW8xTmzuopt.productId)
  }

  private func hanChangeeo7azSfT38yzY(_ status: PaymentStatus) {
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
