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
                    
                    Spacer(minLength: isIPad ? 10 : 4)
                    
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
                            
                            vocabularyCard(
                                word: words[currentIndex],
                                isIPad: isIPad,
                                width: cardWidth,
                                height: cardHeight
                            )
                            .offset(x: dragOffset)
                            .rotationEffect(.degrees(Double(dragOffset / 30)))
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation.width
                                    }
                                    .onEnded { value in
                                        
                                        if value.translation.width < -25 {
                                            nextWord(total: words.count)
                                        } else if value.translation.width > 25 {
                                            previousWord(total: words.count)
                                        }
                                        
                                        withAnimation(.spring(response: 0.32)) {
                                            dragOffset = 0
                                        }
                                    }
                            )
                            
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
                    }
                    
                    Spacer(minLength: isIPad ? 140 : 110)

                    // MARK: Reward Bubble
                    if showReward {
                        
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
                        .clipped()
                        .animation(
                            .easeInOut(duration: 0.7),
                            value: showOwl
                        )
                        .onAppear {
                            
                            // Start outside screen
                            showOwl = false
                            
                            // Enter screen
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showOwl = true
                            }
                            
                            // Leave screen forever
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                showOwl = false
                            }
                        }
                        .transition(
                            .move(edge: .bottom)
                            .combined(with: .opacity)
                        )
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.top, 10)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
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
