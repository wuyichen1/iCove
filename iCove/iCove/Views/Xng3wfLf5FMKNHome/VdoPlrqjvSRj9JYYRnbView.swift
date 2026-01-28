//
//  VdoPlrqjvSRj9JYYRnbView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import AVKit
import SwiftUI
import UIKit

class PlayerContainerView: UIView {
  var plrlarDA6tFZRw9gmdk: AVPlayerLayer?

  override func layoutSubviews() {
    super.layoutSubviews()
    plrlarDA6tFZRw9gmdk?.frame = bounds
  }
}

struct AVPlayerLayerView: UIViewRepresentable {
  let plrv0NGAU9HJiTsi: AVPlayer

  func makeUIView(context: Context) -> PlayerContainerView {
    let conviewYJPCWqHNaCkOm = PlayerContainerView()
    conviewYJPCWqHNaCkOm.backgroundColor = .black

    let plrqkFJP7J8Q4Kva = AVPlayerLayer(player: plrv0NGAU9HJiTsi)
    plrqkFJP7J8Q4Kva.videoGravity = .resizeAspectFill
    conviewYJPCWqHNaCkOm.layer.addSublayer(plrqkFJP7J8Q4Kva)
    conviewYJPCWqHNaCkOm.plrlarDA6tFZRw9gmdk = plrqkFJP7J8Q4Kva

    return conviewYJPCWqHNaCkOm
  }

  func updateUIView(_ EvjLDiuBoTQxB: PlayerContainerView, context: Context) {
    EvjLDiuBoTQxB.plrlarDA6tFZRw9gmdk?.frame = EvjLDiuBoTQxB.bounds
  }
}

struct VdoPlrqjvSRj9JYYRnbView: View {
  let videoName: String
  let fileExtension: String = "mp4"

  @State private var plrv0NGAU9HJiTsi: AVPlayer?
  @State private var ispingBkZqhf7Ly10Mi: Bool = false
  @State private var shobtnWfaqcPMwSXgpi: Bool = false

  var body: some View {
    ZStack {
      if let plrv0NGAU9HJiTsi = plrv0NGAU9HJiTsi {
        AVPlayerLayerView(plrv0NGAU9HJiTsi: plrv0NGAU9HJiTsi)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black)
          .contentShape(Rectangle())
          .onAppear {
            plrv0NGAU9HJiTsi.play()
            ispingBkZqhf7Ly10Mi = true
          }
          .onDisappear {
            plrv0NGAU9HJiTsi.pause()
            ispingBkZqhf7Ly10Mi = false
          }
          .overlay(
            ZStack {
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

              Group {
                if !ispingBkZqhf7Ly10Mi {
                  Image("HTLmY1hsavuQ7Jn2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                }
              }
              .animation(.easeInOut(duration: 0.2), value: shobtnWfaqcPMwSXgpi)
            }
          )
          .onTapGesture {
            togplr7r3x1eXs59OYD()

            withAnimation {
              shobtnWfaqcPMwSXgpi = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              withAnimation {
                shobtnWfaqcPMwSXgpi = false
              }
            }
          }
      } else {
        ProgressView("Loading video...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black)
          .onAppear {
            loadXj72wfGrNzmvN()
          }
      }
    }
  }

  private func loadXj72wfGrNzmvN() {
    var vdo8DLjhWQQeEHLCURL: URL?

    if let bundleURL3c9GnqGIYAUEH = Bundle.main.url(
      forResource: videoName, withExtension: fileExtension)
    {
      vdo8DLjhWQQeEHLCURL = bundleURL3c9GnqGIYAUEH
    } else if let bundleURL3c9GnqGIYAUEH = Bundle.main.url(
      forResource: videoName, withExtension: "mov")
    {
      vdo8DLjhWQQeEHLCURL = bundleURL3c9GnqGIYAUEH
    } else {
      if let jF7Ci75j9AhH9 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first
      {
        let cUiw5M5fw899X = jF7Ci75j9AhH9.appendingPathComponent("UserVideos")
          .appendingPathComponent(videoName)

        if FileManager.default.fileExists(atPath: cUiw5M5fw899X.path) {
          vdo8DLjhWQQeEHLCURL = cUiw5M5fw899X
        } else {
          let T7Bf49D82W0Tc = jF7Ci75j9AhH9.appendingPathComponent("UserVideos")
            .appendingPathComponent("\(videoName).mp4")
          if FileManager.default.fileExists(atPath: T7Bf49D82W0Tc.path) {
            vdo8DLjhWQQeEHLCURL = T7Bf49D82W0Tc
          }
        }
      }
    }

    guard let url4sXBHrAcb8gFe = vdo8DLjhWQQeEHLCURL else {
      print("⚠️ video file not found: \(videoName)")
      return
    }

    let avpreDexzu6U82TeW = AVPlayer(url: url4sXBHrAcb8gFe)

    NotificationCenter.default.addObserver(
      forName: .AVPlayerItemDidPlayToEndTime,
      object: avpreDexzu6U82TeW.currentItem,
      queue: .main
    ) { _ in
      avpreDexzu6U82TeW.seek(to: .zero)
      avpreDexzu6U82TeW.play()
      ispingBkZqhf7Ly10Mi = true
    }

    self.plrv0NGAU9HJiTsi = avpreDexzu6U82TeW
  }

  private func togplr7r3x1eXs59OYD() {
    guard let plrv0NGAU9HJiTsi = plrv0NGAU9HJiTsi else { return }
    if plrv0NGAU9HJiTsi.timeControlStatus == .playing {
      plrv0NGAU9HJiTsi.pause()
      ispingBkZqhf7Ly10Mi = false
    } else {
      plrv0NGAU9HJiTsi.play()
      ispingBkZqhf7Ly10Mi = true
    }
  }
}

