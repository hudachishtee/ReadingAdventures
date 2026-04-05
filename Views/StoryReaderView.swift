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
                
                // ✅ FIX 1: background to remove white bottom area
                Color.orange.opacity(0.9)
                    .ignoresSafeArea()
                
                // MARK: - IMAGE (TOP)
                Image("story1_page1")
                    .resizable()
                    .scaledToFit() // keep this
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height,
                        alignment: .top // ✅ THIS is the fix
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
                            .buttonStyle(PrimaryButtonStyle(isActive: audioManager.isPlaying))
                            Spacer()
                            
                            HStack(spacing: 0) {
                                speedSegment("Slow", 0.75)
                                speedSegment("Normal", 1.0)
                                speedSegment("Fast", 1.5)
                            }
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        // MARK: STORY TEXT
                        Text(page.text)
                            .font(.custom("OpenDyslexic-Regular", size: 16))
                            .lineSpacing(20)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        // MARK: NAVIGATION
                        HStack {
                            
                            Button("Back") {
                                if currentPage > 0 {
                                    currentPage -= 1
                                    audioManager.stop()
                                }
                            }
                            .buttonStyle(OutlineButtonStyle())
                            
                            Spacer()
                            
                            Button("Next") {
                                if currentPage < story.pages.count - 1 {
                                    currentPage += 1
                                    audioManager.stop()
                                }
                            }
                            .buttonStyle(OutlineButtonStyle())
                        }
                        
                        // MARK: PAGE DOTS
                        HStack(spacing: 10) {
                            ForEach(0..<story.pages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage ? Color.blue : Color.gray.opacity(0.4))
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
                                    Color.yellow.opacity(0.95),
                                    Color.orange.opacity(0.9)
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
            // ✅ FIX 2: removes top white safe area
            .ignoresSafeArea()
        }
    }
    
    // MARK: - SPEED SEGMENT
    func speedSegment(_ title: String, _ value: Float) -> some View {
        Button(title) {
            speed = value
        }
        .font(.custom("OpenDyslexic-Bold", size: 13))
        .foregroundColor(.black)
        .frame(width: 70, height: 35)
        .background(
            ZStack {
                if speed == value {
                    LinearGradient(
                        colors: [Color.yellow, Color.orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}

#Preview {
    StoryReaderView(story: sampleStory)
}
