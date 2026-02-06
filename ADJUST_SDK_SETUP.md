# Adjust SDK 集成指南

## 问题说明

当前项目中打印了 "⚠️ [AdjustService] Adjust SDK 未导入，跳过初始化"，这是因为项目中还没有添加 Adjust SDK 依赖。

## 解决方案

### 方法 1：使用 Swift Package Manager（推荐）

1. 在 Xcode 中打开项目
2. 选择项目文件（iCove.xcodeproj）
3. 选择项目 Target（iCove）
4. 点击 "Package Dependencies" 标签
5. 点击 "+" 按钮添加包
6. 输入以下 URL：
   ```
   https://github.com/adjust/ios_sdk
   ```
7. 选择版本（建议选择最新稳定版本，如 5.5.2 或更高）
8. 在 "Add to Target" 中选择 "iCove"
9. 选择 "AdjustSdk" 包
10. 点击 "Add Package"

### 方法 2：使用 CocoaPods

1. 在项目根目录创建或编辑 `Podfile`：
   ```ruby
   platform :ios, '13.0'
   use_frameworks!

   target 'iCove' do
     pod 'Adjust', '~> 5.5.2'
   end
   ```

2. 运行安装命令：
   ```bash
   pod install
   ```

3. 之后使用 `.xcworkspace` 文件打开项目，而不是 `.xcodeproj`

### 方法 3：使用 Carthage

1. 在项目根目录创建或编辑 `Cartfile`：
   ```
   binary "https://raw.githubusercontent.com/adjust/ios_sdk/master/Carthage/AdjustSdk-Dynamic.json" ~> 5.5.2
   ```

2. 运行安装命令：
   ```bash
   carthage update
   ```

## 配置 Adjust SDK

### 1. 配置 App Token 和事件 Token

在 `AdjustService.swift` 文件中，找到以下位置并替换为实际的值：

```swift
// 第 60-70 行
private init() {
  // TODO: 替换为实际的 App Token
  self.appToken = "YourAppToken"  // 替换为你的 Adjust App Token
  
  // TODO: 根据实际情况选择环境
  self.environment = .production  // 或 .sandbox（测试环境）
  
  // TODO: 替换为实际的事件 Token
  self.launchEventToken = "launch_token"  // 替换为安装事件 Token
  self.purchaseEventToken = "purchase_token"  // 替换为购买事件 Token
}
```

### 2. 获取 App Token 和事件 Token

1. **App Token**：
   - 登录 Adjust 控制台
   - 进入你的应用设置
   - 在 "App Settings" 中找到 "App Token"

2. **事件 Token**：
   - 在 Adjust 控制台中进入 "Events" 页面
   - 创建或查看已有的事件
   - 每个事件都有一个唯一的 "Event Token"
   - 安装事件 Token：用于跟踪应用安装
   - 购买事件 Token：用于跟踪购买事件

## 验证安装

安装完成后，重新编译项目。如果安装成功，应用启动时会看到以下日志：

```
✅ [AdjustService] Adjust SDK 初始化成功
   - App Token: xxxxxx
   - Environment: Production
```

而不是：

```
⚠️ [AdjustService] Adjust SDK 未导入，跳过初始化
```

## 功能说明

### 1. 自动初始化

Adjust SDK 会在应用启动时自动初始化（在 `AppDelegate.swift` 的 `didFinishLaunchingWithOptions` 中调用）。

### 2. 安装事件跟踪

当 Adjust 归因信息更新时，会自动触发安装事件跟踪（在归因回调中调用 `trackLaunchEvent`）。

### 3. 购买事件跟踪

购买成功后，会自动记录购买事件到 Adjust（在 `PaymentModule.swift` 中调用 `trackPurchaseEvent`）。

## 对应 Flutter 代码

此 Swift 实现对应 Flutter 中的以下代码：

```dart
// 初始化
void adjustInit() {
  AdjustConfig config = AdjustConfig('YourAppToken', AdjustEnvironment.production);
  config.logLevel = AdjustLogLevel.verbose;
  config.isSendingInBackgroundEnabled = true;
  config.attributionCallback = (AdjustAttribution attributionChangedData) {
    appLaunch(launchToken);
  };
  Adjust.initSdk(config);
}

// 安装事件
appLaunch(String launch_token) async {
  AdjustEvent launchEvent = AdjustEvent(launch_token);
  Adjust.trackEvent(launchEvent);
}

// 购买事件
appPurchase(double dollar) async {
  AdjustEvent purchaseEvent = AdjustEvent(purchase_token);
  purchaseEvent.setRevenue(dollar, 'USD');
  Adjust.trackEvent(purchaseEvent);
}
```

## 注意事项

1. **环境选择**：
   - 生产环境：`.production` - 用于正式发布的应用
   - 沙盒环境：`.sandbox` - 用于开发和测试

2. **日志级别**：
   - 当前设置为 `ADJLogLevelVerbose`（完整日志）
   - 生产环境建议改为 `ADJLogLevelError` 或 `ADJLogLevelSuppress`

3. **隐私权限**：
   - 确保在 App Store Connect 中正确配置了隐私权限说明
   - Adjust SDK 会收集设备信息用于归因分析

4. **后台记录**：
   - 已启用 `isSendingInBackgroundEnabled = true`
   - 允许在应用后台时发送事件

## 当前状态

- ✅ `AdjustService.swift` 已创建并集成
- ✅ `AppDelegate.swift` 中已添加初始化调用
- ✅ `PaymentModule.swift` 中已添加购买事件跟踪
- ⚠️ 需要在项目中添加 Adjust SDK 依赖
- ⚠️ 需要配置实际的 App Token 和事件 Token

## 相关文件

- `iCove/iCove/Services/AdjustService.swift` - Adjust SDK 服务类
- `iCove/iCove/AppDelegate.swift` - 应用启动时初始化 Adjust SDK
- `iCove/iCove/Services/PaymentModule.swift` - 支付成功后记录购买事件

## 参考文档

- [Adjust iOS SDK 官方文档](https://dev.adjust.com/en/sdk/ios)
- [Adjust iOS SDK GitHub](https://github.com/adjust/ios_sdk)
- [Adjust 事件跟踪文档](https://dev.adjust.com/en/sdk/ios/features/events)

