//
//  UnfTdJMyy6tOB4gA.swift
//  iCove
//
//  Created by yangyang on 2026/2/2.
//

import Contacts
import CoreLocation
import Foundation
import UIKit

// MARK: - 常量类
class UnfTdJMyy6tOB4gA {
  // 77923858
  static let Qsag54S4BWNKaBLS = "44332211"
  static let kTdeEbKen9DwkLXZ = "https://opi.li65pe2f.link"
  static let T5LSCMubhHpMlNKX = "1.0.0"
}

// MARK: - 应用信息结构
struct BexfoRuvdHCb9AES {
  let GUTVqDtWEcTF2nrv: String  // 应用名称
  let StenP0UxCkyeS355: String  // URL Scheme
}

// MARK: - 获取设备信息
func Yixwkc5LlLlVToYI() {
  var systemInfo = utsname()
  uname(&systemInfo)

  // 获取设备型号 (machine)
  let machineMirror = Mirror(reflecting: systemInfo.machine)
  let identifier = machineMirror.children.reduce("") { identifier, element in
    guard let value = element.value as? Int8, value != 0 else { return identifier }
    let scalar = UnicodeScalar(UInt8(value))
    return identifier + String(scalar)
  }

  // 设置设备名称
  FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.Wt5fBRQ1ZDlBImWI = identifier

  // 如果设备ID为空，则生成
  if FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.A9ey5jWayK2kXWSs.isEmpty {
    if let vendorID = UIDevice.current.identifierForVendor?.uuidString {
      FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.A9ey5jWayK2kXWSs =
        vendorID + UnfTdJMyy6tOB4gA.Qsag54S4BWNKaBLS
    }
  }
}

// MARK: - 位置信息类
class Ti1ke3ecfRghBZdiT: ObservableObject {
  @Published var iPsqpBxjiipgKmoA: Double = 0.0  // 纬度
  @Published var uUZACsxOvs6NaVxR: Double = 0.0  // 经度
  @Published var ZDmDZc1xp1uvEdDd: String = ""  // 城市
  @Published var HjDS7QQbL0K1MJJI: String = ""  // 国家代码
  @Published var WFLqC8XHtFmNn7T2: String = ""  // 子区域
  @Published var uY5halP5d5kaSHgC: String = ""  // 行政区域

  func qZEmXkLdrxvRjfIf(
    BEMSIhBX3CmcrMUa: Double,
    PPDXw4rzUbNxfDiv: Double,
    b6esoHfRHsi0uzP1S: String,
    ZLTZlOF00bxkroMN: String,
    c7TaFcbCxpCkgsJXv: String,
    HhBiCaOHXo5NGp5X: String
  ) {
    iPsqpBxjiipgKmoA = BEMSIhBX3CmcrMUa
    uUZACsxOvs6NaVxR = PPDXw4rzUbNxfDiv
    ZDmDZc1xp1uvEdDd = b6esoHfRHsi0uzP1S
    HjDS7QQbL0K1MJJI = ZLTZlOF00bxkroMN
    WFLqC8XHtFmNn7T2 = c7TaFcbCxpCkgsJXv
    uY5halP5d5kaSHgC = HhBiCaOHXo5NGp5X
  }
}

// MARK: - 全局变量
var Y6FkAsxBg8tf7jUQ: Bool = true
var kBeecYCHpzEIbBtR: [String] = []
var ZDHLLBxofCahBpud: [String] = []
var R9cLZIY6yOMykwp5: String = ""
var jKTDKbmOLjzrW6iT: [String] = []
var sBXmGiE8yHF9iVi5 = Ti1ke3ecfRghBZdiT()

// MARK: - 定位权限相关全局变量
var locationPermissionCompletion: ((Bool) -> Void)?
var isWaitingForSettingsReturn: Bool = false
var locationRequestSuccess: Bool = false  // 定位是否成功

// MARK: - 定位管理器
class LocationManager: NSObject, CLLocationManagerDelegate {
  static let shared = LocationManager()

  private let locationManager = CLLocationManager()
  private var completion: ((Result<CLLocation, Error>) -> Void)?
  private var timeoutTimer: Timer?

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  // 获取当前权限状态
  var authorizationStatus: CLAuthorizationStatus {
    return locationManager.authorizationStatus
  }

  // 请求定位权限（公开方法）
  func requestAuthorization() {
    locationManager.requestWhenInUseAuthorization()
  }

  func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
    self.completion = completion

    // 检查定位服务是否启用
    guard CLLocationManager.locationServicesEnabled() else {
      completion(
        .failure(
          NSError(
            domain: "LocationError", code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Location services are not enabled"])))
      return
    }

    // 检查权限
    let status = locationManager.authorizationStatus
    if status == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
      return
    }

    if status == .denied || status == .restricted {
      completion(
        .failure(
          NSError(
            domain: "LocationError", code: -2,
            userInfo: [NSLocalizedDescriptionKey: "Location permission denied"])))
      return
    }

    // 开始定位
    locationManager.requestLocation()

    // 设置超时
    timeoutTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [weak self] _ in
      self?.locationManager.stopUpdatingLocation()
      self?.completion?(
        .failure(
          NSError(
            domain: "LocationError", code: -3,
            userInfo: [NSLocalizedDescriptionKey: "Location request timeout"])))
      self?.completion = nil
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    timeoutTimer?.invalidate()
    timeoutTimer = nil

    if let location = locations.first {
      completion?(.success(location))
      completion = nil
    }
    locationManager.stopUpdatingLocation()
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    timeoutTimer?.invalidate()
    timeoutTimer = nil
    completion?(.failure(error))
    completion = nil
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    print("🔄 权限状态变化: \(status.rawValue)")

    // 如果权限已授予，继续获取定位
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      // 如果有 requestLocation 的 completion，继续定位
      if completion != nil {
        manager.requestLocation()
      } else if let pendingCompletion = locationPermissionCompletion {
        // 如果有等待权限请求的 completion，现在可以继续获取定位
        // 对应 Flutter: 请求权限后继续执行
        // 注意：这里会重新调用 ZB3eGKrC681vFIsn，它会检查系统定位服务是否启用
        let savedCompletion = pendingCompletion
        locationPermissionCompletion = nil
        ZB3eGKrC681vFIsn(completion: savedCompletion)
      }
    } else if status == .denied || status == .restricted {
      // 权限被拒绝
      if let savedCompletion = completion {
        savedCompletion(
          .failure(
            NSError(
              domain: "LocationError", code: -2,
              userInfo: [NSLocalizedDescriptionKey: "Location permission denied"])))
        completion = nil
      }
      // 如果有等待权限请求的 completion，显示弹窗
      if let pendingCompletion = locationPermissionCompletion {
        let savedPendingCompletion = pendingCompletion
        locationPermissionCompletion = nil
        mLBaG7PqVl0GRL6m { shouldReturn in
          Y6FkAsxBg8tf7jUQ = true
          locationRequestSuccess = false
          savedPendingCompletion(false)
        }
      }
    }
    // .notDetermined 状态不需要处理，等待用户响应
  }
}

// MARK: - 获取定位信息（对应 Flutter 的 personalizedCosplayConnectionHub）
func ZB3eGKrC681vFIsn(completion: @escaping (Bool) -> Void = { _ in }) {
  Y6FkAsxBg8tf7jUQ = false
  locationRequestSuccess = false  // 重置成功标志

  // 1. 先检查应用是否同意访问定位权限（对应 Flutter: checkPermission）
  // 注意：即使系统定位服务未启用，如果权限是 .notDetermined，也应该先请求权限
  // 这样系统会显示权限弹窗，用户授权后，如果系统定位服务未启用，再提示用户
  let status = LocationManager.shared.authorizationStatus
  print("🔍 定位权限状态: \(status.rawValue)")

  // 2. 如果权限是 .notDetermined，先请求权限（对应 Flutter: requestPermission）
  // 这样会显示系统权限弹窗，显示 Info.plist 中的 NSLocationWhenInUseUsageDescription
  if status == .notDetermined {
    print("ℹ️ 权限未确定，请求权限（会显示系统权限弹窗）")
    LocationManager.shared.requestAuthorization()
    // 保存 completion，等待权限状态变化（通过 locationManagerDidChangeAuthorization 处理）
    locationPermissionCompletion = completion
    return
  }

  // 3. 检查位置服务是否启用（对应 Flutter: isLocationServiceEnabled）
  // 注意：这里在权限已确定后才检查系统定位服务
  guard CLLocationManager.locationServicesEnabled() else {
    // 提示用户打开位置服务（对应 Flutter: customFolkMusicChallenges）
    showToast(
      "We require access to your location to offer current location services. Please enable location services."
    )
    Y6FkAsxBg8tf7jUQ = true
    locationRequestSuccess = false
    completion(false)
    return
  }

  // 4. 如果权限是 denied，尝试再次请求权限（对应 Flutter: requestPermission）
  // 注意：在 iOS 中，如果用户之前拒绝过，再次请求可能不会显示弹窗
  // 但为了与 Flutter 逻辑一致，我们仍然尝试请求
  if status == .denied {
    print("ℹ️ 权限被拒绝，尝试再次请求权限")
    LocationManager.shared.requestAuthorization()
    // 保存 completion，等待权限状态变化
    // 如果用户仍然拒绝，状态会保持 .denied，在 locationManagerDidChangeAuthorization 中处理
    locationPermissionCompletion = completion
    return
  }

  // 5. 如果权限是 deniedForever（iOS 中是 .restricted），显示弹窗
  // 注意：Flutter 代码中这部分被注释了，但为了用户体验，我们保留
  if status == .restricted {
    print("⚠️ 权限被永久拒绝（restricted），显示弹窗")
    mLBaG7PqVl0GRL6m { shouldReturn in
      Y6FkAsxBg8tf7jUQ = true
      locationRequestSuccess = false
      completion(false)
    }
    return
  }

  // 6. 权限已授予，获取位置信息（对应 Flutter: getCurrentPosition）
  // 超时设置为 10 秒（对应 Flutter: timeout(const Duration(seconds: 10))）
  LocationManager.shared.requestLocation { result in
    switch result {
    case .success(let location):
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude

      // 7. 反向地理编码（对应 Flutter: placemarkFromCoordinates）
      reverseGeocode(latitude: latitude, longitude: longitude) { placemark in
        if let placemark = placemark {
          // 处理位置信息（对应 Flutter: isoCountryCode 等）
          J2605xWQMoCiFTMA(
            placemark: placemark,
            latitude: latitude,
            longitude: longitude
          )
          locationRequestSuccess = true  // 定位成功
          Y6FkAsxBg8tf7jUQ = true
          completion(true)
        } else {
          // 对应 Flutter: "No address could be found for the provided coordinates."
          showToast("No address could be found for the provided coordinates.")
          locationRequestSuccess = false
          Y6FkAsxBg8tf7jUQ = true
          completion(false)
        }
      }

    case .failure(let error):
      // 8. 处理超时异常（对应 Flutter: on TimeoutException）
      if let nsError = error as NSError? {
        if nsError.code == -3 {
          // 对应 Flutter: "The attempt to retrieve location information timed out. Please try again later."
          showToast(
            "The attempt to retrieve location information timed out. Please try again later.")
        } else if nsError.code == -2 {
          // 权限被拒绝，显示弹窗
          mLBaG7PqVl0GRL6m { shouldReturn in
            Y6FkAsxBg8tf7jUQ = true
            locationRequestSuccess = false
            completion(false)
          }
          return
        } else {
          // 对应 Flutter: "Unable to retrieve the location."
          showToast("Unable to retrieve the location.")
        }
      } else {
        showToast("Unable to retrieve the location.")
      }
      Y6FkAsxBg8tf7jUQ = true
      locationRequestSuccess = false
      completion(false)
    }
  }
}

// MARK: - 反向地理编码
func reverseGeocode(
  latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?) -> Void
) {
  let geocoder = CLGeocoder()
  let location = CLLocation(latitude: latitude, longitude: longitude)

  geocoder.reverseGeocodeLocation(location) { placemarks, error in
    if let error = error {
      print("Reverse geocoding error: \(error)")
      completion(nil)
      return
    }

    completion(placemarks?.first)
  }
}

// MARK: - 处理位置信息
func J2605xWQMoCiFTMA(placemark: CLPlacemark, latitude: Double, longitude: Double) {
  let locality = placemark.locality ?? ""
  let isoCountryCode = placemark.isoCountryCode ?? ""
  let subLocality = placemark.subLocality ?? ""
  let administrativeArea = placemark.administrativeArea ?? ""

  Y6FkAsxBg8tf7jUQ = true

  sBXmGiE8yHF9iVi5.qZEmXkLdrxvRjfIf(
    BEMSIhBX3CmcrMUa: latitude,
    PPDXw4rzUbNxfDiv: longitude,
    b6esoHfRHsi0uzP1S: locality,
    ZLTZlOF00bxkroMN: isoCountryCode,
    c7TaFcbCxpCkgsJXv: subLocality,
    HhBiCaOHXo5NGp5X: administrativeArea
  )
}

// MARK: - 获取设备首选语言列表
func WfDsyAPSa9VlHh9Q() {
  kBeecYCHpzEIbBtR = Locale.preferredLanguages
}

// MARK: - 应用列表
let MNFZ3z0mmadgbdIt: [BexfoRuvdHCb9AES] = [
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "WhatsApp", StenP0UxCkyeS355: "whatsapp"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "Instagram", StenP0UxCkyeS355: "instagram"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "Facebook", StenP0UxCkyeS355: "fb"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "TikTok", StenP0UxCkyeS355: "tiktok"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "GoogleMaps", StenP0UxCkyeS355: "comgooglemaps"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "twitter", StenP0UxCkyeS355: "tweetie"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "qq", StenP0UxCkyeS355: "mqq"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "weiChat", StenP0UxCkyeS355: "wechat"),
  BexfoRuvdHCb9AES(GUTVqDtWEcTF2nrv: "Aliapp", StenP0UxCkyeS355: "alipay"),
]

// MARK: - 检查已安装的应用
func IvLSJk2Z2Cd1nTVY() {
  ZDHLLBxofCahBpud = []
  let group = DispatchGroup()
  let queue = DispatchQueue(label: "app.check", attributes: .concurrent)

  for app in MNFZ3z0mmadgbdIt {
    group.enter()
    queue.async {
      let urlString = "\(app.StenP0UxCkyeS355)://"
      if let url = URL(string: urlString),
        UIApplication.shared.canOpenURL(url)
      {
        ZDHLLBxofCahBpud.append(app.GUTVqDtWEcTF2nrv)
      }
      group.leave()
    }
  }
  group.wait()
}
// func IvLSJk2Z2Cd1nTVY() {
//   ZDHLLBxofCahBpud = []

//   for app in MNFZ3z0mmadgbdIt {
//     let urlString = "\(app.StenP0UxCkyeS355)://"
//     if let url = URL(string: urlString) {
//       if UIApplication.shared.canOpenURL(url) {
//         ZDHLLBxofCahBpud.append(app.GUTVqDtWEcTF2nrv)
//       }
//     }
//   }
// }

// MARK: - 判断是否为中国
func U7YKGFJMaWM0Cg2W() -> Bool {
  var isChina = false

  // 获取当前语言
  let locale = Locale.current
  if #available(iOS 16, *) {
    let languageCode = locale.language.languageCode?.identifier ?? ""
    let regionCode = locale.region?.identifier ?? ""

    // 检查语言
    if languageCode.contains("zh") || regionCode.contains("CN") {
      isChina = true
    }
  } else {
    let languageCode = locale.languageCode ?? ""
    let regionCode = locale.regionCode ?? ""

    // 检查语言
    if languageCode.contains("zh") || regionCode.contains("CN") {
      isChina = true
    }
  }

  // 获取时区
  R9cLZIY6yOMykwp5 = TimeZone.current.identifier

  // 检查时区
  if R9cLZIY6yOMykwp5 == "Asia/Shanghai" || R9cLZIY6yOMykwp5 == "Asia/Chongqing" {
    isChina = true
  }

  return isChina
}

// MARK: - 获取键盘语言数组
func c0IZPbR2Sxs8mg7l() {
  // iOS 中获取键盘语言的方法
  // 注意：iOS 没有直接获取键盘语言的 API，这里返回当前设备的首选语言
  jKTDKbmOLjzrW6iT = Locale.preferredLanguages
}

// MARK: - 显示 Toast (需要根据项目实际情况实现)
func showToast(_ message: String) {
  // 这里可以使用项目中的 Toast 实现
  // 如果没有，可以使用简单的 print 或者创建 Alert
  print("Toast: \(message)")

  // 如果需要显示 Alert，可以使用以下代码（需要在主线程调用）
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

// MARK: - 打开设置页面（用于定位权限被永久拒绝时）
func VYbxArumCTrtB1Yb() {
  // 确保在跳转设置前，app 已经请求过权限（这样设置中才会显示定位权限选项）
  // 如果权限状态是 .notDetermined，先请求一次权限
  let status = LocationManager.shared.authorizationStatus
  if status == .notDetermined {
    LocationManager.shared.requestAuthorization()
    // 等待一下，让系统处理权限请求
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      openAppSettings()
    }
  } else {
    openAppSettings()
  }
}

// MARK: - 打开 app 设置页面
private func openAppSettings() {
  if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
    if UIApplication.shared.canOpenURL(settingsUrl) {
      UIApplication.shared.open(settingsUrl, options: [:]) { success in
        if success {
          print("✅ 成功打开设置页面")
        } else {
          print("❌ 打开设置页面失败")
        }
      }
    } else {
      print("❌ 无法打开设置 URL")
    }
  } else {
    print("❌ 设置 URL 无效")
  }
}

// MARK: - 显示定位权限弹窗（类似 Flutter 的 mLBaG7PqVl0GRL6m）
func mLBaG7PqVl0GRL6m(completion: @escaping (Bool) -> Void) {
  print("📱 准备显示定位权限弹窗")

  // 保存 completion，以便从设置返回后使用
  locationPermissionCompletion = completion
  isWaitingForSettingsReturn = true

  // 使用弱引用避免循环引用
  var observer: NSObjectProtocol?
  observer = NotificationCenter.default.addObserver(
    forName: UIApplication.willEnterForegroundNotification,
    object: nil,
    queue: .main
  ) { _ in
    guard isWaitingForSettingsReturn else { return }
    print("📱 应用从设置返回，重新检查权限")
    // 延迟一点时间，确保权限状态已更新
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      // 检查权限状态
      let status = LocationManager.shared.authorizationStatus
      let servicesEnabled = CLLocationManager.locationServicesEnabled()

      // 如果权限已授予且服务已启用，重新尝试获取定位
      if servicesEnabled && (status == .authorizedWhenInUse || status == .authorizedAlways) {
        print("✅ 权限已授予，重新获取定位")
        // 重置标志
        Y6FkAsxBg8tf7jUQ = false
        locationRequestSuccess = false

        ZB3eGKrC681vFIsn { success in
          // 调用保存的 completion
          if let savedCompletion = locationPermissionCompletion {
            savedCompletion(success)
            locationPermissionCompletion = nil
            isWaitingForSettingsReturn = false
          }
          // 移除观察者
          if let obs = observer {
            NotificationCenter.default.removeObserver(obs)
          }
        }
      } else {
        // 权限还是没有授予，直接返回 false
        print("❌ 权限仍未授予")
        locationRequestSuccess = false
        if let savedCompletion = locationPermissionCompletion {
          savedCompletion(false)
          locationPermissionCompletion = nil
          isWaitingForSettingsReturn = false
        }
        // 移除观察者
        if let obs = observer {
          NotificationCenter.default.removeObserver(obs)
        }
      }
    }
  }

  DispatchQueue.main.async {
    print("📱 在主线程显示弹窗")

    // 尝试多种方式获取根视图控制器
    var rootViewController: UIViewController?

    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
        rootViewController = window.rootViewController
      } else if let window = windowScene.windows.first {
        rootViewController = window.rootViewController
      }
    }

    // 如果还是找不到，尝试从 delegate 获取
    if rootViewController == nil {
      if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
        as? UIWindowSceneDelegate,
        let window = sceneDelegate.window,
        let rootVC = window?.rootViewController
      {
        rootViewController = rootVC
      }
    }

    guard let rootVC = rootViewController else {
      print("❌ 无法找到根视图控制器")
      completion(false)
      locationPermissionCompletion = nil
      isWaitingForSettingsReturn = false
      if let obs = observer {
        NotificationCenter.default.removeObserver(obs)
      }
      return
    }

    // 找到最顶层的视图控制器
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
        print("✅ 用户点击了 Go to Settings")
        VYbxArumCTrtB1Yb()
        // 不立即调用 completion，等待从设置返回后自动检查
      })

    alert.addAction(
      UIAlertAction(title: "Cancel", style: .cancel) { _ in
        print("❌ 用户点击了 Cancel")
        if let savedCompletion = locationPermissionCompletion {
          savedCompletion(false)
          locationPermissionCompletion = nil
          isWaitingForSettingsReturn = false
        }
        if let obs = observer {
          NotificationCenter.default.removeObserver(obs)
        }
      })

    print("📱 正在显示弹窗")
    topViewController.present(alert, animated: true) {
      print("✅ 弹窗已显示")
    }
  }
}
