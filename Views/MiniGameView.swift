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
//    @State private var showGameComplete = false
    
    @State private var shakeWord = false
    @State private var wrongGlow = false
    
    @State private var showExitAlert = false
    
    @State private var pressedIndex: Int? = nil
//    @State private var animatePopup = false
    
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
                            .foregroundColor(Color("PrimaryText"))
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
                    
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                    
                    VStack(spacing: isPad() ? 24 : 20) {
                        
                        Text("Nice Try!")
                            .font(.custom("OpenDyslexic-Bold", size: isPad() ? 22 : 20))
                            .foregroundColor(.black)

                        Text("Try again?")
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: isPad() ? 22 : 18
                                )
                            )
                            .foregroundColor(.black)

                        HStack(spacing: isPad() ? 18 : 14) {

                            Button {

                                resetTryAgain()

                            } label: {

                                Text("Try Again")

                                    .font(
                                        .custom(
                                            "OpenDyslexic-Bold",
                                            size: isPad() ? 18 : 16
                                        )
                                    )
                                    .foregroundColor(.black)
                                    .frame(width: isPad() ? 170 : 130,
                                           height: isPad() ? 54 : 46)
                                    .background(Color("ButtonSecondaryBackground"))
                                    .cornerRadius(14)
                            }

                            Button {

                                showWrongPopup = false
                                nextGame()

                            } label: {

                                Text("Continue →")

                                    .font(
                                        .custom(
                                            "OpenDyslexic-Bold",
                                            size: isPad() ? 18 : 16
                                        )
                                    )
                                    .foregroundColor(.black)
                                    .frame(width: isPad() ? 170 : 130,
                                           height: isPad() ? 54 : 46)
                                    .background(Color.yellow)
                                    .cornerRadius(14)
                            }
                        }
                    }
                    .padding(isPad() ? 42 : 30)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 14)
                    .frame(maxWidth: isPad() ? 560 : 360)
                    .padding(.horizontal, 30)
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
                .foregroundColor(Color("PrimaryText"))
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
                        .foregroundColor(Color("PrimaryText"))
                        .frame(
                            width: isPad() ? 84 : 68,
                            height: isPad() ? 84 : 68
                        )
                        .background(Color("SpeakerBackground"))
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(
                                Color("PrimaryText").opacity(0.15),
                                lineWidth: 1
                            )
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
                spacing: isPad() ? 28 : 18
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
                    .foregroundColor(Color("PrimaryText"))
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
                    ? (isPad() ? 1.05 : 1.04)
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
        
        return VStack(spacing: isPad() ? 52 : 34) {
            
            HStack(spacing: 12 * scale) {
                
                HStack(spacing: isPad() ? 14 : 10) {
                    
                    ForEach(0..<target.count, id: \.self) { i in
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                wrongGlow
                                ? Color.red.opacity(0.35)
                                : Color("VocabularyCard")
                            )
                            .frame(
                                width: isPad() ? 80 : 56,
                                height: isPad() ? 86 : 62
                            )
                            .overlay(
                                Text(letterAt(i))
                                    .font(
                                        .custom(
                                            "OpenDyslexic-Bold",
                                            size: isPad() ? 34 : 24
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
                        .foregroundColor(Color("PrimaryText"))
                        .frame(
                            width: isPad() ? 72 : 52,
                            height: isPad() ? 72 : 52
                        )
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
                            .frame(height: isPad() ? 64 : 54)
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {

                selectedTab = .home
                onFinish()
                goHome = true
            }
        }
    }
}
#Preview {
    
    NavigationStack {
        
        MiniGameView(
            story: sampleStories[1],
            selectedTab: .constant(.games),
            onFinish: {}
        )
    }
}

