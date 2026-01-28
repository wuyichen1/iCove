//
//  PubVypVDl0eHHL9jView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import AVFoundation
import AVKit
import Photos
import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

#if DEBUG
  import HotSwiftUI
#endif

struct PubVypVDl0eHHL9jView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var auiGgZwlS2hzgS9: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var pubVmUgv9N9Lifjvva = PubVmod3vAA52GUNFoOZ()

  let pubTypeWZOlcaTCZFIeL: PubtypeixL8MqcCr6wZE

  @State private var idea12u7sEM4VSkxy: String = ""
  @State private var contomr5Z3F2pk25G: String = ""
  @State private var isupdingihcxhWuaWfvpX: Bool = false

  @State private var imgsXUiHKeU6kPh5R: [UIImage] = []
  @State private var seleimgsaSpzTYARwzbTh: [PhotosPickerItem] = []
  @State private var showpicker76WU8TQPOyDCk: Bool = false

  @State private var sevdoGl9lwyWvjF4dj: URL?
  @State private var secoverIeISBAgiI58fB: UIImage?
  @State private var svodpivTJTzCLlD6k7Qg: Bool = false
  @State private var sh1U5dX7sH03Ppl: Bool = false
  @State private var shoreczy38cyUCQpGYr: Bool = false

  @State private var shperl2h5V8BF1DCoI: Bool = false
  @State private var pertitdh68UlnTVJt0B: String = ""
  @State private var permsgBuwfKeufmnd9p: String = ""

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        HStack {
          Button(action: {
            dismiss()
          }) {
            ZStack {
              Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
              Image(systemName: "arrow.uturn.left")
                .foregroundColor(Color("buttonPurple"))
            }
          }
          .padding(.leading, 20)

          Spacer()
        }
        .padding(.bottom, 20)

        ScrollView {
          VStack(spacing: 24) {
            contr8zhdyK4dN1MA
              .padding(.horizontal, 20)
              .padding(.top, 20)

            btnRc9xVKQlruGPp
              .padding(.horizontal, 20)
              .padding(.top, 20)
              .padding(.bottom, 40)
          }
        }
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  // MARK: - Main Content Card
  private var contr8zhdyK4dN1MA: some View {
    ZStack {
      LinearGradient(
        colors: [
          Color("btnpink"),
          Color.white,
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))

      VStack(alignment: .leading, spacing: 20) {
        if pubTypeWZOlcaTCZFIeL == .imgHkANxe83jDb0E {
          idealRcCpFSAOOIC0
          picZCjxaCu5Z5hnN
        } else {
          contCH3ahwkIlAIqf
          vdoJa4vXdLKYKrzD
        }
      }
      .padding(20)
    }
  }

  private var idealRcCpFSAOOIC0: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Idea:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 180)

        TxtdtOlMxaoJnUeEsL(text: $idea12u7sEM4VSkxy)
          .padding(.horizontal, 16)
          .padding(.vertical, 15)

        if idea12u7sEM4VSkxy.isEmpty {
          Text("Enter")
            .foregroundColor(.gray.opacity(0.5))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
      }
    }
  }

  private var picZCjxaCu5Z5hnN: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("Picture:")
          .font(.custom("FredokaOne-Regular", size: 18))
          .foregroundColor(.white)

        Spacer()

        if !imgsXUiHKeU6kPh5R.isEmpty {
          Text("\(imgsXUiHKeU6kPh5R.count)/9")
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.8))
        }
      }

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(minHeight: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if imgsXUiHKeU6kPh5R.isEmpty {
          Button(action: {
            reqper2ozOs519VzW5c { granted in
              if granted {
                showpicker76WU8TQPOyDCk = true
              }
            }
          }) {
            VStack(spacing: 8) {
              Image("nTJj2vmUFcjHzW5I")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
            }
          }
        } else {
          VStack(spacing: 8) {
            LazyVGrid(
              columns: [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8),
              ], spacing: 8
            ) {
              ForEach(Array(imgsXUiHKeU6kPh5R.enumerated()), id: \.offset) { index, image in
                ZStack(alignment: .topTrailing) {
                  Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                  Button(action: {
                    removegzXX1QBn9l9ZB(at: index)
                  }) {
                    Image(systemName: "xmark.circle.fill")
                      .foregroundColor(.white)
                      .background(Color.black.opacity(0.6))
                      .clipShape(Circle())
                      .font(.system(size: 18))
                  }
                  .offset(x: 4, y: -4)
                }
              }

              if imgsXUiHKeU6kPh5R.count < 9 {
                Button(action: {
                  reqper2ozOs519VzW5c { granted in
                    if granted {
                      showpicker76WU8TQPOyDCk = true
                    }
                  }
                }) {
                  ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                      .fill(Color.gray.opacity(0.2))
                      .frame(width: 80, height: 80)

                    Image(systemName: "plus")
                      .font(.system(size: 24))
                      .foregroundColor(.gray)
                  }
                }
              }
            }
            .padding(12)
          }
        }
      }
    }
    .photosPicker(
      isPresented: $showpicker76WU8TQPOyDCk,
      selection: $seleimgsaSpzTYARwzbTh,
      maxSelectionCount: imgsXUiHKeU6kPh5R.isEmpty ? 9 : 9 - imgsXUiHKeU6kPh5R.count,
      matching: .images,
      photoLibrary: .shared()
    )
    .onChange(of: seleimgsaSpzTYARwzbTh) {
      loadwWv61ErBiG6dU()
    }
  }

  private func loadwWv61ErBiG6dU() {
    Task {
      var imgs6BpSDNQsFFO9e: [UIImage] = imgsXUiHKeU6kPh5R
      for item1Qep16obIo7ma in seleimgsaSpzTYARwzbTh {
        if let dataqHoFFJEadDCnU = try? await item1Qep16obIo7ma.loadTransferable(type: Data.self),
          let imgfqxYrmohPIWVc = UIImage(data: dataqHoFFJEadDCnU)
        {
          if !imgs6BpSDNQsFFO9e.contains(where: { $0.pngData() == imgfqxYrmohPIWVc.pngData() }) {
            imgs6BpSDNQsFFO9e.append(imgfqxYrmohPIWVc)
          }
        }
      }
      await MainActor.run {
        imgsXUiHKeU6kPh5R = Array(imgs6BpSDNQsFFO9e.prefix(9))
        seleimgsaSpzTYARwzbTh = []
      }
    }
  }

  private func removegzXX1QBn9l9ZB(at idxPfFzE8o4o7WyW: Int) {
    guard idxPfFzE8o4o7WyW < imgsXUiHKeU6kPh5R.count else { return }
    imgsXUiHKeU6kPh5R.remove(at: idxPfFzE8o4o7WyW)
  }

  private var contCH3ahwkIlAIqf: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Content:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack(alignment: .topLeading) {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 180)

        TxtdtOlMxaoJnUeEsL(text: $contomr5Z3F2pk25G)
          .padding(.horizontal, 16)
          .padding(.vertical, 15)

        if contomr5Z3F2pk25G.isEmpty {
          Text("Enter")
            .foregroundColor(.gray.opacity(0.5))
            .font(.system(size: 15))
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
      }
    }
  }

  private var vdoJa4vXdLKYKrzD: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Video works:")
        .font(.custom("FredokaOne-Regular", size: 18))
        .foregroundColor(.white)

      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color.white)
          .frame(height: 200)
          .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 4)

        if let fpnLlYpMWnniZimg = secoverIeISBAgiI58fB {
          ZStack(alignment: .topTrailing) {
            ZStack {
              Image(uiImage: fpnLlYpMWnniZimg)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

              Image(systemName: "play.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.8))
            }

            Button(action: {
              cleare89BAbhUsrv0E()
            }) {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .font(.system(size: 24))
            }
            .padding(12)
          }
        } else {
          Button(action: {
            svodpivTJTzCLlD6k7Qg = true
          }) {
            VStack(spacing: 8) {
              Image("2AQ4HXnboJp7so7u")
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38)
            }
          }
        }
      }
    }
    .confirmationDialog(
      "Select Video Source", isPresented: $svodpivTJTzCLlD6k7Qg, titleVisibility: .visible
    ) {
      Button("Gallery") {
        reqper2ozOs519VzW5c { granted in
          if granted {
            sh1U5dX7sH03Ppl = true
          }
        }
      }
      Button("Record") {
        reqcammicHp3DPi2qHXIi2 { granted in
          if granted {
            shoreczy38cyUCQpGYr = true
          }
        }
      }
      Button("Cancel", role: .cancel) {}
    }
    .sheet(isPresented: $sh1U5dX7sH03Ppl) {
      VdoPickir3kyO9OU2zK7(
        sevdoGl9lwyWvjF4dj: $sevdoGl9lwyWvjF4dj, selethumIQeRFSe6PHrqc: $secoverIeISBAgiI58fB)
    }
    .fullScreenCover(isPresented: $shoreczy38cyUCQpGYr) {
      CameReckLUE1X6e3zr67(
        sevdoGl9lwyWvjF4dj: $sevdoGl9lwyWvjF4dj, selethumIQeRFSe6PHrqc: $secoverIeISBAgiI58fB)
    }
    .alert(pertitdh68UlnTVJt0B, isPresented: $shperl2h5V8BF1DCoI) {
      Button("Cancel", role: .cancel) {}
    } message: {
      Text(permsgBuwfKeufmnd9p)
    }
  }

  private func reqper2ozOs519VzW5c(completion: @escaping (Bool) -> Void) {
    let gDMQxSMLMKnGQ = PHPhotoLibrary.authorizationStatus(for: .readWrite)

    switch gDMQxSMLMKnGQ {
    case .authorized, .limited:
      completion(true)
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization(for: .readWrite) { LmyZSO28J1Pgc in
        DispatchQueue.main.async {
          if LmyZSO28J1Pgc == .authorized || LmyZSO28J1Pgc == .limited {
            completion(true)
          } else {
            denyYlQB6NDfVJpmg(for: "Photo Library")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      denyYlQB6NDfVJpmg(for: "Photo Library")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  private func reqcammicHp3DPi2qHXIi2(completion: @escaping (Bool) -> Void) {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      VXgjxN445gMvz()
      completion(false)
      return
    }

    let vTSinWCEpZT4Wcamstu = AVCaptureDevice.authorizationStatus(for: .video)

    switch vTSinWCEpZT4Wcamstu {
    case .authorized:
      reqmic6C1BJm67LgQHe(completion: completion)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          if granted {
            self.reqmic6C1BJm67LgQHe(completion: completion)
          } else {
            self.denyYlQB6NDfVJpmg(for: "Camera")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      denyYlQB6NDfVJpmg(for: "Camera")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  private func VXgjxN445gMvz() {
    pertitdh68UlnTVJt0B = "Camera Unavailable"
    permsgBuwfKeufmnd9p = "This device does not have a camera or the camera is not available."
    shperl2h5V8BF1DCoI = true
  }

  private func reqmic6C1BJm67LgQHe(completion: @escaping (Bool) -> Void) {
    let micP4wcKvnrbRgNlStatus = AVCaptureDevice.authorizationStatus(for: .audio)

    switch micP4wcKvnrbRgNlStatus {
    case .authorized:
      completion(true)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .audio) { granted in
        DispatchQueue.main.async {
          if granted {
            completion(true)
          } else {
            self.denyYlQB6NDfVJpmg(for: "Microphone")
            completion(false)
          }
        }
      }
    case .denied, .restricted:
      denyYlQB6NDfVJpmg(for: "Microphone")
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  private func denyYlQB6NDfVJpmg(for per4b8Gc1d3ZVSii: String) {
    pertitdh68UlnTVJt0B = "\(per4b8Gc1d3ZVSii) Access Required"
    permsgBuwfKeufmnd9p =
      "Please enable \(per4b8Gc1d3ZVSii) access in Settings to use this feature."
    shperl2h5V8BF1DCoI = true
  }

  private func openAppSettings() {
    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
      UIApplication.shared.open(settingsURL)
    }
  }

  private func cleare89BAbhUsrv0E() {
    if let GW12SiEqpMVSourl = sevdoGl9lwyWvjF4dj {
      try? FileManager.default.removeItem(at: GW12SiEqpMVSourl)
    }
    sevdoGl9lwyWvjF4dj = nil
    secoverIeISBAgiI58fB = nil
  }

  private var btnRc9xVKQlruGPp: some View {
    Button(action: {
      Task {
        await updaHjg6NYWzDJRI()
      }
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(Color("buttonPurple"))
          .frame(width: 220, height: 50)
          .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
              .stroke(Color.white, lineWidth: 2)
          )

        if isupdingihcxhWuaWfvpX {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        } else {
          Text("Upload")
            .font(.custom("FredokaOne-Regular", size: 18))
            .foregroundColor(.white)
        }
      }
    }
    .disabled(!canUpload || isupdingihcxhWuaWfvpX)
  }

  private var canUpload: Bool {
    if pubTypeWZOlcaTCZFIeL == .imgHkANxe83jDb0E {
      return !idea12u7sEM4VSkxy.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !imgsXUiHKeU6kPh5R.isEmpty
    } else {
      return !contomr5Z3F2pk25G.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && sevdoGl9lwyWvjF4dj != nil
    }
  }

  private func updaHjg6NYWzDJRI() async {
    guard !isupdingihcxhWuaWfvpX else { return }
    isupdingihcxhWuaWfvpX = true

    try? await Task.sleep(nanoseconds: 500_000_000)

    guard let uidt8QKZjZkVPBFi = auiGgZwlS2hzgS9.currvj9QRUUPOWY4Ouser?.id else {
      isupdingihcxhWuaWfvpX = false
      return
    }

    if pubTypeWZOlcaTCZFIeL == .imgHkANxe83jDb0E {
      guard !imgsXUiHKeU6kPh5R.isEmpty else {
        isupdingihcxhWuaWfvpX = false
        return
      }

      let svdimgsztO1SlRxZ1Tpd = await localdacAaMu0rjqhusave(imgsXUiHKeU6kPh5R)

      guard !svdimgsztO1SlRxZ1Tpd.isEmpty else {
        isupdingihcxhWuaWfvpX = false
        return
      }

      let poqxzUqQ8fdptEV = Post(
        iT1uV3wX5yZ7aB: svdimgsztO1SlRxZ1Tpd,
        aC9dE1fG3hI5jK: uidt8QKZjZkVPBFi,
        cL7mN9oP1qR3sT: idea12u7sEM4VSkxy.trimmingCharacters(in: .whitespacesAndNewlines),
        tK3lM5nO7pQ9rS: Date()
      )

      pubVmUgv9N9Lifjvva.pub3mTgQb2LHyvZ0post(poqxzUqQ8fdptEV)

      NotificationCenter.default.post(name: NSNotification.Name("PostPublished"), object: nil)
    } else {
      guard let vdurlXssUD21QGjYmX = sevdoGl9lwyWvjF4dj else {
        isupdingihcxhWuaWfvpX = false
        return
      }

      let sdvdoCziNy6PARmUge = await tolocalXFRc0A0kqR0cp(vdurlXssUD21QGjYmX)
      let yhucovrJ10tEwSu5ND0 = await savethumzU1ckn5rujAHa(secoverIeISBAgiI58fB)

      let vdoy3TtxmwyRELjo = l9O6Sz7QVA4SDVideoItem(
        iM5aG7eN9aM1eN: yhucovrJ10tEwSu5ND0 ?? "1akQNNqBpWFE3YsJ0J",
        vI3dE5oN7aM9eN: sdvdoCziNy6PARmUge ?? vdurlXssUD21QGjYmX.lastPathComponent,
        tR3sT5uV7wX9yZ: contomr5Z3F2pk25G.trimmingCharacters(in: .whitespacesAndNewlines),
        aC9dE1fG3hI5jK: uidt8QKZjZkVPBFi,
        tK3lM5nO7pQ9rS: Date(),
        lI1kE3cO5uN7tN: 0,
        iS1lI3kE5dN7eN: false
      )

      pubVmUgv9N9Lifjvva.pubY1lwXpSC1Wwqjvdo(vdoy3TtxmwyRELjo)

      NotificationCenter.default.post(name: NSNotification.Name("VideoPublished"), object: nil)
    }

    isupdingihcxhWuaWfvpX = false
    dismiss()
  }

  private func localdacAaMu0rjqhusave(_ imgs51hQYnsQk7GvQ: [UIImage]) async -> [String] {
    var yHrPD5yq6JfU8: [String] = []
    let B0jn2zDD0xv20 = FileManager.default

    guard
      let EOSUh12HkfhZc = B0jn2zDD0xv20.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return yHrPD5yq6JfU8
    }

    let dtgf88jkHAWz2 = EOSUh12HkfhZc.appendingPathComponent("UserImages", isDirectory: true)

    try? B0jn2zDD0xv20.createDirectory(at: dtgf88jkHAWz2, withIntermediateDirectories: true)

    for (index, imga5eS4KBPFIlsP) in imgs51hQYnsQk7GvQ.enumerated() {
      let SmVoVtrGai9QXname = "img_\(UUID().uuidString)_\(index).jpg"
      let PhZHvKxArD1Vfurl = dtgf88jkHAWz2.appendingPathComponent(SmVoVtrGai9QXname)

      if let kaOfvdzmnL0qzdata = imga5eS4KBPFIlsP.jpegData(compressionQuality: 0.8) {
        do {
          try kaOfvdzmnL0qzdata.write(to: PhZHvKxArD1Vfurl)
          yHrPD5yq6JfU8.append(SmVoVtrGai9QXname)
        } catch {
          print("Failed to save image: \(error)")
        }
      }
    }

    return yHrPD5yq6JfU8
  }

  private func tolocalXFRc0A0kqR0cp(_ vdurlXssUD21QGjYmX: URL) async -> String? {
    let B0jn2zDD0xv20 = FileManager.default

    guard
      let EOSUh12HkfhZc = B0jn2zDD0xv20.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return nil
    }

    let K2gJjTdEjAjlQ = EOSUh12HkfhZc.appendingPathComponent("UserVideos", isDirectory: true)

    try? B0jn2zDD0xv20.createDirectory(at: K2gJjTdEjAjlQ, withIntermediateDirectories: true)

    let PWRaAV8K3bR5g = "video_\(UUID().uuidString).mp4"
    let kp758Dh1k6t45 = K2gJjTdEjAjlQ.appendingPathComponent(PWRaAV8K3bR5g)

    do {
      if B0jn2zDD0xv20.fileExists(atPath: kp758Dh1k6t45.path) {
        try B0jn2zDD0xv20.removeItem(at: kp758Dh1k6t45)
      }
      try B0jn2zDD0xv20.copyItem(at: vdurlXssUD21QGjYmX, to: kp758Dh1k6t45)
      return PWRaAV8K3bR5g
    } catch {
      print("Failed to save video: \(error)")
      return nil
    }
  }

  private func savethumzU1ckn5rujAHa(_ fpnLlYpMWnniZimg: UIImage?) async -> String? {
    guard let fpnLlYpMWnniZimg = fpnLlYpMWnniZimg else { return nil }

    let B0jn2zDD0xv20 = FileManager.default

    guard
      let IpDIobvsq4gHm = B0jn2zDD0xv20.urls(for: .documentDirectory, in: .userDomainMask).first
    else {
      return nil
    }

    let fxOMR9l1lmoEp = IpDIobvsq4gHm.appendingPathComponent(
      "VideoThumbnails", isDirectory: true)

    try? B0jn2zDD0xv20.createDirectory(at: fxOMR9l1lmoEp, withIntermediateDirectories: true)

    let PWRaAV8K3bR5g = "thumb_\(UUID().uuidString).jpg"
    let PhZHvKxArD1Vfurl = fxOMR9l1lmoEp.appendingPathComponent(PWRaAV8K3bR5g)

    if let imageData = fpnLlYpMWnniZimg.jpegData(compressionQuality: 0.8) {
      do {
        try imageData.write(to: PhZHvKxArD1Vfurl)
        return PWRaAV8K3bR5g
      } catch {
        print("Failed to save fpnLlYpMWnniZimg: \(error)")
      }
    }

    return nil
  }
}

@MainActor
class PubVmod3vAA52GUNFoOZ: ObservableObject {
  private let vdserOJXCL1WFIbuOc: VdoServproc63WnoDbxzFob0 = VdoServ63WnoDbxzFob0.shared
  private let poser5DXejfkHzyddJ: PostServprocK4dfzEM6tLRcc = PostServK4dfzEM6tLRcc.shared

  func pubY1lwXpSC1Wwqjvdo(_ vdvZnBjc7NSl5ag: l9O6Sz7QVA4SDVideoItem) {
    vdserOJXCL1WFIbuOc.addXIOHH83trw3Bg(vdvZnBjc7NSl5ag)
  }

  func pub3mTgQb2LHyvZ0post(_ povZnBjc7NSl5ag: Post) {
    poser5DXejfkHzyddJ.addHqRpcCjOX2uuE(povZnBjc7NSl5ag)
  }
}

struct VdoPickir3kyO9OU2zK7: UIViewControllerRepresentable {
  @Binding var sevdoGl9lwyWvjF4dj: URL?
  @Binding var selethumIQeRFSe6PHrqc: UIImage?
  @Environment(\.dismiss) var dismiss

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var CJrlsXBHZUTZp = PHPickerConfiguration()
    CJrlsXBHZUTZp.filter = .videos
    CJrlsXBHZUTZp.selectionLimit = 1

    let KuFWINl1YIOIU = PHPickerViewController(configuration: CJrlsXBHZUTZp)
    KuFWINl1YIOIU.delegate = context.coordinator
    return KuFWINl1YIOIU
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: VdoPickir3kyO9OU2zK7

    init(_ parent: VdoPickir3kyO9OU2zK7) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      parent.dismiss()

      guard let resikJjNiSco6qam = results.first else { return }

      if resikJjNiSco6qam.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
        resikJjNiSco6qam.itemProvider.loadFileRepresentation(
          forTypeIdentifier: UTType.movie.identifier
        ) {
          urlnfrW05lC0g8r1, error in
          guard let urlnfrW05lC0g8r1 = urlnfrW05lC0g8r1, error == nil else {
            print("Error loading video: \(error?.localizedDescription ?? "unknown error")")
            return
          }

          let tempz7YK06SiU67Eb = FileManager.default.temporaryDirectory.appendingPathComponent(
            UUID().uuidString + ".mp4")
          do {
            try FileManager.default.copyItem(at: urlnfrW05lC0g8r1, to: tempz7YK06SiU67Eb)

            let fpnLlYpMWnniZimg = self.gencover1loVoUk8z6Qeh(for: tempz7YK06SiU67Eb)

            DispatchQueue.main.async {
              self.parent.sevdoGl9lwyWvjF4dj = tempz7YK06SiU67Eb
              self.parent.selethumIQeRFSe6PHrqc = fpnLlYpMWnniZimg
            }
          } catch {
            print("Error copying video: \(error)")
          }
        }
      }
    }

    func gencover1loVoUk8z6Qeh(for urlt8FewAnDGYCKD: URL) -> UIImage? {
      let assetruU7IGrp7lApb = AVURLAsset(url: urlt8FewAnDGYCKD)
      let imageGenerator = AVAssetImageGenerator(asset: assetruU7IGrp7lApb)
      imageGenerator.appliesPreferredTrackTransform = true

      let semaphore = DispatchSemaphore(value: 0)
      var resimgocdnkKfWztsB0: UIImage?

      imageGenerator.generateCGImageAsynchronously(
        for: CMTime(seconds: 0, preferredTimescale: 1)
      ) { cgImage, _, error in
        if let cgImage = cgImage {
          resimgocdnkKfWztsB0 = UIImage(cgImage: cgImage)
        } else if let error = error {
          print("Error generating fpnLlYpMWnniZimg: \(error)")
        }
        semaphore.signal()
      }

      semaphore.wait()
      return resimgocdnkKfWztsB0
    }
  }
}

struct CameReckLUE1X6e3zr67: View {
  @Binding var sevdoGl9lwyWvjF4dj: URL?
  @Binding var selethumIQeRFSe6PHrqc: UIImage?
  @Environment(\.dismiss) var dismiss

  @State private var serrK3D4dQvfOkUws: Bool = false
  @State private var hV8a15rojr0C5: String = ""

  var body: some View {
    Group {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        CamRecCtrQ8WEG86doVOWx(
          sevdoGl9lwyWvjF4dj: $sevdoGl9lwyWvjF4dj,
          selthumrhT9RWNICXkN0: $selethumIQeRFSe6PHrqc,
          onError: { errLTBL22RZnsW1U in
            hV8a15rojr0C5 = errLTBL22RZnsW1U
            serrK3D4dQvfOkUws = true
          }
        )
        .ignoresSafeArea()
      } else {
        VStack(spacing: 20) {
          Image(systemName: "camera.fill")
            .font(.system(size: 60))
            .foregroundColor(.gray)

          Text("Camera Unavailable")
            .font(.headline)

          Text("This device does not have a camera or the camera is not available.")
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)

          Button("Close") {
            dismiss()
          }
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
        }
      }
    }
    .alert("Error", isPresented: $serrK3D4dQvfOkUws) {
      Button("OK") {
        dismiss()
      }
    } message: {
      Text(hV8a15rojr0C5)
    }
  }
}

struct CamRecCtrQ8WEG86doVOWx: UIViewControllerRepresentable {
  @Binding var sevdoGl9lwyWvjF4dj: URL?
  @Binding var selthumrhT9RWNICXkN0: UIImage?
  var onError: (String) -> Void
  @Environment(\.dismiss) var dismiss

  func makeUIViewController(context: Context) -> UIViewController {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      let errorVC = UIViewController()
      DispatchQueue.main.async {
        onError("Camera is not available on this device.")
      }
      return errorVC
    }

    do {
      let ORMegHdAvz30Y = UIImagePickerController()
      ORMegHdAvz30Y.sourceType = .camera

      guard
        let EiS47YIGsI6OH = UIImagePickerController.availableMediaTypes(for: .camera),
        EiS47YIGsI6OH.contains(UTType.movie.identifier)
      else {
        DispatchQueue.main.async {
          onError("Video recording is not supported on this device.")
        }
        return UIViewController()
      }

      ORMegHdAvz30Y.mediaTypes = [UTType.movie.identifier]
      ORMegHdAvz30Y.videoMaximumDuration = 60
      ORMegHdAvz30Y.videoQuality = .typeHigh
      ORMegHdAvz30Y.cameraCaptureMode = .video
      ORMegHdAvz30Y.delegate = context.coordinator
      return ORMegHdAvz30Y
    }
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: CamRecCtrQ8WEG86doVOWx

    init(_ parent: CamRecCtrQ8WEG86doVOWx) {
      self.parent = parent
    }

    func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
      parent.dismiss()

      if let vdurlXssUD21QGjYmX = info[.mediaURL] as? URL {
        let CVxW5DgmaDSaG = FileManager.default.temporaryDirectory.appendingPathComponent(
          UUID().uuidString + ".mp4")
        do {
          try FileManager.default.copyItem(at: vdurlXssUD21QGjYmX, to: CVxW5DgmaDSaG)

          let fpnLlYpMWnniZimg = gencover1loVoUk8z6Qeh(for: CVxW5DgmaDSaG)

          DispatchQueue.main.async {
            self.parent.sevdoGl9lwyWvjF4dj = CVxW5DgmaDSaG
            self.parent.selthumrhT9RWNICXkN0 = fpnLlYpMWnniZimg
          }
        } catch {
          DispatchQueue.main.async {
            self.parent.onError("Failed to save the recorded video.")
          }
        }
      }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.dismiss()
    }

    func gencover1loVoUk8z6Qeh(for urlE0jJA1Yu0rnsp: URL) -> UIImage? {
      let RxVHNhK0EooWCasset = AVURLAsset(url: urlE0jJA1Yu0rnsp)
      let imageGenerator = AVAssetImageGenerator(asset: RxVHNhK0EooWCasset)
      imageGenerator.appliesPreferredTrackTransform = true

      let semaphore = DispatchSemaphore(value: 0)
      var resimgocdnkKfWztsB0: UIImage?

      imageGenerator.generateCGImageAsynchronously(
        for: CMTime(seconds: 0, preferredTimescale: 1)
      ) { cgImage, _, error in
        if let cgImage = cgImage {
          resimgocdnkKfWztsB0 = UIImage(cgImage: cgImage)
        } else if let error = error {
          print("Error generating fpnLlYpMWnniZimg: \(error)")
        }
        semaphore.signal()
      }

      semaphore.wait()
      return resimgocdnkKfWztsB0
    }
  }
}

struct TxtdtOlMxaoJnUeEsL: UIViewRepresentable {
  @Binding var text: String

  func makeUIView(context: Context) -> UITextView {
    let QzjZ7Rf5PFm2P = UITextView()
    QzjZ7Rf5PFm2P.delegate = context.coordinator
    QzjZ7Rf5PFm2P.font = .systemFont(ofSize: 15)
    QzjZ7Rf5PFm2P.textColor = .black
    QzjZ7Rf5PFm2P.backgroundColor = .clear
    QzjZ7Rf5PFm2P.returnKeyType = .done
    QzjZ7Rf5PFm2P.textContainerInset = .zero
    QzjZ7Rf5PFm2P.textContainer.lineFragmentPadding = 0
    return QzjZ7Rf5PFm2P
  }

  func updateUIView(_ uiv1Vigq7Lmv9zvX: UITextView, context: Context) {
    if uiv1Vigq7Lmv9zvX.text != text {
      uiv1Vigq7Lmv9zvX.text = text
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UITextViewDelegate {
    let parent: TxtdtOlMxaoJnUeEsL

    init(_ parent: TxtdtOlMxaoJnUeEsL) {
      self.parent = parent
    }

    func textViewDidChange(_ ttvvK0Q7rkBj9XNB: UITextView) {
      parent.text = ttvvK0Q7rkBj9XNB.text
    }

    func textView(
      _ cfIqW17yIXljA: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String
    ) -> Bool {
      if text == "\n" && cfIqW17yIXljA.returnKeyType == .done {
        cfIqW17yIXljA.resignFirstResponder()
        return false
      }
      return true
    }
  }
}
