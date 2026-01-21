//
//  VideoPlayerView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import AVKit
import SwiftUI
import UIKit

// MARK: - Player Container View
class PlayerContainerView: UIView {
  var playerLayer: AVPlayerLayer?

  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer?.frame = bounds
  }
}

// MARK: - AVPlayerLayer UIViewRepresentable
struct AVPlayerLayerView: UIViewRepresentable {
  let player: AVPlayer

  func makeUIView(context: Context) -> PlayerContainerView {
    let containerView = PlayerContainerView()
    containerView.backgroundColor = .black

    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.videoGravity = .resizeAspectFill  // 填满容器，保持比例，裁剪超出部分
    containerView.layer.addSublayer(playerLayer)
    containerView.playerLayer = playerLayer

    return containerView
  }

  func updateUIView(_ uiView: PlayerContainerView, context: Context) {
    // 更新 playerLayer 的 frame
    uiView.playerLayer?.frame = uiView.bounds
  }
}

// MARK: - Video Player View
struct VideoPlayerView: View {
  let videoName: String  // 文件名，不带扩展名
  let fileExtension: String = "mp4"  // 或 "mov" 等

  @State private var player: AVPlayer?
  @State private var isPlaying: Bool = false
  @State private var showPlayButton: Bool = false

  var body: some View {
    ZStack {
      if let player = player {
        // 使用自定义的 AVPlayerLayer 包装器实现全屏播放
        AVPlayerLayerView(player: player)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black)
          .contentShape(Rectangle())
          .onAppear {
            player.play()
            isPlaying = true
          }
          .onDisappear {
            player.pause()
            isPlaying = false
          }
          .overlay(
            // 播放/暂停按钮覆盖层 + 顶底黑色中间透明渐变遮罩
            ZStack {
              // 渐变遮罩
              LinearGradient(
                gradient: Gradient(stops: [
                  .init(color: Color.black.opacity(0.5), location: 0.0),
                  .init(color: Color.black.opacity(0.0), location: 0.18),
                  .init(color: Color.black.opacity(0.0), location: 0.82),
                  .init(color: Color.black.opacity(0.7), location: 1.0),
                ]),
                startPoint: .top,
                endPoint: .bottom
              )
              .ignoresSafeArea()

              // 播放/暂停按钮
              Group {
                if !isPlaying {
                  Image("HTLmY1hsavuQ7Jn2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                }
                // if showPlayButton {
                //     Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                //         .font(.system(size: 80))
                //         .foregroundColor(.white.opacity(0.8))
                // }
              }
              .animation(.easeInOut(duration: 0.2), value: showPlayButton)
            }
          )
          .onTapGesture {
            // 切换播放状态
            togglePlayPause()

            // 显示播放按钮
            withAnimation {
              showPlayButton = true
            }

            // 2秒后自动隐藏
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              withAnimation {
                showPlayButton = false
              }
            }
          }
      } else {
        // 加载状态
        ProgressView("Loading video...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black)
          .onAppear {
            loadVideo()
          }
      }
    }
  }

  private func loadVideo() {
    guard
      let url = Bundle.main.url(
        forResource: videoName,
        withExtension: fileExtension
      )
    else {
      print("⚠️ 视频文件未找到: \(videoName).\(fileExtension)")
      return
    }

    let avPlayer = AVPlayer(url: url)

    // 设置循环播放
    NotificationCenter.default.addObserver(
      forName: .AVPlayerItemDidPlayToEndTime,
      object: avPlayer.currentItem,
      queue: .main
    ) { _ in
      avPlayer.seek(to: .zero)
      avPlayer.play()
      isPlaying = true
    }

    self.player = avPlayer
  }

  /// 切换播放/暂停
  private func togglePlayPause() {
    guard let player = player else { return }
    if player.timeControlStatus == .playing {
      player.pause()
      isPlaying = false
    } else {
      player.play()
      isPlaying = true
    }
  }
}

// #Preview {
//     VideoPlayerView(videoName: "YLXVqZ8wbqT0SSgp1")
// }
