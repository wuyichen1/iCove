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
            ProgressView("处理支付中...")
              .padding()
              .background(Color.white)
              .cornerRadius(12)
          )
      }
    }
    .navigationBarHidden(true)
    .enableInjection()
    .onAppear {
      // 更新 PaymentViewModel 中的 authManager（使用 EnvironmentObject）
      paymentViewModel.updateAuthManager(authManager)

      // 如果产品列表为空，尝试加载产品（支付系统已在 app 启动时初始化）
      if paymentViewModel.products.isEmpty && !paymentViewModel.isLoadingProducts {
        Task {
          await paymentViewModel.loadProducts()
        }
      }
    }
    .alert("支付提示", isPresented: $showPaymentAlert) {
      Button("确定", role: .cancel) {
        // 重置支付状态
        paymentViewModel.resetPaymentStatus()
      }
    } message: {
      Text(paymentAlertMessage)
    }
    .onChange(of: paymentViewModel.paymentStatus) { oldValue, newStatus in
      // 监听支付状态变化
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

      // Wallet 标题 + 余额 + Sandbox 帮助按钮
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
  /// 购买卡片视图
  /// - Parameters:
  ///   - option: 购买选项
  ///   - index: 选项索引（用于获取对应的 productId）
  private func purchaseCard(option: PurchaseOption, index: Int) -> some View {
    Button {
      // 执行支付流程
      Task {
        await handlePurchase(option: option, index: index)
      }
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
    .disabled(isProcessingPayment)  // 支付处理中禁用按钮
  }

  // MARK: - Payment Handling
  /// 处理购买操作
  /// - Parameters:
  ///   - option: 购买选项
  ///   - index: 选项索引（保留用于未来扩展）
  private func handlePurchase(option: PurchaseOption, index: Int) async {
    // 检查是否有有效的 productId
    guard !option.productId.isEmpty else {
      showPaymentAlert(message: "产品 ID 无效，无法进行支付")
      return
    }

    // 检查支付服务是否可用
    let isAvailable = await paymentViewModel.checkPaymentServiceAvailable()
    if !isAvailable {
      showPaymentAlert(message: "支付服务不可用，请检查网络连接或 App Store 登录状态")
      return
    }

    // 如果产品列表为空，先加载产品
    if paymentViewModel.products.isEmpty {
      await paymentViewModel.loadProducts()
    }

    // 设置处理中状态
    isProcessingPayment = true

    // 执行支付
    await paymentViewModel.purchaseProduct(productId: option.productId)

    // 注意：支付状态变化会通过 onChange 监听器处理
    // 这里不需要手动设置 isProcessingPayment = false
    // 因为支付成功或失败后，onChange 会调用 handlePaymentStatusChange
  }

  /// 处理支付状态变化
  /// - Parameter status: 新的支付状态
  private func handlePaymentStatusChange(_ status: PaymentStatus) {
    // 重置处理中状态
    isProcessingPayment = false

    switch status {
    case .idle:
      // 空闲状态，不需要处理
      break

    case .loadingProducts:
      // 加载产品中，不显示遮罩层（避免一进入页面就显示）
      // 产品加载在后台进行，不影响用户操作
      break

    case .processing:
      // 处理支付中，显示处理提示
      isProcessingPayment = true

    case .success:
      // 支付成功
      // 根据选中的产品 ID 获取对应的胡萝卜数量
      if let selectedProductId = paymentViewModel.getSelectedProductId() {
        // 首先尝试从 purchaseOptions 中查找
        if let purchasedOption = diamondPackages.first(where: { $0.productId == selectedProductId })
        {
          showPaymentAlert(message: "支付成功！已获得 \(purchasedOption.carrots) 胡萝卜")
        } else if let product = paymentViewModel.getProduct(by: selectedProductId) {
          // 如果找不到对应的选项，从产品列表中获取
          showPaymentAlert(message: "支付成功！已获得 \(product.diamonds) 胡萝卜")
        } else {
          showPaymentAlert(message: "支付成功！")
        }
      } else {
        showPaymentAlert(message: "支付成功！")
      }

    case .failed(let message):
      // 支付失败
      // 检查是否是 Sandbox 账户相关错误
      if message.contains("Sandbox") || message.contains("sandbox") || message.contains("测试账户") {
        // 显示包含帮助信息的错误提示
        showPaymentAlert(
          message: "\(message)\n\n提示：购买时会自动弹出 Sandbox 账户登录提示，请按照系统提示操作。如需帮助，请点击右上角的帮助按钮。")
      } else {
        showPaymentAlert(message: "支付失败：\(message)")
      }

    case .canceled:
      // 用户取消支付
      showPaymentAlert(message: "支付已取消")

    case .restored:
      // 恢复购买成功
      showPaymentAlert(message: "购买已恢复")
    }
  }

  /// 显示支付提示弹窗
  /// - Parameter message: 提示消息
  private func showPaymentAlert(message: String) {
    paymentAlertMessage = message
    showPaymentAlert = true
  }
}

// MARK: - Helper Views
struct StepView: View {
  let number: Int
  let title: String
  let description: String

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      // 步骤编号
      Text("\(number)")
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 28, height: 28)
        .background(Color.blue)
        .clipShape(Circle())

      // 步骤内容
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.subheadline)
          .fontWeight(.semibold)

        Text(description)
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct BulletPoint: View {
  let text: String

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      Text("•")
        .foregroundColor(.orange)
      Text(text)
        .font(.caption)
        .foregroundColor(.secondary)
    }
  }
}

struct FAQItem: View {
  let question: String
  let answer: String

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text(question)
        .font(.subheadline)
        .fontWeight(.semibold)

      Text(answer)
        .font(.caption)
        .foregroundColor(.secondary)
    }
    .padding(.vertical, 4)
  }
}
