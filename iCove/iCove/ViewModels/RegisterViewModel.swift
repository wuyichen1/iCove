//
//  RegisterViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

/// 注册 ViewModel - 处理注册逻辑和表单校验
@MainActor
class RegisterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var username: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // 表单校验错误
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    @Published var usernameError: String?
    
    // MARK: - Private Properties
    private let authManager: AuthenticationManager
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        emailError == nil && passwordError == nil &&
        confirmPasswordError == nil &&
        !email.isEmpty && !password.isEmpty &&
        !confirmPassword.isEmpty
    }
    
    // MARK: - Initialization
    init(authManager: AuthenticationManager) {
        self.authManager = authManager
    }
    
    // MARK: - Public Methods
    func validateEmail() -> Bool {
        emailError = nil
        
        if email.isEmpty {
            emailError = "请输入邮箱"
            return false
        }
        
        if !isValidEmail(email) {
            emailError = "邮箱格式不正确"
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        passwordError = nil
        
        if password.isEmpty {
            passwordError = "请输入密码"
            return false
        }
        
        if password.count < 6 {
            passwordError = "密码长度至少为 6 位"
            return false
        }
        
        if password.count > 20 {
            passwordError = "密码长度不能超过 20 位"
            return false
        }
        
        return true
    }
    
    func validateConfirmPassword() -> Bool {
        confirmPasswordError = nil
        
        if confirmPassword.isEmpty {
            confirmPasswordError = "请确认密码"
            return false
        }
        
        if password != confirmPassword {
            confirmPasswordError = "两次输入的密码不一致"
            return false
        }
        
        return true
    }
    
    func validateUsername() -> Bool {
        usernameError = nil
        
        if username.isEmpty {
            usernameError = "请输入用户名"
            return false
        }
        
        if username.count < 2 {
            usernameError = "用户名长度至少为 2 个字符"
            return false
        }
        
        if username.count > 20 {
            usernameError = "用户名长度不能超过 20 个字符"
            return false
        }
        
        // 检查用户名是否包含非法字符
        let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_"))
        if username.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            usernameError = "用户名只能包含字母、数字和下划线"
            return false
        }
        
        return true
    }
    
    func validateForm() -> Bool {
        let emailValid = validateEmail()
        let passwordValid = validatePassword()
        let confirmPasswordValid = validateConfirmPassword()
        return emailValid && passwordValid && confirmPasswordValid
    }
    
    func register() async -> Bool {
        // 清除之前的错误
        errorMessage = nil
        
        // 表单校验
        guard validateForm() else {
            return false
        }
        
        isLoading = true
        
        // 如果没有输入用户名，使用邮箱前缀作为用户名
        let finalUsername = username.isEmpty ? email.components(separatedBy: "@").first ?? "用户" : username
        
        do {
            try await authManager.register(email: email, password: password, username: finalUsername)
            isLoading = false
            return true
        } catch let error as AuthError {
            errorMessage = error.errorDescription
            isLoading = false
            return false
        } catch {
            errorMessage = "注册失败，请稍后重试"
            isLoading = false
            return false
        }
    }
    
    func clearErrors() {
        errorMessage = nil
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
        usernameError = nil
    }
    
    // MARK: - Private Methods
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
