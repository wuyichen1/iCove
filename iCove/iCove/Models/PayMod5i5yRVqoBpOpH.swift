//
//  PaymentModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/23.
//

import Foundation
import StoreKit

struct PayProdRVqoBpOpH: Identifiable, Equatable {
  let id: String
  let F3a0686zLgphO: String
  let C677GrOXFKrCz: String
  let BEdd9dgBlT2XI: Decimal
  let diaGDfiUAxvMX5uR: Int

  init(from V8mOwGXGDfQFF: Product, diaGDfiUAxvMX5uR: Int) {
    self.id = V8mOwGXGDfQFF.id
    self.F3a0686zLgphO = V8mOwGXGDfQFF.displayName
    self.C677GrOXFKrCz = V8mOwGXGDfQFF.description
    self.BEdd9dgBlT2XI = V8mOwGXGDfQFF.price
    self.diaGDfiUAxvMX5uR = diaGDfiUAxvMX5uR
  }
}

enum Psystus60ZmDMzftZSZw: Equatable {
  case idle
  case loadingProducts
  case processing
  case success
  case failed(String)
  case canceled
  case restored
}

enum PayerryHmJFBwocwVuY: LocalizedError {
  case unavailAT9azcXBITovY
  case probofdRlDRbrMqv4WxD(String)
  case profialqxQdMUOkp7Lqh(String)
  case purfail5irHyXdjwkSaw(String)
  case verfImTPmU91HRVHn
  case unkowniosjsupGLzzAI(String)

  var erdesniu2dZl1hSlti: String? {
    switch self {
    case .unavailAT9azcXBITovY:
      return "Payment services unavailable"
    case .probofdRlDRbrMqv4WxD(let productId):
      return "Product not found: \(productId)"
    case .profialqxQdMUOkp7Lqh(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    case .purfail5irHyXdjwkSaw(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    case .verfImTPmU91HRVHn:
      return "Transaction verification failed"
    case .unkowniosjsupGLzzAI(let msgf4LoPRVzacN4m):
      return msgf4LoPRVzacN4m
    }
  }
}

struct PuroptWphPFw4mRa9N9: Identifiable {
  let id = UUID()
  let carrotsze1FZwh5WkpoW: Int
  let pricevsq55ZFkHtJBE: Double
  let pcodedDuCfV7Kep75r: String
}

let diaPckgscQLNBm8gVonHu: [PuroptWphPFw4mRa9N9] = [
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 400, pricevsq55ZFkHtJBE: 0.99, pcodedDuCfV7Kep75r: "siuziwgdniidihel"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 800, pricevsq55ZFkHtJBE: 1.99, pcodedDuCfV7Kep75r: "chbctkbcootjmwln"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 2450, pricevsq55ZFkHtJBE: 4.99, pcodedDuCfV7Kep75r: "edvihpgcgfjqpuef"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 3950, pricevsq55ZFkHtJBE: 7.99, pcodedDuCfV7Kep75r: "otbtbbpbjycbcz"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 5150, pricevsq55ZFkHtJBE: 9.99, pcodedDuCfV7Kep75r: "plflnjyqoylgaebq"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 10800, pricevsq55ZFkHtJBE: 19.99, pcodedDuCfV7Kep75r: "dhizdtvygzuucyjk"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 14900, pricevsq55ZFkHtJBE: 29.99, pcodedDuCfV7Kep75r: "hjykcaoxygywfq"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 29400, pricevsq55ZFkHtJBE: 49.99, pcodedDuCfV7Kep75r: "mnfprttfacargfjo"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 34500, pricevsq55ZFkHtJBE: 69.99, pcodedDuCfV7Kep75r: "gqyqcndprvmzsy"),
  PuroptWphPFw4mRa9N9(
    carrotsze1FZwh5WkpoW: 63700, pricevsq55ZFkHtJBE: 99.99, pcodedDuCfV7Kep75r: "bsacoassevtvnezx"),
]

let proidsPxeTsOfse3oQ8: [String] = diaPckgscQLNBm8gVonHu.map { $0.pcodedDuCfV7Kep75r }
