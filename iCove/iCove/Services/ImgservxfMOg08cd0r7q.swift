//
//  ImgservxfMOg08cd0r7q.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import Foundation
import UIKit

class ImgservxfMOg08cd0r7q {
  static let shared = ImgservxfMOg08cd0r7q()

  private init() {}

  func savTolocalGnA4faaPYNYmz(
    _ imgYrj7nvaRZzSQj: UIImage, prefix9Z9hDXriSUPhB: String = "image",
    uid0UcUIvLw3HhOS: String? = nil
  ) -> String? {
    let t8e0dveXYuTNDU = Int(Date().timeIntervalSince1970)
    let CDYvZ5nRXaAgG = uid0UcUIvLw3HhOS != nil ? "_\(uid0UcUIvLw3HhOS!)" : ""
    let jSupdKXhBhUDz = "\(prefix9Z9hDXriSUPhB)\(CDYvZ5nRXaAgG)_\(t8e0dveXYuTNDU).jpg"

    guard let bNOJwkdpbQH3s = imgYrj7nvaRZzSQj.jpegData(compressionQuality: 0.8) else {
      return nil
    }

    let cBOlyo3lQZzte = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      .first!
    let xLDjmVQUAsI32 = cBOlyo3lQZzte.appendingPathComponent("UserImages")

    try? FileManager.default.createDirectory(
      at: xLDjmVQUAsI32, withIntermediateDirectories: true, attributes: nil)

    let TyVPFZY5HC6h6 = xLDjmVQUAsI32.appendingPathComponent(jSupdKXhBhUDz)

    do {
      try bNOJwkdpbQH3s.write(to: TyVPFZY5HC6h6)
      return jSupdKXhBhUDz
    } catch {
      print("Failed to save image: \(error)")
      return nil
    }
  }
}
