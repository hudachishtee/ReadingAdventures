//
// CelebrationView.swift
// FINAL COMPLETE VERSION
// DARK MODE FIXED
//

import SwiftUI
import Combine

struct CelebrationView: View {
    
    let story: Story
    
    @StateObject private var progress = ProgressManager.shared
    
    @State private var showTitle = false
    @State private var showOwl = false
    @State private var showBadge = false
    @State private var showButtons = false
    @State private var badgeDismissed = false
    
    @State private var goMiniGame = false
    @State private var goHome = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            ZStack {
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ConfettiBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer()
                        .frame(height: isIPad ? 90 : 70)
                    
                    //==================================================
                    // TITLE
                    //==================================================
                    
                    if showTitle {
                        
                        VStack(spacing: 10) {
                            
                            Text("You Did It!")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 44 : 32
                                    )
                                )
                                .foregroundColor(.appPrimaryText)
                            
                            Text("You finished reading")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Regular",
                                        size: isIPad ? 26 : 20
                                    )
                                )
                                .foregroundColor(.appPrimaryText)
                            
                            Text(story.title)
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 28 : 22
                                    )
                                )
                                .foregroundColor(.appPrimaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }
                    }
                    
                    Spacer()
                    
                    //==================================================
                    // OWL
                    //==================================================
                    
                    if showOwl {
                        
                        Image("owl")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isIPad ? 700 : 240)
                    }
                    
                    Spacer()
                    
                    //==================================================
                    // BUTTONS
                    //==================================================
                    
                    if showButtons {
                        
                        VStack(spacing: isIPad ? 16 : 14) {
                            
                            Button {
                                goMiniGame = true
                            } label: {
                                
                                HStack(spacing: 10) {

                                    Image(systemName: "gamecontroller.fill")

                                    Text("Play Mini Game")
                                        .font(
                                            .custom(
                                                "OpenDyslexic-Bold",
                                                size: isIPad ? 24 : 18
                                            )
                                        )

                                    Image(systemName: "arrow.right")
                                }
                                .foregroundColor(.appPrimaryText)
                                .frame(maxWidth: isIPad ? 520 : 320)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color("ButtonColor"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(
                                                    Color.white.opacity(0.25),
                                                    lineWidth: 1.5
                                                )
                                        )
                                )
                                .shadow(
                                    color: .black.opacity(0.18),
                                    radius: 10,
                                    x: 0,
                                    y: 5
                                )
                            }
                            
                            Button {
                                goHome = true
                            } label: {
                                
                                HStack(spacing: 10) {

                                    Image(systemName: "books.vertical.fill")

                                    Text("Back To Library")
                                        .font(
                                            .custom(
                                                "OpenDyslexic-Bold",
                                                size: isIPad ? 26 : 20
                                            )
                                        )
                                }
                                .foregroundColor(.appPrimaryText)
                                .frame(maxWidth: isIPad ? 520 : 320)
                                .padding(.vertical, isIPad ? 18 : 17)
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color("ButtonColor"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(
                                                    Color.white.opacity(0.25),
                                                    lineWidth: 1.5
                                                )
                                        )
                                )
                                .shadow(
                                    color: .black.opacity(0.10),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 22)
                    }
                }
                
                //==================================================
                // BADGE CARD
                //==================================================
                
                if showBadge && !badgeDismissed {
                    
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
//                        .onTapGesture {
//                            dismissBadge()
//                        }
                    
                    ZStack(alignment: .topTrailing) {

                        Image(BadgeHelper.badgeImage(for: story))
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: isIPad ? 500 : 340
                            )

                        Button {
                            dismissBadge()
                        } label: {

                            Image(systemName: "xmark.circle.fill")
                                .font(
                                    .system(
                                        size: isIPad ? 40 : 30
                                    )
                                )
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.gray.opacity(0.9))
                                )
                        }
                        .offset(
                            x: isIPad ? 35 : 22,
                            y: isIPad ? -40 : -25
                        )
                    }
                }
            }
            .fullScreenCover(isPresented: $goMiniGame) {
                
                MiniGameView(
                    story: story,
                    selectedTab: .constant(.games),
                    onFinish: {
                        goHome = true
                    }
                )
            }
            .fullScreenCover(isPresented: $goHome) {
                MainTabContainerView()
            }
            .onAppear {
                startAnimation()
                progress.completeStory(story)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//==============================================================
// MARK: Animation
//==============================================================

extension CelebrationView {
    
    func startAnimation() {
        
        withAnimation(.easeOut(duration: 0.45)) {
            showTitle = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            
            withAnimation(.spring()) {
                showOwl = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            
            withAnimation(.spring()) {
                showBadge = true
            }
        }
    }
    
    func dismissBadge() {
        
        withAnimation(.easeOut(duration: 0.2)) {
            badgeDismissed = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            
            withAnimation(.spring()) {
                showButtons = true
            }
        }
    }
}

//==============================================================
// MARK: Confetti Models
//==============================================================

struct ConfettiParticle: Identifiable {
    
    let id = UUID()
    
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var color: Color
    var rotation: Double
    var speed: CGFloat
    var isCircle: Bool
}

struct ConfettiBackground: View {
    
    @State private var particles: [ConfettiParticle] = []
    
    let timer = Timer.publish(
        every: 0.03,
        on: .main,
        in: .common
    ).autoconnect()
    
    let colors: [Color] = [
        .red,
        .blue,
        .green,
        .yellow,
        .orange,
        .pink,
        .purple
    ]
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                ForEach(particles.indices, id: \.self) { i in
                    
                    let p = particles[i]
                    
                    Group {
                        
                        if p.isCircle {
                            
                            Circle()
                                .fill(p.color)
                            
                        } else {
                            
                            RoundedRectangle(cornerRadius: 2)
                                .fill(p.color)
                        }
                    }
                    .frame(width: p.size, height: p.size)
                    .rotationEffect(.degrees(p.rotation))
                    .position(x: p.x, y: p.y)
                }
            }
            .onAppear {
                particles = createParticles(
                    count: 95,
                    size: geo.size
                )
            }
            .onReceive(timer) { _ in
                
                for i in particles.indices {
                    
                    particles[i].y += particles[i].speed
                    particles[i].rotation += 4
                    
                    if particles[i].y > geo.size.height + 20 {
                        
                        particles[i].y = -20
                        
                        particles[i].x = CGFloat.random(
                            in: 0...geo.size.width
                        )
                    }
                }
            }
        }
    }
    
    func createParticles(
        count: Int,
        size: CGSize
    ) -> [ConfettiParticle] {
        
        (0..<count).map { _ in
            
            ConfettiParticle(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height),
                size: CGFloat.random(in: 6...14),
                color: colors.randomElement()!,
                rotation: Double.random(in: 0...360),
                speed: CGFloat.random(in: 1...4),
                isCircle: Bool.random()
            )
        }
    }
}

//==============================================================
// MARK: Preview
//==============================================================

#Preview {
    
    NavigationStack {
        
        CelebrationView(
            story: sampleStories[0]
        )
    }
}
