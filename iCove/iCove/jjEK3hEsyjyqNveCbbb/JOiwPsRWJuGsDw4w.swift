//
//  JOiwPsRWJuGsDw4w.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import Contacts
import CoreLocation
import Foundation
import UIKit

class JOiwPsRWJuGsDw4w {
  // 77923858
  static let q5ipAG3FJBQZiLkjr = "77923858"
  static let FdQAOEQbNVql1u09 = "https://opi.li65pe2f.link"
  static let LyT22mIfpUZoBYnT = "1.1.0"
}

struct Kk9VObEVtqyhiffn {
  let ma53aGsARLx6MShp: String
  let Dtk5s5TXWVpaX9Ii: String
}

func FYV7Dhia0n5CrgvO() {
  var Vqri00h1bMhaeP2s = utsname()
  uname(&Vqri00h1bMhaeP2s)

  let WpxkdqmxcXdFl8nb = Mirror(reflecting: Vqri00h1bMhaeP2s.machine)
  let K9SzAMP1nARR1iIe = WpxkdqmxcXdFl8nb.children.reduce("") { K9SzAMP1nARR1iIe, element in
    guard let CvkwBfI4NJyLNN4b = element.value as? Int8, CvkwBfI4NJyLNN4b != 0 else {
      return K9SzAMP1nARR1iIe
    }
    let uzRJZqahnYCl2HQQ = UnicodeScalar(UInt8(CvkwBfI4NJyLNN4b))
    return K9SzAMP1nARR1iIe + String(uzRJZqahnYCl2HQQ)
  }

  QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.v1uxolvQvuBShvrrL = K9SzAMP1nARR1iIe

  if QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.bJ6QpJWei7m3PS8U.isEmpty {
    if let vendorID = UIDevice.current.identifierForVendor?.uuidString {
      QXpn2II4KVY26Jz2.XUgjT2hpCIlk3FWG.bJ6QpJWei7m3PS8U =
        vendorID + JOiwPsRWJuGsDw4w.q5ipAG3FJBQZiLkjr
    }
  }
}

class H5JlNtIOzXxqvxX5j: ObservableObject {
  @Published var cQ2StaF0zQcVlBmn: Double = 0.0
  @Published var FNMx3wqn1DVSJXVK: Double = 0.0
  @Published var jUE8U9XHaNC0nk56: String = ""
  @Published var TBxDDNgHitOkdJJa: String = ""
  @Published var ScZ5JoFhIzD52nwy: String = ""
  @Published var JU9njnmg2WRn1zet: String = ""

  func OQzlS4dfPvCq1IZV(
    r3MasgQBEevfxt2i0: Double,
    ARQxFbql3iFUzAIb: Double,
    I2YsXeSotHA8UtLH: String,
    PRV5hMT00WQ02Ly6: String,
    kzgZhpdwgSIygBF5: String,
    spo18htngwe6xKan: String
  ) {
    cQ2StaF0zQcVlBmn = r3MasgQBEevfxt2i0
    FNMx3wqn1DVSJXVK = ARQxFbql3iFUzAIb
    jUE8U9XHaNC0nk56 = I2YsXeSotHA8UtLH
    TBxDDNgHitOkdJJa = PRV5hMT00WQ02Ly6
    ScZ5JoFhIzD52nwy = kzgZhpdwgSIygBF5
    JU9njnmg2WRn1zet = spo18htngwe6xKan
  }
}

var CtgAyHr1SymMU6OG: Bool = true
var j5QMeBYJygpdWE2Yo: [String] = []
var el5FpJNqYH9Tz7fW: [String] = []
var BFY1s3mActpSwfWD: String = ""
var LnI24PMVofwRqStW: [String] = []
var Z9WEGtgFinazN4mf = H5JlNtIOzXxqvxX5j()

var j7hOf7fMZCw8180V: ((Bool) -> Void)?
var dFeM05MQy4jSgzpH: Bool = false
var vyh0pp4OCqg6eBtU: Bool = false

class Hzh2qdaLd2XccvhM: NSObject, CLLocationManagerDelegate {
  static let shared = Hzh2qdaLd2XccvhM()

  private let hA28D0HXs0gsZY55 = CLLocationManager()
  private var completion: ((Result<CLLocation, Error>) -> Void)?
  private var timeoutTimer: Timer?

  override init() {
    super.init()
    hA28D0HXs0gsZY55.delegate = self
    hA28D0HXs0gsZY55.desiredAccuracy = kCLLocationAccuracyBest
  }

  var au1iNVRTqtBe3n3pc8: CLAuthorizationStatus {
    return hA28D0HXs0gsZY55.authorizationStatus
  }

  func requestAuthorization() {
    hA28D0HXs0gsZY55.requestWhenInUseAuthorization()
  }

  func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
    self.completion = completion

    guard CLLocationManager.locationServicesEnabled() else {
      completion(
        .failure(
          NSError(
            domain: "LocationError", code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Location services are not enabled"])))
      return
    }

    let vHNr3jekq7rz8Wr0 = hA28D0HXs0gsZY55.authorizationStatus
    if vHNr3jekq7rz8Wr0 == .notDetermined {
      hA28D0HXs0gsZY55.requestWhenInUseAuthorization()
      return
    }

    if vHNr3jekq7rz8Wr0 == .denied || vHNr3jekq7rz8Wr0 == .restricted {
      completion(
        .failure(
          NSError(
            domain: "LocationError", code: -2,
            userInfo: [NSLocalizedDescriptionKey: "Location permission denied"])))
      return
    }

    hA28D0HXs0gsZY55.requestLocation()

    timeoutTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [weak self] _ in
      self?.hA28D0HXs0gsZY55.stopUpdatingLocation()
      self?.completion?(
        .failure(
          NSError(
            domain: "LocationError", code: -3,
            userInfo: [NSLocalizedDescriptionKey: "Location request timeout"])))
      self?.completion = nil
    }
  }

  func hA28D0HXs0gsZY55(
    _ manager: CLLocationManager, didUpdateLocations VUGgoePa2P8gfhah: [CLLocation]
  ) {
    timeoutTimer?.invalidate()
    timeoutTimer = nil

    if let Ct7OovTRuM41pUI1 = VUGgoePa2P8gfhah.first {
      completion?(.success(Ct7OovTRuM41pUI1))
      completion = nil
    }
    hA28D0HXs0gsZY55.stopUpdatingLocation()
  }

  func hA28D0HXs0gsZY55(_ manager: CLLocationManager, didFailWithError error: Error) {
    timeoutTimer?.invalidate()
    timeoutTimer = nil
    completion?(.failure(error))
    completion = nil
  }

}

func m4dbv0tWg4OPsWG7(completion: @escaping (Bool) -> Void = { _ in }) {
  CtgAyHr1SymMU6OG = false
  vyh0pp4OCqg6eBtU = false

  let oURxFaiZXlduLW6C = Hzh2qdaLd2XccvhM.shared.au1iNVRTqtBe3n3pc8

  if oURxFaiZXlduLW6C == .notDetermined {
    Hzh2qdaLd2XccvhM.shared.requestAuthorization()
    j7hOf7fMZCw8180V = completion
    return
  }

  guard CLLocationManager.locationServicesEnabled() else {
    showiHKqTs7mKnc5UkgbToast(
      "We require access to your location to offer current location services. Please enable location services."
    )
    CtgAyHr1SymMU6OG = true
    vyh0pp4OCqg6eBtU = false
    completion(false)
    return
  }

  if oURxFaiZXlduLW6C == .denied {
    Hzh2qdaLd2XccvhM.shared.requestAuthorization()
    j7hOf7fMZCw8180V = completion
    return
  }

  if oURxFaiZXlduLW6C == .restricted {
    WmmQ3dfJdQVroH6V { shouldReturn in
      CtgAyHr1SymMU6OG = true
      vyh0pp4OCqg6eBtU = false
      completion(false)
    }
    return
  }

  Hzh2qdaLd2XccvhM.shared.requestLocation { result in
    switch result {
    case .success(let location):
      let H73iEFJre5IP7wgW = location.coordinate.latitude
      let erpvu4RP28SfkQDT = location.coordinate.longitude

      K7SdzqsmJtK6h9xS(zjF9MttRozXogVVD: H73iEFJre5IP7wgW, B49OyWTTYJALmRdV: erpvu4RP28SfkQDT) {
        placemark in
        if let placemark = placemark {
          HKCoPP8pMCCSZg4j(
            placemark: placemark,
            latitude: H73iEFJre5IP7wgW,
            longitude: erpvu4RP28SfkQDT
          )
          vyh0pp4OCqg6eBtU = true
          CtgAyHr1SymMU6OG = true
          completion(true)
        } else {
          showiHKqTs7mKnc5UkgbToast("No address could be found for the provided coordinates.")
          vyh0pp4OCqg6eBtU = false
          CtgAyHr1SymMU6OG = true
          completion(false)
        }
      }

    case .failure(let error):
      if let nsError = error as NSError? {
        if nsError.code == -3 {
          showiHKqTs7mKnc5UkgbToast(
            "The attempt to retrieve location information timed out. Please try again later.")
        } else if nsError.code == -2 {
          WmmQ3dfJdQVroH6V { shouldReturn in
            CtgAyHr1SymMU6OG = true
            vyh0pp4OCqg6eBtU = false
            completion(false)
          }
          return
        } else {
          showiHKqTs7mKnc5UkgbToast("Unable to retrieve the location.")
        }
      } else {
        showiHKqTs7mKnc5UkgbToast("Unable to retrieve the location.")
      }
      CtgAyHr1SymMU6OG = true
      vyh0pp4OCqg6eBtU = false
      completion(false)
    }
  }
}

func K7SdzqsmJtK6h9xS(
  zjF9MttRozXogVVD: Double, B49OyWTTYJALmRdV: Double, completion: @escaping (CLPlacemark?) -> Void
) {
  let IRSfxOyNHHnR4Ui9 = CLGeocoder()
  let BjYJ6GskOq1ExLP8 = CLLocation(latitude: zjF9MttRozXogVVD, longitude: B49OyWTTYJALmRdV)

  IRSfxOyNHHnR4Ui9.reverseGeocodeLocation(BjYJ6GskOq1ExLP8) { placemarks, error in
    if let error = error {
      completion(nil)
      return
    }

    completion(placemarks?.first)
  }
}

func HKCoPP8pMCCSZg4j(placemark: CLPlacemark, latitude: Double, longitude: Double) {
  let qCRU3r8kDtFESR7u = placemark.locality ?? ""
  let vSvwqeJjkqbfcLuU = placemark.isoCountryCode ?? ""
  let Kneu2gX25Azsqf6D = placemark.subLocality ?? ""
  let administrativeArea = placemark.administrativeArea ?? ""

  CtgAyHr1SymMU6OG = true

  Z9WEGtgFinazN4mf.OQzlS4dfPvCq1IZV(
    r3MasgQBEevfxt2i0: latitude,
    ARQxFbql3iFUzAIb: longitude,
    I2YsXeSotHA8UtLH: qCRU3r8kDtFESR7u,
    PRV5hMT00WQ02Ly6: vSvwqeJjkqbfcLuU,
    kzgZhpdwgSIygBF5: Kneu2gX25Azsqf6D,
    spo18htngwe6xKan: administrativeArea
  )
}

func WfDsyAPSa9VlHh9Q() {
  j5QMeBYJygpdWE2Yo = Locale.preferredLanguages
}

let MNFZ3z0mmadgbdIt: [Kk9VObEVtqyhiffn] = [
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "WhatsApp", Dtk5s5TXWVpaX9Ii: "whatsapp"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "Instagram", Dtk5s5TXWVpaX9Ii: "instagram"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "Facebook", Dtk5s5TXWVpaX9Ii: "fb"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "TikTok", Dtk5s5TXWVpaX9Ii: "tiktok"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "GoogleMaps", Dtk5s5TXWVpaX9Ii: "comgooglemaps"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "twitter", Dtk5s5TXWVpaX9Ii: "tweetie"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "qq", Dtk5s5TXWVpaX9Ii: "mqq"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "weiChat", Dtk5s5TXWVpaX9Ii: "wechat"),
  Kk9VObEVtqyhiffn(ma53aGsARLx6MShp: "Aliapp", Dtk5s5TXWVpaX9Ii: "alipay"),
]

func X3v8NsNOmho0vQGh() {
  el5FpJNqYH9Tz7fW = []
  let y2WENE948OfRRFRr = DispatchGroup()
  let gdQiTc8m7UGsiAOm = DispatchQueue(label: "app.check", attributes: .concurrent)

  for Zg0CS6HN0gLodjJ0 in MNFZ3z0mmadgbdIt {
    y2WENE948OfRRFRr.enter()
    gdQiTc8m7UGsiAOm.async {
      let urlString = "\(Zg0CS6HN0gLodjJ0.Dtk5s5TXWVpaX9Ii)://"
      if let url = URL(string: urlString),
        UIApplication.shared.canOpenURL(url)
      {
        el5FpJNqYH9Tz7fW.append(Zg0CS6HN0gLodjJ0.ma53aGsARLx6MShp)
      }
      y2WENE948OfRRFRr.leave()
    }
  }
  y2WENE948OfRRFRr.wait()
}

func SXTk4sx5PmnlmFRr() -> Bool {
  var YvgikMwkgSkJrf8F = false

  let u05CszC9ytD213o1 = Locale.current
  if #available(iOS 16, *) {
    let p2aZfpo1xk8RjLvL = u05CszC9ytD213o1.language.languageCode?.identifier ?? ""
    let PpgL5SUeqI0ltES4 = u05CszC9ytD213o1.region?.identifier ?? ""

    if p2aZfpo1xk8RjLvL.contains("zh") || PpgL5SUeqI0ltES4.contains("CN") {
      YvgikMwkgSkJrf8F = true
    }
  } else {
    let p2aZfpo1xk8RjLvL = u05CszC9ytD213o1.languageCode ?? ""
    let PpgL5SUeqI0ltES4 = u05CszC9ytD213o1.regionCode ?? ""

    if p2aZfpo1xk8RjLvL.contains("zh") || PpgL5SUeqI0ltES4.contains("CN") {
      YvgikMwkgSkJrf8F = true
    }
  }

  BFY1s3mActpSwfWD = TimeZone.current.identifier

  if BFY1s3mActpSwfWD == "Asia/Shanghai" || BFY1s3mActpSwfWD == "Asia/Chongqing" {
    YvgikMwkgSkJrf8F = true
  }

  return YvgikMwkgSkJrf8F
}

func MDlX5twh2QLzXrWD() {
  LnI24PMVofwRqStW = Locale.preferredLanguages
}

func showiHKqTs7mKnc5UkgbToast(_ message: String) {
  DispatchQueue.main.async {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
      let window = windowScene.windows.first,
      let rootViewController = window.rootViewController
    {
      let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
      rootViewController.present(alert, animated: true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          alert.dismiss(animated: true)
        }
      }
    }
  }
}

func sZpDyJTpoxSVLTqK() {
  let status = Hzh2qdaLd2XccvhM.shared.au1iNVRTqtBe3n3pc8
  if status == .notDetermined {
    Hzh2qdaLd2XccvhM.shared.requestAuthorization()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      openAppSettings()
    }
  } else {
    openAppSettings()
  }
}

private func openAppSettings() {
  if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, options: [:]) { success in
      }
    } else {
      print("❌settings URL is invalid")
    }
  }
}

func WmmQ3dfJdQVroH6V(completion: @escaping (Bool) -> Void) {
  j7hOf7fMZCw8180V = completion
  dFeM05MQy4jSgzpH = true

  var YHLxZ3TcDVvHDKCA: NSObjectProtocol?
  YHLxZ3TcDVvHDKCA = NotificationCenter.default.addObserver(
    forName: UIApplication.willEnterForegroundNotification,
    object: nil,
    queue: .main
  ) { _ in
    guard dFeM05MQy4jSgzpH else { return }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      let status = Hzh2qdaLd2XccvhM.shared.au1iNVRTqtBe3n3pc8
      let servicesEnabled = CLLocationManager.locationServicesEnabled()

      if servicesEnabled && (status == .authorizedWhenInUse || status == .authorizedAlways) {
        CtgAyHr1SymMU6OG = false
        vyh0pp4OCqg6eBtU = false

        m4dbv0tWg4OPsWG7 { success in
          if let savedCompletion = j7hOf7fMZCw8180V {
            savedCompletion(success)
            j7hOf7fMZCw8180V = nil
            dFeM05MQy4jSgzpH = false
          }
          if let obs = YHLxZ3TcDVvHDKCA {
            NotificationCenter.default.removeObserver(obs)
          }
        }
      } else {
        vyh0pp4OCqg6eBtU = false
        if let savedCompletion = j7hOf7fMZCw8180V {
          savedCompletion(false)
          j7hOf7fMZCw8180V = nil
          dFeM05MQy4jSgzpH = false
        }

        if let obs = YHLxZ3TcDVvHDKCA {
          NotificationCenter.default.removeObserver(obs)
        }
      }
    }
  }

  DispatchQueue.main.async {
    var z71j31c7hKj2mhLB: UIViewController?

    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
        z71j31c7hKj2mhLB = window.rootViewController
      } else if let window = windowScene.windows.first {
        z71j31c7hKj2mhLB = window.rootViewController
      }
    }

    if z71j31c7hKj2mhLB == nil {
      if let FrSVHtLfzvTLCErA = UIApplication.shared.connectedScenes.first?.delegate
        as? UIWindowSceneDelegate,
        let window = FrSVHtLfzvTLCErA.window,
        let rootVC = window?.rootViewController
      {
        z71j31c7hKj2mhLB = rootVC
      }
    }

    guard let rootVC = z71j31c7hKj2mhLB else {
      completion(false)
      j7hOf7fMZCw8180V = nil
      dFeM05MQy4jSgzpH = false
      if let obs = YHLxZ3TcDVvHDKCA {
        NotificationCenter.default.removeObserver(obs)
      }
      return
    }

    var topViewController = rootVC
    while let presented = topViewController.presentedViewController {
      topViewController = presented
    }

    let alert = UIAlertController(
      title: nil,
      message:
        "This app requires the permission to access your location information in order to provide you with more personalized services. Your location data will be strictly confidential and will only be used upon your active authorization, for the purpose of enhancing your overall usage experience.",
      preferredStyle: .alert
    )

    alert.addAction(
      UIAlertAction(title: "Go to Settings", style: .default) { _ in
        sZpDyJTpoxSVLTqK()
      })

    alert.addAction(
      UIAlertAction(title: "Cancel", style: .cancel) { _ in
        if let savedCompletion = j7hOf7fMZCw8180V {
          savedCompletion(false)
          j7hOf7fMZCw8180V = nil
          dFeM05MQy4jSgzpH = false
        }
        if let obs = YHLxZ3TcDVvHDKCA {
          NotificationCenter.default.removeObserver(obs)
        }
      })

    topViewController.present(alert, animated: true) {

    }
  }
}
