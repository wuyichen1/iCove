//
//  DisceQwLbYkS3iDTTView.swift
//  iCove
//
//  Created by yangyang on 2026/1/14.
//

import SwiftUI

#if DEBUG
  import HotSwiftUI
#endif

struct DisceQwLbYkS3iDTTView: View {
  @EnvironmentObject var aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod
  @StateObject private var disVmrWpELPZVmt8tD: DiscouU6Bh8Exak2IXVmod
  @State private var sblo5BJbOqoX3oUyD = false
  @State private var blouidGAKcNhg8hC0qh: String? = nil
  @State private var repbloM1RyF4YUhJXVs = false
  @State private var uid2IoIb4lqiLMOQ: String? = nil
  @State private var pendinguidQuacRuNaqmHyG: String? = nil
  @EnvironmentObject var router: Router

  #if DEBUG
    @ObserveInjection var redraw
  #endif

  init() {
    _disVmrWpELPZVmt8tD = StateObject(wrappedValue: DiscouU6Bh8Exak2IXVmod())
  }

  var body: some View {
    ZStack {

      Image("KYECVROdZxhA1GUw")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()

      VStack(spacing: 0) {

        head80bQQTa3yQG7S

        if disVmrWpELPZVmt8tD.islingumgdWs0fYfz52 && disVmrWpELPZVmt8tD.colp8W7CMTdrTSK9g.isEmpty
          && disVmrWpELPZVmt8tD.allp8jyycPefN5IIz.isEmpty
        {
          loadOycj4QRSkyG0J
        } else {
          contview7LBPOsWKb8MIs
        }
      }
    }
    .blockDiaLcTUIAjgtcOHd(isPresented: $sblo5BJbOqoX3oUyD, uidK1uO6OuOGNky0: blouidGAKcNhg8hC0qh)
    .sheet(
      isPresented: Binding(
        get: { repbloM1RyF4YUhJXVs },
        set: { RrAcO4pUcBGzO in
          repbloM1RyF4YUhJXVs = RrAcO4pUcBGzO
          if !RrAcO4pUcBGzO {
            uid2IoIb4lqiLMOQ = nil
          }
        }
      )
    ) {
      Group {
        if let uidlJWt8AfqsTpw4 = uid2IoIb4lqiLMOQ {
          ReportBlockBottomSheet(
            userId: uidlJWt8AfqsTpw4,
            isPresented: Binding(
              get: { repbloM1RyF4YUhJXVs },
              set: { RrAcO4pUcBGzO in
                repbloM1RyF4YUhJXVs = RrAcO4pUcBGzO
                if !RrAcO4pUcBGzO {
                  uid2IoIb4lqiLMOQ = nil
                }
              }
            ),
            onBlock: {
              blouidGAKcNhg8hC0qh = uidlJWt8AfqsTpw4
              sblo5BJbOqoX3oUyD = true
            }
          )
          .environmentObject(aumaOPNRYtaLzBwfO)
          .environmentObject(router)
          .presentationDetents([.height(240)])
          .presentationBackground(.clear)
          .presentationDragIndicator(.hidden)
        } else {
          Color.clear
            .frame(width: 0, height: 0)
        }
      }
    }
    #if DEBUG
      .enableInjection()
    #endif
    .onAppear {
      disVmrWpELPZVmt8tD.updAuma7Cif2ltv9c65t(aumaOPNRYtaLzBwfO)
    }
    .onChange(of: aumaOPNRYtaLzBwfO.currvj9QRUUPOWY4Ouser?.cP9hI1jK3lM5nO) { oldValue, newValue in
      disVmrWpELPZVmt8tD.refAYUyaJd0ZNl9v()
    }
    .onChange(of: uid2IoIb4lqiLMOQ) { oldValue, hEGLmW1NGMvRj in
      if let uidSvIde6DOjDz8o = hEGLmW1NGMvRj, !repbloM1RyF4YUhJXVs {
        DispatchQueue.main.async {
          if uid2IoIb4lqiLMOQ == uidSvIde6DOjDz8o {
            repbloM1RyF4YUhJXVs = true
          } else {
            uid2IoIb4lqiLMOQ = uidSvIde6DOjDz8o
            DispatchQueue.main.async {
              repbloM1RyF4YUhJXVs = true
            }
          }
        }
      }
    }
  }

  private var head80bQQTa3yQG7S: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Discover")
          .font(.custom("FredokaOne-Regular", size: 32))
          .foregroundColor(.white)

        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.top, 50)
      .padding(.bottom, 16)
    }
  }

  private var loadOycj4QRSkyG0J: some View {
    VStack(spacing: 20) {
      Spacer()
      ProgressView()
        .scaleEffect(1.5)
        .tint(.white)

      Text("Loading...")
        .font(.system(size: 16))
        .foregroundColor(.white.opacity(0.8))
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var contview7LBPOsWKb8MIs: some View {
    VStack(alignment: .leading, spacing: 0) {

      if !disVmrWpELPZVmt8tD.colp8W7CMTdrTSK9g.isEmpty {
        VStack {
          HStack {
            StarTextThyUv3yWgSTcz(
              text: "My collection",
              textColor: Color("yinguanglv"),
              textSize: 18
            )

            Spacer()
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 0)

          collectionCarousel
            .padding(.bottom, 16)
        }

      }

      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.clear)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(
            TopborpathQocmohrb0utCT(conradxrUXU0WJQ4cZU: 40)
              .stroke(Color.green, lineWidth: 2)
          )
          .cornerRadius(12, corners: [.topLeft, .topRight])
          .padding(.top, 26)

        VStack(alignment: .leading) {
          HStack(spacing: 24) {
            ZStack {
              Image("TYRzuMytPGz0mCSA")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 45)
                .clipped()

              HStack {
                StarTextThyUv3yWgSTcz(
                  text: "All",
                  textColor: .black,
                  textSize: 18
                )
              }

            }
            .frame(height: 45)

            Button(action: {
              router.push(.publish(type: .imgHkANxe83jDb0E))
            }) {
              Image("Tz0wJDM3mdSWeD0Y")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 66, height: 43)
                .clipped()
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 6)
          .padding(.leading, 16)

          if disVmrWpELPZVmt8tD.allp8jyycPefN5IIz.isEmpty {
            EmptyJYGRYC2t97Qi3()
              .padding(.bottom, 120)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          } else {
            ScrollView {
              LazyVStack(spacing: 16) {
                ForEach(disVmrWpELPZVmt8tD.allp8jyycPefN5IIz) { post in
                  PocardrDm6S2F8tYSbU(
                    postjmttDhoS3qgib: post,
                    onBlozWbxoGpaIWfTW: {
                      blouidGAKcNhg8hC0qh = post.aC9dE1fG3hI5jK
                      sblo5BJbOqoX3oUyD = true
                    },
                    onrepbloooTsNyqTWt2Qu: { userId in
                      uid2IoIb4lqiLMOQ = userId
                    }
                  )
                  .onTapGesture {
                    router.push(.podeti0Gx1PwxsKGxM(postId: post.id))
                  }
                }
              }
              .padding(.horizontal, 20)
              .padding(.bottom, 130)
              .padding(.top, 10)
              .animation(
                .spring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.4),
                value: disVmrWpELPZVmt8tD.allp8jyycPefN5IIz
              )

            }
          }
        }
      }

    }
  }

  private var collectionCarousel: some View {
    GeometryReader { geometry in
      let screenWidth = geometry.size.width
      let itemWidth = screenWidth * 2 / 3
      let cardSpacing: CGFloat = 18
      let containerHeight: CGFloat = 220
      let cardHeight: CGFloat = 180
      let spacerHeight: CGFloat = 20
      let sidePadding = (screenWidth - itemWidth) / 2

      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: cardSpacing) {
            ForEach(Array(disVmrWpELPZVmt8tD.colp8W7CMTdrTSK9g.enumerated()), id: \.element.id) {
              index, post in
              if let firstImage = post.iT1uV3wX5yZ7aB.first {
                CollectionCardView(
                  imageName: firstImage,
                  post: post,
                  itemWidth: itemWidth,
                  cardHeight: cardHeight,
                  spacerHeight: spacerHeight,
                  containerHeight: containerHeight,
                  scrollWidth: screenWidth,
                  onrepbloooTsNyqTWt2Qu: { userId in
                    uid2IoIb4lqiLMOQ = userId
                  }
                )
                .id(index)
              }
            }
          }
          .padding(.horizontal, sidePadding)
          .scrollTargetLayout()
        }
        .coordinateSpace(name: "scroll")
        .scrollTargetBehavior(.viewAligned)
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.never)
        .frame(width: screenWidth)
        .onAppear {
          if !disVmrWpELPZVmt8tD.colp8W7CMTdrTSK9g.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              proxy.scrollTo(0, anchor: .center)
            }
          }
        }
      }
      .frame(width: screenWidth, height: containerHeight)
    }
    .frame(height: 220)
  }
}

struct CollectionCardView: View {
  let imageName: String
  let post: Post
  let itemWidth: CGFloat
  let cardHeight: CGFloat
  let spacerHeight: CGFloat
  let containerHeight: CGFloat
  let scrollWidth: CGFloat
  var onrepbloooTsNyqTWt2Qu: ((String) -> Void)? = nil
  @EnvironmentObject var aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod
  @EnvironmentObject var router: Router

  var body: some View {
    GeometryReader { cardGeometry in
      let cardCenterX = cardGeometry.frame(in: .named("scroll")).midX
      let scrollCenterX = scrollWidth / 2
      let distanceFromCenter = abs(cardCenterX - scrollCenterX)
      let maxDistance = scrollWidth / 2

      let progress = min(1.0, distanceFromCenter / maxDistance)

      let topSpacerHeight = spacerHeight * progress
      let bottomSpacerHeight = spacerHeight * (1.0 - progress)

      VStack(spacing: 0) {
        Spacer()
          .frame(height: topSpacerHeight)

        cardView

        Spacer()
          .frame(height: bottomSpacerHeight)
      }
      .frame(width: itemWidth, height: containerHeight)
      .animation(
        .spring(response: 0.35, dampingFraction: 0.75, blendDuration: 0.15),
        value: progress
      )
    }
    .frame(width: itemWidth, height: containerHeight)
  }

  private var cardView: some View {
    DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: imageName, contentMode: .fill)
      .frame(width: itemWidth, height: cardHeight)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .overlay(
        VStack {
          if aumaOPNRYtaLzBwfO.currvj9QRUUPOWY4Ouser?.id != post.aC9dE1fG3hI5jK {
            HStack {
              Spacer()

              Button(action: {
                onrepbloooTsNyqTWt2Qu?(post.aC9dE1fG3hI5jK)
              }) {
                Image(systemName: "ellipsis")
                  .font(.system(size: 24))
                  .foregroundColor(.white)
              }
            }
            .padding(.trailing, 16)
            .padding(.top, 16)

          }
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              aumaOPNRYtaLzBwfO.toggleB2rGhFgSQb0qAcol(pid3rhTIg1jfRXQj: post.id)
            }) {
              Image(systemName: "star.fill")
                .font(.system(size: 18))
                .foregroundColor(
                  aumaOPNRYtaLzBwfO.isColBbbiJ8jXV5fKI(pid3rhTIg1jfRXQj: post.id) ? .yellow : .white
                )
                .padding(8)
                .background(Color("buttonPurple"))
                .clipShape(Circle())
            }
            .padding(.trailing, 12)
            .padding(.bottom, 12)
          }
        }
      )
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.white, lineWidth: 2)
      )
      .contentShape(RoundedRectangle(cornerRadius: 16))
      .onTapGesture {
        router.push(.podeti0Gx1PwxsKGxM(postId: post.id))
      }
  }
}

struct PocardrDm6S2F8tYSbU: View {
  let postjmttDhoS3qgib: Post
  var onBlozWbxoGpaIWfTW: (() -> Void)? = nil
  var onrepbloooTsNyqTWt2Qu: ((String) -> Void)? = nil
  @StateObject private var disVmrWpELPZVmt8tD: PostcdppOzBHrSEqXxfVmod
  @EnvironmentObject var router: Router
  @EnvironmentObject var aumaOPNRYtaLzBwfO: AuthManagA645b8Y0Aod3aVmod

  init(
    postjmttDhoS3qgib: Post, onBlozWbxoGpaIWfTW: (() -> Void)? = nil,
    onrepbloooTsNyqTWt2Qu: ((String) -> Void)? = nil
  ) {
    self.postjmttDhoS3qgib = postjmttDhoS3qgib
    self.onBlozWbxoGpaIWfTW = onBlozWbxoGpaIWfTW
    self.onrepbloooTsNyqTWt2Qu = onrepbloooTsNyqTWt2Qu
    _disVmrWpELPZVmt8tD = StateObject(
      wrappedValue: PostcdppOzBHrSEqXxfVmod(auidhmUVmgwfUL08N: postjmttDhoS3qgib.aC9dE1fG3hI5jK))
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .top) {
        if let auth9fNAHb3e5Z8U4 = disVmrWpELPZVmt8tD.atSDfJi0ntFvhx3,
          let ava338PmT5u5k4nm = auth9fNAHb3e5Z8U4.aG3hI5jK7lM9nO
        {
          Button(action: {
            if let auth9fNAHb3e5Z8U4 = disVmrWpELPZVmt8tD.atSDfJi0ntFvhx3 {
              router.push(
                .profibW16jiY12DMmv(uidmhh7e21b987RS: auth9fNAHb3e5Z8U4.id, showBackicon: true))
            }
          }) {
            DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: ava338PmT5u5k4nm)
              .frame(width: 46, height: 46)
              .clipShape(Circle())
          }
        } else {
          Circle()
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [
                  Color.pink.opacity(0.3), Color.purple.opacity(0.3),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
            .frame(width: 46, height: 46)
            .overlay {
              if let authVrLYkrwpBRD31 = disVmrWpELPZVmt8tD.atSDfJi0ntFvhx3 {
                Text(String(authVrLYkrwpBRD31.uX4yZ6aB8cD0eF.prefix(1)))
                  .font(.headline)
                  .foregroundColor(.pink)
              }
            }
        }

        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text(disVmrWpELPZVmt8tD.atSDfJi0ntFvhx3?.uX4yZ6aB8cD0eF ?? "Unknown")
              .font(.custom("FredokaOne-Regular", size: 17))
              .foregroundColor(.white)

            Spacer()

            if aumaOPNRYtaLzBwfO.currvj9QRUUPOWY4Ouser?.id != postjmttDhoS3qgib.aC9dE1fG3hI5jK {
              Button(action: {
                if let auidx1DP54a9z5Puo = disVmrWpELPZVmt8tD.atSDfJi0ntFvhx3?.id {
                  onrepbloooTsNyqTWt2Qu?(auidx1DP54a9z5Puo)
                }
              }) {
                Image(systemName: "ellipsis")
                  .font(.system(size: 18))
                  .foregroundColor(.white)
              }
            }
          }

          Text(postjmttDhoS3qgib.cL7mN9oP1qR3sT)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .lineLimit(3)
            .padding(.bottom, 6)

          if !postjmttDhoS3qgib.iT1uV3wX5yZ7aB.isEmpty {
            HStack(spacing: 8) {
              ForEach(Array(postjmttDhoS3qgib.iT1uV3wX5yZ7aB.prefix(3).enumerated()), id: \.offset)
              {
                index, imgDAdCYdjyI3UVw in
                ZStack {
                  DymiimgYKxe1c8TyvAiL(imgMx6GF7oyJoIJA: imgDAdCYdjyI3UVw)
                    .frame(
                      width: (UIScreen.main.bounds.width - 150) / 3,
                      height: (UIScreen.main.bounds.width - 150) / 3
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                  if index == 2 && postjmttDhoS3qgib.iT1uV3wX5yZ7aB.count > 3 {
                    RoundedRectangle(cornerRadius: 8)
                      .fill(Color.black.opacity(0.5))
                      .frame(
                        width: (UIScreen.main.bounds.width - 150) / 3,
                        height: (UIScreen.main.bounds.width - 150) / 3
                      )

                    Text("+\(postjmttDhoS3qgib.iT1uV3wX5yZ7aB.count - 3)")
                      .font(.system(size: 18, weight: .bold))
                      .foregroundColor(.white)
                  }
                }
              }
            }
          }
        }
        .padding(.leading, 3)
        .padding(.top, 10)
      }
      .padding(.top, 10)
      .padding(.horizontal, 16)
      .padding(.bottom, 16)

    }
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 216 / 255, green: 72 / 255, blue: 227 / 255),
          Color(red: 216 / 255, green: 177 / 255, blue: 227 / 255),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    )
    .cornerRadius(20)
    .onAppear {
      disVmrWpELPZVmt8tD.setJv27Ie1wK02GM(aumaOPNRYtaLzBwfO)
    }
  }
}
