# iCove 项目架构说明文档

## 📋 目录

- [项目概述](#项目概述)
- [架构模式](#架构模式)
- [项目结构](#项目结构)
- [分层架构](#分层架构)
- [核心组件](#核心组件)
- [数据流](#数据流)
- [设计原则](#设计原则)
- [技术栈](#技术栈)
- [开发规范](#开发规范)

---

## 项目概述

**iCove** 是一个基于 SwiftUI 开发的 iOS 应用，采用 MVVM（Model-View-ViewModel）架构模式。项目实现了完整的用户认证系统、内容流展示、发现推荐、消息会话和个人资料管理等核心功能。

### 主要特性

- ✅ 完整的登录/注册系统
- ✅ 四个主要功能模块（首页、发现、消息、我的）
- ✅ 状态驱动的 UI 更新
- ✅ 表单验证和错误处理
- ✅ 持久化存储支持

---

## 架构模式

### MVVM (Model-View-ViewModel)

项目采用 **MVVM** 架构模式，实现视图与业务逻辑的完全分离：

```
┌─────────────┐
│    View     │  ← 纯 UI 展示，响应式更新
└──────┬──────┘
       │ @StateObject / @ObservedObject
       │ @Published
┌──────▼──────┐
│  ViewModel  │  ← 业务逻辑处理，状态管理
└──────┬──────┘
       │ 使用
       │
┌──────▼──────┐
│   Service   │  ← 网络请求，数据操作
└──────┬──────┘
       │ 返回
       │
┌──────▼──────┐
│   Models    │  ← 数据模型定义
└─────────────┘
```

### 架构优势

1. **关注点分离**：View 只负责 UI，ViewModel 处理业务逻辑，Models 定义数据结构
2. **可测试性**：ViewModel 可独立测试，不依赖 UI；Models 可独立验证
3. **可维护性**：代码结构清晰，分层明确，易于维护和扩展
4. **状态管理**：使用 `@Published` 实现响应式状态更新
5. **数据共享**：Models 层可被多个 ViewModel 和 Service 共享，避免重复定义

---

## 项目结构

```
iCove/
├── iCove/
│   ├── iCoveApp.swift              # App 入口，根视图管理
│   ├── ContentView.swift           # 遗留视图（可删除）
│   │
│   ├── Models/                      # 数据模型层
│   │   ├── AuthModels.swift            # 认证相关模型
│   │   ├── HomeModels.swift            # 首页相关模型
│   │   ├── DiscoverModels.swift        # 发现页相关模型
│   │   ├── MessagesModels.swift        # 消息页相关模型
│   │   └── ProfileModels.swift         # 我的页相关模型
│   │
│   ├── Views/                       # 视图层
│   │   ├── AuthenticationView.swift     # 认证容器视图
│   │   ├── LoginView.swift             # 登录视图
│   │   ├── RegisterView.swift          # 注册视图
│   │   ├── MainTabView.swift           # 主 Tab 导航
│   │   ├── HomeView.swift              # 首页视图
│   │   ├── DiscoverView.swift         # 发现页视图
│   │   ├── MessagesView.swift         # 消息页视图
│   │   └── ProfileView.swift          # 我的页视图
│   │
│   ├── ViewModels/                 # 视图模型层
│   │   ├── AuthenticationManager.swift # 认证状态管理器（全局）
│   │   ├── LoginViewModel.swift        # 登录视图模型
│   │   ├── RegisterViewModel.swift     # 注册视图模型
│   │   ├── HomeViewModel.swift         # 首页视图模型
│   │   ├── DiscoverViewModel.swift     # 发现页视图模型
│   │   ├── MessagesViewModel.swift     # 消息页视图模型
│   │   └── ProfileViewModel.swift      # 我的页视图模型
│   │
│   └── Services/                   # 服务层
│       └── AuthenticationService.swift # 认证服务（网络请求）
│
├── Assets.xcassets/               # 资源文件
└── ARCHITECTURE.md                # 本架构文档
```

---

## 分层架构

### 1. 模型层 (Models)

**职责**：
- 定义数据结构
- 数据模型和枚举类型
- 不包含业务逻辑

**特点**：
- 纯数据结构定义
- 可被 ViewModel 和 Service 层共享
- 支持 Codable 协议（如需要）

**文件组织**：
- 按功能模块组织（AuthModels、HomeModels 等）
- 每个文件包含相关的模型和枚举

**示例**：
```swift
// Models/AuthModels.swift
struct User: Codable {
    let id: String
    let email: String
    let username: String
    let avatar: String?
}
```

### 2. 视图层 (Views)

**职责**：
- 纯 UI 展示和用户交互
- 通过 `@StateObject` 或 `@ObservedObject` 绑定 ViewModel
- 响应 ViewModel 的状态变化自动更新 UI

**特点**：
- 不包含业务逻辑
- 使用 SwiftUI 声明式语法
- 支持预览（Preview）

**示例**：
```swift
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        // UI 代码
    }
}
```

### 3. 视图模型层 (ViewModels)

**职责**：
- 处理业务逻辑
- 管理视图状态（`@Published` 属性）
- 调用 Service 层获取数据
- 处理用户交互事件

**特点**：
- 使用 `@MainActor` 确保主线程执行
- 继承 `ObservableObject` 协议
- 不直接依赖 View，可独立测试

**示例**：
```swift
@MainActor
class HomeViewModel: ObservableObject {
    @Published var feedItems: [FeedItem] = []
    @Published var isLoading: Bool = false
    
    func loadInitialData() async {
        // 业务逻辑
    }
}
```

### 4. 服务层 (Services)

**职责**：
- 处理网络请求
- 数据持久化
- 与外部 API 交互
- 数据转换和格式化

**特点**：
- 使用协议定义接口，便于测试和替换
- 异步操作使用 `async/await`
- 错误处理统一

**示例**：
```swift
protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) async throws -> AznsY674Pb5bXx
}

class AuthenticationService: AuthenticationServiceProtocol {
    func login(email: String, password: String) async throws -> AznsY674Pb5bXx {
        // 网络请求逻辑
    }
}
```

---

## 核心组件

### 1. 认证系统

#### AuthenticationManager
- **类型**：全局状态管理器
- **职责**：管理用户登录状态、Token、用户信息
- **特点**：
  - 使用 `@Published` 发布状态变化
  - 支持状态持久化（UserDefaults）
  - 通过 `EnvironmentObject` 在 App 层共享

#### AuthenticationService
- **类型**：服务层
- **职责**：处理登录/注册/登出的网络请求
- **特点**：
  - 使用协议定义，便于 Mock 测试
  - 模拟网络延迟和错误
  - 数据验证和错误处理

#### LoginViewModel / RegisterViewModel
- **类型**：视图模型
- **职责**：
  - 表单验证（邮箱、密码、用户名格式）
  - 调用 AuthenticationManager 执行登录/注册
  - 管理加载状态和错误信息

### 2. 主界面导航

#### MainTabView
- **类型**：容器视图
- **职责**：管理四个主要 Tab 页面
- **Tab 页面**：
  1. **首页** (HomeView) - 内容流展示
  2. **发现** (DiscoverView) - 探索推荐
  3. **消息** (MessagesView) - 会话列表
  4. **我的** (ProfileView) - 个人资料

### 3. 各功能模块

#### 首页模块 (Home)
- **ViewModel**: `HomeViewModel`
- **功能**：
  - 内容流展示
  - 下拉刷新
  - 上拉加载更多
  - 点赞交互

#### 发现模块 (Discover)
- **ViewModel**: `DiscoverViewModel`
- **功能**：
  - 热门话题展示
  - 分类筛选
  - 推荐内容流
  - 关注/取消关注

#### 消息模块 (Messages)
- **ViewModel**: `MessagesViewModel`
- **功能**：
  - 会话列表
  - 搜索功能
  - 未读消息计数
  - 置顶/删除操作

#### 我的模块 (Profile)
- **ViewModel**: `ProfileViewModel`
- **功能**：
  - 个人资料展示
  - 统计数据展示
  - 设置入口
  - 退出登录

---

## 数据流

### 1. 认证流程

```
用户输入
    ↓
LoginView / RegisterView (Views)
    ↓
LoginViewModel / RegisterViewModel (ViewModels - 表单验证)
    ↓
AuthenticationManager (ViewModels - 状态管理)
    ↓
AuthenticationService (Services - 网络请求)
    ↓
返回 AznsY674Pb5bXx (Models)
    ↓
AuthenticationManager (更新状态)
    ↓
RootView (监听 isAuthenticated)
    ↓
自动切换视图 (MainTabView / AuthenticationView)
```

### 2. 数据加载流程

```
View 初始化 (Views)
    ↓
ViewModel.init() → Task { await loadData() } (ViewModels)
    ↓
Service 层请求数据 (Services)
    ↓
返回 Model 数据 (Models)
    ↓
ViewModel 更新 @Published 属性
    ↓
View 自动响应更新
```

### 3. 用户交互流程

```
用户操作 (点击、输入等)
    ↓
View 调用 ViewModel 方法
    ↓
ViewModel 处理业务逻辑
    ↓
ViewModel 更新状态
    ↓
View 自动更新 UI
```

---

## 设计原则

### 1. 单一职责原则 (SRP)
- View 只负责 UI 展示
- ViewModel 只处理业务逻辑
- Service 只处理数据操作

### 2. 依赖注入 (DI)
- ViewModel 通过初始化参数接收依赖
- 不使用单例 ViewModel（除了全局状态管理器）
- 便于测试和替换实现

### 3. 状态驱动
- 使用 `@Published` 属性驱动 UI 更新
- UI 完全响应式，无需手动刷新
- 状态变化自动触发视图更新

### 4. 错误处理
- Service 层抛出错误
- ViewModel 捕获并转换为用户友好的错误信息
- View 展示错误提示

### 5. 异步处理
- 使用 `async/await` 处理异步操作
- ViewModel 使用 `@MainActor` 确保主线程更新 UI
- 避免阻塞主线程

---

## 技术栈

### 开发框架
- **SwiftUI**: 声明式 UI 框架
- **Combine**: 响应式编程（SwiftUI 内置）

### 语言特性
- **Swift 5.0+**: 现代 Swift 语法
- **async/await**: 异步编程
- **@MainActor**: 主线程隔离

### 架构模式
- **MVVM**: Model-View-ViewModel
- **Protocol-Oriented**: 协议导向编程

### 数据存储
- **UserDefaults**: 轻量级数据持久化
- **@AppStorage**: SwiftUI 状态持久化（可选）

---

## 开发规范

### 1. 命名规范

#### Model
- 使用名词：`User`, `FeedItem`, `Conversation`
- 使用 PascalCase
- 枚举使用单数形式：`SettingType`, `RefreshState`

#### View
- 以 `View` 结尾：`HomeView`, `LoginView`
- 使用 PascalCase

#### ViewModel
- 以 `ViewModel` 结尾：`HomeViewModel`, `LoginViewModel`
- 使用 PascalCase

#### Service
- 以 `Service` 结尾：`AuthenticationService`
- 协议以 `Protocol` 结尾：`AuthenticationServiceProtocol`

#### 文件组织
- Models：按功能模块组织，一个模块一个文件
- Views：一个文件一个主要视图
- ViewModels：一个文件一个主要 ViewModel
- Services：一个文件一个主要 Service
- 相关类型放在同一文件（如 Supporting Types）

### 2. 代码结构

#### ViewModel 标准结构
```swift
@MainActor
class XxxViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var property: Type
    
    // MARK: - Private Properties
    private let service: ServiceProtocol
    
    // MARK: - Initialization
    init(service: ServiceProtocol = DefaultService.shared) {
        self.service = service
    }
    
    // MARK: - Public Methods
    func publicMethod() async {
        // 实现
    }
    
    // MARK: - Private Methods
    private func privateMethod() {
        // 实现
    }
}
```

#### View 标准结构
```swift
struct XxxView: View {
    @StateObject private var viewModel = XxxViewModel()
    
    var body: some View {
        // UI 代码
    }
    
    // MARK: - Private Views
    private var someView: some View {
        // 子视图
    }
}
```

### 3. 注释规范

- 使用 `// MARK:` 分隔代码块
- 公共方法添加文档注释
- 复杂逻辑添加行内注释

### 4. 错误处理

- Service 层抛出具体错误类型
- ViewModel 捕获并转换为用户友好信息
- View 展示错误，提供重试机制

### 5. 状态管理

- 使用 `@Published` 标记需要响应式更新的属性
- 使用 `@StateObject` 创建 ViewModel 实例
- 使用 `@ObservedObject` 接收外部 ViewModel
- 使用 `@EnvironmentObject` 共享全局状态

### 6. 模型使用

- Models 定义在 `Models/` 目录，按功能模块组织
- ViewModel 和 Service 通过导入使用 Models
- 避免在 ViewModel 或 Service 中定义数据模型
- 需要序列化的模型实现 `Codable` 协议

---

## 扩展指南

### 添加新功能模块

1. **创建 Model**（如需要）
   ```swift
   // Models/NewFeatureModels.swift
   struct NewFeatureItem: Identifiable {
       let id: String
       // ...
   }
   ```

2. **创建 ViewModel**
   ```swift
   // ViewModels/NewFeatureViewModel.swift
   @MainActor
   class NewFeatureViewModel: ObservableObject {
       @Published var data: [NewFeatureItem] = []
       // ...
   }
   ```

3. **创建 View**
   ```swift
   // Views/NewFeatureView.swift
   struct NewFeatureView: View {
       @StateObject private var viewModel = NewFeatureViewModel()
       // ...
   }
   ```

4. **创建 Service**（如需要）
   ```swift
   // Services/NewFeatureService.swift
   protocol NewFeatureServiceProtocol {
       func fetchData() async throws -> [NewFeatureItem]
   }
   ```

5. **集成到导航**
   - 添加到 `MainTabView`（如果是 Tab 页面）
   - 或添加到相应的导航栈

### 添加新的 Service

1. **定义 Model**（如需要）
   ```swift
   // Models/NewServiceModels.swift
   struct NewServiceResponse: Codable {
       // ...
   }
   ```

2. **定义协议**
   ```swift
   // Services/NewService.swift
   protocol NewServiceProtocol {
       func fetchData() async throws -> NewServiceResponse
   }
   ```

3. **实现服务**
   ```swift
   class NewService: NewServiceProtocol {
       func fetchData() async throws -> NewServiceResponse {
           // 实现
       }
   }
   ```

4. **在 ViewModel 中使用**
   ```swift
   init(service: NewServiceProtocol = NewService.shared) {
       self.service = service
   }
   ```

---

## 测试建议

### ViewModel 测试
- Mock Service 层
- 测试状态变化
- 测试错误处理

### Service 测试
- 测试网络请求
- 测试数据转换
- 测试错误情况

### View 测试
- 使用 SwiftUI Preview
- 测试不同状态下的 UI
- UI 自动化测试（可选）

---

## 常见问题

### Q: 为什么使用 @MainActor？
**A**: 确保 ViewModel 的所有操作在主线程执行，避免 UI 更新问题。

### Q: 为什么不使用单例 ViewModel？
**A**: 单例难以测试，依赖注入更灵活。只有全局状态管理器（如 AuthenticationManager）使用单例模式。

### Q: 如何共享状态？
**A**: 
- 全局状态：使用 `@EnvironmentObject` + `AuthenticationManager`
- 局部状态：使用 `@StateObject` 在 View 中创建

### Q: 如何处理网络错误？
**A**: Service 层抛出错误，ViewModel 捕获并转换为用户友好的错误信息，View 展示错误提示。

### Q: Models 应该放在哪里？
**A**: 所有数据模型统一放在 `Models/` 目录下，按功能模块组织。ViewModel 和 Service 通过导入使用，避免重复定义。

### Q: 如何组织 Models 文件？
**A**: 按功能模块组织，每个模块一个文件（如 `AuthModels.swift`、`HomeModels.swift`）。相关模型和枚举放在同一文件中。

---

## 更新日志

### v1.1.0 (2026-01-14)
- ✅ 重构项目结构，添加 Models 层
- ✅ 提取所有数据模型到 Models 目录
- ✅ 按功能模块组织模型文件（AuthModels、HomeModels、DiscoverModels、MessagesModels、ProfileModels）
- ✅ 更新架构文档，完善 Models 层说明
- ✅ 修复 ProfileModels.swift 编译错误
- ✅ 更新架构图和数据流程图

### v1.0.0 (2026-01-14)
- ✅ 初始架构搭建
- ✅ 实现 MVVM 架构
- ✅ 完成登录/注册模块
- ✅ 实现四个主要功能模块
- ✅ 状态管理和持久化

---

## 参考资料

- [SwiftUI 官方文档](https://developer.apple.com/documentation/swiftui)
- [MVVM 架构模式](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)
- [Swift Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

---

**文档版本**: 1.1.0  
**最后更新**: 2026-01-14  
**维护者**: iCove Team

---

## 模型文件说明

### Models 目录结构

所有数据模型按功能模块组织在 `Models/` 目录下：

#### AuthModels.swift
- `AznsY674Pb5bXx` - 认证响应模型
- `User` - 用户模型（Codable）
- `MockUser` - 模拟用户模型（仅用于 Service 层）
- `AuthError` - 认证错误枚举

#### HomeModels.swift
- `FeedItem` - 首页内容项模型
- `RefreshState` - 刷新状态枚举

#### DiscoverModels.swift
- `DiscoverItem` - 发现页内容项模型
- `TrendingTopic` - 热门话题模型
- `DiscoverCategory` - 发现分类枚举
- `TrendDirection` - 趋势方向枚举

#### MessagesModels.swift
- `Conversation` - 会话模型

#### ProfileModels.swift
- `UserProfile` - 用户资料模型
- `SettingItem` - 设置项模型
- `SettingType` - 设置类型枚举

### 模型设计原则

1. **单一职责**：每个模型只表示一种数据结构
2. **不可变性优先**：使用 `let` 定义不可变属性，需要可变时使用 `var`
3. **协议支持**：需要序列化时实现 `Codable` 协议
4. **标识符**：列表项模型实现 `Identifiable` 协议
5. **文档注释**：为每个模型添加清晰的文档注释
