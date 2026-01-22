//
//  AuthenticationView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI  // 导入库
#endif

/// 认证页面模式
enum AuthMode {
  case signIn
  case signUp
  case forgotPassword
}

/// 认证容器视图 - 包含登录、注册和忘记密码页面
struct AuthenticationView: View {
  @EnvironmentObject var authManager: AuthenticationManager
  @Environment(\.dismiss) var dismiss
  @State private var currentMode: AuthMode

  /// 初始化方法
  /// - Parameter initialMode: 初始显示的模式，默认为登录模式
  init(initialMode: AuthMode = .signIn) {
    _currentMode = State(initialValue: initialMode)
  }

  // 表单字段
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""
  @State private var isPasswordVisible: Bool = false
  @State private var isConfirmPasswordVisible: Bool = false

  // 错误信息
  @State private var emailError: String?
  @State private var passwordError: String?
  @State private var confirmPasswordError: String?
  @State private var errorMessage: String?

  // 加载状态
  @State private var isLoading: Bool = false

  // 认证服务（用于重置密码）
  private let authService: AuthenticationServiceProtocol = AuthenticationService.shared

  @FocusState private var focusedField: AuthField?

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
      // 背景
      Image("gY80sW7YXCRIPed2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      ScrollView(showsIndicators: false) {
        VStack(spacing: 0) {
          Spacer().frame(height: 100)
          // Logo 和 App 名称
          logoSection
            .padding(.top, 30)
            .padding(.bottom, 50)

          // 标题区域
          titleSection
            .padding(.horizontal, 20)
            .padding(.bottom, 40)

          // 表单区域
          formSection
            .padding(.horizontal, 20)

          // 错误提示
          if let error = errorMessage {
            errorBanner(message: error)
              .padding(.horizontal, 24)
              .padding(.top, 16)
          }

          // 忘记密码链接（仅登录模式）
          if currentMode == .signIn {
            forgotPasswordLink
              .padding(.top, 12)
              .padding(.horizontal, 20)
          }

          // 主按钮
          actionButton
            .padding(.horizontal, 60)
            .padding(.top, currentMode == .signIn ? 60 : 80)

          Spacer(minLength: 50)
        }
      }
      .onTapGesture {
        focusedField = nil
      }

      // 返回按钮
      VStack {
        backButton
          .padding(.top, 46)
          .padding(.leading, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
      }

    }
    .animation(.easeInOut(duration: 0.3), value: currentMode)
    .enableInjection()
  }

  // MARK: - Back Button
  private var backButton: some View {
    Button(action: {
      if currentMode == .forgotPassword {
        // 从忘记密码返回登录
        withAnimation {
          currentMode = .signIn
          clearForm()
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
          .foregroundColor(Color(red: 0.5, green: 0.3, blue: 0.7))
          .font(.system(size: 20, weight: .medium))
      }
    }
  }

  // MARK: - Logo Section
  private var logoSection: some View {
    VStack(spacing: 12) {
      // Logo 图片
      Image("icove_logo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 75, height: 75)
        .clipShape(RoundedRectangle(cornerRadius: 20))

      // App 名称
      Text("iCove")
        .font(.custom("FredokaOne-Regular", size: 24))
        .foregroundColor(.white)
    }
  }

  // MARK: - Title Section
  private var titleSection: some View {
    HStack {
      Group {
        if currentMode == .forgotPassword {
          // 忘记密码标题
          StarText(
            text: "Forgot password",
            textSize: 22,
          )
          // HStack(spacing: 6) {
          //   Text("Forgot password")
          //     .font(.custom("FredokaOne-Regular", size: 22))
          //     .foregroundColor(.white)

          //   sparkleIcon(isWhite: true)
          // }
          .frame(maxWidth: .infinity, alignment: .leading)
        } else {
          // 登录/注册切换标签
          modeSwitcher
        }
      }

      Spacer()
    }

  }

  // MARK: - Mode Switcher
  private var modeSwitcher: some View {
    HStack(spacing: 50) {
      // Sign in 标签
      Button(action: {
        withAnimation {
          currentMode = .signIn
          clearErrors()
        }
      }) {
        StarText(
          text: "Sign in",
          textColor: currentMode == .signIn ? .white : .white.opacity(0.5)
        )
      }

      // Sign up 标签
      Button(action: {
        withAnimation {
          currentMode = .signUp
          clearErrors()
        }
      }) {
        StarText(
          text: "Sign up",
          textColor: currentMode == .signUp ? .white : .white.opacity(0.5)
        )
      }
    }
  }

  // MARK: - Sparkle Icon
  private func sparkleIcon(isWhite: Bool) -> some View {
    HStack(spacing: 2) {
      Image(systemName: "sparkle")
        .font(.system(size: 10))
      Image(systemName: "sparkle")
        .font(.system(size: 6))
    }
    .foregroundColor(isWhite ? .white : .white.opacity(0.5))
  }

  // MARK: - Form Section
  private var formSection: some View {
    VStack(spacing: 24) {
      // 邮箱输入
      AuthInputField(
        icon: "3BeYvZQWUF3j9VQh",
        placeholder: "Email",
        text: $email,
        error: emailError,
        keyboardType: .emailAddress
      )
      .focused($focusedField, equals: .email)
      .onChange(of: email) { _, _ in
        if emailError != nil {
          validateEmail()
        }
      }
      .onSubmit {
        focusedField = .password
      }

      // 密码输入
      AuthPasswordField(
        icon: "jASWmFLKpFnsoplY",
        placeholder: "Password",
        text: $password,
        isPasswordVisible: $isPasswordVisible,
        error: passwordError
      )
      .focused($focusedField, equals: .password)
      .onChange(of: password) { _, _ in
        if passwordError != nil {
          validatePassword()
        }
      }
      .onSubmit {
        if currentMode == .signIn {
          Task {
            await handleSubmit()
          }
        } else {
          focusedField = .confirmPassword
        }
      }

      // 确认密码输入（注册和忘记密码模式）
      if currentMode == .signUp || currentMode == .forgotPassword {
        AuthPasswordField(
          icon: "jASWmFLKpFnsoplY",
          placeholder: "Enter the password again",
          text: $confirmPassword,
          isPasswordVisible: $isConfirmPasswordVisible,
          error: confirmPasswordError
        )
        .focused($focusedField, equals: .confirmPassword)
        .onChange(of: confirmPassword) { _, _ in
          if confirmPasswordError != nil {
            validateConfirmPassword()
          }
        }
        .onSubmit {
          Task {
            await handleSubmit()
          }
        }
        .transition(.opacity.combined(with: .move(edge: .top)))
      }
    }
  }

  // MARK: - Forgot Password Link
  private var forgotPasswordLink: some View {
    HStack {
      Spacer()
      Button(action: {
        withAnimation {
          currentMode = .forgotPassword
          clearForm()
        }
      }) {
        Text("Forgot ?")
          .font(.system(size: 16, weight: .medium))
          .foregroundColor(.white)
      }
    }
  }

  // MARK: - Action Button
  private var actionButton: some View {
    PrimaryButton(
      title: buttonTitle,
      action: {
        Task {
          await handleSubmit()
        }
      },
      isLoading: isLoading,
      isEnabled: isFormValid,
      width: 200
    )
  }

  private var buttonTitle: String {
    switch currentMode {
    case .signIn:
      return "SIGN IN"
    case .signUp:
      return "SIGN UP"
    case .forgotPassword:
      return "SAVE"
    }
  }

  // MARK: - Error Banner
  private func errorBanner(message: String) -> some View {
    HStack {
      Image(systemName: "exclamationmark.triangle.fill")
        .foregroundColor(.red)
      Text(message)
        .font(.subheadline)
        .foregroundColor(.red)
      Spacer()
    }
    .padding()
    .background(Color.red.opacity(0.1))
    .cornerRadius(8)
  }

  // MARK: - Validation
  private var isFormValid: Bool {
    switch currentMode {
    case .signIn:
      return !email.isEmpty && !password.isEmpty
    case .signUp, .forgotPassword:
      return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }
  }

  @discardableResult
  private func validateEmail() -> Bool {
    if email.isEmpty {
      emailError = "请输入邮箱"
      return false
    }
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    if !emailPredicate.evaluate(with: email) {
      emailError = "请输入有效的邮箱地址"
      return false
    }
    emailError = nil
    return true
  }

  @discardableResult
  private func validatePassword() -> Bool {
    if password.isEmpty {
      passwordError = "请输入密码"
      return false
    }
    if password.count < 6 {
      passwordError = "密码至少6位"
      return false
    }
    passwordError = nil
    return true
  }

  @discardableResult
  private func validateConfirmPassword() -> Bool {
    if confirmPassword.isEmpty {
      confirmPasswordError = "请再次输入密码"
      return false
    }
    if confirmPassword != password {
      confirmPasswordError = "两次密码不一致"
      return false
    }
    confirmPasswordError = nil
    return true
  }

  private func validateForm() -> Bool {
    let isEmailValid = validateEmail()
    let isPasswordValid = validatePassword()

    if currentMode == .signUp || currentMode == .forgotPassword {
      let isConfirmValid = validateConfirmPassword()
      return isEmailValid && isPasswordValid && isConfirmValid
    }

    return isEmailValid && isPasswordValid
  }

  // MARK: - Actions
  private func handleSubmit() async {
    focusedField = nil
    errorMessage = nil

    guard validateForm() else { return }

    isLoading = true

    do {
      switch currentMode {
      case .signIn:
        try await authManager.login(email: email, password: password)
      case .signUp:
        // 注册时使用邮箱前缀作为默认用户名
        let defaultUsername = email.components(separatedBy: "@").first ?? "User"
        try await authManager.register(email: email, password: password, username: defaultUsername)
      case .forgotPassword:
        try await authService.resetPassword(email: email, newPassword: password)
        // 重置成功后返回登录页面
        withAnimation {
          currentMode = .signIn
          clearForm()
        }
      }
    } catch {
      errorMessage = error.localizedDescription
    }

    isLoading = false
  }

  private func clearForm() {
    email = ""
    password = ""
    confirmPassword = ""
    isPasswordVisible = false
    isConfirmPasswordVisible = false
    clearErrors()
  }

  private func clearErrors() {
    emailError = nil
    passwordError = nil
    confirmPasswordError = nil
    errorMessage = nil
  }
}

// MARK: - Auth Input Field Component
struct AuthInputField: View {
  let icon: String
  let placeholder: String
  @Binding var text: String
  var error: String?
  var keyboardType: UIKeyboardType = .default

  var body: some View {
    HStack(spacing: 16) {
      // 图标
      ZStack {
        // RoundedRectangle(cornerRadius: 8)
        //   .fill(Color.white)
        //   .frame(width: 36, height: 36)

        Image(icon)
          .resizable()
          .scaledToFit()
          .frame(width: 22, height: 22)
      }
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 16) {
          // 输入框
          TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)))
            .foregroundColor(.white)
            .font(.system(size: 16))
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .autocorrectionDisabled()
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

        if let error = error {
          Text(error)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.leading, 60)
        }
      }
    }

  }
}

// MARK: - Auth Password Field Component
struct AuthPasswordField: View {
  let icon: String
  let placeholder: String
  @Binding var text: String
  @Binding var isPasswordVisible: Bool
  var error: String?

  var body: some View {
    HStack(spacing: 16) {
      // 图标
      ZStack {
        // RoundedRectangle(cornerRadius: 8)
        //   .fill(Color.white)
        //   .frame(width: 36, height: 36)

        Image(icon)
          .resizable()
          .scaledToFit()
          .frame(width: 22, height: 22)
      }
      VStack(alignment: .leading, spacing: 8) {
        HStack(spacing: 16) {

          // 密码输入框
          Group {
            if isPasswordVisible {
              TextField(
                "", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)))
            } else {
              SecureField(
                "", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)))
            }
          }
          .foregroundColor(.white)
          .font(.system(size: 16))
          .autocapitalization(.none)
          .autocorrectionDisabled()

          // 显示/隐藏密码按钮
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

        if let error = error {
          Text(error)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.leading, 60)
        }
      }
    }

  }
}

// #Preview {
//     AuthenticationView()
// }
