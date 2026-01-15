//
//  WelcomeView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

/// 欢迎页/登录选择页
struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showingEmailLogin = false
    @State private var agreedToTerms = false
    
    /*
        @ObserveInjection var redraw：名字随意（redraw / inject / forceUpdate 都行），它会监听 InjectionIII 的注入通知。
        #if DEBUG 包裹它，确保 Release 构建无影响。
        .enableInjection() 保持在 body 最外层。
    */
    #if DEBUG
    @ObserveInjection var redraw  // ← 这行关键！让视图监听注入事件，强制 body 重建
    #endif

    var body: some View {
        ZStack {
            // 背景渐变
            backgroundGradient
            
            // 内容
            VStack(spacing: 0) {
                Spacer()
                
                // Logo 和 App 名称
                logoSection
                    .padding(.bottom, 60)
                
                // 按钮区域
                buttonsSection
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                
                // 底部链接和协议
                bottomSection
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
            }
        }
        .fullScreenCover(isPresented: $showingEmailLogin) {
            AuthenticationView()
                .environmentObject(authManager)
        }
        .enableInjection() // 这行关键：强制 SwiftUI 重建 body，实现热重载
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
    
    // MARK: - Logo Section
    private var logoSection: some View {
        VStack(spacing: 16) {
            // Logo
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
                    .frame(width: 80, height: 80)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    }
                
                // 桃子图标（简化版）
                VStack(spacing: 0) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.pink.opacity(0.8), Color.pink.opacity(0.6)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 50, height: 50)
                        .offset(x: -5)
                    
                    Ellipse()
                        .fill(Color.cyan.opacity(0.6))
                        .frame(width: 12, height: 8)
                        .offset(x: -15, y: -5)
                }
            }
            
            // App 名称
            Text("iCove")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    // MARK: - Buttons Section
    private var buttonsSection: some View {
        VStack(spacing: 16) {
            // Login by email 按钮
            Button(action: {
                showingEmailLogin = true
            }) {
                Text("Login by email")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.6, green: 0.3, blue: 0.8),
                                        Color(red: 0.5, green: 0.2, blue: 0.7)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    }
            }
            
            // I'm new 按钮（快速登录）
            Button(action: {
                Task {
                    await handleQuickLogin()
                }
            }) {
                Text("I'm new")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.clear)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1.5)
                    }
            }
        }
    }
    
    // MARK: - Bottom Section
    private var bottomSection: some View {
        VStack(spacing: 16) {
            // Sign up 链接
            Button(action: {
                showingEmailLogin = true
            }) {
                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .foregroundColor(.white.opacity(0.8))
                    Text("Sign up")
                        .foregroundColor(.white)
                        .underline()
                }
                .font(.system(size: 14))
            }
            
            // 用户协议和隐私政策
            HStack(spacing: 8) {
                Button(action: {
                    agreedToTerms.toggle()
                }) {
                    Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                
                HStack(spacing: 4) {
                    Text("Agree with")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(size: 12))
                    
                    Button(action: {
                        // TODO: 打开用户协议
                    }) {
                        Text("User Agreement")
                            .foregroundColor(.white)
                            .underline()
                            .font(.system(size: 12))
                    }
                    
                    Text("and")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.system(size: 12))
                    
                    Button(action: {
                        // TODO: 打开隐私政策
                    }) {
                        Text("Privacy Policy")
                            .foregroundColor(.white)
                            .underline()
                            .font(.system(size: 12))
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    private func handleQuickLogin() async {
        do {
            try await authManager.quickLogin()
        } catch {
            // 处理错误
            print("Quick login error: \(error)")
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AuthenticationManager())
}
