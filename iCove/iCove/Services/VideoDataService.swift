//
//  VideoDataService.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation

/// 视频数据服务协议
protocol VideoDataServiceProtocol {
  func loadVideos() -> [VideoItem]
  func saveVideos(_ videos: [VideoItem])
  func addVideo(_ video: VideoItem)
  func updateVideo(_ video: VideoItem)
  func deleteVideo(id: String)
  func resetToSampleData()
}

/// 视频数据服务 - 负责视频数据的持久化存储
class VideoDataService: VideoDataServiceProtocol {
  static let shared = VideoDataService()

  private let videosKey = "saved_videos"

  private init() {
    // 如果是首次启动，初始化示例数据
    if loadVideos().isEmpty {
      initializeSampleVideos()
    }

    // 开发调试：需要更新示例数据时，取消下面的注释
    // resetToSampleData()
  }

  // MARK: - Public Methods

  func loadVideos() -> [VideoItem] {
    guard let data = UserDefaults.standard.data(forKey: videosKey),
      let videos = try? JSONDecoder().decode([VideoItem].self, from: data)
    else {
      return []
    }
    return videos
  }

  func saveVideos(_ videos: [VideoItem]) {
    if let data = try? JSONEncoder().encode(videos) {
      UserDefaults.standard.set(data, forKey: videosKey)
    }
  }

  func addVideo(_ video: VideoItem) {
    var videos = loadVideos()
    videos.insert(video, at: 0)  // 新视频添加到最前面
    saveVideos(videos)
  }

  func updateVideo(_ video: VideoItem) {
    var videos = loadVideos()
    if let index = videos.firstIndex(where: { $0.id == video.id }) {
      videos[index] = video
      saveVideos(videos)
    }
  }

  func deleteVideo(id: String) {
    var videos = loadVideos()
    videos.removeAll { $0.id == id }
    saveVideos(videos)
  }

  /// 重置为示例数据（用于开发调试）
  func resetToSampleData() {
    UserDefaults.standard.removeObject(forKey: videosKey)
    initializeSampleVideos()
  }

  // MARK: - Private Methods

  private func initializeSampleVideos() {
    // 使用本地图片资源作为示例数据
    let sampleVideos: [VideoItem] = [
      VideoItem(
        id: "video_001",
        imageName: "RClW0Qk7ObNtk86q1",
        videoName: "YLXVqZ8wbqT0SSgp1",
        title: "Today's outfit, what do you all think of it?",
        authorId: "user_002",
        timestamp: Date().addingTimeInterval(-86400 * 2),
        likeCount: 346,
        isLiked: false
      ),
      VideoItem(
        id: "video_002",
        imageName: "RClW0Qk7ObNtk86q2",
        videoName: "YLXVqZ8wbqT0SSgp2",
        title: "Today's outfit suggestion: You can refer to this one for your daily wear. It's very comfortable.",
        authorId: "user_003",
        timestamp: Date().addingTimeInterval(-86400 * 3),
        likeCount: 289,
        isLiked: false
      ),
      VideoItem(
        id: "video_003",
        imageName: "RClW0Qk7ObNtk86q3",
        videoName: "YLXVqZ8wbqT0SSgp3",
        title: "Some recent fits",
        authorId: "user_004",
        timestamp: Date().addingTimeInterval(-86400 * 4),
        likeCount: 512,
        isLiked: false
      ),
      VideoItem(
        id: "video_004",
        imageName: "RClW0Qk7ObNtk86q4",
        videoName: "YLXVqZ8wbqT0SSgp4",
        title: "my outfit of the day，literally wearing the same version of an outfit everyday because it’s so cold and I grab the first thing I see",
        authorId: "user_005",
        timestamp: Date().addingTimeInterval(-86400 * 5),
        likeCount: 423,
        isLiked: false
      ),
      VideoItem(
        id: "video_005",
        imageName: "RClW0Qk7ObNtk86q5",
        videoName: "YLXVqZ8wbqT0SSgp5",
        title: "I really love these accessories of mine. They are so beautiful!",
        authorId: "user_006",
        timestamp: Date().addingTimeInterval(-86400 * 6),
        likeCount: 678,
        isLiked: false
      ),
      VideoItem(
        id: "video_006",
        imageName: "RClW0Qk7ObNtk86q6",
        videoName: "YLXVqZ8wbqT0SSgp6",
        title: "Such a simple and casual outfit would be very suitable.",
        authorId: "user_001",
        timestamp: Date().addingTimeInterval(-86400 * 7),
        likeCount: 891,
        isLiked: false
      ),
    ]

    saveVideos(sampleVideos)
  }
}
