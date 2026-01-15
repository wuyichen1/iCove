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

/// 认证容器视图 - 包含登录和注册页面切换
struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    @State private var isLoginMode: Bool = true
    @State private var showingForgotPassword = false
    
    #if DEBUG
    @ObserveInjection var redraw
    #endif
    
    var body: some View {
        ZStack {
            // 背景渐变
            backgroundGradient
            
            VStack(spacing: 0) {
                // 返回按钮
                backButton
                    .padding(.top, 8)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Logo 和 App 名称
                logoSection
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                
                // 模式切换标签
                modeSwitcher
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                
                // 内容区域
                if isLoginMode {
                    LoginView(authManager: authManager) {
                        showingForgotPassword = true
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
                } else {
                    RegisterView(authManager: authManager)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isLoginMode)
        .sheet(isPresented: $showingForgotPassword) {
            ForgotPasswordView()
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
    
    // MARK: - Back Button
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 36, height: 36)
                
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
            }
        }
    }
    
    // MARK: - Logo Section
    private var logoSection: some View {
        VStack(spacing: 12) {
            // Logo
            ZStack {
                RoundedRectangle(cornerRadius: 18)
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
                        RoundedRectangle(cornerRadius: 18)
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
            
            // App 名称
            Text("iCove")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    // MARK: - Mode Switcher
    private var modeSwitcher: some View {
        HStack(spacing: 0) {
            // Sign in 标签
            Button(action: {
                isLoginMode = true
            }) {
                HStack(spacing: 8) {
                    Text("Sign in")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(isLoginMode ? .white : .white.opacity(0.6))
                    
                    if isLoginMode {
                        HStack(spacing: 4) {
                            Image(systemName: "sparkle")
                                .font(.system(size: 10))
                            Image(systemName: "sparkle")
                                .font(.system(size: 10))
                        }
                        .foregroundColor(.white.opacity(0.8))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            
            // Sign up 标签
            Button(action: {
                isLoginMode = false
            }) {
                HStack(spacing: 8) {
                    Text("Sign up")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(isLoginMode ? .white.opacity(0.6) : .white)
                    
                    if !isLoginMode {
                        HStack(spacing: 4) {
                            Image(systemName: "sparkle")
                                .font(.system(size: 10))
                            Image(systemName: "sparkle")
                                .font(.system(size: 10))
                        }
                        .foregroundColor(.white.opacity(0.8))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
