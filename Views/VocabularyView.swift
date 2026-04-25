import SwiftUI

struct VocabularyView: View {
    
    let story: Story
    
    @State private var currentIndex = 0
    @State private var showReward = false
    @State private var dragOffset: CGFloat = 0
    @State private var goToCelebration = false   // ✅ ONLY ADDED
    
    @ObservedObject var audioManager = AudioManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            let cardWidth = isIPad ? min(geo.size.width * 0.72, 640) : geo.size.width * 0.74
            let cardHeight = isIPad ? min(geo.size.height * 0.42, 520) : geo.size.height * 0.40
            
            let words = story.vocabulary
            
            ZStack {
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer(minLength: isIPad ? 18 : 12)
                    
                    // MARK: Done
                    HStack {
                        Spacer()
                        
                        Button("Done") {
                            goToCelebration = true   // ✅ CHANGED ONLY
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
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: isIPad ? 18 : 10)
                    
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
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.84))
                        )
                    
                    Spacer(minLength: isIPad ? 26 : 14)
                    
                    // MARK: Card + Arrows
                    if !words.isEmpty {
                        
                        HStack(spacing: isIPad ? 18 : 10) {
                            
                            Button {
                                previousWord(total: words.count)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: isIPad ? 34 : 26, weight: .medium))
                                    .foregroundColor(.black.opacity(0.75))
                                    .frame(width: isIPad ? 44 : 34)
                            }
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 26)
                                    .fill(Color.orange.opacity(0.55))
                                    .frame(
                                        width: cardWidth + 8,
                                        height: cardHeight
                                    )
                                    .offset(y: 12)
                                
                                RoundedRectangle(cornerRadius: 26)
                                    .fill(Color.yellow.opacity(0.78))
                                    .frame(
                                        width: cardWidth + 4,
                                        height: cardHeight
                                    )
                                    .offset(y: 6)
                                
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
                            }
                            
                            Button {
                                nextWord(total: words.count)
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: isIPad ? 34 : 26, weight: .medium))
                                    .foregroundColor(.black.opacity(0.75))
                                    .frame(width: isIPad ? 44 : 34)
                            }
                        }
                    }
                    
                    Spacer()
                    
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
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white.opacity(0.88))
                                )
                            
                            Image("side_owl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: isIPad ? 150 : 95)
                                .offset(x: isIPad ? -12 : -8)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.top, 10)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $goToCelebration) {
            CelebrationView(
                story: story
            )
        }
    }
    
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
            RoundedRectangle(cornerRadius: 26)
                .fill(
                    Color(
                        red: 253/255,
                        green: 232/255,
                        blue: 109/255
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 26)
                        .stroke(
                            Color(
                                red: 0.85,
                                green: 0.72,
                                blue: 0.22
                            ),
                            lineWidth: 2
                        )
                )
        )
    }
    
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
            currentIndex = currentIndex == 0 ? total - 1 : currentIndex - 1
        }
    }
}

#Preview {
    VocabularyView(story: sampleStories[0])
}
