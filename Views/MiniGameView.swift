import SwiftUI

struct MiniGameView: View {
    
    let story: Story
    var onFinish: () -> Void
    
    @State private var currentIndex = 0
    @State private var selectedIndex: Int? = nil
    @State private var builtLetters: [String] = []
    
    @State private var showWrongPopup = false
    @State private var showConfetti = false
    @State private var showGameComplete = false
    
    @State private var shakeWord = false
    @State private var wrongGlow = false
    
    var currentGame: GameQuestion {
        story.games[currentIndex]
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            ZStack {
                
                // MARK: Background
                LinearGradient(
                    colors: [
                        Color(red: 0.76, green: 0.88, blue: 1.0),
                        Color(red: 0.56, green: 0.78, blue: 0.98)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if showConfetti {
                    ConfettiBackground()
                        .ignoresSafeArea()
                }
                
                VStack(spacing: 14 * scale) {
                    
                    Spacer()
                        .frame(height: 8)
                    
                    // MARK: Title
                    Text("Story Game")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 26
                        ))
                        .foregroundColor(.appPrimaryText)
                    
                    // MARK: Progress
                    HStack(spacing: 10) {
                        ForEach(0..<story.games.count, id: \.self) { index in
                            Capsule()
                                .fill(index <= currentIndex ? .yellow : .white.opacity(0.55))
                                .frame(
                                    width: 24 * scale,
                                    height: 6
                                )
                        }
                    }
                    
                    // MARK: Image
                    Image(story.coverImage)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: geo.size.width * 0.72,
                            height: isIPad ? 260 : 180
                        )
                        .cornerRadius(22)
                    
                    // MARK: LOWERED MORE
                    Spacer()
                        .frame(height: isIPad ? 55 : 34)
                    
                    // MARK: Game Card
                    VStack(spacing: 18 * scale) {
                        
                        Text(currentGame.question)
                            .font(.custom(
                                "OpenDyslexic-Bold",
                                size: 20 * scale
                            ))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        if currentGame.type == .buildWord {
                            buildWordView(scale: scale)
                        } else {
                            optionsView(scale: scale)
                        }
                    }
                    .padding(20 * scale)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(26)
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 10,
                        x: 0,
                        y: 6
                    )
                    .padding(.horizontal, 18)
                    
                    Spacer(minLength: 10)
                }
                
                // MARK: Wrong Popup
                if showWrongPopup {
                    
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 18) {
                        
                        Text("Nice Try!")
                            .font(.custom("OpenDyslexic-Bold", size: 24))
                        
                        Text("Want to try again or continue?")
                            .font(.custom("OpenDyslexic-Regular", size: 16))
                            .multilineTextAlignment(.center)
                        
                        HStack(spacing: 14) {
                            
                            Button("Try Again") {
                                resetTryAgain()
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.blue.opacity(0.25))
                            .cornerRadius(14)
                            
                            Button("Continue") {
                                showWrongPopup = false
                                nextGame()
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.green.opacity(0.25))
                            .cornerRadius(14)
                        }
                    }
                    .padding(26)
                    .background(Color.white)
                    .cornerRadius(26)
                    .shadow(radius: 14)
                    .padding(.horizontal, 30)
                }
                
                // MARK: Success Popup
                if showGameComplete {
                    
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        
                        Text("Amazing Work!")
                            .font(.custom("OpenDyslexic-Bold", size: 28))
                        
                        Text("You completed\n\(story.title)")
                            .font(.custom("OpenDyslexic-Regular", size: 18))
                            .multilineTextAlignment(.center)
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.yellow)
                        
                        HStack(spacing: 14) {
                            
                            Button("Play Again") {
                                restartGame()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.yellow)
                            .cornerRadius(14)
                            
                            Button("Back Home") {
                                onFinish()
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(Color.blue.opacity(0.25))
                            .cornerRadius(14)
                        }
                    }
                    .padding(28)
                    .background(Color.white)
                    .cornerRadius(28)
                    .shadow(radius: 16)
                    .padding(.horizontal, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: OPTIONS
extension MiniGameView {
    
    func optionsView(scale: CGFloat) -> some View {
        
        VStack(spacing: 14 * scale) {
            
            ForEach(currentGame.options.indices, id: \.self) { index in
                
                Button {
                    optionTapped(index)
                } label: {
                    
                    HStack {
                        
                        Text(currentGame.options[index])
                            .font(.custom(
                                "OpenDyslexic-Regular",
                                size: 18 * scale
                            ))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if selectedIndex == index &&
                            index == currentGame.correctIndex {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                        
                        if selectedIndex == index &&
                            index != currentGame.correctIndex {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .background(buttonColor(index))
                    .cornerRadius(18)
                }
            }
        }
    }
    
    func optionTapped(_ index: Int) {
        
        selectedIndex = index
        
        if index == currentGame.correctIndex {
            correctAnswer()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                showWrongPopup = true
            }
        }
    }
    
    func buttonColor(_ index: Int) -> Color {
        
        if selectedIndex == index &&
            index == currentGame.correctIndex {
            return .green.opacity(0.85)
        }
        
        if selectedIndex == index &&
            index != currentGame.correctIndex {
            return .red.opacity(0.85)
        }
        
        return .white
    }
}

// MARK: BUILD WORD
// MARK: BUILD WORD
extension MiniGameView {
    
    func buildWordView(scale: CGFloat) -> some View {
        
        let target = currentGame.correctAnswer ?? ""
        
        return VStack(spacing: 18) {
            
            // MARK: Word Boxes + Delete Button
            HStack(spacing: 12 * scale) {
                
                HStack(spacing: 8) {
                    
                    ForEach(0..<target.count, id: \.self) { i in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                wrongGlow
                                ? Color.red.opacity(0.35)
                                : Color(red: 1.0, green: 0.96, blue: 0.55)
                            )
                            .frame(
                                width: 42 * scale,
                                height: 48 * scale
                            )
                            .overlay(
                                Text(letterAt(i))
                                    .font(.custom(
                                        "OpenDyslexic-Bold",
                                        size: 22 * scale
                                    ))
                            )
                    }
                }
                
                // Delete Button on Right
                Button {
                    deleteLastLetter()
                } label: {
                    
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(width: 46, height: 46)
                        .background(Color.red)
                        .cornerRadius(12)
                }
                .opacity(builtLetters.isEmpty ? 0.45 : 1)
            }
            .offset(x: shakeWord ? -8 : 8)
            
            // MARK: Letter Choices
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible()),
                    count: 4
                ),
                spacing: 12
            ) {
                
                ForEach(currentGame.options, id: \.self) { letter in
                    
                    Button {
                        addLetter(letter)
                    } label: {
                        
                        Text(letter)
                            .font(.custom(
                                "OpenDyslexic-Bold",
                                size: 22 * scale
                            ))
                            .foregroundColor(.black)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .cornerRadius(14)
                    }
                }
            }
        }
    }
    
    func addLetter(_ letter: String) {
        
        let target = currentGame.correctAnswer ?? ""
        guard builtLetters.count < target.count else { return }
        
        builtLetters.append(letter)
        
        if builtLetters.joined() == target {
            correctAnswer()
            return
        }
        
        if builtLetters.count == target.count &&
            builtLetters.joined() != target {
            wrongBuildWordAnimation()
        }
    }
    
    func deleteLastLetter() {
        guard !builtLetters.isEmpty else { return }
        builtLetters.removeLast()
    }
    
    func wrongBuildWordAnimation() {
        
        wrongGlow = true
        
        withAnimation(.default.repeatCount(3, autoreverses: true)) {
            shakeWord.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            
            withAnimation(.spring()) {
                builtLetters = []
            }
            
            wrongGlow = false
            shakeWord = false
        }
    }
    
    func letterAt(_ index: Int) -> String {
        if index < builtLetters.count {
            return builtLetters[index]
        }
        return ""
    }
}

// MARK: FLOW
extension MiniGameView {
    
    func correctAnswer() {
        
        showConfetti = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            showConfetti = false
            nextGame()
        }
    }
    
    func resetTryAgain() {
        showWrongPopup = false
        selectedIndex = nil
        builtLetters = []
    }
    
    func nextGame() {
        
        selectedIndex = nil
        builtLetters = []
        
        if currentIndex < story.games.count - 1 {
            currentIndex += 1
        } else {
            showGameComplete = true
        }
    }
    
    func restartGame() {
        currentIndex = 0
        selectedIndex = nil
        builtLetters = []
        showGameComplete = false
    }
}

#Preview {
    NavigationStack {
        MiniGameView(
            story: sampleStories[0],
            onFinish: {}
        )
    }
}
