//
// CelebrationView.swift
// PERFECT BALANCED LAYOUT
// title upper-middle + owl center + buttons bottom
//

import SwiftUI
import Combine

struct CelebrationView: View {
    
    let story: Story
    var onBackToLibrary: () -> Void
    var onPlayGame: () -> Void
    
    @State private var showTitle = false
    @State private var showOwl = false
    @State private var showBadge = false
    @State private var showButtons = false
    @State private var badgeDismissed = false
    
    var body: some View {
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            ZStack {
                
                // MARK: Background
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
                    
                    // MARK: Title Block
                    if showTitle {
                        
                        VStack(spacing: 10) {
                            
                            Text("You Did It!")
                                .font(.custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 44 : 32
                                ))
                                .foregroundColor(.appPrimaryText)
                            
                            Text("You finished reading")
                                .font(.custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 24 : 18
                                ))
                                .foregroundColor(.appPrimaryText)
                            
                            Text(story.title)
                                .font(.custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 28 : 22
                                ))
                                .foregroundColor(.appPrimaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }
                    }
                    
                    // pushes owl to center area
                    Spacer()
                    
                    // MARK: Owl Center
                    if showOwl {
                        
                        Image("owl")
                            .resizable()
                            .scaledToFill()
                            .frame(width: isIPad ? 700 : 240)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Spacer()
                    
                    // MARK: Bottom Buttons
                    if showButtons {
                        
                        VStack(spacing: 14) {
                            
                            Button {
                                onPlayGame()
                            } label: {
                                Text("Play Mini Game")
                                    .font(.custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 24 : 18
                                    ))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.yellow)
                                    .cornerRadius(18)
                            }
                            
                            Button {
                                onBackToLibrary()
                            } label: {
                                Text("Back To Library")
                                    .font(.custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 24 : 18
                                    ))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(18)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 22)
                    }
                }
                
                // MARK: Popup Badge
                if showBadge && !badgeDismissed {
                    
                    Color.black.opacity(0.18)
                        .ignoresSafeArea()
                        .onTapGesture {
                            dismissBadge()
                        }
                    
                    VStack(spacing: 22) {
                        
                        Text("You Earned\nA Badge!")
                            .font(.custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 28 : 24
                            ))
                            .multilineTextAlignment(.center)
                        
                        Circle()
                            .fill(Color.orange)
                            .frame(
                                width: isIPad ? 120 : 105,
                                height: isIPad ? 120 : 105
                            )
                            .overlay(
                                Image(systemName: "star.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 44))
                            )
                        
                        Text(
                            (story.title.components(separatedBy: " ").first ?? "Reading")
                            + " Star"
                        )
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 24 : 20
                        ))
                        
                        Text("Tap anywhere")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 34)
                    .padding(.horizontal, 28)
                    .frame(width: isIPad ? 420 : 350)
                    .background(Color.white)
                    .cornerRadius(28)
                    .shadow(radius: 18)
                }
            }
            .onAppear {
                startAnimation()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: Animation

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

// MARK: CONFETTI

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
        .red, .blue, .green,
        .yellow, .orange,
        .pink, .purple
    ]
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                ForEach(particles.indices, id: \.self) { i in
                    
                    let p = particles[i]
                    
                    Group {
                        if p.isCircle {
                            Circle().fill(p.color)
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
                        particles[i].x = CGFloat.random(in: 0...geo.size.width)
                    }
                }
            }
        }
    }
    
    func createParticles(count: Int, size: CGSize) -> [ConfettiParticle] {
        
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

#Preview {
    CelebrationView(
        story: sampleStories[0],
        onBackToLibrary: {},
        onPlayGame: {}
    )
}
