//
//  BlacklistView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct BlacklistView: View {
  @EnvironmentObject var au8PAPgSVGmoAhD: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @StateObject private var blcAzRj9NhSBUoqvVmod = BlcAZzdkCZPB1o2aVmdl()

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(spacing: 0) {
        header
          .padding(.horizontal, 20)
          .padding(.bottom, 10)

        if blcAzRj9NhSBUoqvVmod.blouserctQXbGMX3kUgr.isEmpty {
          EmptyPlaceholderView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          ScrollView {
            VStack(spacing: 16) {
              ForEach(blcAzRj9NhSBUoqvVmod.blouserctQXbGMX3kUgr, id: \.id) { user in
                blaitemM2hwr7BxOebb3(userNtm79g6kOJtqr: user)
              }
            }
            .frame(width: .infinity, height: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
            .padding(.top, 16)
          }
        }
      }
    }
    .navigationBarHidden(true)
    .onAppear {
      blcAzRj9NhSBUoqvVmod.loadBlockedUsers(
        blouidFKnKiKBUzjZq0: au8PAPgSVGmoAhD.currvj9QRUUPOWY4Ouser?.blockedUserIds ?? [],
        ausernBbJzsGRqu4eF: Authsdmd0VXzbAnDYServ.shared
      )
    }
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var header: some View {
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

      Text("Blacklist")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)
    }
  }

  private func blaitemM2hwr7BxOebb3(userNtm79g6kOJtqr: User) -> some View {
    ZStack(alignment: .topLeading) {
      ZStack {
        Image("todrcOCVKxRfLanQ")
          .resizable()
          .scaledToFill()
          .clipped()
          .frame(width: .infinity, height: 78)

        VStack(alignment: .leading, spacing: 12) {
          HStack {
            Text(userNtm79g6kOJtqr.username)
              .font(.custom("FredokaOne-Regular", size: 16))
              .foregroundColor(.white)

            Spacer()

            Button {
              au8PAPgSVGmoAhD.reNRhAhnjCSdO8F(userNtm79g6kOJtqr.id)
              blcAzRj9NhSBUoqvVmod.removeUser(uidTb4r3Jbz7orP5: userNtm79g6kOJtqr.id)
            } label: {
              Text("Remove")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                  RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("buttonPurple"))
                    .overlay(
                      RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.white, lineWidth: 1)
                    )
                )
            }
          }
          .frame(maxWidth: .infinity)
        }
        .padding(.leading, 106)
        .padding(.trailing, 14)
      }
      .padding(.top, 12)

      ProfileImageView(
        avatar: userNtm79g6kOJtqr.avatar,
        username: userNtm79g6kOJtqr.username,
        size: 62,
        subSize: 16,
      )
      .padding(.leading, 12)

    }
  }
}

@MainActor
class BlcAZzdkCZPB1o2aVmdl: ObservableObject {
  @Published var blouserctQXbGMX3kUgr: [User] = []

  func loadBlockedUsers(
    blouidFKnKiKBUzjZq0: [String], ausernBbJzsGRqu4eF: Authsdmd0VXzbAnDYServProc
  ) {
    blouserctQXbGMX3kUgr = blouidFKnKiKBUzjZq0.compactMap { uidTb4r3Jbz7orP5 in
      ausernBbJzsGRqu4eF.getbyidQwpUuIWnzzs99(uidTb4r3Jbz7orP5)
    }
  }

  func removeUser(uidTb4r3Jbz7orP5: String) {
    blouserctQXbGMX3kUgr.removeAll { $0.id == uidTb4r3Jbz7orP5 }
  }
}
