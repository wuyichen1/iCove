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
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 60)
                        // Logo 和 App 名称
                        logoSection
                            .padding(.bottom, 60)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.leading, 40)

                // 按钮区域
                buttonsSection
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                // 底部链接和协议
                bottomSection
                    .padding(.horizontal, 24)
                    .padding(.bottom, 50)
            }
        }
        .fullScreenCover(isPresented: $showingEmailLogin) {
            AuthenticationView()
                .environmentObject(authManager)
        }
        .enableInjection()  // 这行关键：强制 SwiftUI 重建 body，实现热重载
    }

    // MARK: - Background Image
    private var backgroundGradient: some View {
        ZStack {
            // 背景图片
            Image("jK792W9HOGn9U1z3")
                .resizable()
                .scaledToFill()  // 填充整个屏幕
                .ignoresSafeArea()

            // // 可选：添加半透明遮罩层，确保文字可读性
            // Color.black.opacity(0.3)
            //     .ignoresSafeArea()
        }
    }

    // MARK: - Logo Section
    private var logoSection: some View {
        VStack(spacing: 16) {
            // Logo
            // 使用本地图片（假设你加的 Image Set 叫 "app_logo"）
            Image("icove_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 5)  // 可选加阴影
            // ZStack {
            //     RoundedRectangle(cornerRadius: 20)
            //         .fill(
            //             LinearGradient(
            //                 colors: [
            //                     Color(red: 0.6, green: 0.3, blue: 0.8),
            //                     Color(red: 0.5, green: 0.2, blue: 0.7)
            //                 ],
            //                 startPoint: .topLeading,
            //                 endPoint: .bottomTrailing
            //             )
            //         )
            //         .frame(width: 80, height: 80)
            //         .overlay {
            //             RoundedRectangle(cornerRadius: 20)
            //                 .stroke(Color.white.opacity(0.3), lineWidth: 1)
            //         }

            //     // 桃子图标（简化版）
            //     VStack(spacing: 0) {
            //         Circle()
            //             .fill(
            //                 LinearGradient(
            //                     colors: [Color.pink.opacity(0.8), Color.pink.opacity(0.6)],
            //                     startPoint: .leading,
            //                     endPoint: .trailing
            //                 )
            //             )
            //             .frame(width: 50, height: 50)
            //             .offset(x: -5)

            //         Ellipse()
            //             .fill(Color.cyan.opacity(0.6))
            //             .frame(width: 12, height: 8)
            //             .offset(x: -15, y: -5)
            //     }
            // }

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
            PrimaryButton(
                title: "Login by email",
                action: {
                    showingEmailLogin = true
                },
                width: 260,
            )
            PrimaryButton(
                title: "I'm new",
                action: {
                    Task {
                        await handleQuickLogin()
                    }
                },
                width: 260,
                backgroundColor: Color("btnpink"),
            )
        }
    }

    // MARK: - Bottom Section
    private var bottomSection: some View {
        VStack(spacing: 60) {
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
