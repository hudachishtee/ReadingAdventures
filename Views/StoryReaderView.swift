import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    @State private var goToMoral = false
    
    @StateObject private var audioManager = AudioManager.shared

    var body: some View {
        let page = story.pages[currentPage]
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
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
                    HStack {
                        
                        // Listen Button
                        Button {
                            if audioManager.isPlaying {
                                audioManager.stop()
                            } else {
                                audioManager.play(
                                    audioName: page.audioName,
                                    speed: speed
                                )
                            }
                        } label: {
                            Text(audioManager.isPlaying ? "Pause" : "Listen")
                        }
                        .buttonStyle(
                            PrimaryButtonStyle(
                                isActive: audioManager.isPlaying,
                                themeColor: story.theme.primary
                            )
                        )
                        
                        Spacer()
                        
                        // Speed Control
                        VStack(spacing: 4) {
                            
                            HStack(spacing: 10) {
                                
                                Text("🐢")
                                    .font(.system(size: isIPad ? 20 : 16))
                                
                                Slider(
                                    value: $speed,
                                    in: 0.5...1.5,
                                    step: 0.25
                                )
                                .tint(story.theme.primary)
                                
                                Text("🐇")
                                    .font(.system(size: isIPad ? 20 : 16))
                            }
                            
                            Text("\(String(format: "%.1fx", speed))")
                                .font(.system(size: isIPad ? 14 : 12, weight: .medium))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .frame(width: isIPad ? 260 : 180)
                        .background(.ultraThinMaterial)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    }
                    
                    // MARK: - TEXT
                    ScrollView(showsIndicators: false) {
                        textContent(
                            page: page,
                            isIPad: isIPad
                        )
//                        .padding(.top, isIPad ? 20 : 10)
                        .padding(.bottom, 8)
                    }
                    
                    Spacer(minLength: 0)
                    
                    // MARK: - NAVIGATION
                    HStack {
                        
                        Button("Back") {
                            if currentPage > 0 {
                                currentPage -= 1
                                audioManager.stop()
                            }
                        }
                        .buttonStyle(
                            OutlineButtonStyle(
                                themeColor: story.theme.primary
                            )
                        )
                        
                        Spacer()
                        
                        Button(
                            currentPage == story.pages.count - 1
                            ? "Finish"
                            : "Next"
                        ) {
                            if currentPage < story.pages.count - 1 {
                                currentPage += 1
                                audioManager.stop()
                            } else {
                                audioManager.stop()
                                goToMoral = true
                            }
                        }
                        .buttonStyle(
                            OutlineButtonStyle(
                                themeColor: story.theme.primary
                            )
                        )
                    }
                    .padding(.bottom, 2)
                    
                    // MARK: - PAGE DOTS
                    HStack(spacing: 10) {
                        ForEach(0..<story.pages.count, id: \.self) { index in
                            Circle()
                                .fill(
                                    index == currentPage
                                    ? Color.white
                                    : Color.white.opacity(0.45)
                                )
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, isIPad ? 12 : 8)
                }
                .padding(isIPad ? 28 : 20)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(
                    ZStack {
                        LinearGradient(
                            colors: [
                                story.theme.secondary,
                                story.theme.primary,
                                story.theme.primary.opacity(0.95)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.25),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .center
                        )
                    }
                    .drawingGroup()
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: isIPad ? 50 : 40,
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
                story.theme.primary.opacity(0.9)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
            
            // MARK: - SWIPE
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let horizontalAmount = value.translation.width
                        
                        if horizontalAmount < -50 {
                            if currentPage < story.pages.count - 1 {
                                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.85)) {
                                    currentPage += 1
                                    audioManager.stop()
                                }
                            } else {
                                goToMoral = true
                            }
                        }
                        
                        if horizontalAmount > 50 {
                            if currentPage > 0 {
                                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.85)) {
                                    currentPage -= 1
                                    audioManager.stop()
                                }
                            }
                        }
                    }
            )
        }
        .navigationDestination(isPresented: $goToMoral) {
            MoralView(story: story)
        }
    }
    
    func textContent(page: Page, isIPad: Bool) -> some View {
        
        let lines = page.text
            .components(separatedBy: "\n")
            .filter {
                !$0.trimmingCharacters(in: .whitespaces).isEmpty
            }
        
        return VStack(
            alignment: .leading,
            spacing: isIPad ? 28 : 20
        ) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineSpacing(isIPad ? 10 : 6)
            }
        }
        .font(
            .custom(
                "OpenDyslexic-Regular",
                size: isIPad ? 26 : 18
            )
        )
        .tracking(-0.4)
        .foregroundColor(.appPrimaryText)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 5)
    }
}

#Preview {
    StoryReaderView(story: sampleStories[0])
}
