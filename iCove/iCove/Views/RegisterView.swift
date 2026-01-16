//
//  RegisterView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI
#if DEBUG
import HotSwiftUI  // 导入库
#endif

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    @FocusState private var focusedField: RegisterField?
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    enum RegisterField {
        case email
        case password
        case confirmPassword
    }
    
    init(authManager: AuthenticationManager) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(authManager: authManager))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 表单区域
                formSection
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                
                // 错误提示
                if let error = viewModel.errorMessage {
                    errorBanner(message: error)
                        .padding(.horizontal, 24)
                }
                
                // 注册按钮
                registerButton
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
        .onTapGesture {
            // 点击空白区域收起键盘
            focusedField = nil
        }
        .enableInjection()
    }
    
    // MARK: - Form Section
    private var formSection: some View {
        VStack(spacing: 20) {
            // 邮箱输入
            inputField(
                icon: "envelope.open",
                placeholder: "Email",
                text: $viewModel.email,
                field: .email,
                error: viewModel.emailError
            )
            
            // 密码输入
            passwordField(
                icon: "lock",
                placeholder: "Password",
                text: $viewModel.password,
                field: .password,
                error: viewModel.passwordError
            )
            
            // 确认密码输入
            passwordField(
                icon: "lock",
                placeholder: "Enter the password again",
                text: $viewModel.confirmPassword,
                field: .confirmPassword,
                error: viewModel.confirmPasswordError
            )
        }
    }
    
    // MARK: - Input Field
    private func inputField(
        icon: String,
        placeholder: String,
        text: Binding<String>,
        field: RegisterField,
        error: String?
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 20)
                
                TextField(placeholder, text: text)
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: field)
                    .onChange(of: text.wrappedValue) { _, _ in
                        if error != nil {
                            _ = viewModel.validateEmail()
                        }
                    }
                    .onSubmit {
                        focusedField = .password
                    }
            }
            .padding()
            .background(Color(red: 0.25, green: 0.15, blue: 0.35).opacity(0.6))
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            }
            
            if let error = error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 32)
            }
        }
    }
    
    // MARK: - Password Field
    private func passwordField(
        icon: String,
        placeholder: String,
        text: Binding<String>,
        field: RegisterField,
        error: String?
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 20)
                
                SecureField(placeholder, text: text)
                    .foregroundColor(.white)
                    .focused($focusedField, equals: field)
                    .onChange(of: text.wrappedValue) { _, _ in
                        if error != nil {
                            if field == .password {
                                _ = viewModel.validatePassword()
                            } else if field == .confirmPassword {
                                _ = viewModel.validateConfirmPassword()
                            }
                        }
                        // 如果密码已输入，重新验证确认密码
                        if field == .password && !viewModel.confirmPassword.isEmpty {
                            _ = viewModel.validateConfirmPassword()
                        }
                    }
                    .onSubmit {
                        if field == .password {
                            focusedField = .confirmPassword
                        } else {
                            Task {
                                await handleRegister()
                            }
                        }
                    }
                
                Image(systemName: "eye")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.system(size: 14))
            }
            .padding()
            .background(Color(red: 0.25, green: 0.15, blue: 0.35).opacity(0.6))
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            }
            
            if let error = error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 32)
            }
        }
    }
    
    // MARK: - Register Button
    private var registerButton: some View {
        PrimaryButton(
            title: "SIGN UP",
            action: {
                Task {
                    await handleRegister()
                }
            },
            isLoading: viewModel.isLoading,
            isEnabled: viewModel.isFormValid
        )
        .padding(.top, 8)
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
    
    // MARK: - Actions
    private func handleRegister() async {
        focusedField = nil
        let success = await viewModel.register()
        if success {
            // 注册成功，状态已由 AuthenticationManager 更新
            // 视图切换由 App 层处理
        }
    }
}

// #Preview {
//     RegisterView(authManager: AuthenticationManager())
// }
