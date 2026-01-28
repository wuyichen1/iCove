//
//  AuthCW5IFQbXt8XViView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

enum AuthModeg4BqkLhWQKgsh {
  case S6jCVHP1l4JrX
  case MtR06GhhdHl5i
  case dw9OrzTJRvChU
}

struct AuthCW5IFQbXt8XViView: View {
  @EnvironmentObject var auma3KvMQWRVzrTCZGp: AuthManagA645b8Y0Aod3aVmod
  @Environment(\.dismiss) var dismiss
  @State private var mode3SKlR1H07hi4ZBl: AuthModeg4BqkLhWQKgsh

  init(initialMode: AuthModeg4BqkLhWQKgsh = .S6jCVHP1l4JrX) {
    _mode3SKlR1H07hi4ZBl = State(initialValue: initialMode)
  }

  @State private var email5JGG0viqiPJadRO: String = ""
  @State private var pwdx92WFu5sk3xxEyV: String = ""
  @State private var confirmiOZaPPK51vdlEGm: String = ""
  @State private var isvis0uVIZh3fJeFrDJD: Bool = false
  @State private var isvisconisvisconCVTfoN1J9YOqKoc: Bool = false

  @State private var emailErrNRj6AtIUU0KX5oj: String?
  @State private var pwderrrpoDbCQVh8fy6As: String?
  @State private var confirmPasswordError: String?
  @State private var errmsgi9duPT2fqcbcvfo: String?

  @State private var S4UbytlZEPCRhxZing: Bool = false

  private let aserv1UesNFlnX1FWfJc: Authsdmd0VXzbAnDYServProc = Authsdmd0VXzbAnDYServ.shared

  @FocusState private var focusF8V7w9DiIGa3tTN: AuthField?

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  enum AuthField {
    case email
    case password
    case confirmPassword
  }

  var body: some View {
    ZStack {
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          Spacer().frame(height: 100)

          logo13ZXjEEX0x1hlEF
            .padding(.top, 30)
            .padding(.bottom, 50)

          tithFfG9Ak5SztiQAC
            .padding(.horizontal, 20)
            .padding(.bottom, 40)

          formkz4vDSML4ytGk
            .padding(.horizontal, 20)

          if let error = errmsgi9duPT2fqcbcvfo {
            errOxLHD7e0ndNTp(HHbyW98KExDSA: error)
              .padding(.horizontal, 24)
              .padding(.top, 16)
          }

          if mode3SKlR1H07hi4ZBl == .S6jCVHP1l4JrX {
            fotgotRN5jQEDPhRdQ1
              .padding(.top, 12)
              .padding(.horizontal, 20)
          }

          btncBchUpNCl4X43
            .padding(.horizontal, 60)
            .padding(.top, mode3SKlR1H07hi4ZBl == .S6jCVHP1l4JrX ? 60 : 80)

          Spacer(minLength: 50)
        }
      }
      .onTapGesture {
        focusF8V7w9DiIGa3tTN = nil
      }

      VStack {
        bkL5cecExmlgPWHux
          .padding(.top, 46)
          .padding(.leading, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
      }

    }
    .animation(.easeInOut(duration: 0.3), value: mode3SKlR1H07hi4ZBl)
    #if DEBUG
      .enableInjection()
    #endif
  }

  private var bkL5cecExmlgPWHux: some View {
    Button(action: {
      if mode3SKlR1H07hi4ZBl == .dw9OrzTJRvChU {
        withAnimation {
          mode3SKlR1H07hi4ZBl = .S6jCVHP1l4JrX
          clearhkfAVTsIibARi()
        }
      } else {
        dismiss()
      }
    }) {
      ZStack {
        Circle()
          .fill(Color.white)
          .frame(width: 40, height: 40)

        Image(systemName: "arrow.uturn.left")
          .foregroundColor(Color("buttonPurple"))
      }
    }
  }

  private var logo13ZXjEEX0x1hlEF: some View {
    VStack(spacing: 12) {
      Image("icove_logo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 75, height: 75)
        .clipShape(RoundedRectangle(cornerRadius: 20))

      Text("iCove")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)
    }
  }

  private var tithFfG9Ak5SztiQAC: some View {
    HStack {
      Group {
        if mode3SKlR1H07hi4ZBl == .dw9OrzTJRvChU {
          StarTextThyUv3yWgSTcz(
            text: "Forgot password",
            textSize: 22,
          )
          .frame(maxWidth: .infinity, alignment: .leading)
        } else {
          modeSwitcherJ5cgedl9eW
        }
      }

      Spacer()
    }

  }

  private var modeSwitcherJ5cgedl9eW: some View {
    HStack(spacing: 50) {
      Button(action: {
        withAnimation {
          mode3SKlR1H07hi4ZBl = .S6jCVHP1l4JrX
          cerrcZ5BelI16SwWL()
        }
      }) {
        StarTextThyUv3yWgSTcz(
          text: "Sign in",
          textColor: mode3SKlR1H07hi4ZBl == .S6jCVHP1l4JrX ? .white : .white.opacity(0.5)
        )
      }

      Button(action: {
        withAnimation {
          mode3SKlR1H07hi4ZBl = .MtR06GhhdHl5i
          cerrcZ5BelI16SwWL()
        }
      }) {
        StarTextThyUv3yWgSTcz(
          text: "Sign up",
          textColor: mode3SKlR1H07hi4ZBl == .MtR06GhhdHl5i ? .white : .white.opacity(0.5)
        )
      }
    }
  }

  private var formkz4vDSML4ytGk: some View {
    VStack(spacing: 24) {
      Iptem1Avn34LiVdrFR(
        EHXKujwG9gCDlicon: "3BeYvZQWUF3j9VQh",
        hintBZaEEP3rGcZQT: "Email",
        txtqpbnWOie20qZy: $email5JGG0viqiPJadRO,
        errHVK1WDDniuBnd: emailErrNRj6AtIUU0KX5oj,
        keytypeERbkLzGUNUl8p: .emailAddress
      )
      .focused($focusF8V7w9DiIGa3tTN, equals: .email)
      .onChange(of: email5JGG0viqiPJadRO) { _, _ in
        if emailErrNRj6AtIUU0KX5oj != nil {
          valiemailFIGi8YWzd()
        }
      }
      .onSubmit {
        focusF8V7w9DiIGa3tTN = .password
      }

      AuthPasswordField(
        j9MDDPu2hh7QZicon: "jASWmFLKpFnsoplY",
        hintBAmFW1kxABjuu: "Password",
        LT8oTB7FHhFu5txt: $pwdx92WFu5sk3xxEyV,
        isPasswordVisible: $isvis0uVIZh3fJeFrDJD,
        errQ1v12f7CgcJFY: pwderrrpoDbCQVh8fy6As
      )
      .focused($focusF8V7w9DiIGa3tTN, equals: .password)
      .onChange(of: pwdx92WFu5sk3xxEyV) { _, _ in
        if pwderrrpoDbCQVh8fy6As != nil {
          vapwdS2kxyN6VQML87()
        }
      }
      .onSubmit {
        if mode3SKlR1H07hi4ZBl == .S6jCVHP1l4JrX {
          Task {
            await submBSw3CzMS9Tsk0()
          }
        } else {
          focusF8V7w9DiIGa3tTN = .confirmPassword
        }
      }

      if mode3SKlR1H07hi4ZBl == .MtR06GhhdHl5i || mode3SKlR1H07hi4ZBl == .dw9OrzTJRvChU {
        AuthPasswordField(
          j9MDDPu2hh7QZicon: "jASWmFLKpFnsoplY",
          hintBAmFW1kxABjuu: "Enter the password again",
          LT8oTB7FHhFu5txt: $confirmiOZaPPK51vdlEGm,
          isPasswordVisible: $isvisconisvisconCVTfoN1J9YOqKoc,
          errQ1v12f7CgcJFY: confirmPasswordError
        )
        .focused($focusF8V7w9DiIGa3tTN, equals: .confirmPassword)
        .onChange(of: confirmiOZaPPK51vdlEGm) { _, _ in
          if confirmPasswordError != nil {
            vaconfccrhC43nDwUEq()
          }
        }
        .onSubmit {
          Task {
            await submBSw3CzMS9Tsk0()
          }
        }
        .transition(.opacity.combined(with: .move(edge: .top)))
      }
    }
  }

  private var fotgotRN5jQEDPhRdQ1: some View {
    HStack {
      Spacer()
      Button(action: {
        withAnimation {
          mode3SKlR1H07hi4ZBl = .dw9OrzTJRvChU
          clearhkfAVTsIibARi()
        }
      }) {
        Text("Forgot ?")
          .font(.system(size: 16, weight: .medium))
          .foregroundColor(.white)
      }
    }
  }

  private var btncBchUpNCl4X43: some View {
    BtnjDlKDD6h7eI3t(
      title: btext9b6vEmwn9TNJy,
      action: {
        Task {
          await submBSw3CzMS9Tsk0()
        }
      },
      isLoading: S4UbytlZEPCRhxZing,
      isEnabled: validzDJF20YfnBW8u,
      width: 200
    )
  }

  private var btext9b6vEmwn9TNJy: String {
    switch mode3SKlR1H07hi4ZBl {
    case .S6jCVHP1l4JrX:
      return "SIGN IN"
    case .MtR06GhhdHl5i:
      return "SIGN UP"
    case .dw9OrzTJRvChU:
      return "SAVE"
    }
  }

  private func errOxLHD7e0ndNTp(HHbyW98KExDSA: String) -> some View {
    HStack {
      Image(systemName: "exclamationmark.triangle.fill")
        .foregroundColor(.red)
      Text(HHbyW98KExDSA)
        .font(.subheadline)
        .foregroundColor(.red)
      Spacer()
    }
    .padding()
    .background(Color.red.opacity(0.1))
    .cornerRadius(8)
  }

  private var validzDJF20YfnBW8u: Bool {
    switch mode3SKlR1H07hi4ZBl {
    case .S6jCVHP1l4JrX:
      return !email5JGG0viqiPJadRO.isEmpty && !pwdx92WFu5sk3xxEyV.isEmpty
    case .MtR06GhhdHl5i, .dw9OrzTJRvChU:
      return !email5JGG0viqiPJadRO.isEmpty && !pwdx92WFu5sk3xxEyV.isEmpty
        && !confirmiOZaPPK51vdlEGm.isEmpty
    }
  }

  @discardableResult
  private func valiemailFIGi8YWzd() -> Bool {
    if email5JGG0viqiPJadRO.isEmpty {
      emailErrNRj6AtIUU0KX5oj = "Please enter your email address."
      return false
    }
    let sKl9VpUNqVbxF = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let CRWa0YOKzue5n = NSPredicate(format: "SELF MATCHES %@", sKl9VpUNqVbxF)
    if !CRWa0YOKzue5n.evaluate(with: email5JGG0viqiPJadRO) {
      emailErrNRj6AtIUU0KX5oj = "Incorrect email format."
      return false
    }
    emailErrNRj6AtIUU0KX5oj = nil
    return true
  }

  @discardableResult
  private func vapwdS2kxyN6VQML87() -> Bool {
    if pwdx92WFu5sk3xxEyV.isEmpty {
      pwderrrpoDbCQVh8fy6As = "Please enter your password."
      return false
    }
    if pwdx92WFu5sk3xxEyV.count < 6 {
      pwderrrpoDbCQVh8fy6As = "The password must be at least 6 characters long."
      return false
    }
    pwderrrpoDbCQVh8fy6As = nil
    return true
  }

  @discardableResult
  private func vaconfccrhC43nDwUEq() -> Bool {
    if confirmiOZaPPK51vdlEGm.isEmpty {
      confirmPasswordError = "Please enter the password again."
      return false
    }
    if confirmiOZaPPK51vdlEGm != pwdx92WFu5sk3xxEyV {
      confirmPasswordError = "The passwords do not match."
      return false
    }
    confirmPasswordError = nil
    return true
  }

  private func valiform0N4muHKaouwMS() -> Bool {
    let ULrnmxYeO2ogk = valiemailFIGi8YWzd()
    let SDNKMdpjfqvPe = vapwdS2kxyN6VQML87()

    if mode3SKlR1H07hi4ZBl == .MtR06GhhdHl5i || mode3SKlR1H07hi4ZBl == .dw9OrzTJRvChU {
      let isConfirmValid = vaconfccrhC43nDwUEq()
      return ULrnmxYeO2ogk && SDNKMdpjfqvPe && isConfirmValid
    }

    return ULrnmxYeO2ogk && SDNKMdpjfqvPe
  }

  private func submBSw3CzMS9Tsk0() async {
    focusF8V7w9DiIGa3tTN = nil
    errmsgi9duPT2fqcbcvfo = nil

    guard valiform0N4muHKaouwMS() else { return }

    S4UbytlZEPCRhxZing = true

    do {
      switch mode3SKlR1H07hi4ZBl {
      case .S6jCVHP1l4JrX:
        try await auma3KvMQWRVzrTCZGp.logini2AfORx9Y0cOC(
          Yc7aEPUWtsLiC: email5JGG0viqiPJadRO, dbCMz0ksUEfDw: pwdx92WFu5sk3xxEyV)
      case .MtR06GhhdHl5i:
        let oHLiBEbYkYiUm = email5JGG0viqiPJadRO.components(separatedBy: "@").first ?? "User"
        try await auma3KvMQWRVzrTCZGp.registerPAms88DfTLWMl(
          Qjhs1UuEXxKto: email5JGG0viqiPJadRO, AYVm1fJqgpm5W: pwdx92WFu5sk3xxEyV,
          dTzVtlmF1dSnU: oHLiBEbYkYiUm)
      case .dw9OrzTJRvChU:
        try await aserv1UesNFlnX1FWfJc.resetAD5RG71gufWEh(
          e1NwZPJd8HYCD8: email5JGG0viqiPJadRO, LwBDL4g9GeWqW: pwdx92WFu5sk3xxEyV)
        withAnimation {
          mode3SKlR1H07hi4ZBl = .S6jCVHP1l4JrX
          clearhkfAVTsIibARi()
        }
      }
    } catch {
      errmsgi9duPT2fqcbcvfo = error.localizedDescription
    }

    S4UbytlZEPCRhxZing = false
  }

  private func clearhkfAVTsIibARi() {
    email5JGG0viqiPJadRO = ""
    pwdx92WFu5sk3xxEyV = ""
    confirmiOZaPPK51vdlEGm = ""
    isvis0uVIZh3fJeFrDJD = false
    isvisconisvisconCVTfoN1J9YOqKoc = false
    cerrcZ5BelI16SwWL()
  }

  private func cerrcZ5BelI16SwWL() {
    emailErrNRj6AtIUU0KX5oj = nil
    pwderrrpoDbCQVh8fy6As = nil
    confirmPasswordError = nil
    errmsgi9duPT2fqcbcvfo = nil
  }
}

struct Iptem1Avn34LiVdrFR: View {
  let EHXKujwG9gCDlicon: String
  let hintBZaEEP3rGcZQT: String
  @Binding var txtqpbnWOie20qZy: String
  var errHVK1WDDniuBnd: String?
  var keytypeERbkLzGUNUl8p: UIKeyboardType = .default

  var body: some View {
    HStack(spacing: 16) {
      ZStack {
        Image(EHXKujwG9gCDlicon)
          .resizable()
          .scaledToFit()
          .frame(width: 22, height: 22)
      }
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 16) {
          TextField(
            "", text: $txtqpbnWOie20qZy,
            prompt: Text(hintBZaEEP3rGcZQT).foregroundColor(.white.opacity(0.5))
          )
          .foregroundColor(.white)
          .font(.system(size: 16))
          .keyboardType(keytypeERbkLzGUNUl8p)
          .autocapitalization(.none)
          .autocorrectionDisabled()
          .submitLabel(.next)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
        .background(
          RoundedRectangle(cornerRadius: 33)
            .fill(Color.white.opacity(0.2))
        )
        .overlay {
          RoundedRectangle(cornerRadius: 33)
            .stroke(Color.white.opacity(0.3), lineWidth: 1)
        }

        if let error = errHVK1WDDniuBnd {
          Text(error)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.leading, 60)
        }
      }
    }

  }
}

struct AuthPasswordField: View {
  let j9MDDPu2hh7QZicon: String
  let hintBAmFW1kxABjuu: String
  @Binding var LT8oTB7FHhFu5txt: String
  @Binding var isPasswordVisible: Bool
  var errQ1v12f7CgcJFY: String?

  var body: some View {
    HStack(spacing: 16) {
      ZStack {
        Image(j9MDDPu2hh7QZicon)
          .resizable()
          .scaledToFit()
          .frame(width: 22, height: 22)
      }
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 16) {

          Group {
            if isPasswordVisible {
              TextField(
                "", text: $LT8oTB7FHhFu5txt,
                prompt: Text(hintBAmFW1kxABjuu).foregroundColor(.white.opacity(0.5))
              )
              .submitLabel(.next)
            } else {
              SecureField(
                "", text: $LT8oTB7FHhFu5txt,
                prompt: Text(hintBAmFW1kxABjuu).foregroundColor(.white.opacity(0.5))
              )
              .submitLabel(.next)
            }
          }
          .foregroundColor(.white)
          .font(.system(size: 16))
          .autocapitalization(.none)
          .autocorrectionDisabled()

          Button(action: {
            isPasswordVisible.toggle()
          }) {
            Image(isPasswordVisible ? "Z5xHMhhLkMtwROI6" : "biZ5xHMhhLkMtwROI6")
              .resizable()
              .scaledToFit()
              .frame(width: 22, height: 22)
              .padding(.top, 2)
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(
          RoundedRectangle(cornerRadius: 33)
            .fill(Color.white.opacity(0.2))
        )
        .overlay {
          RoundedRectangle(cornerRadius: 33)
            .stroke(Color.white.opacity(0.3), lineWidth: 1)
        }

        if let error = errQ1v12f7CgcJFY {
          Text(error)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.leading, 60)
        }
      }
    }

  }
}
