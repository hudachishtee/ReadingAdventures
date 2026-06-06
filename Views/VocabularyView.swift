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
                ? min(geo.size.width * 0.64, 580)
                : geo.size.width * 0.74
            
            let cardHeight = isIPad
                ? min(geo.size.height * 0.40, 520)
                : geo.size.height * 0.42
            
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
                        
                        Button {
                            goToCelebration = true
                        } label: {
                            
                            Image(systemName: "checkmark")
                                .font(.system(
                                    size: isIPad ? 20 : 16,
                                    weight: .bold
                                ))
                                .foregroundColor(.appPrimaryText)
                                .frame(
                                    width: isIPad ? 52 : 44,
                                    height: isIPad ? 52 : 44
                                )
                                .background(
                                    Circle()
                                        .fill(Color("ButtonColor"))
                                )
                                .overlay(
                                    Circle()
                                        .stroke(
                                            Color.white.opacity(0.35),
                                            lineWidth: 1
                                        )
                                )
                                .shadow(
                                    color: .black.opacity(0.12),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, isIPad ? 40 : 28)
                .padding(.horizontal, 20)
                
                // MARK: Main Content
                VStack(spacing: 0) {
                    
                    Spacer(minLength: isIPad ? 42 : 28)
                    
                    // MARK: Title
                    Text("New Words")                       .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 20
                        ))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 20)
                        .padding(.vertical, isIPad ? 18 : 14)
                        .frame(maxWidth: isIPad ? 620 : 240)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 24,
                                style: .continuous
                            )
                            .fill(
                                Color.appCardBackground.opacity(0.82)
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
                        
                        HStack(spacing: isIPad ? 8 : 2) {
                            Button {
                                previousWord(total: words.count)
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(
                                        size: isIPad ? 34 : 26,
                                        weight: .medium
                                    ))
                                    .foregroundColor(
                                        .appPrimaryText.opacity(0.85)
                                    )
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
                                .offset(x: 8, y: 8)
                                
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
                                .offset(x: 4, y: 4)
                                
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
                                    .foregroundColor(
                                        .appPrimaryText.opacity(0.85)
                                    )
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
                                    .fill(Color("ButtonSecondaryBackground"))                              )
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
        
        VStack(alignment: .leading, spacing: isIPad ? 32 : 22) {
            
            HStack {

                Spacer()

                Text(word.word)
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 34 : 20
                    ))
                    .foregroundColor(.appPrimaryText)

                Button {
                    audioManager.play(
                        audioName: word.audioName,
                        text: ""
                    )
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundColor(Color("VocabularyAccent"))
                        .font(.system(size: isIPad ? 26 : 16))
                }

                Spacer()

                Button {

                    // save word

                } label: {

                    Image(systemName: "bookmark")
                        .font(.system(size: isIPad ? 24 : 18))
                        .foregroundColor(.appPrimaryText.opacity(0.7))
                }
            }
            
            
            Divider()
                .padding(.top, 4)
            
            Text(word.meaning)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 28 : 16
                ))
                .foregroundColor(.appPrimaryText)                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, isIPad ? 14 : 8)
            
            HStack {
                
                Text("Example")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 22 : 14
                    ))
                
                Spacer()
            }
            .padding(.top, isIPad ? 10 : 6)
            
            Text(word.example)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 28 : 16
                ))
                .foregroundColor(.appPrimaryText)                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 6)
        }
        .padding(isIPad ? 28 : 18)
        .frame(width: width)
        .frame(minHeight: height)
        .background(
            ZStack {
                
                RoundedRectangle(
                    cornerRadius: 26,
                    style: .continuous
                )
                .fill(Color.vocabularyCard)
                
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
    VocabularyView(story: sampleStories[1])
}
