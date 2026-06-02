import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    @State private var goToMoral = false
    @State private var lastScrolledLine = 0
    
    @StateObject private var audioManager = AudioManager.shared
    
    var body: some View {
        
        let page = story.pages[currentPage]
        
        GeometryReader { geo in
            
            let isIPad =
            UIDevice.current.userInterfaceIdiom == .pad
            
            VStack(spacing: 0) {
                
                // MARK: - IMAGE
                
                Image(page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geo.size.width,
                        height: isIPad
                        ? geo.size.height * 0.70
                        : geo.size.height * 0.56
                    )
                    .offset(y: page.imageOffset)
                
                Spacer(minLength: 0)
                
                // MARK: - CONTENT
                
                VStack(spacing: isIPad ? 20 : 16) {
                    
                    // MARK: - CONTROLS
                    
                    // MARK: - CONTROLS

                    HStack(spacing: 8) {
                        
                        Button {
                            
                            if audioManager.isPlaying {
                                
                                audioManager.pause()
                                
                            } else if audioManager.isPaused {
                                
                                audioManager.resume()
                                
                            } else {
                                
                                audioManager.play(
                                    audioName: page.audioName,
                                    text: page.text,
                                    speed: speed
                                )
                            }
                            
                        } label: {
                            
                            Image(
                                systemName:
                                    audioManager.isPlaying
                                    ? "pause.fill"
                                    : audioManager.isPaused
                                    ? "play.fill"
                                    : "speaker.wave.2.fill"
                            )
                            .font(
                                .system(
                                    size: isIPad ? 22 : 18,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                Color(uiColor: .label)
                            )
                            .frame(
                                width: isIPad ? 52 : 46,
                                height: 46
                            )
                        }
                        
                        HStack {
                            
                            // MINUS
                            
                            Button {
                                
                                if speed > 0.5 {
                                    
                                    speed -= 0.25
                                    
                                    if audioManager.isPlaying {
                                        
                                        audioManager.play(
                                            audioName: page.audioName,
                                            text: page.text,
                                            speed: speed
                                        )
                                    }
                                }
                                
                            } label: {
                                
                                Text("−")
                                    .font(
                                        .system(
                                            size: isIPad ? 20 : 16,
                                            weight: .bold
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(uiColor: .label)
                                    )
                                    .frame(width: 54, height: 30)
                                    .contentShape(Rectangle())
                            }
                            
                            Spacer(minLength: 0)
                            
                            Text(
                                "\(String(format: "%.1fx", speed))"
                            )
                            .font(
                                .system(
                                    size: isIPad ? 15 : 13,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(
                                Color(uiColor: .label)
                            )
                            
                            Spacer(minLength: 0)
                            
                            // PLUS
                            
                            Button {
                                
                                if speed < 1.5 {
                                    
                                    speed += 0.25
                                    
                                    if audioManager.isPlaying {
                                        
                                        audioManager.play(
                                            audioName: page.audioName,
                                            text: page.text,
                                            speed: speed
                                        )
                                    }
                                }
                                
                            } label: {
                                
                                Text("+")
                                    .font(
                                        .system(
                                            size: isIPad ? 20 : 16,
                                            weight: .bold
                                        )
                                    )
                                    .foregroundStyle(
                                        Color(uiColor: .label)
                                    )
                                    .frame(width: 44, height: 30)
                                    .contentShape(Rectangle())
                            }
                        }
                        .frame(
                            width: isIPad ? 240 : 180,
                            height: 46
                        )
                    }
                    .padding(.horizontal, isIPad ? 18 : 12)
                    .frame(height: isIPad ? 58 : 46)
                    .background(
                        SpeedControlBackground(
                            themeColor: story.theme.primary
                        )
                    )
                    
                    // MARK: - TEXT
                    
                    ScrollViewReader { proxy in
                        
                        ScrollView(showsIndicators: false) {
                            
                            NarratedTextView(
                                text: page.text,
                                currentWordIndex:
                                    audioManager.currentWordIndex,
                                themeColor: story.theme.primary,
                                isIPad: isIPad
                            )
//                            .id(audioManager.currentWordIndex)
                            .frame(
                                maxWidth: isIPad ? 720 : .infinity,
                                alignment: .leading
                            )
                            .padding(.horizontal, isIPad ? 18 : 2)
                            .padding(.bottom, 8)
                        }
                        .frame(maxWidth: .infinity)
                        
                        .onChange(
                            of: audioManager.currentWordIndex
                        ) { _, newValue in
                            
                            guard newValue >= 0 else { return }
                            
                            let lines =
                                page.text
                                    .components(separatedBy: "\n")
                                    .filter {
                                        !$0.trimmingCharacters(
                                            in: .whitespaces
                                        ).isEmpty
                                    }
                            
                            var runningCount = 0
                            var currentLine = 0
                            
                            for (index, line) in lines.enumerated() {
                                
                                let words =
                                    line
                                        .components(
                                            separatedBy: .whitespaces
                                        )
                                        .filter { !$0.isEmpty }
                                
                                runningCount += words.count
                                
                                if newValue < runningCount {
                                    currentLine = index
                                    break
                                }
                            }
                            
                            guard currentLine != lastScrolledLine else {
                                return
                            }
                            
                            lastScrolledLine = currentLine
                            
                            withAnimation(
                                .easeInOut(duration: 0.55)
                            ) {
                                
                                proxy.scrollTo(
                                    newValue,
                                    anchor: .center
                                )
                            }
                        }
                    }
                    
//                    Spacer(minLength: 0)
                    
                    // MARK: - SWIPE HINTS + FINISH

                    ZStack {
                        
                        HStack {
                            
                            Image(systemName: "arrow.left")
                                .font(
                                    .system(
                                        size: isIPad ? 34 : 26,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    Color.black.opacity(0.28)
                                )
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .font(
                                    .system(
                                        size: isIPad ? 34 : 26,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    Color.black.opacity(0.28)
                                )
                        }
                        
                        if currentPage == story.pages.count - 1 {
                            
                            HStack {
                                
                                Spacer()
                                
                                Button("Finish") {
                                    
                                    audioManager.stop()
                                    goToMoral = true
                                }
                                .buttonStyle(
                                    PrimaryButtonStyle(
                                        isActive: true,
                                        themeColor: .green
                                    )
                                )
                            }
                        }
                    }
                    .frame(height: isIPad ? 60 : 50)
                    .padding(.bottom, 2)
                    
                    // MARK: - PAGE DOTS
                    
                    HStack(spacing: 10) {
                        
                        ForEach(
                            0..<story.pages.count,
                            id: \.self
                        ) { index in
                            
                            Circle()
                                .fill(
                                    index == currentPage
                                    ? Color.white
                                    : Color.white.opacity(0.45)
                                )
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(
                        .bottom,
                        isIPad ? 12 : 8
                    )
                }
                .padding(.horizontal, isIPad ? 34 : 20)
                .padding(.top, isIPad ? 30 : 20)
                .padding(.bottom, isIPad ? 20 : 16)
                .frame(
                    maxWidth: .infinity,
                    alignment: .top
                )
                .background(
                    ZStack {
                        
                        // MAIN GRADIENT
                        
                        LinearGradient(
                            colors: [
                                story.theme.secondary,
                                story.theme.primary,
                                story.theme.primary.opacity(0.95)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        // TOP HIGHLIGHT
                        
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.22),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .center
                        )
                        
                        // BORDER
                        
                        RoundedRectangle(
                            cornerRadius:
                                isIPad ? 50 : 40,
                            style: .continuous
                        )
                        .stroke(
                            Color.white.opacity(0.35),
                            lineWidth: 1.2
                        )
                    }
                    .drawingGroup()
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius:
                            isIPad ? 50 : 40,
                        style: .continuous
                    )
                )
                .shadow(
                    color: Color.black.opacity(0.15),
                    radius: 10,
                    x: 0,
                    y: -5
                )
            }
            .frame(maxHeight: .infinity)
            .background(
                story.theme.primary
                    .opacity(0.9)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
            
            // MARK: - SWIPE
            
            .gesture(
                DragGesture()
                    .onEnded { value in
                        
                        let horizontalAmount =
                        value.translation.width
                        
                        if horizontalAmount < -50 {
                            
                            if currentPage <
                                story.pages.count - 1 {
                                
                                withAnimation(
                                    .interactiveSpring(
                                        response: 0.4,
                                        dampingFraction: 0.85
                                    )
                                ) {
                                    
                                    currentPage += 1
                                    audioManager.stop()
                                }
                                
                            } else {
                                
                                goToMoral = true
                            }
                        }
                        
                        if horizontalAmount > 50 {
                            
                            if currentPage > 0 {
                                
                                withAnimation(
                                    .interactiveSpring(
                                        response: 0.4,
                                        dampingFraction: 0.85
                                    )
                                ) {
                                    
                                    currentPage -= 1
                                    audioManager.stop()
                                }
                            }
                        }
                    }
            )
        }
        .navigationDestination(
            isPresented: $goToMoral
        ) {
            MoralView(story: story)
        }
    }
}

#Preview {
    StoryReaderView(
        story: sampleStories[1]
    )
}
