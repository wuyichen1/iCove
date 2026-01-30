//
//  EULA8HDmpRmkpG6hView.swift
//  iCove
//
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct EULA8HDmpRmkpG6hView: View {
  let onCancel: () -> Void
  let onAgree: () -> Void
  let onOpenTermsOfUse: () -> Void
  let onOpenPrivacyPolicy: () -> Void

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  private let titlehkKJavnN9JI1 = "EULA"
  private let wel98ZTYrQGxPSc =
    "Welcome to iCove! To make a better place, the following content is not allowed in the app in particular."
  private let i171kQ83J93f2Z =
    "Any content about child harm, pornography related detrimental to children."
  private let i2qpv0aKazbo1o =
    "Fake and harmful messages about recent or current events."
  private let i3RfQIrV6SLd26 =
    "Any violence, bullying content, publicly promotes pornography and other content."
  private let OAppAii3VnZc =
    "If we find any content including and not limited to the above violations your content will be deleted and account will be banned. By clicking the above button, you agree to the Terms of Use and Privacy Policy."

  var body: some View {
    ZStack {
      Color.black.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {}

      VStack(spacing: 0) {
        Text(titlehkKJavnN9JI1)
          .font(.custom("FredokaOne-Regular", size: 22))
          .foregroundColor(.white)
          .padding(.top, 24)
          .padding(.bottom, 16)

        ScrollView {
          VStack(alignment: .leading, spacing: 12) {
            Text(wel98ZTYrQGxPSc)
              .font(.system(size: 15))
              .foregroundColor(.white)

            Text("1. \(i171kQ83J93f2Z)")
              .font(.system(size: 15))
              .foregroundColor(.white)
            Text("2. \(i2qpv0aKazbo1o)")
              .font(.system(size: 15))
              .foregroundColor(.white)
            Text("3. \(i3RfQIrV6SLd26)")
              .font(.system(size: 15))
              .foregroundColor(.white)

            Text(OAppAii3VnZc)
              .font(.system(size: 15))
              .foregroundColor(.white)
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 12)
        }
        .frame(maxHeight: 370)

        HStack(spacing: 8) {
          Button(action: onOpenTermsOfUse) {
            Text("Terms of Use")
              .font(.system(size: 14))
              .foregroundColor(.black)
              .underline()
          }
          Text(" ")
          Button(action: onOpenPrivacyPolicy) {
            Text("Privacy Policy")
              .font(.system(size: 14))
              .foregroundColor(.black)
              .underline()
          }
        }
        .padding(.bottom, 16)

        HStack(spacing: 16) {
          Button(action: onCancel) {
            Text("Cancel")
              .font(.custom("FredokaOne-Regular", size: 17))
              .foregroundColor(.white)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 13)
              .background(Color("buttonPurple"))
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.white, lineWidth: 2)
              )
          }

          Button(action: onAgree) {
            Text("I agree")
              .font(.custom("FredokaOne-Regular", size: 17))
              .foregroundColor(.black)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 13)
              .background(Color(red: 157 / 255, green: 245 / 255, blue: 13 / 255))
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color.white, lineWidth: 2)
              )
          }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
      }
      .background(
        LinearGradient(
          colors: [
            Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
            Color(red: 216 / 255, green: 172 / 255, blue: 227 / 255),
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
      .cornerRadius(20)
      .padding(.horizontal, 24)
    }
    #if DEBUG
      .enableInjection()
    #endif
  }
}
