//
//  SettingsView.swift
//  iCove
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct SettingsView: View {
  @EnvironmentObject var TZn9Psbmx6nlq: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router
  @Environment(\.dismiss) var dismiss
  @State private var sdelI9WcIDcqYmOFT = false

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  var body: some View {
    ZStack {
      Color(red: 30 / 255, green: 5 / 255, blue: 57 / 255)
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 24) {
        headCe0I3mQWb8Usy
          .padding(.top, 0)
          .padding(.horizontal, 20)

        ScrollView {
          VStack(spacing: 16) {
            setbtnnGkQ3HgdYpOrc(
              titlHeVgRclzqrl3v: "Edit personal information",
              isPrim6Ooi8SHCn75ud: true
            ) {
              router.push(.editProfile)
            }

            setbtnnGkQ3HgdYpOrc(titlHeVgRclzqrl3v: "Blacklist", isPrim6Ooi8SHCn75ud: true) {
              router.push(.blacklist)
            }

            setbtnnGkQ3HgdYpOrc(titlHeVgRclzqrl3v: "Privacy Policy", isPrim6Ooi8SHCn75ud: true) {
              router.push(
                .agreement(url: "https://app.li65pe2f.link/privacy", title: "Privacy Policy"))
            }

            setbtnnGkQ3HgdYpOrc(titlHeVgRclzqrl3v: "User Agreement", isPrim6Ooi8SHCn75ud: true) {
              router.push(
                .agreement(url: "https://app.li65pe2f.link/users", title: "User Agreement"))
            }

            setbtnnGkQ3HgdYpOrc(titlHeVgRclzqrl3v: "Delete Account", isPrim6Ooi8SHCn75ud: true) {
              sdelI9WcIDcqYmOFT = true
            }

            setbtnnGkQ3HgdYpOrc(titlHeVgRclzqrl3v: "Log Out", isPrim6Ooi8SHCn75ud: true) {
              Task {
                await TZn9Psbmx6nlq.logoutWfSgkdWFVCXy1()
                router.popToRoot()
              }
            }
          }
          .padding(.horizontal, 20)
          .padding(.top, 8)
        }
      }

      if sdelI9WcIDcqYmOFT {
        UnlockConfirmDialog(
          hasEnoughBalance: nil,
          onCancel: {
            sdelI9WcIDcqYmOFT = false
          },
          onConfirm: {
            Task {
              await delAnttlypdVYhivb4k5()
            }
          },
          title:
            "Are you sure you want to delete this account? All data will be permanently cleared and cannot be restored.",
          btnText: "Sure",
        )
      }
    }
    .navigationBarHidden(true)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var headCe0I3mQWb8Usy: some View {
    VStack(alignment: .leading, spacing: 24) {
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

      Text("Settings")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(Color("btnpink"))
    }
  }

  private func setbtnnGkQ3HgdYpOrc(
    titlHeVgRclzqrl3v: String,
    isPrim6Ooi8SHCn75ud: Bool = false,
    actionYy0LnCuhhf3VN: @escaping () -> Void
  ) -> some View {
    Button(action: actionYy0LnCuhhf3VN) {
      Text(titlHeVgRclzqrl3v)
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color.white)
            .overlay(
              RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(
                  isPrim6Ooi8SHCn75ud ? Color("btnpink") : Color.clear,
                  lineWidth: 3
                )
            )
        )
    }
  }

  private func delAnttlypdVYhivb4k5() async {
    defer { sdelI9WcIDcqYmOFT = false }
    do {
      try await TZn9Psbmx6nlq.delGwzevOwddsi6i()
      router.popToRoot()
    } catch {
      print("Delete account failed: \(error)")
    }
  }
}
