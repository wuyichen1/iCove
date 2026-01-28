//
//  EditProfileView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import PhotosUI
import SwiftUI
import UIKit

#if DEBUG
  import HotSwiftUI
#endif

struct EditProfileView: View {
  @EnvironmentObject var FUmIz00KvBJa2: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss

  @State private var pTN8hZ9kCDZmYuname: String = ""

  @State private var selmgUW9WZvxFvNWaI: UIImage?
  @State private var shpickvyDFa1XET29Sa: Bool = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack(alignment: .top) {
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 32) {
        top0SwDQASlIlaOz
          .padding(.top, 46)
          .padding(.horizontal, 20)

        ava3qFcQjV7tE0U1
          .padding(.vertical, 24)

        formm3DKAIJOm0kIT
          .padding(.horizontal, 24)

        btnz5k2SFnlFNVJa
          .padding(.horizontal, 40)
          .padding(.vertical, 60)
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      if pTN8hZ9kCDZmYuname.isEmpty {
        pTN8hZ9kCDZmYuname = FUmIz00KvBJa2.currvj9QRUUPOWY4Ouser?.username ?? ""
      }
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var top0SwDQASlIlaOz: some View {
    HStack {
      Button {
        router.pop()
      } label: {
        Circle()
          .fill(Color.white)
          .frame(width: 40, height: 40)
          .overlay(
            Image(systemName: "arrow.uturn.left")
              .foregroundColor(Color("buttonPurple"))
          )
      }

      Spacer()

      Text("Information")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)

    }
  }

  private var ava3qFcQjV7tE0U1: some View {
    Button {
      shpickvyDFa1XET29Sa = true
    } label: {
      ZStack(alignment: .topTrailing) {
        if let selmgUW9WZvxFvNWaI = selmgUW9WZvxFvNWaI {
          ProfileImageView(
            avatar: selmgUW9WZvxFvNWaI,
            username: FUmIz00KvBJa2.currvj9QRUUPOWY4Ouser?.username ?? "",
            size: 115,
            subSize: 32
          )
        } else if let avajoEEIb3dBxOav = FUmIz00KvBJa2.currvj9QRUUPOWY4Ouser?.avatar {
          ProfileImageView(
            avatar: avajoEEIb3dBxOav,
            username: FUmIz00KvBJa2.currvj9QRUUPOWY4Ouser?.username ?? "",
            size: 115,
            subSize: 32
          )
        } else {
          ProfileImageView(
            avatar: "icove_logo",
            username: FUmIz00KvBJa2.currvj9QRUUPOWY4Ouser?.username ?? "",
            size: 115,
            subSize: 32
          )
        }

        Image("2uIPOm40mxvOSEtB")
          .resizable()
          .scaledToFill()
          .frame(width: 24, height: 24)
      }
    }
    .imagePicker(selectedImage: $selmgUW9WZvxFvNWaI, showPicker: $shpickvyDFa1XET29Sa)
  }

  // MARK: - Form Section
  private var formm3DKAIJOm0kIT: some View {
    VStack(alignment: .leading, spacing: 16) {

      ZStack {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .fill(
            LinearGradient(
              colors: [
                Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
                Color.white,
              ],
              startPoint: .top,
              endPoint: .bottom
            )
          )

        VStack(alignment: .leading) {
          Text("Username:")
            .font(.custom("FredokaOne-Regular", size: 20))
            .foregroundColor(.white)

          TextField("Enter your username", text: $pTN8hZ9kCDZmYuname)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
            )
            .submitLabel(.done)
        }
        .padding(.horizontal, 16)

      }
      .frame(maxWidth: .infinity, maxHeight: 150)
    }
  }

  private var btnz5k2SFnlFNVJa: some View {
    Button {
      saveY7yuvGxwfZN9Y()
    } label: {
      Text("Save")
        .font(.custom("FredokaOne-Regular", size: 22))
        .foregroundColor(.white)
        .frame(maxWidth: 240)
        .padding(.vertical, 13)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color("buttonPurple"))
            .overlay(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white, lineWidth: 2)
            )
        )
    }
  }

  private func saveY7yuvGxwfZN9Y() {
    let viTiNWw93cVOn = pTN8hZ9kCDZmYuname.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !viTiNWw93cVOn.isEmpty else { return }

    FUmIz00KvBJa2.updunamespsqxOby9PquA(viTiNWw93cVOn)

    if let gGdHWvOquOIBy = selmgUW9WZvxFvNWaI {
      FUmIz00KvBJa2.updavaiyCs1j96Lelzs(gGdHWvOquOIBy)
      selmgUW9WZvxFvNWaI = nil
    }

    router.pop()
  }
}
