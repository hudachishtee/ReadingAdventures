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
    
    @State private var showExitAlert = false
    
    @State private var pressedIndex: Int? = nil
    @State private var animatePopup = false
    
    @State private var goHome = false
    
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
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if showConfetti {
                    ConfettiBackground()
                        .ignoresSafeArea()
                        .transition(.opacity)
                }
                
                // MARK: Exit Button
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            showExitAlert = true
                        } label: {
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 46, height: 46)
                                .background(Color.red)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    Spacer()
                }
                
                // MARK: Main Content
                
                VStack(spacing: 14 * scale) {
                    
                    Spacer().frame(height: isIPad ? 70 : 24);                    Text("Story Game")
                        .font(.custom("OpenDyslexic-Bold", size: isIPad ? 34 : 26))
                        .foregroundColor(.appPrimaryText)
                    
                    // MARK: Progress
                    
                    HStack(spacing: 10) {
                        
                        ForEach(0..<story.games.count, id: \.self) { index in
                            
                            Capsule()
                                .fill(index <= currentIndex ? .yellow : .white.opacity(0.55))
                                .frame(width: 24 * scale, height: 6)
                                .animation(.easeInOut(duration: 0.3), value: currentIndex)
                        }
                    }
                    
                    // MARK: Image
                    
                    Image(story.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width * 0.92,
                            height: isIPad ? 300 : 210
                        )
                        .clipped()
                        .cornerRadius(22)
                    
                    Spacer().frame(height: isIPad ? 55 : 34)
                    
                    // MARK: Question Card
                    
                    VStack(spacing: 18 * scale) {
                        
                        highlightedQuestion(scale: scale)
                        
                        // MARK: Prompt Audio
                        
                        if let promptAudio = currentGame.promptAudio,
                           currentGame.type != .listenAndChoose {
                            Button {
                                
                                AudioManager.shared.playSound(
                                    named: promptAudio,
                                    text: ""
                                )
                            } label: {
                                
                                HStack(spacing: 10) {
                                    
                                    Image(systemName: "speaker.wave.2.fill")
                                    
                                    Text("Hear Word")
                                }
                                .font(.custom("OpenDyslexic-Bold", size: 18))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .background(Color.orange)
                                .cornerRadius(18)
                            }
                        }
                        
                        if currentGame.type == .buildWord {
                            
                            buildWordView(scale: scale)
                            
                        } else {
                            
                            optionsView(scale: scale)
                        }
                    }
                    .padding(20 * scale)
                    .background(Color("MiniGameOuter")) .cornerRadius(26)
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
                
                // MARK: Complete Popup
                
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
                                
                                selectedTab = .home
                                onFinish()
                                goHome = true
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
        
        .fullScreenCover(isPresented: $goHome) {
            MainTabContainerView()
        }
        
        .alert("Leave Mini Game?", isPresented: $showExitAlert) {
            
            Button("Continue", role: .cancel) { }
            
            Button("Leave", role: .destructive) {
                
                selectedTab = .home
                onFinish()
                goHome = true
            }
        }
    }
}

// MARK: Highlighted Question

extension MiniGameView {
    
    func highlightedQuestion(scale: CGFloat) -> some View {
        
        Text(currentGame.question)
            .font(.custom("OpenDyslexic-Bold", size: 20 * scale))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
    }
}

// MARK: Options View

extension MiniGameView {
    
    func optionsView(scale: CGFloat) -> some View {
        
        VStack(spacing: 14 * scale) {
            
            ForEach(Array(currentGame.options.enumerated()), id: \.offset) { index, option in
                
                HStack(spacing: 12) {
                    
                    Button {
                        
                        AudioManager.shared.playSound(
                            named: option.audioName,
                            text: ""
                        )
                        
                    } label: {
                        
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                    
                    Button {
                        
                        pressedIndex = index
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                            
                            optionTapped(index)
                            pressedIndex = nil
                        }
                        
                    } label: {
                        
                        HStack {
                            
                            Text(option.text)
                                .font(.custom("OpenDyslexic-Regular", size: 18 * scale))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            if selectedIndex == index &&
                                option.text == currentGame.correctAnswer {
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                            
                            if selectedIndex == index &&
                                option.text != currentGame.correctAnswer {
                                
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 16)
                        .background(buttonColor(index))
                        .cornerRadius(18)
                        .scaleEffect(pressedIndex == index ? 0.96 : 1)
                        .animation(
                            .spring(response: 0.25, dampingFraction: 0.55),
                            value: pressedIndex
                        )
                    }
                }
            }
        }
    }
    
    func optionTapped(_ index: Int) {
        
        selectedIndex = index
        
        let selectedText = currentGame.options[index].text
        
        if selectedText == currentGame.correctAnswer {
            
            correctAnswer()
            
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                showWrongPopup = true
            }
        }
    }
    
    func buttonColor(_ index: Int) -> Color {
        
        let selectedText = currentGame.options[index].text
        
        if selectedIndex == index &&
            selectedText == currentGame.correctAnswer {
            
            return .green.opacity(0.85)
        }
        
        if selectedIndex == index &&
            selectedText != currentGame.correctAnswer {
            
            return .red.opacity(0.85)
        }
        
        return Color("MiniGameOption")    }
}

// MARK: Build Word

extension MiniGameView {
    
    func buildWordView(scale: CGFloat) -> some View {
        
        let target = currentGame.correctAnswer
        
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
                
                ForEach(Array(currentGame.options.enumerated()), id: \.offset) { index, option in
                    
                    let letter = option.text
                    let isUsed = builtLetterIndices.contains(index)
                    
                    Button {
                        
                        AudioManager.shared.playSound(
                            named: option.audioName,
                            text: ""
                        )
                        
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
        
        let target = currentGame.correctAnswer
        
        guard builtLetterIndices.count < target.count else {
            return
        }
        
        builtLetterIndices.append(index)
        
        let builtWord = builtLetterIndices.map {
            currentGame.options[$0].text
        }
        .joined()
        
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
        
        guard !builtLetterIndices.isEmpty else {
            return
        }
        
        builtLetterIndices.removeLast()
    }
    
    func letterAt(_ index: Int) -> String {
        
        if index < builtLetterIndices.count {
            return currentGame.options[builtLetterIndices[index]].text
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

// MARK: Flow

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
            story: sampleStories[13],
            selectedTab: .constant(.games),
            onFinish: {}
        )
    }
}
