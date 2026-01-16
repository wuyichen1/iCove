//
//  HomeViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var videos: [VideoItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var refreshState: RefreshState = .idle
    
    // MARK: - Private Properties
    private let videoService: VideoDataServiceProtocol
    
    // MARK: - Initialization
    init(videoService: VideoDataServiceProtocol = VideoDataService.shared) {
        self.videoService = videoService
        loadVideos()
        
        // 监听通知，当有新视频发布时刷新
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("VideoPublished"),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.loadVideos()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    func loadInitialData() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 模拟网络请求延迟
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        loadVideos()
        isLoading = false
    }
    
    func refresh() async {
        refreshState = .refreshing
        
        // 模拟刷新延迟
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        loadVideos()
        refreshState = .idle
    }
    
    func toggleLike(for video: VideoItem) {
        if let index = videos.firstIndex(where: { $0.id == video.id }) {
            var updatedVideo = videos[index]
            updatedVideo.isLiked.toggle()
            if updatedVideo.isLiked {
                updatedVideo.likeCount += 1
            } else {
                updatedVideo.likeCount = max(0, updatedVideo.likeCount - 1)
            }
            videos[index] = updatedVideo
            videoService.updateVideo(updatedVideo)
        }
    }
    
    // MARK: - Private Methods
    private func loadVideos() {
        videos = videoService.loadVideos()
    }
}

