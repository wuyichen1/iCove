# Facebook SDK 集成指南

## 问题说明

当前项目中打印了 "⚠️ [PaymentModule] Facebook SDK 未导入，跳过购买事件记录"，这是因为项目中还没有添加 Facebook SDK 依赖。

## 解决方案

### 方法 1：使用 Swift Package Manager（推荐）

1. 在 Xcode 中打开项目
2. 选择项目文件（iCove.xcodeproj）
3. 选择项目 Target（iCove）
4. 点击 "Package Dependencies" 标签
5. 点击 "+" 按钮添加包
6. 输入以下 URL：
   ```
   https://github.com/facebook/facebook-ios-sdk
   ```
7. 选择版本（建议选择最新稳定版本）
8. 在 "Add to Target" 中选择 "iCove"
9. 选择 "FBSDKCoreKit" 包（只需要 CoreKit，用于 App Events）
10. 点击 "Add Package"

### 方法 2：使用 CocoaPods

1. 在项目根目录创建 `Podfile`（如果不存在）：
   ```ruby
   platform :ios, '13.0'
   use_frameworks!

   target 'iCove' do
     pod 'FBSDKCoreKit'
   end
   ```

2. 运行安装命令：
   ```bash
   pod install
   ```

3. 之后使用 `.xcworkspace` 文件打开项目，而不是 `.xcodeproj`

## 验证安装

安装完成后，重新编译项目。如果安装成功，支付时会看到以下日志：
```
📊 [PaymentModule] 记录 Facebook 购买事件 - 金额: X.XX, 产品ID: xxx
```

而不是：
```
⚠️ [PaymentModule] Facebook SDK 未导入，跳过购买事件记录
```

## 注意事项

1. **Info.plist 配置**：已在 `Info.plist` 中配置了 Facebook App ID 和 Client Token，无需额外配置
2. **初始化**：Facebook SDK 会在应用启动时自动初始化（通过 Info.plist 配置）
3. **隐私权限**：确保在 App Store Connect 中正确配置了隐私权限说明

## 当前状态

- ✅ Info.plist 已配置 Facebook App ID: `1594082498477934`
- ✅ Info.plist 已配置 Facebook Client Token: `7ccf6f49f8da453a18e2ee53bf5dedf3`
- ✅ Info.plist 已配置 Facebook Display Name: `iCove`
- ✅ Info.plist 已配置 FacebookAutoLogAppEventsEnabled: `true`
- ✅ URL Scheme 已配置: `fb1594082498477934`
- ❌ Facebook SDK 依赖未添加（需要手动添加）

## 相关文件

- `iCove/iCove/iCove/Services/PaymentModule.swift` - 支付模块，包含 Facebook App Events 记录逻辑
- `iCove/iCove/iCove/Info.plist` - Facebook 配置信息

