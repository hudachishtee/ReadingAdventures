import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    
    @ObservedObject var audioManager = AudioManager.shared
    
    var body: some View {
        let page = story.pages[currentPage]
        
        GeometryReader { geo in
            
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad

            ZStack {
                
                // Background
                story.theme.primary.opacity(0.9)
                    .ignoresSafeArea()
                
                // MARK: - IMAGE
                Image(page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: isIPad ? .fill : .fit)
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height,
                        alignment: .top
                    )
                    .clipped()
                    .ignoresSafeArea(edges: .top)
                
                // MARK: - CONTENT
                VStack {
                    
                    Spacer(minLength: isIPad ? geo.size.height * 0.55 : 0)
                    
                    VStack(spacing: UIDevice.current.userInterfaceIdiom == .pad ? 5 : 16) {
                        Spacer()
                        // MARK: CONTROLS
                        HStack {
                            
                            // Listen Button
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
                            
                            // ✅ CLEAN SLIDER (FIXED DESIGN)
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
                        
                        // TEXT
                        Group {
                            if page.text.count > 80 {
                                ScrollView(showsIndicators: false) {
                                    textContent(page: page)
                                        .padding(.top, isIPad ? 20 : 8)
                                }
                            } else {
                                textContent(page: page)
                                    .padding(.top, isIPad ? 12 : 8)
                            }
                        }
                        .frame(
                            maxWidth: .infinity,
                            minHeight: isIPad ? 180 : 150,
                            maxHeight: isIPad ? 180 : 150,
                            alignment: .top
                        )
                        
//                        Spacer()
                        
                        // NAVIGATION
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
                            
                            Button("Next") {
                                if currentPage < story.pages.count - 1 {
                                    currentPage += 1
                                    audioManager.stop()
                                }
                            }
                            .buttonStyle(
                                OutlineButtonStyle(themeColor: story.theme.primary)
                            )
                        }
                        
                        // PAGE DOTS
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
                    }
                    .padding(20)
                    .frame(
                        width: geo.size.width,
                        height: isIPad
                            ? geo.size.height * 0.32
                            : geo.size.height * 0.5
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
                        RoundedRectangle(cornerRadius: 45, style: .continuous)
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: -5)
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            .ignoresSafeArea()
        }
    }
    
    // MARK: - TEXT
    func textContent(page: Page) -> some View {
        let lines = page.text
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad
        
        return VStack(alignment: .leading, spacing: isIPad ? 28 : 20) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineSpacing(isIPad ? 10 : 6)
            }
        }
        .font(.custom(
            "OpenDyslexic-Regular",
            size: isIPad ? 24 : 17.2
        ))
        .tracking(-0.5)
        .foregroundColor(.appPrimaryText)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 9)
    }
}

#Preview {
    StoryReaderView(story: sampleStories[3])
}
