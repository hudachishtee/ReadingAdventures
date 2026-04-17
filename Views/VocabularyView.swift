import SwiftUI

struct VocabularyView: View {
    
    let story: Story
    
    @State private var currentIndex = 0
    @State private var showReward = false
    @State private var dragOffset: CGFloat = 0
    
    @ObservedObject var audioManager = AudioManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            // FIXED iPhone sizing
            let cardWidth = isIPad ? 630.0 : geo.size.width - 26
            let cardHeight = isIPad ? 510.0 : geo.size.height * 0.42
            
            let words = story.vocabulary
            let word = words.isEmpty ? nil : words[currentIndex]
            
            ZStack {
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer(minLength: isIPad ? 18 : 10)
                    
                    // MARK: Done
                    HStack {
                        Spacer()
                        
                        Button("Done") {
                            dismiss()
                        }
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 24 : 16
                        ))
                        .foregroundColor(.black)
                        .padding(.horizontal, isIPad ? 26 : 20)
                        .padding(.vertical, isIPad ? 10 : 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.75))
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: isIPad ? 18 : 10)
                    
                    // MARK: Title
                    Text("Vocabulary of the Week")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 18
                        ))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.vertical, isIPad ? 18 : 14)
                        .frame(maxWidth: isIPad ? 620 : 250)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.white.opacity(0.78))
                        )
                    
                    Spacer(minLength: isIPad ? 26 : 16)
                    
                    // MARK: Card Stack
                    if let word = word {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.orange.opacity(0.55))
                                .frame(
                                    width: cardWidth + 8,
                                    height: cardHeight
                                )
                                .offset(y: 12)
                            
                            RoundedRectangle(cornerRadius: 28)
                                .fill(Color.yellow.opacity(0.75))
                                .frame(
                                    width: cardWidth + 4,
                                    height: cardHeight
                                )
                                .offset(y: 6)
                            
                            vocabularyCard(
                                word: word,
                                isIPad: isIPad,
                                width: cardWidth,
                                height: cardHeight
                            )
                            .offset(x: dragOffset)
                            .rotationEffect(.degrees(Double(dragOffset / 28)))
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation.width
                                    }
                                    .onEnded { value in
                                        
                                        if value.translation.width < -70 {
                                            nextWord(total: words.count)
                                        } else if value.translation.width > 70 {
                                            previousWord(total: words.count)
                                        }
                                        
                                        withAnimation(.spring()) {
                                            dragOffset = 0
                                        }
                                    }
                            )
                            .onTapGesture {
                                nextWord(total: words.count)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: Reward Bubble
                    if showReward {
                        
                        ZStack(alignment: .trailing) {
                            
                            Text("Wow! You learned new words today!")
                                .font(.custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 24 : 14
                                ))
                                .foregroundColor(.appPrimaryText)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, isIPad ? 24 : 16)
                                .padding(.vertical, isIPad ? 22 : 16)
                                .frame(maxWidth: isIPad ? 500 : 250)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white.opacity(0.86))
                                )
                            
                            Image("side_owl")
                                .resizable()
                                .scaledToFit()
                                .frame(width: isIPad ? 180 : 135)
                                .offset(
                                    x: isIPad ? 220 : 78,
                                    y: 5
                                )
                        }
                        .frame(maxWidth: isIPad ? 520 : 255)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    Spacer(minLength: isIPad ? 18 : 10)
                    
                    // MARK: Bottom Bar
                    HStack {
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "gamecontroller.fill")
                        Spacer()
                        Image(systemName: "medal.fill")
                    }
                    .font(.system(size: isIPad ? 28 : 18))
                    .foregroundColor(.appPrimaryText)
                    .padding(.horizontal, 28)
                    .padding(.vertical, isIPad ? 18 : 12)
                    .frame(maxWidth: isIPad ? 620 : 250)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.55))
                    )
                    .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: Front Card
    func vocabularyCard(
        word: VocabularyWord,
        isIPad: Bool,
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    Color(
                        red: 253/255,
                        green: 232/255,
                        blue: 109/255
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(
                            Color(
                                red: 0.35,
                                green: 0.65,
                                blue: 0.75
                            ),
                            lineWidth: 1.5
                        )
                )
            
            VStack(alignment: .leading, spacing: isIPad ? 22 : 14) {
                
                HStack {
                    Spacer()
                    
                    Text(word.word)
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 30 : 18
                        ))
                        .foregroundColor(.appPrimaryText)
                    
                    Button {
                        audioManager.play(audioName: word.audioName)
                    } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundColor(.green)
                            .font(.system(size: isIPad ? 28 : 16))
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                Text(word.meaning)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 24 : 14
                    ))
                    .foregroundColor(.black)
                
                Text("Example")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 22 : 14
                    ))
                
                Text(word.example)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 22 : 14
                    ))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(isIPad ? 22 : 16)
        }
        .frame(width: width, height: height)
    }
    
    // MARK: Next
    func nextWord(total: Int) {
        guard total > 0 else { return }
        
        withAnimation(.spring()) {
            currentIndex = (currentIndex + 1) % total
        }
        
        if !showReward {
            withAnimation(.spring()) {
                showReward = true
            }
        }
    }
    
    // MARK: Previous
    func previousWord(total: Int) {
        guard total > 0 else { return }
        
        withAnimation(.spring()) {
            currentIndex = currentIndex == 0
            ? total - 1
            : currentIndex - 1
        }
    }
}

#Preview {
    VocabularyView(story: sampleStories[0])
}
