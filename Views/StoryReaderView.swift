import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    
    @ObservedObject var audioManager = AudioManager.shared
    
    var body: some View {
        let page = story.pages[currentPage]
        
        GeometryReader { geo in
            
            ZStack {
                
                // Background
                story.theme.primary.opacity(0.9)
                    .ignoresSafeArea()
                
                // MARK: - IMAGE (TOP)
                Image(page.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height,
                        alignment: .top
                    )
                    .ignoresSafeArea(edges: .top)
                
                // MARK: - CONTENT
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                        // MARK: CONTROLS
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
                            
                            HStack(spacing: 0) {
                                speedSegment("Slow", 0.75)
                                speedSegment("Normal", 1.0)
                                speedSegment("Fast", 1.5)
                            }
                            .padding(4)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .animation(.easeInOut(duration: 0.2), value: speed)
                        }
                        
                        // ✅ FIXED TEXT SECTION
                        Group {
                            if page.text.count > 80 {
                                ScrollView(showsIndicators: false) {
                                    textContent(page: page)
                                }
                            } else {
                                textContent(page: page)
                            }
                        }
                        .frame(maxHeight: 250)
                        
                        Spacer()
                        
                        // MARK: NAVIGATION
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
                        
                        // MARK: PAGE DOTS
                        HStack(spacing: 10) {
                            ForEach(0..<story.pages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage ? story.theme.primary : Color.gray.opacity(0.4))
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }
                    .padding(20)
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height * 0.5
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
    
    // ✅ CLEAN TEXT BUILDER
    func textContent(page: Page) -> some View {
        
        let lines = page.text
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        return VStack(alignment: .leading, spacing: 20) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineSpacing(6)
            }
        }
        .font(.custom("OpenDyslexic-Regular", size: 17.2))
        .tracking(-0.5)
        .foregroundColor(.appPrimaryText)
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.vertical, 9)
    }
    
    // MARK: - SPEED SEGMENT
    func speedSegment(_ title: String, _ value: Float) -> some View {
        Text(title)
            .font(.custom("OpenDyslexic-Bold", size: 13))
            .foregroundColor(.black)
            .frame(width: 75, height: 38)
            .background(
                ZStack {
                    if speed == value {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        story.theme.primary,
                                        story.theme.primary.opacity(0.7)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                }
            )
            .onTapGesture {
                speed = value
            }
    }
}

// MARK: - PREVIEW
#Preview {
    StoryReaderView(story: sampleStories[3])
}
