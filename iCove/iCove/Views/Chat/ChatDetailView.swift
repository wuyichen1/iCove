//
//  ChatDetailView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import AVFoundation
import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct ChatDetailView: View {
  let conversationId: String
  let otherUserId: String
  @EnvironmentObject var router: Router
  @EnvironmentObject var authManager: AuthenticationManager
  @StateObject private var viewModel: ChatDetailViewModel
  @State private var showingReportBlockSheet = false
  @State private var showingBlockDialog = false
  @State private var blockUserId: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  // 筛选后的消息列表（只显示当前会话的消息）
  private var filteredMessages: [Message] {
    viewModel.messages.filter { $0.conversationId == conversationId }
  }

  init(conversationId: String, otherUserId: String) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    _viewModel = StateObject(
      wrappedValue: ChatDetailViewModel(
        conversationId: conversationId,
        otherUserId: otherUserId
      )
    )
  }

  var body: some View {
    ZStack {
      // 深紫色背景
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        // 顶部导航栏
        topNavigationBar

        // 消息列表
        messagesList

        // 底部输入栏
        inputBar
      }

      // 录音错误提示 Toast
      recordingErrorToast
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    .sheet(isPresented: $showingReportBlockSheet) {
      ReportBlockBottomSheet(
        userId: otherUserId,
        isPresented: $showingReportBlockSheet,
        onBlock: {
          blockUserId = otherUserId
          showingBlockDialog = true
        }
      )
      .environmentObject(authManager)
      .environmentObject(router)
      .presentationDetents([.height(240)])
      .presentationBackground(.clear)
      .presentationDragIndicator(.hidden)
    }
    .blockUserDialog(isPresented: $showingBlockDialog, userId: blockUserId)
    .enableInjection()
    .animation(.easeInOut(duration: 0.2), value: viewModel.recordingErrorMessage != nil)
  }

  // MARK: - Top Navigation Bar
  private var topNavigationBar: some View {
    ZStack(alignment: .top) {
      // background: linear-gradient(180deg, rgb(255, 255, 255) 0%, rgb(216, 72, 227) 100%);
      // 渐变背景：linear-gradient(180deg, rgb(255,255,255) 0%, rgb(216,72,227) 100%)
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
          Color(red: 216 / 255, green: 127 / 255, blue: 227 / 255),
          // Color.white,
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))
      .overlay(
        RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
          .stroke(Color.white.opacity(0.2), lineWidth: 1)
      )
      .ignoresSafeArea(edges: .top)

      HStack(spacing: 12) {
        // 对方用户头像和名称
        if let otherUser = viewModel.otherUser {
          if let avatarName = otherUser.avatar {
            DynamicImage(imageName: avatarName)
              .frame(width: 40, height: 40)
              .clipShape(Circle())
          } else {
            Circle()
              .fill(Color.gray.opacity(0.3))
              .frame(width: 40, height: 40)
              .overlay {
                Text(String(otherUser.username.prefix(1)))
                  .font(.headline)
                  .foregroundColor(.gray)
              }
          }

          Text(otherUser.username)
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.black)
        }
      }
      .padding(.top, 3)

      TopActionBar(
        onBack: {
          router.pop()
        },
        onMore: {
          showingReportBlockSheet = true
        }
      )
    }
    .frame(height: 60)
  }

  // MARK: - Messages List
  private var messagesList: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(filteredMessages) { message in
            MessageBubble(
              message: message,
              isFromCurrentUser: message.senderId == authManager.currentUser?.id,
              otherUser: viewModel.otherUser,
              currentUser: authManager.currentUser
            )
            .id(message.id)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        // 滚动到底部
        if let lastMessage = filteredMessages.last {
          proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
      }
      .onChange(of: viewModel.messages.count) { _, _ in
        // 新消息时滚动到底部
        if let lastMessage = filteredMessages.last {
          withAnimation {
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Input Bar
  private var inputBar: some View {
    HStack(spacing: 0) {
      // 附件按钮（绿色圆形按钮）
      Button(action: {
        viewModel.toggleAttachmentMenu()
      }) {
        Image(
          systemName: viewModel.showAttachmentMenu || viewModel.showRecordingButton
            ? "xmark" : "plus"
        )
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(
          viewModel.showAttachmentMenu || viewModel.showRecordingButton
            ? Color("yinguanglv") : Color.black
        )
        .frame(width: 46, height: 46)
        .background(
          viewModel.showAttachmentMenu || viewModel.showRecordingButton
            ? Color.black : Color("yinguanglv")
        )
        .clipShape(Circle())
      }
      .padding(.trailing, 16)

      // 附件菜单（当显示时）
      if viewModel.showAttachmentMenu {
        attachmentMenu
      }

      // 录音按钮（当显示时）
      if viewModel.showRecordingButton {
        recordingButton
      }

      // 主输入栏
      HStack(spacing: 12) {
        // 输入框和发送按钮（当不显示录音按钮时显示）
        if !viewModel.showRecordingButton && !viewModel.showAttachmentMenu {
          HStack(spacing: 12) {
            // 输入框
            ZStack(alignment: .leading) {
              if viewModel.inputText.isEmpty {
                Text("Say something...")
                  .font(.system(size: 16))
                  .foregroundColor(.white.opacity(0.4))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 15)
                  .allowsHitTesting(false)  // 不阻挡 TextField 的点击
              }
              TextField("", text: $viewModel.inputText)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
            }

            // 发送按钮
            Button(action: {
              if let currentUserId = authManager.currentUser?.id {
                viewModel.sendMessage(currentUserId: currentUserId)
              }
            }) {
              Image(systemName: "paperplane.fill")
                .font(.system(size: 22))
                .foregroundColor(Color("yinguanglv"))
                .frame(width: 46, height: 46)
            }
            .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
          }
          .background(Color(red: 25 / 255, green: 33 / 255, blue: 38 / 255))
          .cornerRadius(12)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 20)
    .background(Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255))
  }

  // MARK: - Recording Error Toast
  private var recordingErrorToast: some View {
    VStack {
      Spacer()
      if let errorMessage = viewModel.recordingErrorMessage {
        Text(errorMessage)
          .font(.system(size: 14))
          .foregroundColor(.white)
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(Color.red.opacity(0.9))
          .cornerRadius(8)
          .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
          .transition(.move(edge: .bottom).combined(with: .opacity))
          .padding(.bottom, 100)  // 在输入栏上方显示
      }
    }
    .frame(maxWidth: .infinity)
  }

  // MARK: - Attachment Menu
  private var attachmentMenu: some View {
    HStack(spacing: 12) {
      // 第一个选项：录音
      Button(action: {
        viewModel.selectAttachmentOption(.voice)
      }) {
        VStack(spacing: 8) {
          Image("puBQrcebakwOe3Fb")
            .resizable()
            .scaledToFit()
            .padding(8)
        }
        .frame(width: 46, height: 46)
        .background(Color("yinguanglv"))
        .clipShape(Circle())
      }

      // 第二个选项：图片
      ZStack {
        ImagePickerButton { selectedImage in
          // 图片选择后，保存并发送
          if let currentUserId = authManager.currentUser?.id,
            let imageName = ImageService.shared.saveImageToLocal(
              selectedImage, prefix: "chat", userId: currentUserId)
          {
            viewModel.sendImage(imageName: imageName, currentUserId: currentUserId)
          }
        }

        VStack(spacing: 8) {
          Image("SjdYiWxMSH85ZiZW")
            .resizable()
            .scaledToFit()
            .padding(8)
        }
        .frame(width: 46, height: 46)
        .background(Color("yinguanglv"))
        .clipShape(Circle())
        .allowsHitTesting(false)  // 让点击事件穿透到下面的按钮
      }

      // 第三个选项：视频通话
      // Button(action: {
      //   viewModel.selectAttachmentOption(.videoCall)
      //   router.push(.videoCall(conversationId: conversationId, otherUserId: otherUserId))
      // }) {
      //   VStack(spacing: 8) {
      //     Image("FltoQrPQqNaUP6E4")
      //       .resizable()
      //       .scaledToFit()
      //       .padding(8)
      //   }
      //   .frame(width: 46, height: 46)
      //   .background(Color("yinguanglv"))
      //   .clipShape(Circle())
      // }
    }
  }

  // MARK: - Recording Button
  private var recordingButton: some View {
    HStack {
      Spacer()
      Text(viewModel.isRecording ? "Recording..." : "Hold to Speak")
        .font(.custom("FredokaOne-Regular", size: 16))
        .foregroundColor(.black)
      Spacer()
    }
    .frame(height: 46)
    .background(Color("yinguanglv"))
    .cornerRadius(12)
    .gesture(
      LongPressGesture(minimumDuration: 0)
        .sequenced(before: DragGesture(minimumDistance: 0))
        .updating($recordingGestureState) { value, state, _ in
          switch value {
          case .first(true):
            // 长按开始
            state = .pressing
          case .second(true, _):
            // 拖动中
            state = .pressing
          default:
            break
          }
        }
        .onEnded { value in
          // 松开时停止录音并发送
          if viewModel.isRecording {
            if let currentUserId = authManager.currentUser?.id {
              viewModel.stopRecording(currentUserId: currentUserId)
            }
          }
        }
    )
    .onChange(of: recordingGestureState) { oldValue, newValue in
      if newValue == .pressing && !viewModel.isRecording {
        // 开始录音
        viewModel.startRecording()
      }
    }
  }

  @GestureState private var recordingGestureState: RecordingGestureState = .inactive

  private enum RecordingGestureState {
    case inactive
    case pressing
  }

  /// 格式化录音时长
  private func formatDuration(_ duration: TimeInterval) -> String {
    let minutes = Int(duration) / 60
    let seconds = Int(duration) % 60
    return String(format: "%d:%02d", minutes, seconds)
  }
}

// MARK: - Message Bubble
struct MessageBubble: View {
  let message: Message
  let isFromCurrentUser: Bool
  let otherUser: User?
  let currentUser: User?

  @StateObject private var audioService = AudioService.shared

  private var timeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      if !isFromCurrentUser {
        // 对方消息：显示头像
        if let avatarName = otherUser?.avatar {
          DynamicImage(imageName: avatarName)
            .frame(width: 38, height: 38)
            .clipShape(Circle())
            .padding(.trailing, 3)
        } else {
          Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 38, height: 38)
            .overlay {
              Text(String(otherUser?.username.prefix(1) ?? "?"))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.gray)
            }
            .padding(.trailing, 3)
        }
      }

      VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: 6) {
        // 消息气泡
        Group {
          switch message.messageType {
          case .text:
            Text(message.content)
              .font(.system(size: 16))
              .foregroundColor(isFromCurrentUser ? .black : .white)
              .padding(.horizontal, 3)
          case .image:
            let corners: UIRectCorner =
              isFromCurrentUser
              ? [.topLeft, .bottomLeft, .bottomRight]
              : [.topRight, .bottomLeft, .bottomRight]

            DynamicImage(imageName: message.content)
              // Image(message.content)
              // .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 150, height: 150)
              .clipShape(
                RoundedRectangle(cornerRadius: 15)
              )
              .overlay(
                RoundedCorner(
                  radius: 10,
                  corners: corners
                )
                .stroke(
                  isFromCurrentUser
                    ? Color.clear
                    : Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                  lineWidth: 2
                )
              )
          case .audio:
            AudioBubbleView(
              audioFileName: message.content,
              isFromCurrentUser: isFromCurrentUser,
              audioService: audioService
            )
          }
        }
        .padding(12)
        .background(
          RoundedCorner(
            radius: 10,
            corners: isFromCurrentUser
              ? [.topLeft, .bottomLeft, .bottomRight]
              : [.topRight, .bottomLeft, .bottomRight]
          )
          .fill(
            isFromCurrentUser
              ? Color.white
              : Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255)
          )
        )

        // 时间戳
        Text(timeFormatter.string(from: message.timestamp))
          .font(.system(size: 12))
          .foregroundColor(.white.opacity(0.6))
      }
      .padding(.top, isFromCurrentUser ? 0 : 15)

      // if isFromCurrentUser {
      //   // 当前用户头像
      //   Image(currentUser!.avatar!)
      //     .resizable()
      //     .scaledToFit()
      //     .frame(width: 38, height: 38)
      //     .clipShape(Circle())
      // }
    }
    .frame(maxWidth: .infinity, alignment: isFromCurrentUser ? .trailing : .leading)
  }
}

// MARK: - Audio Bubble View
struct AudioBubbleView: View {
  let audioFileName: String
  let isFromCurrentUser: Bool
  @ObservedObject var audioService: AudioService

  @State private var audioDuration: TimeInterval = 0
  @State private var isPlaying: Bool = false

  private var audioURL: URL? {
    let fileManager = FileManager.default
    let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let audioDir = documentsPath.appendingPathComponent("audio")
    let audioFileURL = audioDir.appendingPathComponent(audioFileName)

    if fileManager.fileExists(atPath: audioFileURL.path) {
      return audioFileURL
    }
    return nil
  }

  var body: some View {
    HStack(spacing: 12) {
      // 播放按钮
      Button(action: {
        togglePlayback()
      }) {
        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
          .font(.system(size: 24))
          .foregroundColor(isFromCurrentUser ? .black : .white)
      }

      // 音频波形或时长显示
      Text(formatDuration(audioDuration))
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(isFromCurrentUser ? .black : .white)

    }
    .onAppear {
      loadAudioDuration()
    }
    .onChange(of: audioService.isPlaying) { _, newValue in
      isPlaying = newValue && audioService.currentPlayingURL == audioURL
    }
    .onChange(of: audioService.currentPlayingURL) { _, newURL in
      isPlaying = newURL == audioURL && audioService.isPlaying
    }
  }

  private func togglePlayback() {
    guard let url = audioURL else { return }

    if isPlaying {
      // 如果正在播放当前音频，停止播放
      if audioService.currentPlayingURL == url {
        audioService.stopPlaying()
      }
    } else {
      // 开始播放
      do {
        try audioService.playAudio(from: url)
      } catch {
        print("Failed to play audio: \(error)")
      }
    }
  }

  private func loadAudioDuration() {
    guard let url = audioURL else { return }

    Task {
      do {
        let player = try AVAudioPlayer(contentsOf: url)
        audioDuration = player.duration
      } catch {
        print("Failed to load audio duration: \(error)")
      }
    }
  }

  private func formatDuration(_ duration: TimeInterval) -> String {
    let minutes = Int(duration) / 60
    let seconds = Int(duration) % 60
    return String(format: "%d:%02d", minutes, seconds)
  }
}

// #Preview {
//   ChatDetailView(conversationId: "conv_001", otherUserId: "user_002")
//     .environmentObject(Router())
//     .environmentObject(AuthenticationManager())
// }
