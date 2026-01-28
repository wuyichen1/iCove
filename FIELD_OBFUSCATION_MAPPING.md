# 字段混淆映射说明文档

本文档记录了 Models 目录下所有 Model 字段的混淆映射关系。

**重要提示：**
- CodingKeys 的 rawValue 保持不变，确保 JSON 序列化/反序列化正常工作
- 相同字段名在不同结构体中使用相同的混淆名，保持一致性
- 所有引用（字段定义、init 参数、self.引用、forKey 引用等）都已更新

---

## 全局字段映射（跨文件保持一致）

以下字段在多个 Model 中使用，统一使用相同的混淆名：

| 原始字段名 | 混淆后字段名 | 使用位置 |
|-----------|------------|---------|
| `title` | `tR3sT5uV7wX9yZ` | DiscitemMQE0TVcUSS7Z, VideoItem, SettingItemG9ajK0rqU3bc7 |
| `authorId` | `aC9dE1fG3hI5jK` | Post, VideoItem, Comment |
| `content` | `cL7mN9oP1qR3sT` | Post, Comment, Message |
| `timestamp` | `tK3lM5nO7pQ9rS` | DiscitemMQE0TVcUSS7Z, Post, VideoItem, Comment, Conversation, Message |

---

## AuthModels.swift

### User 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `email` | `eK8mN2pQ7rT9vW` | String | 用户邮箱 |
| `username` | `uX4yZ6aB8cD0eF` | String | 用户名 |
| `avatar` | `aG3hI5jK7lM9nO` | String? | 头像URL |
| `balance` | `bP2qR4sT6uV8wX` | Int | 余额 |
| `bio` | `bY1zA3bC5dE7fG` | String? | 个人简介 |
| `collectedPostIds` | `cP9hI1jK3lM5nO` | [String] | 收藏的帖子ID列表 |
| `blockedUserIds` | `bQ7rS9tU1vW3xY` | [String] | 屏蔽的用户ID列表 |
| `followingUserIds` | `fZ5aB7cD9eF1gH` | [String] | 关注的用户ID列表 |
| `followerUserIds` | `fI3jK5lM7nO9pQ` | [String] | 粉丝用户ID列表 |

### CodingKeys 映射

```swift
enum CodingKeys: String, CodingKey {
  case id
  case eK8mN2pQ7rT9vW = "email"
  case uX4yZ6aB8cD0eF = "username"
  case aG3hI5jK7lM9nO = "avatar"
  case bP2qR4sT6uV8wX = "balance"
  case bY1zA3bC5dE7fG = "bio"
  case cP9hI1jK3lM5nO = "collectedPostIds"
  case bQ7rS9tU1vW3xY = "blockedUserIds"
  case fZ5aB7cD9eF1gH = "followingUserIds"
  case fI3jK5lM7nO9pQ = "followerUserIds"
}
```

---

## DiscoverModels.swift

### DiscitemMQE0TVcUSS7Z 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `title` | `tR3sT5uV7wX9yZ` | String | 标题（全局映射） |
| `description` | `dA1bC3dE5fG7hI` | String | 描述 |
| `imageUrl` | `iJ9kL1mN3oP5qR` | String? | 图片URL |
| `viewCount` | `vS7tU9vW1xY3zA` | Int | 浏览次数 |
| `author` | `aB5cD7eF9gH1iJ` | String | 作者 |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |

### Post 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `imageNames` | `iT1uV3wX5yZ7aB` | [String] | 图片名称列表 |
| `authorId` | `aC9dE1fG3hI5jK` | String | 作者ID（全局映射） |
| `content` | `cL7mN9oP1qR3sT` | String | 内容（全局映射） |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |

### CodingKeys 映射

```swift
enum CodingKeys: String, CodingKey {
  case id
  case iT1uV3wX5yZ7aB = "imageNames"
  case aC9dE1fG3hI5jK = "authorId"
  case cL7mN9oP1qR3sT = "content"
  case tK3lM5nO7pQ9rS = "timestamp"
}
```

---

## HomeModels.swift

### VideoItem 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `imageName` | `iM5aG7eN9aM1eN` | String | 图片名称 |
| `videoName` | `vI3dE5oN7aM9eN` | String | 视频名称 |
| `title` | `tR3sT5uV7wX9yZ` | String | 标题（全局映射） |
| `authorId` | `aC9dE1fG3hI5jK` | String | 作者ID（全局映射） |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |
| `likeCount` | `lI1kE3cO5uN7tN` | Int | 点赞数 |
| `isLiked` | `iS1lI3kE5dN7eN` | Bool | 是否已点赞 |

### Comment 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `videoId` | `vI3dE5oI7dN9eN` | String | 视频ID |
| `authorId` | `aC9dE1fG3hI5jK` | String | 作者ID（全局映射） |
| `content` | `cL7mN9oP1qR3sT` | String | 内容（全局映射） |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |

### CodingKeys 映射

**VideoItem:**
```swift
enum CodingKeys: String, CodingKey {
  case id
  case iM5aG7eN9aM1eN = "imageName"
  case vI3dE5oN7aM9eN = "videoName"
  case tR3sT5uV7wX9yZ = "title"
  case aC9dE1fG3hI5jK = "authorId"
  case tK3lM5nO7pQ9rS = "timestamp"
  case lI1kE3cO5uN7tN = "likeCount"
  case iS1lI3kE5dN7eN = "isLiked"
}
```

**Comment:**
```swift
enum CodingKeys: String, CodingKey {
  case id
  case vI3dE5oI7dN9eN = "videoId"
  case aC9dE1fG3hI5jK = "authorId"
  case cL7mN9oP1qR3sT = "content"
  case tK3lM5nO7pQ9rS = "timestamp"
}
```

---

## MessagesModels.swift

### Conversation 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `participantIds` | `pA5rT1iC3iP5aN7t` | [String] | 参与者ID列表 |
| `lastMessage` | `lA9sT1mE3sS5aG7e` | String | 最后一条消息 |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |
| `unreadCount` | `uN9rE1aD3cO5uN7t` | Int | 未读消息数 |
| `isUnread` | `iS1uN3rE5aD7eN` | Bool | 是否有未读消息 |
| `isPinned` | `iS1pI3nN5eD7eN` | Bool | 是否置顶 |

### Message 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `conversationId` | `cO5nV1eR3sA5tI7oN` | String | 会话ID |
| `senderId` | `sE5nD1eR3iD5eN` | String | 发送者ID |
| `content` | `cL7mN9oP1qR3sT` | String | 消息内容（全局映射） |
| `messageType` | `mE5sS1aG3eT5yP7e` | MtyWY6eefw4eu6Ve | 消息类型 |
| `timestamp` | `tK3lM5nO7pQ9rS` | Date | 时间戳（全局映射） |

### CodingKeys 映射

**Conversation:**
```swift
enum CodingKeys: String, CodingKey {
  case id
  case pA5rT1iC3iP5aN7t = "participantIds"
  case lA9sT1mE3sS5aG7e = "lastMessage"
  case tK3lM5nO7pQ9rS = "timestamp"
  case uN9rE1aD3cO5uN7t = "unreadCount"
  case iS1uN3rE5aD7eN = "isUnread"
  case iS1pI3nN5eD7eN = "isPinned"
}
```

**Message:**
```swift
enum CodingKeys: String, CodingKey {
  case id
  case cO5nV1eR3sA5tI7oN = "conversationId"
  case sE5nD1eR3iD5eN = "senderId"
  case cL7mN9oP1qR3sT = "content"
  case mE5sS1aG3eT5yP7e = "messageType"
  case tK3lM5nO7pQ9rS = "timestamp"
}
```

---

## ProfileModels.swift

### SettingItemG9ajK0rqU3bc7 结构体

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | UUID | 保持不变 |
| `title` | `tR3sT5uV7wX9yZ` | String | 标题（全局映射） |
| `icon` | `iC5oN7eN9aM1eN` | String | 图标名称 |
| `type` | `tY3pE5nA7m9eN` | SettingType | 设置类型 |
| `isDestructive` | `iS1dE3sT5rU7cT9v` | Bool | 是否为危险操作 |

---

## PayMod5i5yRVqoBpOpH.swift

该文件已经部分混淆，当前字段映射：

| 原始字段名 | 混淆后字段名 | 类型 | 说明 |
|-----------|------------|------|------|
| `id` | `id` | String | 保持不变 |
| `displayName` | `F3a0686zLgphO` | String | 显示名称 |
| `description` | `C677GrOXFKrCz` | String | 描述 |
| `price` | `BEdd9dgBlT2XI` | Decimal | 价格 |
| `carrots` | `diaGDfiUAxvMX5uR` | Int | 胡萝卜数量 |

---

## 使用说明

### 1. 查找字段映射

如果需要查找某个字段的混淆名，可以使用以下方式：
- 在本文档中搜索原始字段名
- 查看对应 Model 文件的 CodingKeys enum

### 2. 更新代码引用

当需要更新代码中使用的字段时：
1. 查找本文档获取混淆后的字段名
2. 替换所有引用（包括点语法访问、init 参数等）
3. 确保 CodingKeys 的 rawValue 保持不变

### 3. 添加新字段

添加新字段时：
1. 生成混淆名（首字母小写 + 10-15个随机大写字母和数字）
2. 在 CodingKeys 中添加映射：`case 混淆名 = "原始字段名"`
3. 更新本文档

---

## 混淆规则

1. **命名规则**：首字母小写 + 10-15个随机大写字母和数字组合
2. **一致性**：相同字段名在不同结构体中使用相同的混淆名
3. **保留字段**：`id` 字段通常保持不变
4. **CodingKeys**：rawValue 必须保持原始字段名，确保 JSON 序列化正常工作

---

**文档版本**: 1.0.0  
**创建日期**: 2026-01-28  
**最后更新**: 2026-01-28
