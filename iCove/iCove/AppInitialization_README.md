# 应用初始化说明文档

## 概述

本文档说明 Swift 项目中应用启动时的初始化功能，对应 Flutter 项目 `main.dart` 中的初始化逻辑。

## 初始化功能分析

### 1. 持久化数据初始化 ✅ 已实现

**Flutter 代码：**
```dart
await FlW0vlw1jBvjx3hy().r38wmZLXCKtowlhOi();
await FlW0vlw1jBvjx3hy().clearAllPersistentData();
```

**Swift 实现：**
- 位置：`iCoveApp.swift` 的 `init()` 方法
- 功能：从 UserDefaults 和 Keychain 中加载持久化数据
- 实现类：`FlW0vlw1jBvjx3hy.swift`

**代码：**
```swift
// 初始化持久化数据（从存储中加载数据）
FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.r38wmZLXCKtowlhOi()

// 注意：clearAllPersistentData() 通常是测试代码，生产环境不应在启动时清空数据
```

**说明：**
- `r38wmZLXCKtowlhOi()` 从存储中加载所有持久化变量
- `clearAllPersistentData()` 已注释，因为生产环境不应在启动时清空数据
- 如需清空数据，可在特定场景（如退出登录）下调用

### 2. 推送通知 Token 处理 ✅ 已实现

**Flutter 代码：**
```dart
const MethodChannel s8PpmrwBmjoUBVNcs = MethodChannel('RetrographicSubpixelAntiAliasing');
s8PpmrwBmjoUBVNcs.setMethodCallHandler((MethodCall call) async {
  if (call.method == 'RetrographicSubpixelAntiAliasingReceived') {
    final p2JaMIqVMQCEjszQE = call.arguments as String?;
    if (p2JaMIqVMQCEjszQE != null && p2JaMIqVMQCEjszQE.isNotEmpty) {
      FlW0vlw1jBvjx3hy().mmnN2bMkxLm3iqBA = p2JaMIqVMQCEjszQE;
    }
  }
});
```

**Swift 实现：**
- 位置：`AppDelegate.swift`
- 功能：注册推送通知，接收 device token 并保存到持久化存储
- 实现方法：
  - `registerForPushNotifications()` - 注册推送通知
  - `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` - 接收 token

**代码：**
```swift
// 在 AppDelegate 的 didFinishLaunchingWithOptions 中
registerForPushNotifications(application: application)

// 接收 token 后自动保存
func application(_ application: UIApplication, 
                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
  let token = tokenParts.joined()
  FlW0vlw1jBvjx3hy.EN6tBVb4ZAvwC626.mmnN2bMkxLm3iqBA = token
}
```

**说明：**
- iOS 原生应用直接使用 `UIApplicationDelegate` 处理推送通知
- 无需 MethodChannel，token 会自动通过 delegate 方法接收
- Token 自动保存到 `FlW0vlw1jBvjx3hy` 的 `mmnN2bMkxLm3iqBA` 属性

### 3. 屏幕保护功能 ✅ 已实现

**Flutter 代码：**
```dart
unawaited(
  () async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageWithBlur();
  }(),
);
```

**Swift 实现：**
- 位置：
  - `iCoveApp.swift` 的 `init()` - 启用截图保护
  - `AppDelegate.swift` - 处理后台模糊效果
  - `ScreenProtector.swift` - 屏幕保护工具类

**功能说明：**

#### 3.1 防止截图
- 方法：`ScreenProtector.shared.preventScreenshotOn()`
- 功能：监听截图事件，检测到截图时显示警告
- 限制：iOS 无法完全防止截图，只能检测并警告

#### 3.2 防止数据泄露（后台模糊）
- 方法：`ScreenProtector.shared.protectDataLeakageWithBlur()`
- 触发时机：应用进入后台时自动调用
- 功能：在应用窗口上添加模糊视图，防止应用切换器显示敏感内容

**代码：**
```swift
// 在 iCoveApp.init() 中
ScreenProtector.shared.preventScreenshotOn()

// 在 AppDelegate 中
func applicationDidEnterBackground(_ application: UIApplication) {
  ScreenProtector.shared.protectDataLeakageWithBlur()
}

func applicationWillEnterForeground(_ application: UIApplication) {
  ScreenProtector.shared.removeDataLeakageProtection()
}
```

### 4. 屏幕方向锁定 ✅ 已实现

**Flutter 代码：**
```dart
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
]);
```

**Swift 实现：**
- 位置：`Info.plist`
- 配置项：
  - `UISupportedInterfaceOrientations` - iPhone 支持的方向
  - `UISupportedInterfaceOrientations~ipad` - iPad 支持的方向

**代码：**
```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
<key>UISupportedInterfaceOrientations~ipad</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
</array>
```

**说明：**
- iOS 中屏幕方向主要在 `Info.plist` 中配置
- SwiftUI 中也可以通过 `.preferredInterfaceOrientationForPresentation()` 设置，但主要依赖 Info.plist

## 文件结构

### 新增文件

1. **AppDelegate.swift**
   - 处理应用生命周期
   - 推送通知注册和 token 接收
   - 后台/前台切换时的屏幕保护

2. **ScreenProtector.swift**
   - 屏幕保护工具类
   - 截图检测
   - 后台模糊效果

### 修改文件

1. **iCoveApp.swift**
   - 添加 `@UIApplicationDelegateAdaptor` 使用 AppDelegate
   - 在 `init()` 中添加初始化逻辑

2. **Info.plist**
   - 添加屏幕方向锁定配置

## 初始化流程

```
应用启动
  ↓
iCoveApp.init()
  ↓
1. 初始化持久化数据 (FlW0vlw1jBvjx3hy.r38wmZLXCKtowlhOi())
  ↓
2. 启用截图保护 (ScreenProtector.shared.preventScreenshotOn())
  ↓
AppDelegate.didFinishLaunchingWithOptions
  ↓
3. 注册推送通知 (registerForPushNotifications)
  ↓
4. 设置屏幕方向 (Info.plist 配置)
  ↓
应用就绪
```

## 需要的 Xcode 依赖

### 系统框架（无需额外安装）

1. **Foundation** - 基础功能
2. **UIKit** - UI 和应用生命周期
3. **UserNotifications** - 推送通知
4. **Security** - Keychain 存储（已在 FlW0vlw1jBvjx3hy.swift 中使用）

所有功能都使用 iOS 系统原生 API，无需第三方依赖。

## 注意事项

### 1. 推送通知权限

- 首次运行时会弹出推送通知权限请求
- 需要在 `Info.plist` 中配置推送通知权限说明（如果还没有）
- 建议添加：`NSUserNotificationsUsageDescription`

### 2. 屏幕保护限制

- **截图保护**：iOS 无法完全防止截图，只能检测并警告
- **后台模糊**：在应用进入后台时自动添加，进入前台时自动移除

### 3. 屏幕方向

- 主要通过 `Info.plist` 配置
- 如果需要在运行时动态改变方向，可以使用 `UIViewController` 的 `supportedInterfaceOrientations` 属性

### 4. 持久化数据清空

- `clearAllPersistentData()` 已在代码中注释
- 生产环境不应在启动时清空数据
- 如需清空，可在退出登录等场景下调用

## 测试建议

1. **推送通知测试**
   - 运行应用，检查是否弹出权限请求
   - 检查控制台是否输出 "Push token received"
   - 验证 token 是否保存到 `FlW0vlw1jBvjx3hy.mmnN2bMkxLm3iqBA`

2. **屏幕保护测试**
   - 尝试截图，检查是否显示警告
   - 切换到后台，检查是否显示模糊效果
   - 切换回前台，检查模糊效果是否移除

3. **屏幕方向测试**
   - 旋转设备，检查是否保持竖屏
   - 验证所有界面都保持竖屏方向

4. **持久化数据测试**
   - 设置一些数据，重启应用
   - 检查数据是否正确加载

## 版本信息

- **创建日期**: 2026/2/2
- **对应 Flutter 版本**: `main.dart`
- **Swift 版本**: 5.0+
- **iOS 版本**: iOS 13.0+

## 相关文件

- `iCoveApp.swift` - 应用入口和初始化
- `AppDelegate.swift` - 应用生命周期和推送通知
- `ScreenProtector.swift` - 屏幕保护功能
- `FlW0vlw1jBvjx3hy.swift` - 持久化存储
- `Info.plist` - 应用配置

