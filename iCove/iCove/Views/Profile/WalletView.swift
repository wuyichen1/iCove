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

/// 钱包页面
struct WalletView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  // 购买选项数据
  private let purchaseOptions: [PurchaseOption] = [
    PurchaseOption(carrots: 400, price: 0.99),
    PurchaseOption(carrots: 800, price: 1.99),
    PurchaseOption(carrots: 2450, price: 4.99),
    PurchaseOption(carrots: 3950, price: 7.99),
    PurchaseOption(carrots: 4900, price: 9.99),
    PurchaseOption(carrots: 9800, price: 19.99),
    PurchaseOption(carrots: 14900, price: 29.99),
    PurchaseOption(carrots: 24500, price: 49.99),
    PurchaseOption(carrots: 34500, price: 69.99),
    PurchaseOption(carrots: 49000, price: 99.99),
  ]

  var body: some View {
    ZStack {
      Image("KYECVROdZxhA1GUw")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部返回 + 标题 + 余额
        header
          .padding(.top, 46)
          .padding(.horizontal, 20)
          .padding(.bottom, 24)

        // 购买选项网格
        ScrollView {
          LazyVGrid(
            columns: [
              GridItem(.flexible(), spacing: 16),
              GridItem(.flexible(), spacing: 16),
              GridItem(.flexible(), spacing: 16),
            ],
            spacing: 0
          ) {
            ForEach(purchaseOptions, id: \.id) { option in
              purchaseCard(option: option)
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 100)
        }
      }
    }
    .navigationBarHidden(true)
    .enableInjection()
  }

  // MARK: - Header
  private var header: some View {
    VStack(spacing: 16) {
      // 返回按钮
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

      // Wallet 标题 + 余额
      HStack {
        Text("Wallet")
          .font(.custom("FredokaOne-Regular", size: 24))
          .foregroundColor(.black)

        Spacer()

        HStack(spacing: 6) {
          // 胡萝卜图标（如果有自定义图片可以使用，否则使用系统图标）
          Image("jXFWhEc2SdV2UuW7")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)

          Text("\(authManager.currentUser?.balance ?? 0)")
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
  private func purchaseCard(option: PurchaseOption) -> some View {
    Button {
      // 购买：更新用户余额
      authManager.addBalance(option.carrots)
    } label: {
      VStack(spacing: 0) {
        // 胡萝卜图标
        Image("jXFWhEc2SdV2UuW7")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)

        // 数量
        Text("\(option.carrots)")
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(.black)
          .lineLimit(1)
          .minimumScaleFactor(0.8)
          .padding(.top, 5)

        // 价格条
        Text("$\(String(format: "%.2f", option.price))")
          .font(.system(size: 14, weight: .semibold))
          .foregroundColor(.black)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 8)
          .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
              .fill(Color.white)
          )
          .padding(.top, 10)
      }
      .frame(maxWidth: .infinity)
      // .frame(height: 140)
      .padding(.vertical, 16)
      .padding(.horizontal, 12)
      .background(
        Image("DleSdqSGPchgXsQc")
          .resizable()
          .scaledToFill()
          .frame(maxHeight: 120)
          .clipped()
      )
    }
    .buttonStyle(.plain)
  }
}

// MARK: - Purchase Option Model
struct PurchaseOption: Identifiable {
  let id = UUID()
  let carrots: Int
  let price: Double
}
