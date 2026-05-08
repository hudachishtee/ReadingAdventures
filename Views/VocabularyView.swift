import SwiftUI

struct VocabularyView: View {
    
    let story: Story
    
    @State private var currentIndex = 0
    @State private var showReward = false
    @State private var dragOffset: CGFloat = 0
    @State private var goToCelebration = false
    @State private var showOwl = false
    
    @ObservedObject var audioManager = AudioManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            let cardWidth = isIPad
                ? min(geo.size.width * 0.72, 640)
                : geo.size.width * 0.74
            
            let cardHeight = isIPad
                ? min(geo.size.height * 0.42, 520)
                : geo.size.height * 0.40
            
            let words = story.vocabulary
            
            ZStack {
                
                // MARK: Background
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                // MARK: Floating Done Button
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        Button("Done") {
                            goToCelebration = true
                        }
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 24 : 16
                        ))
                        .foregroundColor(.black)
                        .padding(.horizontal, isIPad ? 28 : 22)
                        .padding(.vertical, isIPad ? 10 : 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.8))
                        )
                        .overlay(
                            Capsule()
                                .stroke(
                                    Color.white.opacity(0.45),
                                    lineWidth: 1
                                )
                        )
                    }
                    
                    Spacer()
                }
                .padding(.top, isIPad ? 24 : 16)
                .padding(.horizontal, 20)
                
                // MARK: Main Content
                VStack(spacing: 0) {
                    
                    Spacer(minLength: isIPad ? 42 : 28)
                    
                    // MARK: Title
                    Text("Vocabulary of\nthe Week")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 20
                        ))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 20)
                        .padding(.vertical, isIPad ? 18 : 14)
                        .frame(maxWidth: isIPad ? 620 : 280)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 24,
                                style: .continuous
                            )
                            .fill(
                                Color.appCardBackground.opacity(0.6)
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 24,
                                style: .continuous
                            )
                            .stroke(
                                Color.white.opacity(0.45),
                                lineWidth: 1.2
                            )
                        )
                    
                    // MARK: Card + Arrows
                    if !words.isEmpty {
                        
                        HStack(spacing: isIPad ? 18 : 10) {
                            
                            Button {
                                previousWord(total: words.count)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(
                                        size: isIPad ? 34 : 26,
                                        weight: .medium
                                    ))
                                    .foregroundColor(.black.opacity(0.75))
                                    .frame(width: isIPad ? 44 : 34)
                            }
                            
                            ZStack {
                                
                                // Back Card 2
                                RoundedRectangle(
                                    cornerRadius: 26,
                                    style: .continuous
                                )
                                .fill(
                                    Color(
                                        red: 228/255,
                                        green: 218/255,
                                        blue: 150/255
                                    )
                                )
                                .frame(
                                    width: cardWidth - 14,
                                    height: cardHeight - 14
                                )
                                .offset(x: 16, y: 16)
                                
                                // Back Card 1
                                RoundedRectangle(
                                    cornerRadius: 26,
                                    style: .continuous
                                )
                                .fill(
                                    Color(
                                        red: 242/255,
                                        green: 229/255,
                                        blue: 165/255
                                    )
                                )
                                .frame(
                                    width: cardWidth - 8,
                                    height: cardHeight - 8
                                )
                                .offset(x: 8, y: 8)
                                
                                // Main Card
                                vocabularyCard(
                                    word: words[currentIndex],
                                    isIPad: isIPad,
                                    width: cardWidth,
                                    height: cardHeight
                                )
                                .offset(x: dragOffset)
                                .rotationEffect(
                                    .degrees(Double(dragOffset / 28))
                                )
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            dragOffset = value.translation.width
                                        }
                                        .onEnded { value in
                                            
                                            let threshold: CGFloat = 70
                                            
                                            if value.translation.width < -threshold {
                                                
                                                withAnimation(.easeOut(duration: 0.2)) {
                                                    dragOffset = -geo.size.width
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                    
                                                    nextWord(total: words.count)
                                                    
                                                    dragOffset = geo.size.width * 0.2
                                                    
                                                    withAnimation(
                                                        .spring(
                                                            response: 0.36,
                                                            dampingFraction: 0.84
                                                        )
                                                    ) {
                                                        dragOffset = 0
                                                    }
                                                }
                                                
                                            } else if value.translation.width > threshold {
                                                
                                                withAnimation(.easeOut(duration: 0.2)) {
                                                    dragOffset = geo.size.width
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                    
                                                    previousWord(total: words.count)
                                                    
                                                    dragOffset = -geo.size.width * 0.2
                                                    
                                                    withAnimation(
                                                        .spring(
                                                            response: 0.36,
                                                            dampingFraction: 0.84
                                                        )
                                                    ) {
                                                        dragOffset = 0
                                                    }
                                                }
                                                
                                            } else {
                                                
                                                withAnimation(
                                                    .spring(
                                                        response: 0.35,
                                                        dampingFraction: 0.84
                                                    )
                                                ) {
                                                    dragOffset = 0
                                                }
                                            }
                                        }
                                )
                            }
                            
                            Button {
                                nextWord(total: words.count)
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(
                                        size: isIPad ? 34 : 26,
                                        weight: .medium
                                    ))
                                    .foregroundColor(.black.opacity(0.75))
                                    .frame(width: isIPad ? 44 : 34)
                            }
                        }
                        .offset(y: isIPad ? 100 : 100)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.top, -200)
                .frame(maxWidth: 500)
                .frame(maxWidth: .infinity)
                
                // MARK: Floating Reward Bubble
                if showReward {
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 0) {
                            
                            Text("Wow! You learned new words today!")
                                .font(.custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 22 : 13
                                ))
                                .foregroundColor(.appPrimaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, isIPad ? 28 : 18)
                                .padding(.vertical, isIPad ? 18 : 12)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 24,
                                        style: .continuous
                                    )
                                    .fill(Color.white.opacity(0.88))
                                )
                                .overlay(
                                    RoundedRectangle(
                                        cornerRadius: 24,
                                        style: .continuous
                                    )
                                    .stroke(
                                        Color.white.opacity(0.45),
                                        lineWidth: 1.2
                                    )
                                )
                            
                            Image("side_owl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: isIPad ? 150 : 95)
                        }
                        .offset(
                            x: showOwl
                                ? 0
                                : geo.size.width + 500
                        )
                        .animation(
                            .easeInOut(duration: 0.7),
                            value: showOwl
                        )
                        .padding(.bottom, isIPad ? 50 : 35)
                        .onAppear {
                            
                            showOwl = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showOwl = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                showOwl = false
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $goToCelebration) {
            CelebrationView(story: story)
        }
    }
    
    // MARK: Vocabulary Card
    func vocabularyCard(
        word: VocabularyWord,
        isIPad: Bool,
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        
        VStack(spacing: isIPad ? 24 : 16) {
            
            HStack(spacing: 8) {
                
                Spacer()
                
                Text(word.word)
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 34 : 20
                    ))
                    .foregroundColor(.appPrimaryText)
                
                Button {
                    audioManager.play(audioName: word.audioName)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(.green)
                        .font(.system(size: isIPad ? 26 : 16))
                }
                
                Spacer()
            }
            
            Divider()
            
            Text(word.meaning)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 28 : 16
                ))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text("Example")
                .font(.custom(
                    "OpenDyslexic-Bold",
                    size: isIPad ? 22 : 14
                ))
            
            Text(word.example)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 28 : 16
                ))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(isIPad ? 28 : 18)
        .frame(width: width, height: height)
        .background(
            ZStack {
                
                RoundedRectangle(
                    cornerRadius: 26,
                    style: .continuous
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color(
                                red: 255/255,
                                green: 239/255,
                                blue: 170/255
                            ),
                            Color(
                                red: 255/255,
                                green: 221/255,
                                blue: 120/255
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                RoundedRectangle(
                    cornerRadius: 26,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(0.5),
                    lineWidth: 1.5
                )
            }
        )
        .shadow(
            color: Color.orange.opacity(0.18),
            radius: 10,
            x: 0,
            y: 4
        )
    }
    
    // MARK: Navigation Helpers
    func nextWord(total: Int) {
        guard total > 0 else { return }
        
        withAnimation(.spring(response: 0.35)) {
            currentIndex = (currentIndex + 1) % total
        }
        
        if !showReward {
            withAnimation(.spring()) {
                showReward = true
            }
        }
    }
    
    func previousWord(total: Int) {
        guard total > 0 else { return }
        
        withAnimation(.spring(response: 0.35)) {
            currentIndex = currentIndex == 0
                ? total - 1
                : currentIndex - 1
        }
    }
}

#Preview {
    VocabularyView(story: sampleStories[0])
}
