import SwiftUI

struct MiniGameView: View {
    
    let story: Story
    @Binding var selectedTab: TabItem
    
    @Environment(\.dismiss) private var dismiss
    
    var onFinish: () -> Void
    
    @State private var currentIndex = 0
    @State private var selectedIndex: Int? = nil
    @State private var showCheckButton = false
    
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
                
                VStack(
                    spacing: isPad()
                        ? 24
                        : 18
                ) {
                    
                    Spacer()
                        .frame(height: geo.size.height * 0.06)                    // Header Card
                    Text("Story Game")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 34 : 22
                            )
                        )
                        .foregroundColor(Color("PrimaryText"))
                        .frame(
                            width: isIPad ? 420 : geo.size.width * 0.60,
                            height: isIPad ? 72 : 56
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color("CardBackground"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    Color("PrimaryText").opacity(0.08),
                                    lineWidth: 1
                                )
                        )
                    // Progress Bar with fraction
                    HStack(spacing: 12) {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.white.opacity(0.6))
                                .frame(height: 6)
                            let progress = CGFloat(currentIndex + 1) / CGFloat(max(story.games.count, 1))
                            Capsule()
                                .fill(Color.yellow)
                                .frame(width: (UIScreen.main.bounds.width - 120) * progress, height: 6)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Text("\(currentIndex + 1)/\(story.games.count)")
                            .font(.custom("OpenDyslexic-Regular", size: isIPad ? 18 : 14))
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.horizontal, isIPad ? 40 : 24)
                    .padding(.bottom, geo.size.height * 0.03)
                    .animation(.easeInOut(duration: 0.25), value: currentIndex)
                    
                    // MARK: Question Card
                    
                    highlightedQuestion(scale: scale)
                    Spacer()
                        .frame(height: isIPad ? 30 : 18)

                    Group {
                        if currentGame.type == .buildWord {
                            buildWordView(scale: scale)
                        } else {
                            optionsView(scale: scale)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer(minLength: 10)
                }
                
                // MARK: Wrong Popup
                
                if showWrongPopup {
                    
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 18) {
                        
                        Text("Nice Try!")
                            .font(.custom("OpenDyslexic-Bold", size: 24))
                            .foregroundColor(.black)

                        Text("Want to try again or continue?")
                            .font(.custom("OpenDyslexic-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
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
                            .foregroundColor(.black)

                        Text("You completed\n\(story.title)")
                            .font(.custom("OpenDyslexic-Regular", size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
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

        VStack(spacing: 14 * scale) {
            // Emphasized question text similar to screenshot
            Text(currentGame.question)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isPad() ? 38 : 26
                    )
                )
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
                .padding(.horizontal, isPad() ? 40 : 24)

            if let promptAudio = currentGame.promptAudio {
                Button {
                    AudioManager.shared.playSound(
                        named: promptAudio,
                        text: ""
                    )
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.system(size: isPad() ? 28 : 24, weight: .bold))
                        .foregroundColor(.black)
                        .frame(
                            width: isPad() ? 84 : 68,
                            height: isPad() ? 84 : 68
                        )
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.black.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(
                            color: Color.black.opacity(0.15),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                }
                .padding(.top, 8)
                .padding(.bottom, isPad() ? 10 : 4)
            }
        }
    }
    private func isPad() -> Bool { UIDevice.current.userInterfaceIdiom == .pad }
}
// MARK: Options View

extension MiniGameView {

    func optionsView(scale: CGFloat) -> some View {

        VStack(spacing: isPad() ? 18 : 26) {

            let options = currentGame.options

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: isPad() ? 20 : 12),
                    GridItem(.flexible())
                ],
                spacing: isPad() ? 22 : 14
            ) {

                ForEach(Array(options.enumerated()), id: \.offset) { index, option in

                    answerCard(
                        option: option,
                        index: index,
                        color: cardColor(for: index),
                        scale: scale
                    )
                }
            }

            Spacer()
                .frame(height: isPad() ? 32 : 0)

            Button {

                checkSelectedAnswer()

            } label: {

                Text("Check ✓")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isPad() ? 24 : 20
                        )
                    )
                    .foregroundColor(.black)
                    .frame(
                        width: isPad() ? 280 : 220,
                        height: isPad() ? 70 : 58
                    )
                    .background(
                        showCheckButton
                        ? Color.yellow
                        : Color.gray.opacity(0.35)
                    )
                    .cornerRadius(18)
                    .shadow(
                        color: Color.black.opacity(0.15),
                        radius: 6,
                        x: 0,
                        y: 3
                    )
            }
            .disabled(!showCheckButton)
            .opacity(showCheckButton ? 1 : 0.7)
        }
    }
    func cardColor(for index: Int) -> Color {

        switch index {

        case 0:
            return Color("MiniGameOption1")

        case 1:
            return Color("MiniGameOption2")

        case 2:
            return Color("MiniGameOption3")

        default:
            return Color("MiniGameOption4")
        }
    }

    func optionTapped(_ index: Int) {

        let option = currentGame.options[index]

        AudioManager.shared.playSound(
            named: option.audioName,
            text: ""
        )

        selectedIndex = index

        withAnimation(.spring()) {
            showCheckButton = true
        }
    }

    @ViewBuilder
    func answerCard(
        option: GameOption,
        index: Int,
        color: Color,
        scale: CGFloat
    ) -> some View {

        Button {

            optionTapped(index)

        } label: {

            Text(option.text)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isPad() ? 24 : 15
                    )
                )
                .foregroundColor(Color("PrimaryText"))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(
                    maxWidth: .infinity,
                    minHeight: isPad() ? 140 : 115
                )
                .background(color.opacity(0.9))
                .cornerRadius(24)
                .shadow(
                    color: Color.black.opacity(0.18),
                    radius: 10,
                    x: 0,
                    y: 4
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            selectedIndex == index
                            ? story.theme.primary
                            : Color.clear,
                            lineWidth: 4
                        )
                )
                .scaleEffect(
                    selectedIndex == index
                    ? 1.03
                    : 1.0
                )
                .animation(
                    .spring(
                        response: 0.35,
                        dampingFraction: 0.8
                    ),
                    value: selectedIndex
                )
        }
    }
}
// MARK: Build Word

extension MiniGameView {
    
    func buildWordView(scale: CGFloat) -> some View {
        
        let target = currentGame.correctAnswer
        
        return VStack(spacing: 24) {
            
            HStack(spacing: 12 * scale) {
                
                HStack(spacing: isPad() ? 8 : 6) {
                    
                    ForEach(0..<target.count, id: \.self) { i in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                wrongGlow
                                ? Color.red.opacity(0.35)
                                : Color("VocabularyCard")
                            )
                            .frame(
                                width: isPad() ? 42 : 34,
                                height: isPad() ? 48 : 42
                            )
                            .overlay(
                                Text(letterAt(i))
                                    .font(
                                        .custom(
                                            "OpenDyslexic-Bold",
                                            size: isPad() ? 22 : 18
                                        )
                                    )
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
                        .foregroundColor(.black)
                        .frame(width: 46, height: 46)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black.opacity(0.15), lineWidth: 1))
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
    
    func checkSelectedAnswer() {
        
        guard let selectedIndex else {
            return
        }
        
        let selectedText = currentGame.options[selectedIndex].text
        
        if selectedText == currentGame.correctAnswer {
            
            correctAnswer()
            
        } else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showWrongPopup = true
            }
        }
    }
    
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
        showCheckButton = false
    }
    
    func nextGame() {
        
        selectedIndex = nil
        builtLetterIndices = []
        showCheckButton = false
        
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
        showCheckButton = false
    }
}
#Preview {
    
    NavigationStack {
        
        MiniGameView(
            story: sampleStories[14],
            selectedTab: .constant(.games),
            onFinish: {}
        )
    }
}

