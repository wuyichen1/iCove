# 支付功能问题排查指南

## 🔍 "产品未找到" 错误排查

当遇到"产品未找到"错误时，请按照以下步骤逐一排查：

### 1. ✅ 检查产品 ID 是否正确

**问题**：产品 ID 拼写错误或大小写不匹配

**排查步骤**：
1. 打开 `Models/PaymentModels.swift` 文件
2. 检查 `diaPckgscQLNBm8gVonHu` 数组中的 `productId`
3. 确保与 App Store Connect 中的产品 ID **完全一致**（包括大小写）

**当前配置的产品 ID**：
```
lvbsvhxcgcrvesor
dxismgcwewhrtezo
khtxlcejaxmqcsra
yadwwvxspgxwlndb
qnrcuelbtiuflyky
ymohxnvpkqxutvab
```

### 2. ✅ 检查 App Store Connect 中的产品配置

**问题**：产品未在 App Store Connect 中创建

**排查步骤**：
1. 登录 [App Store Connect](https://appstoreconnect.apple.com/)
2. 进入"我的 App" > 选择你的应用
3. 点击"功能" > "App 内购买项目"
4. 检查是否已创建上述所有产品 ID
5. 如果未创建，点击"+"创建新的内购项目

**创建产品时的注意事项**：
- 产品类型选择：**消耗型产品**（Consumable）
- 产品 ID 必须与代码中的完全一致
- 填写产品信息（名称、描述、价格等）
- 产品状态需要是"准备提交"或"已批准"

### 3. ✅ 检查产品状态

**问题**：产品状态不正确

**排查步骤**：
1. 在 App Store Connect 中查看每个产品的状态
2. 确保产品状态是以下之一：
   - ✅ "准备提交"（Ready to Submit）
   - ✅ "已批准"（Approved）
3. 如果状态是"待处理"（Pending），需要等待审核

**注意**：产品状态为"待处理"时，无法在真机上测试购买。

### 4. ✅ 检查 Bundle ID 是否匹配

**问题**：应用的 Bundle ID 与 App Store Connect 中的应用 Bundle ID 不一致

**当前应用的 Bundle ID**：
```
com.jswqsgwlhywr.icove.iCove
```

**排查步骤**：

#### 查看应用的 Bundle ID：
1. 在 Xcode 中打开项目
2. 选择项目文件（蓝色图标）
3. 选择 Target（通常是 iCove）
4. 在"General"标签页中查看"Bundle Identifier"
5. 确认 Bundle ID 是：`com.jswqsgwlhywr.icove.iCove`

#### 查看 App Store Connect 中的 Bundle ID：
1. 登录 App Store Connect
2. 进入"我的 App" > 选择你的应用
3. 在"App 信息"中查看 Bundle ID

**⚠️ 重要：确保两者完全一致！**

如果 Bundle ID 不匹配，产品查询会失败，所有产品都会显示"未找到"。

### 5. ✅ 检查网络连接

**问题**：网络问题导致无法查询产品

**排查步骤**：
1. 确保设备已连接到网络
2. 尝试在 Safari 中访问 App Store，确认可以正常访问
3. 如果使用 VPN，尝试关闭 VPN 后重试
4. 如果在公司网络，检查是否有防火墙阻止 App Store 访问

### 6. ✅ 检查测试环境

**问题**：在模拟器上测试（模拟器不支持内购）

**排查步骤**：
1. ✅ **必须在真机上测试**，模拟器不支持内购功能
2. 确保使用真机设备运行应用
3. 确保设备已登录 Apple ID（可以是 Sandbox 测试账户）

### 7. ✅ 检查产品是否已配置到 Sandbox 环境

**问题**：产品未正确配置到 Sandbox 测试环境

**排查步骤**：
1. 在 App Store Connect 中，产品创建后会自动配置到 Sandbox 环境
2. 确保产品状态不是"已删除"或"已拒绝"
3. 如果产品刚创建，可能需要等待几分钟才能生效

### 8. ✅ 查看详细错误日志

**调试方法**：
1. 在 Xcode 中运行应用
2. 打开控制台（Console）查看日志
3. 查找以下标记的日志：
   - 🔍 开始查询产品
   - ✅ 成功查询到产品
   - ⚠️ 产品未找到
   - ❌ 错误信息

**日志示例**：
```
🔍 开始查询产品，产品 ID 列表：["lvbsvhxcgcrvesor", ...]
✅ 成功查询到 6 个产品
   - 产品 ID: lvbsvhxcgcrvesor, 名称: 小包, 价格: ¥6.00
```

如果看到 `⚠️ 以下产品未找到：[...]`，说明这些产品 ID 在 App Store Connect 中不存在或状态不正确。

## 🔧 常见问题解决方案

### 问题 1：所有产品都未找到

**可能原因**：
- Bundle ID 不匹配
- 产品未在 App Store Connect 中创建
- 网络问题

**解决方案**：
1. 检查 Bundle ID 是否匹配
2. 在 App Store Connect 中创建所有产品
3. 检查网络连接

### 问题 2：部分产品未找到

**可能原因**：
- 某些产品 ID 拼写错误
- 某些产品状态不正确
- 某些产品未创建

**解决方案**：
1. 查看控制台日志，确认哪些产品未找到
2. 在 App Store Connect 中检查这些产品
3. 确保所有产品都已创建且状态正确

### 问题 3：产品查询成功但购买失败

**可能原因**：
- Sandbox 账户未登录
- 产品状态不正确
- 网络问题

**解决方案**：
1. 确保已登录 Sandbox 测试账户
2. 检查产品状态
3. 重试购买

## 📝 检查清单

在报告问题前，请确认以下所有事项：

- [ ] 产品 ID 与 App Store Connect 中的完全一致
- [ ] 所有产品已在 App Store Connect 中创建
- [ ] 产品状态是"准备提交"或"已批准"
- [ ] Bundle ID 与 App Store Connect 中的应用 Bundle ID 一致
- [ ] 在真机上测试（不是模拟器）
- [ ] 网络连接正常
- [ ] 已查看控制台日志，了解具体错误信息

## 🆘 仍然无法解决？

如果按照以上步骤排查后仍然无法解决问题，请提供以下信息：

1. **控制台日志**：完整的错误日志（包含 🔍、✅、⚠️、❌ 标记的日志）
2. **产品 ID 列表**：代码中配置的所有产品 ID
3. **App Store Connect 截图**：
   - 产品列表页面
   - 每个产品的状态
4. **应用的 Bundle ID**：在 Xcode 中查看的 Bundle Identifier
5. **测试环境**：真机型号、iOS 版本
6. **错误信息**：完整的错误提示
