# Swift 原生支付功能使用说明

本文档说明如何在 Swift 项目中使用 App Store Sandbox 模式下的支付功能。

## 📁 文件结构

支付功能包含以下三个核心文件：

1. **Models/PaymentModels.swift** - 支付相关的数据模型
2. **Services/PaymentService.swift** - 支付服务，处理 StoreKit 逻辑
3. **ViewModels/PaymentViewModel.swift** - 支付视图模型，管理支付状态

## 🚀 快速开始

### 1. 在 View 中使用 PaymentViewModel

```swift
import SwiftUI

struct PaymentView: View {
    @StateObject private var paymentViewModel: PaymentViewModel
    @EnvironmentObject var authManager: AuthenticationManager
    
    init(authManager: AuthenticationManager) {
        _paymentViewModel = StateObject(wrappedValue: PaymentViewModel(authManager: authManager))
    }
    
    var body: some View {
        VStack {
            // 显示产品列表
            if paymentViewModel.isLoadingProducts {
                ProgressView("加载产品中...")
            } else {
                List(paymentViewModel.products) { product in
                    ProductRow(product: product) {
                        // 点击购买
                        Task {
                            await paymentViewModel.purchaseProduct(productId: product.id)
                        }
                    }
                }
            }
            
            // 显示支付状态
            if case .success = paymentViewModel.paymentStatus {
                Text("支付成功！")
                    .foregroundColor(.green)
            } else if case .failed(let message) = paymentViewModel.paymentStatus {
                Text("支付失败：\(message)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            // 初始化支付（如果还未初始化）
            Task {
                await paymentViewModel.initializePayment()
            }
        }
    }
}
```

### 2. 购买产品

```swift
// 购买指定产品
Task {
    await paymentViewModel.purchaseProduct(productId: "lvbsvhxcgcrvesor")
}
```

### 3. 恢复购买

```swift
// 恢复之前的购买
Task {
    await paymentViewModel.restorePurchases()
}
```

### 4. 监听支付状态

```swift
// 在 View 中监听支付状态变化
switch paymentViewModel.paymentStatus {
case .idle:
    // 空闲状态
    break
case .loadingProducts:
    // 正在加载产品
    break
case .processing:
    // 正在处理支付
    break
case .success:
    // 支付成功
    // 用户余额已自动更新
    break
case .failed(let message):
    // 支付失败
    print("支付失败：\(message)")
case .canceled:
    // 用户取消支付
    break
case .restored:
    // 恢复购买成功
    break
}
```

## ⚙️ 配置说明

### 1. 产品 ID 配置

在 `Models/PaymentModels.swift` 中配置产品 ID 和对应的钻石数量：

```swift
let diamondPackages: [DiamondPackage] = [
    DiamondPackage(productId: "lvbsvhxcgcrvesor", diamonds: 100, packageName: "小包"),
    DiamondPackage(productId: "dxismgcwewhrtezo", diamonds: 500, packageName: "中包"),
    // ... 更多产品
]
```

**重要**：这些产品 ID 必须与 App Store Connect 中配置的产品 ID 完全一致。

### 2. App Store Connect 配置

1. 登录 [App Store Connect](https://appstoreconnect.apple.com/)
2. 选择你的应用
3. 进入"功能" -> "App 内购买项目"
4. 创建新的内购项目，类型选择"消耗型"
5. 填写产品 ID（必须与代码中的 productId 一致）
6. 填写产品信息（名称、描述、价格等）

### 3. Sandbox 测试账户

1. 在 App Store Connect 中创建 Sandbox 测试账户
2. 在设备上退出 App Store 登录
3. 运行应用，进行购买时会提示登录 Sandbox 账户
4. 使用 Sandbox 账户完成测试购买

## 📝 主要功能说明

### PaymentViewModel 主要方法

- `initializePayment()` - 初始化支付系统
- `loadProducts()` - 加载产品列表
- `purchaseProduct(productId:)` - 购买指定产品
- `restorePurchases()` - 恢复购买
- `refreshProducts()` - 刷新产品列表
- `resetPaymentStatus()` - 重置支付状态

### PaymentService 主要方法

- `isPaymentServiceAvailable()` - 检查支付服务是否可用
- `queryProducts(productIds:)` - 查询产品详情
- `purchaseProduct(_:)` - 购买产品
- `restorePurchases()` - 恢复购买
- `finishTransaction(_:)` - 完成交易
- `clearPendingTransactions()` - 清理待处理交易（iOS）

## 🔄 支付流程

1. **初始化**：调用 `initializePayment()` 检查服务可用性并加载产品
2. **选择产品**：用户选择要购买的产品
3. **发起购买**：调用 `purchaseProduct(productId:)` 发起购买
4. **处理结果**：
   - 成功：自动更新用户余额（通过 `AuthenticationManager.addBalance()`）
   - 失败：显示错误信息
   - 取消：用户取消购买
5. **完成交易**：交易成功后自动调用 `finishTransaction()` 完成交易

## ⚠️ 注意事项

1. **产品 ID 必须一致**：代码中的 productId 必须与 App Store Connect 中的完全一致
2. **Sandbox 环境**：开发测试时使用 Sandbox 账户，正式环境会自动切换到生产环境
3. **交易验证**：代码中已包含交易验证，实际应用中建议同时进行服务器端验证
4. **错误处理**：所有支付操作都应处理可能的错误情况
5. **余额更新**：支付成功后会自动更新用户余额，无需手动处理

## 🐛 常见问题

### Q: 产品列表为空？
A: 检查以下几点：
- 产品 ID 是否正确
- App Store Connect 中是否已创建产品
- 产品状态是否为"准备提交"或"已批准"
- 网络连接是否正常

### Q: 支付失败？
A: 检查以下几点：
- 是否使用 Sandbox 账户登录
- 设备是否支持内购
- 网络连接是否正常
- 查看错误信息中的具体原因

### Q: 如何测试支付？
A: 
1. 创建 Sandbox 测试账户
2. 在设备上退出 App Store 登录
3. 运行应用并尝试购买
4. 使用 Sandbox 账户完成购买

## 📚 相关文档

- [StoreKit 2 官方文档](https://developer.apple.com/documentation/storekit)
- [App Store Connect 帮助](https://help.apple.com/app-store-connect/)
- [内购测试指南](https://developer.apple.com/app-store-connect/in-app-purchases-and-subscriptions/)


DEVELOPMENT_TEAM = M7A59P87QQ;