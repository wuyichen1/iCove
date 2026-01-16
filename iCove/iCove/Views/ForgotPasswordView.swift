//
//  ForgotPasswordView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI
#if DEBUG
import HotSwiftUI  // 导入库
#endif

struct ForgotPasswordView: View {
    @StateObject private var viewModel: ForgotPasswordViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: ForgotPasswordField?
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    enum ForgotPasswordField {
        case email
        case password
        case confirmPassword
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ForgotPasswordViewModel())
    }
    
    var body: some View {
        ZStack {
            // 背景渐变
            backgroundGradient
            
            ScrollView {
                VStack(spacing: 24) {
                    // Logo 和标题
                    headerSection
                        .padding(.top, 40)
                    
                    // 表单区域
                    formSection
                        .padding(.horizontal, 24)
                    
                    // 错误提示
                    if let error = viewModel.errorMessage {
                        errorBanner(message: error)
                            .padding(.horizontal, 24)
                    }
                    
                    // 保存按钮
                    saveButton
                        .padding(.horizontal, 24)
                }
                .padding(.bottom, 40)
            }
        }
        .onTapGesture {
            focusedField = nil
        }
        .enableInjection()
    }
    
    // MARK: - Background Gradient
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.2, green: 0.1, blue: 0.3),
                Color(red: 0.3, green: 0.15, blue: 0.4),
                Color(red: 0.25, green: 0.1, blue: 0.35)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Logo
            logoView
            
            // App 名称
            Text("iCove")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            
            // 标题
            HStack(spacing: 8) {
                Text("Forgot password")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
    
    // MARK: - Logo View
    private var logoView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.6, green: 0.3, blue: 0.8),
                            Color(red: 0.5, green: 0.2, blue: 0.7)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 70, height: 70)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                }
            
            VStack(spacing: 0) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.pink.opacity(0.8), Color.pink.opacity(0.6)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 45, height: 45)
                    .offset(x: -4)
                
                Ellipse()
                    .fill(Color.cyan.opacity(0.6))
                    .frame(width: 10, height: 7)
                    .offset(x: -13, y: -4)
            }
        }
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
            
            // 新密码输入
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
        field: ForgotPasswordField,
        error: String?
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 20)
                
                TextField(placeholder, text: text)
                    .foregroundColor(.white)
                    .keyboardType(field == .email ? .emailAddress : .default)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: field)
                    .onChange(of: text.wrappedValue) { _, _ in
                        if error != nil {
                            if field == .email {
                                _ = viewModel.validateEmail()
                            }
                        }
                    }
                    .onSubmit {
                        switch field {
                        case .email:
                            focusedField = .password
                        case .password:
                            focusedField = .confirmPassword
                        case .confirmPassword:
                            Task {
                                await handleResetPassword()
                            }
                        }
                    }
                
                if field == .email {
                    Spacer()
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
        field: ForgotPasswordField,
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
                                await handleResetPassword()
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
    
    // MARK: - Save Button
    private var saveButton: some View {
        PrimaryButton(
            title: "SAVE",
            action: {
                Task {
                    await handleResetPassword()
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
    private func handleResetPassword() async {
        focusedField = nil
        let success = await viewModel.resetPassword()
        if success {
            dismiss()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
