//
//  ForgotPasswordViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class ForgotPasswordViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?

  @Published var emailError: String?
  @Published var passwordError: String?
  @Published var confirmPasswordError: String?

  // MARK: - Private Properties
  private let authService: AuthenticationServiceProtocol

  // MARK: - Computed Properties
  var isFormValid: Bool {
    emailError == nil && passwordError == nil && confirmPasswordError == nil && !email.isEmpty
      && !password.isEmpty && !confirmPassword.isEmpty
  }

  // MARK: - Initialization
  init(authService: AuthenticationServiceProtocol = AuthenticationService.shared) {
    self.authService = authService
  }

  // MARK: - Public Methods
  func validateEmail() -> Bool {
    emailError = nil

    if email.isEmpty {
      emailError = "Please enter your email address."
      return false
    }

    if !isValidEmail(email) {
      emailError = "Incorrect email format."
      return false
    }

    return true
  }

  func validatePassword() -> Bool {
    passwordError = nil

    if password.isEmpty {
      passwordError = "Please enter your password."
      return false
    }

    if password.count < 6 {
      passwordError = "The password must be at least 6 characters long."
      return false
    }

    return true
  }

  func validateConfirmPassword() -> Bool {
    confirmPasswordError = nil

    if confirmPassword.isEmpty {
      confirmPasswordError = "Please confirm your password."
      return false
    }

    if password != confirmPassword {
      confirmPasswordError = "The passwords do not match."
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

  func resetPassword() async -> Bool {
    errorMessage = nil

    guard validateForm() else {
      return false
    }

    isLoading = true

    do {
      try await authService.resetPassword(email: email, newPassword: password)
      isLoading = false
      return true
    } catch let error as AuthError {
      errorMessage = error.errorDescription
      isLoading = false
      return false
    } catch {
      errorMessage = "Failed to reset password, please try again later."
      isLoading = false
      return false
    }
  }

  func clearErrors() {
    errorMessage = nil
    emailError = nil
    passwordError = nil
    confirmPasswordError = nil
  }

  // MARK: - Private Methods
  private func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }
}
