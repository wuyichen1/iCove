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
  @EnvironmentObject var paymentViewModel: PaymentViewModel

  // 支付状态提示
  @State private var showPaymentAlert = false
  @State private var paymentAlertMessage = ""
  @State private var isProcessingPayment = false
  // 当前选中的卡片索引
  @State private var selectedCardIndex: Int? = nil

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
            ForEach(Array(diamondPackages.enumerated()), id: \.element.id) { index, option in
              purchaseCard(option: option, index: index)
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 100)
        }
      }

      // 支付处理中遮罩层
      if isProcessingPayment {
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
    #if DEBUG
      .enableInjection()
    #endif
    .onAppear {
      paymentViewModel.updateAuthManager(authManager)

      // 如果产品列表为空，尝试加载产品
      if paymentViewModel.products.isEmpty && !paymentViewModel.isLoadingProducts {
        Task {
          await paymentViewModel.loadProducts()
        }
      }
    }
    .alert("Payment", isPresented: $showPaymentAlert) {
      Button("OK", role: .cancel) {
        paymentViewModel.resetPaymentStatus()
      }
    } message: {
      Text(paymentAlertMessage)
    }
    .onChange(of: paymentViewModel.paymentStatus) { _, newStatus in
      handlePaymentStatusChange(newStatus)
    }
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
  private func purchaseCard(option: PurchaseOption, index: Int) -> some View {
    let isSelected = selectedCardIndex == index

    return Button {
      // 更新选中状态
      selectedCardIndex = index
      Task {
        await handlePurchase(option: option, index: index)
      }
    } label: {
      ZStack {
        // 背景图片 - 拉伸填充整个卡片，不保持宽高比，不裁剪
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

        // 内容层
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
      // .frame(minWidth: 0, maxWidth: .infinity)
      .clipped()

    }
    .buttonStyle(.plain)
    .disabled(isProcessingPayment)
  }

  // MARK: - Payment Handling
  private func handlePurchase(option: PurchaseOption, index: Int) async {
    if paymentViewModel.products.isEmpty {
      await paymentViewModel.loadProducts()
    }
    await paymentViewModel.purchaseProduct(productId: option.productId)
  }

  private func handlePaymentStatusChange(_ status: PaymentStatus) {
    isProcessingPayment = false

    switch status {
    case .idle, .loadingProducts:
      break
    case .processing:
      isProcessingPayment = true
    case .success:
      showPaymentAlert(message: "Payment successful!")
    case .failed(let message):
      showPaymentAlert(message: "Payment failed: \(message)")
    case .canceled:
      showPaymentAlert(message: "Payment canceled")
    case .restored:
      showPaymentAlert(message: "Purchase restored")
    }
  }

  private func showPaymentAlert(message: String) {
    paymentAlertMessage = message
    showPaymentAlert = true
  }
}
