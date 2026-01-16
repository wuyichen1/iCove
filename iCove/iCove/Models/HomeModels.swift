//
//  HomeModels.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

// MARK: - Home Models

/// 首页内容项模型
struct FeedItem: Identifiable {
    let id: String
    let title: String
    let content: String
    let author: String
    let timestamp: Date
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
}

/// 视频项模型
struct VideoItem: Identifiable, Codable, Hashable {
    let id: String
    let imageName: String // 本地图片资源名称
    let videoName: String // 视频名称
    let title: String
    let authorId: String
    let timestamp: Date
    var likeCount: Int
    var isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageName
        case videoName
        case title
        case authorId
        case timestamp
        case likeCount
        case isLiked
    }
    
    init(id: String = UUID().uuidString, 
         imageName: String,
         videoName: String,
         title: String, 
         authorId: String, 
         timestamp: Date = Date(), 
         likeCount: Int = 0, 
         isLiked: Bool = false) {
        self.id = id
        self.imageName = imageName
        self.videoName = videoName
        self.title = title
        self.authorId = authorId
        self.timestamp = timestamp
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageName = try container.decode(String.self, forKey: .imageName)
        videoName = try container.decodeIfPresent(String.self, forKey: .videoName) ?? ""
        title = try container.decode(String.self, forKey: .title)
        authorId = try container.decode(String.self, forKey: .authorId)
        let timestampInterval = try container.decode(TimeInterval.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timestampInterval)
        likeCount = try container.decode(Int.self, forKey: .likeCount)
        isLiked = try container.decode(Bool.self, forKey: .isLiked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(videoName, forKey: .videoName)
        try container.encode(title, forKey: .title)
        try container.encode(authorId, forKey: .authorId)
        try container.encode(timestamp.timeIntervalSince1970, forKey: .timestamp)
        try container.encode(likeCount, forKey: .likeCount)
        try container.encode(isLiked, forKey: .isLiked)
    }
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(imageName)
        hasher.combine(videoName)
        hasher.combine(title)
        hasher.combine(authorId)
        hasher.combine(timestamp)
        hasher.combine(likeCount)
        hasher.combine(isLiked)
    }
    
    static func == (lhs: VideoItem, rhs: VideoItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.imageName == rhs.imageName &&
               lhs.videoName == rhs.videoName &&
               lhs.title == rhs.title &&
               lhs.authorId == rhs.authorId &&
               lhs.timestamp == rhs.timestamp &&
               lhs.likeCount == rhs.likeCount &&
               lhs.isLiked == rhs.isLiked
    }
}

/// 评论模型
struct Comment: Identifiable, Codable {
    let id: String
    let videoId: String
    let authorId: String
    let content: String
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case videoId
        case authorId
        case content
        case timestamp
    }
    
    init(id: String = UUID().uuidString,
         videoId: String,
         authorId: String,
         content: String,
         timestamp: Date = Date()) {
        self.id = id
        self.videoId = videoId
        self.authorId = authorId
        self.content = content
        self.timestamp = timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        videoId = try container.decode(String.self, forKey: .videoId)
        authorId = try container.decode(String.self, forKey: .authorId)
        content = try container.decode(String.self, forKey: .content)
        let timestampInterval = try container.decode(TimeInterval.self, forKey: .timestamp)
        timestamp = Date(timeIntervalSince1970: timestampInterval)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(videoId, forKey: .videoId)
        try container.encode(authorId, forKey: .authorId)
        try container.encode(content, forKey: .content)
        try container.encode(timestamp.timeIntervalSince1970, forKey: .timestamp)
    }
}

/// 刷新状态
enum RefreshState {
    case idle
    case refreshing
}
