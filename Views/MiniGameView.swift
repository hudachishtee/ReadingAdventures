import SwiftUI

struct MiniGameView: View {
    
    let story: Story
    @Binding var selectedTab: TabItem
    @Environment(\.dismiss) private var dismiss
    
    var onFinish: () -> Void
    
    @State private var currentIndex = 0
    @State private var selectedIndex: Int? = nil
    
    @State private var builtLetterIndices: [Int] = []
    
    @State private var showWrongPopup = false
    @State private var showConfetti = false
    @State private var showGameComplete = false
    
    @State private var shakeWord = false
    @State private var wrongGlow = false
    
    @State private var goHome = false
    @State private var showExitAlert = false
    
    @State private var pressedIndex: Int? = nil
    @State private var animatePopup = false
    
    var currentGame: GameQuestion {
        story.games[currentIndex]
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            ZStack {
                
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
                        .transition(.opacity)
                }
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            showExitAlert = true
                        } label: {
                            Image(systemName: "door.left.hand.open")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: 48, height: 48)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    Spacer()
                }
                
                VStack(spacing: 14 * scale) {
                    
                    Spacer().frame(height: 8)
                    
                    Text("Story Game")
                        .font(.custom("OpenDyslexic-Bold", size: isIPad ? 34 : 26))
                        .foregroundColor(.appPrimaryText)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<story.games.count, id: \.self) { index in
                            Capsule()
                                .fill(index <= currentIndex ? .yellow : .white.opacity(0.55))
                                .frame(width: 24 * scale, height: 6)
                                .animation(.easeInOut(duration: 0.3), value: currentIndex)
                        }
                    }
                    
                    Image(story.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width * 0.92,
                               height: isIPad ? 300 : 210)
                        .clipped()
                        .cornerRadius(22)
                    
                    Spacer().frame(height: isIPad ? 55 : 34)
                    
                    VStack(spacing: 18 * scale) {
                        
                        highlightedQuestion(scale: scale) // ✅ HERE
                    
                        if currentGame.type == .buildWord {
                            buildWordView(scale: scale)
                        } else {
                            optionsView(scale: scale)
                        }
                    }
                    .padding(20 * scale)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(26)
                    .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 6)
                    .padding(.horizontal, 18)
                    
                    Spacer(minLength: 10)
                }
                
                if showWrongPopup {
                    Color.black.opacity(0.25).ignoresSafeArea()
                    
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
                
                if showGameComplete {
                    Color.black.opacity(0.25).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Amazing Work!")
                            .font(.custom("OpenDyslexic-Bold", size: 28))
                        
                        Text("You completed\n\(story.title)")
                            .font(.custom("OpenDyslexic-Regular", size: 18))
                            .multilineTextAlignment(.center)
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 60))
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
                                selectedTab = .games
                                dismiss()
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
                    .scaleEffect(animatePopup ? 1 : 0.8)
                    .opacity(animatePopup ? 1 : 0)
                    .onAppear {
                        withAnimation(.spring()) {
                            animatePopup = true
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .alert("Leave Mini Game?", isPresented: $showExitAlert) {
            Button("Continue", role: .cancel) { }
            Button("Leave", role: .destructive) {
                selectedTab = .games
                dismiss()
            }
        }
//        .fullScreenCover(isPresented: $goHome) {
//            MainTabContainerView()
//        }
    }
}

//
// MARK: ✅ Highlight ONLY specific words
//
extension MiniGameView {
    
    func highlightedQuestion(scale: CGFloat) -> some View {
        
        let highlightWords = ["Sandwich", "KIND", "Share", "Brave", "Ocean", "WAVE", "Promise", "Friendship", "SKY", "Crayon", "Lost", "DRAW", "Toy", "Soft"]
        let words = currentGame.question.split(separator: " ")
        
        var text = Text("")
        
        for word in words {
            
            let clean = word.trimmingCharacters(in: .punctuationCharacters)
            
            if highlightWords.contains(clean) {
                text = text + Text("\(word) ").foregroundColor(.orange)
            } else {
                text = text + Text("\(word) ")
            }
        }
        
        return text
            .font(.custom("OpenDyslexic-Bold", size: 20 * scale))
            .multilineTextAlignment(.center)
    }
}

//
// MARK: OPTIONS (🔥 Improved)
//
extension MiniGameView {
    
    func optionsView(scale: CGFloat) -> some View {
        
        VStack(spacing: 14 * scale) {
            
            ForEach(currentGame.options.indices, id: \.self) { index in
                
                Button {
                    pressedIndex = index
                    
                    // 🔥 Tap feedback delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        optionTapped(index)
                        pressedIndex = nil
                    }
                    
                } label: {
                    
                    HStack {
                        
                        Text(currentGame.options[index])
                            .font(.custom("OpenDyslexic-Regular", size: 18 * scale))
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
                    .scaleEffect(pressedIndex == index ? 0.95 : 1)
                    .animation(.spring(response: 0.25, dampingFraction: 0.5), value: pressedIndex)
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

//
// MARK: BUILD WORD (🔥 Improved Animation)
//
extension MiniGameView {
    
    func buildWordView(scale: CGFloat) -> some View {
        
        let target = currentGame.correctAnswer ?? ""
        
        return VStack(spacing: 18) {
            
            HStack(spacing: 12 * scale) {
                
                HStack(spacing: 8) {
                    
                    ForEach(0..<target.count, id: \.self) { i in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                wrongGlow
                                ? Color.red.opacity(0.35)
                                : Color(red: 1.0, green: 0.96, blue: 0.55)
                            )
                            .frame(width: 42 * scale, height: 48 * scale)
                            .overlay(
                                Text(letterAt(i))
                                    .font(.custom("OpenDyslexic-Bold", size: 22 * scale))
                            )
                            .scaleEffect(letterAt(i).isEmpty ? 0.9 : 1)
                            .animation(.spring(), value: builtLetterIndices)
                    }
                }
                
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
                .opacity(builtLetterIndices.isEmpty ? 0.45 : 1)
            }
            .offset(x: shakeWord ? -8 : 8)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 4),
                spacing: 12
            ) {
                
                ForEach(currentGame.options.indices, id: \.self) { index in
                    
                    let letter = currentGame.options[index]
                    let isUsed = builtLetterIndices.contains(index)
                    
                    Button {
                        withAnimation(.spring()) {
                            addLetter(index)
                        }
                    } label: {
                        
                        Text(letter)
                            .font(.custom("OpenDyslexic-Bold", size: 22 * scale))
                            .foregroundColor(.black)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .cornerRadius(14)
                            .opacity(isUsed ? 0.4 : 1.0)
                    }
                    .disabled(isUsed)
                }
            }
        }
    }
    
    func addLetter(_ index: Int) {
        
        let target = currentGame.correctAnswer ?? ""
        guard builtLetterIndices.count < target.count else { return }
        
        builtLetterIndices.append(index)
        
        let builtWord = builtLetterIndices.map {
            currentGame.options[$0]
        }.joined()
        
        if builtWord == target {
            correctAnswer()
            return
        }
        
        if builtLetterIndices.count == target.count &&
            builtWord != target {
            wrongBuildWordAnimation()
        }
    }
    
    func deleteLastLetter() {
        guard !builtLetterIndices.isEmpty else { return }
        builtLetterIndices.removeLast()
    }
    
    func letterAt(_ index: Int) -> String {
        if index < builtLetterIndices.count {
            return currentGame.options[builtLetterIndices[index]]
        }
        return ""
    }
    
    func wrongBuildWordAnimation() {
        
        wrongGlow = true
        
        withAnimation(.default.repeatCount(3, autoreverses: true)) {
            shakeWord.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            
            withAnimation(.spring()) {
                builtLetterIndices = []
            }
            
            wrongGlow = false
            shakeWord = false
        }
    }
}

//
// MARK: FLOW
//
extension MiniGameView {
    
    func correctAnswer() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            showConfetti = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                showConfetti = false
                nextGame()
            }
        }
    }
    
    func resetTryAgain() {
        showWrongPopup = false
        selectedIndex = nil
        builtLetterIndices = []
    }
    
    func nextGame() {
        selectedIndex = nil
        builtLetterIndices = []
        
        if currentIndex < story.games.count - 1 {
            currentIndex += 1
        } else {
            showGameComplete = true
        }
    }
    
    func restartGame() {
        currentIndex = 0
        selectedIndex = nil
        builtLetterIndices = []
        showGameComplete = false
        animatePopup = false
    }
}

#Preview {
    NavigationStack {
        MiniGameView(
            story: sampleStories[0],
            selectedTab: .constant(.games),
            onFinish: {}
        )
    }
}
