import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    @State private var goToMoral = false
    
    @ObservedObject var audioManager = AudioManager.shared
    
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
//                    .clipped()
                
                // MARK: - CONTENT
                VStack(spacing: isIPad ? 20 : 16) {
                    
                    // MARK: - CONTROLS
                    HStack {
                        
                        Button(audioManager.isPlaying ? "Pause" : "Listen") {
                            if audioManager.isPlaying {
                                audioManager.stop()
                            } else {
                                audioManager.play(audioName: page.audioName, speed: speed)
                            }
                        }
                        .buttonStyle(
                            PrimaryButtonStyle(
                                isActive: audioManager.isPlaying,
                                themeColor: story.theme.primary
                            )
                        )
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            
                            Text("🐢")
                                .font(.system(size: isIPad ? 20 : 16))
                            
                            Slider(value: $speed, in: 0.5...1.5, step: 0.25)
                                .tint(story.theme.primary)
                            
                            Text("🐇")
                                .font(.system(size: isIPad ? 20 : 16))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .frame(width: isIPad ? 260 : 180)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    // MARK: - TEXT
                    ScrollView(showsIndicators: false) {
                        textContent(page: page, isIPad: isIPad)
                            .padding(.top, isIPad ? 20 : 10)
                            .padding(.bottom, 20)
                    }
                    
                    // MARK: - NAVIGATION
                    HStack {
                        
                        Button("Back") {
                            if currentPage > 0 {
                                currentPage -= 1
                                audioManager.stop()
                            }
                        }
                        .buttonStyle(
                            OutlineButtonStyle(themeColor: story.theme.primary)
                        )
                        
                        Spacer()
                        
                        Button(currentPage == story.pages.count - 1 ? "Finish" : "Next") {
                            if currentPage < story.pages.count - 1 {
                                currentPage += 1
                                audioManager.stop()
                            } else {
                                audioManager.stop()
                                goToMoral = true
                            }
                        }
                        .buttonStyle(
                            OutlineButtonStyle(themeColor: story.theme.primary)
                        )
                    }
                    
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
                .frame(
                    width: geo.size.width,
                    height: isIPad
                        ? geo.size.height * 0.34
                        : geo.size.height * 0.44
                )
                .background(
                    ZStack {
                        LinearGradient(
                            colors: [
                                story.theme.secondary.opacity(0.95),
                                story.theme.primary.opacity(0.9)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.35),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .center
                        )
                    }
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: isIPad ? 50 : 40, style: .continuous)
                )
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: -5)
            }
            .background(
                story.theme.primary.opacity(0.9)
                    .ignoresSafeArea()
            )
            .ignoresSafeArea()
        }
        .navigationDestination(isPresented: $goToMoral) {
            MoralView(story: story)
        }
    }
    
    func textContent(page: Page, isIPad: Bool) -> some View {
        
        let lines = page.text
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        return VStack(alignment: .leading, spacing: isIPad ? 28 : 20) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineSpacing(isIPad ? 10 : 6)
            }
        }
        .font(.custom(
            "OpenDyslexic-Regular",
            size: isIPad ? 26 : 18
        ))
        .tracking(-0.4)
        .foregroundColor(.appPrimaryText)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 8)
    }
}

#Preview {
    StoryReaderView(story: sampleStories[13])
}
