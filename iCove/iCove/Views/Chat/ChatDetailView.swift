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
  @EnvironmentObject var aumanE2ZBeaqioilk: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var ctdtVmMj14NObPYFLCj: ChatDeth7xaLfsJnyiaYVmod
  @State private var repblosheetdd0PsyA3rHbiN = false
  @State private var blodiagJAtmqvn88cjR = false
  @State private var blouidpZnL4q6TFHXHV: String? = nil

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  private var filteredMessages: [Message] {
    ctdtVmMj14NObPYFLCj.W9fdBCK2PwNT9.filter { $0.conversationId == conversationId }
  }

  init(conversationId: String, otherUserId: String) {
    self.conversationId = conversationId
    self.otherUserId = otherUserId
    _ctdtVmMj14NObPYFLCj = StateObject(
      wrappedValue: ChatDeth7xaLfsJnyiaYVmod(
        cvidAQ11yFJplzflU: conversationId,
        ouid9I27rq3XslYVV: otherUserId
      )
    )
  }

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        LWPUxmxa9rCNe

        msglist2egFIJQ5vPjBR

        potbary7dSUqnasb0bv
      }

      recderrh6YNGOHlUh48d
    }
    .navigationBarHidden(true)
    .toolbar(.hidden, for: .tabBar)
    .sheet(isPresented: $repblosheetdd0PsyA3rHbiN) {
      ReportBlockBottomSheet(
        userId: otherUserId,
        isPresented: $repblosheetdd0PsyA3rHbiN,
        onBlock: {
          blouidpZnL4q6TFHXHV = otherUserId
          blodiagJAtmqvn88cjR = true
        }
      )
      .environmentObject(aumanE2ZBeaqioilk)
      .environmentObject(router)
      .presentationDetents([.height(240)])
      .presentationBackground(.clear)
      .presentationDragIndicator(.hidden)
    }
    .blockUserDialog(isPresented: $blodiagJAtmqvn88cjR, uidK1uO6OuOGNky0: blouidpZnL4q6TFHXHV)
    #if DEBUG
      .enableInjection()
    #endif
    .animation(.easeInOut(duration: 0.2), value: ctdtVmMj14NObPYFLCj.oQJFpzwEuhOCverr != nil)
  }

  // MARK: - Top Navigation Bar
  private var LWPUxmxa9rCNe: some View {
    ZStack(alignment: .top) {
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
          Color(red: 216 / 255, green: 127 / 255, blue: 227 / 255),
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
        if let ohuserlCI4zzXt8KJEb = ctdtVmMj14NObPYFLCj.othWYFKvCmorLqVV {
          if let avaNB07ZePIlnh0b = ohuserlCI4zzXt8KJEb.avatar {
            DynamicImage(imageName: avaNB07ZePIlnh0b)
              .frame(width: 40, height: 40)
              .clipShape(Circle())
          } else {
            Circle()
              .fill(Color.gray.opacity(0.3))
              .frame(width: 40, height: 40)
              .overlay {
                Text(String(ohuserlCI4zzXt8KJEb.username.prefix(1)))
                  .font(.headline)
                  .foregroundColor(.gray)
              }
          }

          Text(ohuserlCI4zzXt8KJEb.username)
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
          repblosheetdd0PsyA3rHbiN = true
        }
      )
    }
    .frame(height: 60)
  }

  // MARK: - Messages List
  private var msglist2egFIJQ5vPjBR: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack(spacing: 16) {
          ForEach(filteredMessages) { msgHKAo8eMn5mdVJ in
            MsgBubF87zGlqlutlLx(
              msgrf8eAfHnXCGIL: msgHKAo8eMn5mdVJ,
              isfrocurhelhF33uQZmia: msgHKAo8eMn5mdVJ.senderId
                == aumanE2ZBeaqioilk.currvj9QRUUPOWY4Ouser?.id,
              othF4yYLpbl5slTA: ctdtVmMj14NObPYFLCj.othWYFKvCmorLqVV,
              curaxrNHJOZfOKzQ: aumanE2ZBeaqioilk.currvj9QRUUPOWY4Ouser
            )
            .id(msgHKAo8eMn5mdVJ.id)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        if let lastmsgk1maMxjDsQllK = filteredMessages.last {
          proxy.scrollTo(lastmsgk1maMxjDsQllK.id, anchor: .bottom)
        }
      }
      .onChange(of: ctdtVmMj14NObPYFLCj.W9fdBCK2PwNT9.count) { _, _ in
        if let lastmsgk1maMxjDsQllK = filteredMessages.last {
          withAnimation {
            proxy.scrollTo(lastmsgk1maMxjDsQllK.id, anchor: .bottom)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  // MARK: - Input Bar
  private var potbary7dSUqnasb0bv: some View {
    HStack(spacing: 0) {
      Button(action: {
        ctdtVmMj14NObPYFLCj.togzxj4RWZ5iWkLD()
      }) {
        Image(
          systemName: ctdtVmMj14NObPYFLCj.xUUF5t6Gbyhne
            || ctdtVmMj14NObPYFLCj.sBZVfHlN89O0Y
            ? "xmark" : "plus"
        )
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(
          ctdtVmMj14NObPYFLCj.xUUF5t6Gbyhne || ctdtVmMj14NObPYFLCj.sBZVfHlN89O0Y
            ? Color("yinguanglv") : Color.black
        )
        .frame(width: 46, height: 46)
        .background(
          ctdtVmMj14NObPYFLCj.xUUF5t6Gbyhne || ctdtVmMj14NObPYFLCj.sBZVfHlN89O0Y
            ? Color.black : Color("yinguanglv")
        )
        .clipShape(Circle())
      }
      .padding(.trailing, 16)

      if ctdtVmMj14NObPYFLCj.xUUF5t6Gbyhne {
        menumuG694R6WA9l4
      }

      if ctdtVmMj14NObPYFLCj.sBZVfHlN89O0Y {
        recordingButton
      }

      HStack(spacing: 12) {
        if !ctdtVmMj14NObPYFLCj.sBZVfHlN89O0Y && !ctdtVmMj14NObPYFLCj.xUUF5t6Gbyhne {
          HStack(spacing: 12) {
            ZStack(alignment: .leading) {
              if ctdtVmMj14NObPYFLCj.inpfBw841kKnHeft.isEmpty {
                Text("Say something...")
                  .font(.system(size: 16))
                  .foregroundColor(.white.opacity(0.4))
                  .padding(.horizontal, 16)
                  .padding(.vertical, 15)
                  .allowsHitTesting(false)
              }
              TextField("", text: $ctdtVmMj14NObPYFLCj.inpfBw841kKnHeft)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 15)
                .submitLabel(.done)
            }

            Button(action: {
              if let curIdCeZH7925UDr0C = aumanE2ZBeaqioilk.currvj9QRUUPOWY4Ouser?.id {
                ctdtVmMj14NObPYFLCj.sendb9kzu5TB4hAkL(cuidoM2I0g1VnXoXW: curIdCeZH7925UDr0C)
                UIApplication.shared.sendAction(
                  #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
              }
            }) {
              Image(systemName: "paperplane.fill")
                .font(.system(size: 22))
                .foregroundColor(Color("yinguanglv"))
                .frame(width: 46, height: 46)
            }
            .disabled(
              ctdtVmMj14NObPYFLCj.inpfBw841kKnHeft.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty)
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
  private var recderrh6YNGOHlUh48d: some View {
    VStack {
      Spacer()
      if let errTadAd5zHdkbET = ctdtVmMj14NObPYFLCj.oQJFpzwEuhOCverr {
        Text(errTadAd5zHdkbET)
          .font(.system(size: 14))
          .foregroundColor(.white)
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(Color.red.opacity(0.9))
          .cornerRadius(8)
          .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
          .transition(.move(edge: .bottom).combined(with: .opacity))
          .padding(.bottom, 100)
      }
    }
    .frame(maxWidth: .infinity)
  }

  // MARK: - Attachment Menu
  private var menumuG694R6WA9l4: some View {
    HStack(spacing: 12) {
      Button(action: {
        ctdtVmMj14NObPYFLCj.selex31VUBVkwrtCB(.voiceGR1jUIKQ73wI7)
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

      ZStack {
        ImagePickerButton { slecr3n6ikDc2glUAimg in
          if let curIdhOKCGE3VIU5mn = aumanE2ZBeaqioilk.currvj9QRUUPOWY4Ouser?.id,
            let imgOQizpPbX5rB3F = ImgservxfMOg08cd0r7q.shared.savTolocalGnA4faaPYNYmz(
              slecr3n6ikDc2glUAimg, prefix9Z9hDXriSUPhB: "chat", uid0UcUIvLw3HhOS: curIdhOKCGE3VIU5mn)
          {
            ctdtVmMj14NObPYFLCj.sndimgTJyqAu4MxapC3(
              img02k8jBULdZ5To: imgOQizpPbX5rB3F, cutaQz3mfJvoGWS: curIdhOKCGE3VIU5mn)
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
        .allowsHitTesting(false)
      }

      // 第三个选项：视频通话 !!!!!!
      // Button(action: {
      //   ctdtVmMj14NObPYFLCj.selex31VUBVkwrtCB(.videoCall)
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
      Text(ctdtVmMj14NObPYFLCj.recingqavn8VXVjnhFw ? "Recording..." : "Hold to Speak")
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
        .updating($recordingGestureState) { c7QczyjlnZ0nu, ncaKSA9d09YVd, _ in
          switch c7QczyjlnZ0nu {
          case .first(true):
            ncaKSA9d09YVd = .pressing
          case .second(true, _):
            ncaKSA9d09YVd = .pressing
          default:
            break
          }
        }
        .onEnded { c7QczyjlnZ0nu in
          if ctdtVmMj14NObPYFLCj.recingqavn8VXVjnhFw {
            if let curIdEe7d6oq0Vd2XJ = aumanE2ZBeaqioilk.currvj9QRUUPOWY4Ouser?.id {
              ctdtVmMj14NObPYFLCj.stop45lI9JRtaBQBg(c6GQKa0ch0YKY: curIdEe7d6oq0Vd2XJ)
            }
          }
        }
    )
    .onChange(of: recordingGestureState) { oldValue, foO5F9emByVKj in
      if foO5F9emByVKj == .pressing && !ctdtVmMj14NObPYFLCj.recingqavn8VXVjnhFw {
        ctdtVmMj14NObPYFLCj.startd9fMj5HrwT7X4()
      }
    }
  }

  @GestureState private var recordingGestureState: RecstateIlDoK3E9AJp8i = .inactive

  private enum RecstateIlDoK3E9AJp8i {
    case inactive
    case pressing
  }
}

// MARK: - Message Bubble
struct MsgBubF87zGlqlutlLx: View {
  let msgrf8eAfHnXCGIL: Message
  let isfrocurhelhF33uQZmia: Bool
  let othF4yYLpbl5slTA: User?
  let curaxrNHJOZfOKzQ: User?

  @StateObject private var audserRfn5YlM76i6Hw = AudServIjFimBlyqhPqL.shared

  private var tf485F8fjU0kCDO: DateFormatter {
    let f9FlyALQRJ44dZ = DateFormatter()
    f9FlyALQRJ44dZ.dateFormat = "h:mm"
    f9FlyALQRJ44dZ.locale = Locale(identifier: "en_US_POSIX")
    return f9FlyALQRJ44dZ
  }

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      if !isfrocurhelhF33uQZmia {
        if let avaTJbmAxdt2PedA = othF4yYLpbl5slTA?.avatar {
          DynamicImage(imageName: avaTJbmAxdt2PedA)
            .frame(width: 38, height: 38)
            .clipShape(Circle())
            .padding(.trailing, 3)
        } else {
          Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 38, height: 38)
            .overlay {
              Text(String(othF4yYLpbl5slTA?.username.prefix(1) ?? "?"))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.gray)
            }
            .padding(.trailing, 3)
        }
      }

      VStack(alignment: isfrocurhelhF33uQZmia ? .trailing : .leading, spacing: 6) {
        Group {
          switch msgrf8eAfHnXCGIL.messageType {
          case .text:
            Text(msgrf8eAfHnXCGIL.content)
              .font(.system(size: 16))
              .foregroundColor(isfrocurhelhF33uQZmia ? .black : .white)
              .padding(.horizontal, 3)
          case .image:
            let corners: UIRectCorner =
              isfrocurhelhF33uQZmia
              ? [.topLeft, .bottomLeft, .bottomRight]
              : [.topRight, .bottomLeft, .bottomRight]

            DynamicImage(imageName: msgrf8eAfHnXCGIL.content)
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
                  isfrocurhelhF33uQZmia
                    ? Color.clear
                    : Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                  lineWidth: 2
                )
              )
          case .audio:
            Audbubg3mfsZYl1gedv(
              audwaGpngjKcv9hQ: msgrf8eAfHnXCGIL.content,
              isfrocurhelhF33uQZmia: isfrocurhelhF33uQZmia,
              audserRfn5YlM76i6Hw: audserRfn5YlM76i6Hw
            )
          }
        }
        .padding(12)
        .background(
          RoundedCorner(
            radius: 10,
            corners: isfrocurhelhF33uQZmia
              ? [.topLeft, .bottomLeft, .bottomRight]
              : [.topRight, .bottomLeft, .bottomRight]
          )
          .fill(
            isfrocurhelhF33uQZmia
              ? Color.white
              : Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255)
          )
        )

        Text(tf485F8fjU0kCDO.string(from: msgrf8eAfHnXCGIL.timestamp))
          .font(.system(size: 12))
          .foregroundColor(.white.opacity(0.6))
      }
      .padding(.top, isfrocurhelhF33uQZmia ? 0 : 15)
    }
    .frame(maxWidth: .infinity, alignment: isfrocurhelhF33uQZmia ? .trailing : .leading)
  }
}

// MARK: - Audio Bubble View
struct Audbubg3mfsZYl1gedv: View {
  let audwaGpngjKcv9hQ: String
  let isfrocurhelhF33uQZmia: Bool
  @ObservedObject var audserRfn5YlM76i6Hw: AudServIjFimBlyqhPqL

  @State private var durasLt9haRBYP8bG: TimeInterval = 0
  @State private var ispingvOIHj7JFNcMl9: Bool = false

  private var audrlNjw1umz8eZE0h: URL? {
    let gWrZ7Xsf4yiEG = FileManager.default
    let PK9AkXncbGNlY = gWrZ7Xsf4yiEG.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let WmyN6zxXjrL7Q = PK9AkXncbGNlY.appendingPathComponent("audio")
    let nB0rEDpDjBthx = WmyN6zxXjrL7Q.appendingPathComponent(audwaGpngjKcv9hQ)

    if gWrZ7Xsf4yiEG.fileExists(atPath: nB0rEDpDjBthx.path) {
      return nB0rEDpDjBthx
    }
    return nil
  }

  var body: some View {
    HStack(spacing: 12) {
      Button(action: {
        togglebOCX8y7KH6Qjh()
      }) {
        Image(systemName: ispingvOIHj7JFNcMl9 ? "pause.circle.fill" : "play.circle.fill")
          .font(.system(size: 24))
          .foregroundColor(isfrocurhelhF33uQZmia ? .black : .white)
      }

      Text(fromatrBBB8ZkIgoyJP(durasLt9haRBYP8bG))
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(isfrocurhelhF33uQZmia ? .black : .white)

    }
    .onAppear {
      loadaudXffOxtV8slTvA()
    }
    .onChange(of: audserRfn5YlM76i6Hw.ispingMRBbNuQyubCWx) { _, foO5F9emByVKj in
      ispingvOIHj7JFNcMl9 =
        foO5F9emByVKj && audserRfn5YlM76i6Hw.cururlgodvV9Jg90QXr == audrlNjw1umz8eZE0h
    }
    .onChange(of: audserRfn5YlM76i6Hw.cururlgodvV9Jg90QXr) { _, eP26ktyOkIg6q in
      ispingvOIHj7JFNcMl9 =
        eP26ktyOkIg6q == audrlNjw1umz8eZE0h && audserRfn5YlM76i6Hw.ispingMRBbNuQyubCWx
    }
  }

  private func togglebOCX8y7KH6Qjh() {
    guard let url9vG4HAsQCNMtg = audrlNjw1umz8eZE0h else { return }

    if ispingvOIHj7JFNcMl9 {
      if audserRfn5YlM76i6Hw.cururlgodvV9Jg90QXr == url9vG4HAsQCNMtg {
        audserRfn5YlM76i6Hw.stopWuAtWgjNjseJu()
      }
    } else {
      do {
        try audserRfn5YlM76i6Hw.playEIFmrihmHyTVX(from: url9vG4HAsQCNMtg)
      } catch {
        print("Failed to play audio: \(error)")
      }
    }
  }

  private func loadaudXffOxtV8slTvA() {
    guard let url9o9twX1aDhkTV = audrlNjw1umz8eZE0h else { return }

    Task {
      do {
        let erfioq8aZMshJSN = try AVAudioPlayer(contentsOf: url9o9twX1aDhkTV)
        durasLt9haRBYP8bG = erfioq8aZMshJSN.duration
      } catch {
        print("Failed to load audio duration: \(error)")
      }
    }
  }

  private func fromatrBBB8ZkIgoyJP(_ dvmoBltW6JaMU: TimeInterval) -> String {
    let Q4Lu1HnHSXItf = Int(dvmoBltW6JaMU) / 60
    let B0JCli2B0an7e = Int(dvmoBltW6JaMU) % 60
    return String(format: "%d:%02d", Q4Lu1HnHSXItf, B0JCli2B0an7e)
  }
}

// #Preview {
//   ChatDetailView(conversationId: "conv_001", otherUserId: "user_002")
//     .environmentObject(Router())
//     .environmentObject(AuthManagA645b8Y0Aod3aVmod())
// }
