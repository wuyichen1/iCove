//
//  LoginViewModel.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?

  @Published var emailError: String?
  @Published var passwordError: String?

  // MARK: - Private Properties
  private let authManager: AuthenticationManager

  // MARK: - Computed Properties
  var isFormValid: Bool {
    emailError == nil && passwordError == nil && !email.isEmpty && !password.isEmpty
  }

  // MARK: - Initialization
  init(authManager: AuthenticationManager) {
    self.authManager = authManager
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

  func validateForm() -> Bool {
    let emailValid = validateEmail()
    let passwordValid = validatePassword()
    return emailValid && passwordValid
  }

  func login() async -> Bool {
    errorMessage = nil

    guard validateForm() else {
      return false
    }

    isLoading = true

    do {
      try await authManager.login(email: email, password: password)
      isLoading = false
      return true
    } catch let error as AuthError {
      errorMessage = error.errorDescription
      isLoading = false
      return false
    } catch {
      errorMessage = "Failed to login, please try again later."
      isLoading = false
      return false
    }
  }

  func clearErrors() {
    errorMessage = nil
    emailError = nil
    passwordError = nil
  }

  // MARK: - Private Methods
  private func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }
}
