//
//  Payn8tqsrRpmXPZWVmod.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//  此文件是适配器，将新的 PaymentModule 适配到现有代码
//

import Combine
import Foundation
import StoreKit
import SwiftUI

/// 支付成功处理器适配器，用于连接 PaymentModule 和现有的 AuthManager
@MainActor
private class PaymentSuccessHandlerAdapter: PaymentSuccessHandler {
  private weak var authManager: AuthManagA645b8Y0Aod3aVmod?
  private let authService: Authsdmd0VXzbAnDYServProc

  init(authManager: AuthManagA645b8Y0Aod3aVmod, authService: Authsdmd0VXzbAnDYServProc) {
    self.authManager = authManager
    self.authService = authService
  }

  func addBalance(_ amount: Int) {
    authManager?.addbanxsQVAH9mAY0ZZ(amount)
  }

  func updateUser() {
    if let currentUser = authManager?.currvj9QRUUPOWY4Ouser {
      authService.upd39Yrqyc7YxrPf(currentUser)
    }
  }
}

/// 支付 ViewModel - 使用合并后的 PaymentModule
/// 此 ViewModel 保持与现有代码的兼容性，内部使用新的 PaymentModule
@MainActor
class Payn8tqsrRpmXPZWVmod: ObservableObject {
  // 使用新的 PaymentModule 中的 ViewModel
  private let paymentModule: PaymentViewModelBase

  // 为了保持兼容性，暴露相同的属性
  @Published var pros1FessbjOCPZuE: [PayProdRVqoBpOpH] = []
  @Published var stuXwBv2xiiWPj4U: Psystus60ZmDMzftZSZw = .idle
  @Published var errlTB7VE3zUfXPr: String?
  @Published var lopingSfYVxI17xwzFY: Bool = false
  @Published var sele2p0Tz2CJngEqZidx: Int?

  private var successHandlerAdapter: PaymentSuccessHandlerAdapter?

  init(
    hbxFiWQcWP75Zserv: PayServnDaWE7QuyO56jProc? = nil,
    IS2i7T25V612b: AuthManagA645b8Y0Aod3aVmod,
    GXSI49ebk5OUK: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared,
    autoInitialize: Bool = false
  ) {
    // 创建适配器
    let adapter = PaymentSuccessHandlerAdapter(
      authManager: IS2i7T25V612b,
      authService: GXSI49ebk5OUK
    )
    self.successHandlerAdapter = adapter

    // 创建新的 PaymentModule ViewModel
    self.paymentModule = PaymentViewModelBase(
      hbxFiWQcWP75Zserv: hbxFiWQcWP75Zserv,
      successHandler: adapter,
      autoInitialize: false
    )

    // 监听属性变化
    observePaymentModule()

    if autoInitialize {
      Task {
        await initZKQ7zcla5jX0Y()
      }
    }
  }

  // 同步内部模块的属性到外部属性
  private func syncProperties() {
    // 使用 Combine 的 sink 来同步属性
    // 注意：这里需要监听 paymentModule 的属性变化
    pros1FessbjOCPZuE = paymentModule.pros1FessbjOCPZuE
    stuXwBv2xiiWPj4U = paymentModule.stuXwBv2xiiWPj4U
    errlTB7VE3zUfXPr = paymentModule.errlTB7VE3zUfXPr
    lopingSfYVxI17xwzFY = paymentModule.lopingSfYVxI17xwzFY
    sele2p0Tz2CJngEqZidx = paymentModule.sele2p0Tz2CJngEqZidx
  }

  // 监听内部模块的属性变化
  private var cancellables: Set<AnyCancellable> = []

  private func observePaymentModule() {
    paymentModule.$pros1FessbjOCPZuE
      .assign(to: &$pros1FessbjOCPZuE)
    paymentModule.$stuXwBv2xiiWPj4U
      .assign(to: &$stuXwBv2xiiWPj4U)
    paymentModule.$errlTB7VE3zUfXPr
      .assign(to: &$errlTB7VE3zUfXPr)
    paymentModule.$lopingSfYVxI17xwzFY
      .assign(to: &$lopingSfYVxI17xwzFY)
    paymentModule.$sele2p0Tz2CJngEqZidx
      .assign(to: &$sele2p0Tz2CJngEqZidx)
  }

  func initZKQ7zcla5jX0Y() async {
    await paymentModule.initZKQ7zcla5jX0Y()
  }

  func loadzXWNROryo53Db() async {
    await paymentModule.loadzXWNROryo53Db()
  }

  func relpay7vImdn19ATr15(pidkxe68JHwzNP58: String) async {
    await paymentModule.relpay7vImdn19ATr15(pidkxe68JHwzNP58: pidkxe68JHwzNP58)
  }

  func restorePiBwOqacnYVqP() async {
    await paymentModule.restorePiBwOqacnYVqP()
  }

  func redssf7ssJoNt3ObDB() {
    paymentModule.redssf7ssJoNt3ObDB()
  }

  func updAuma7Cif2ltv9c65t(_ IS2i7T25V612b: AuthManagA645b8Y0Aod3aVmod) {
    // 更新适配器中的 authManager
    let adapter = PaymentSuccessHandlerAdapter(
      authManager: IS2i7T25V612b,
      authService: Authsdmd0VXzbAnDYServ.shared
    )
    self.successHandlerAdapter = adapter
    paymentModule.setSuccessHandler(adapter)
  }
}
