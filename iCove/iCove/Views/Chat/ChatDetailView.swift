//
//  ChatDetailView.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

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
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    .enableInjection()
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
          // 更多选项
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
    // .padding(.vertical, 14)
    .background(Color("yinguanglv"))
    .cornerRadius(12)
    .gesture(
      DragGesture(minimumDistance: 0)
        .onChanged { _ in
          if !viewModel.isRecording {
            viewModel.startRecording()
          }
        }
        .onEnded { _ in
          if viewModel.isRecording {
            viewModel.stopRecording()
          }
        }
    )
  }
}

// MARK: - Message Bubble
struct MessageBubble: View {
  let message: Message
  let isFromCurrentUser: Bool
  let otherUser: User?
  let currentUser: User?

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

// #Preview {
//   ChatDetailView(conversationId: "conv_001", otherUserId: "user_002")
//     .environmentObject(Router())
//     .environmentObject(AuthenticationManager())
// }
