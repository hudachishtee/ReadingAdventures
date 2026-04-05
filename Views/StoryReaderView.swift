import SwiftUI

struct StoryReaderView: View {
    
    let story: Story
    
    @State private var currentPage = 0
    @State private var speed: Float = 1.0
    
    @ObservedObject var audioManager = AudioManager.shared
    
    var body: some View {
        let page = story.pages[currentPage]
        
        ZStack {
            
            // MARK: - FULL WIDTH IMAGE
            Image("story1_page1") // 👈 make sure your model has this
                .resizable()
                .scaledToFill()
                .frame(height: 800)
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: .top)
            
            // MARK: - BOTTOM CARD
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    
                    // MARK: CONTROLS
                    HStack(spacing: 12) {
                        
                        // Listen Button
                        Button(audioManager.isPlaying ? "Pause" : "Listen") {
                            if audioManager.isPlaying {
                                audioManager.stop()
                            } else {
                                audioManager.play(audioName: page.audioName, speed: speed)
                            }
                        }
                        .font(.custom("OpenDyslexic-Bold", size: 16))
                        .foregroundColor(.black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(
                            LinearGradient(
                                colors: [Color.yellow, Color.orange],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white.opacity(0.7), lineWidth: 1)
                        )
                        
                        // Speed Segmented Control
                        HStack(spacing: 0) {
                            speedSegment("Slow", 0.75)
                            speedSegment("Normal", 1.0)
                            speedSegment("Fast", 1.5)
                        }
                        .background(Color.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    
                    // MARK: STORY TEXT
                    Text(page.text)
                        .font(.custom("OpenDyslexic-Regular", size: 18))
                        .lineSpacing(14)
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
                    
                    // MARK: PAGE INDICATOR
                    HStack(spacing: 10) {
                        ForEach(0..<story.pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.blue : Color.gray.opacity(0.4))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                .padding(25)
                .frame(maxWidth: .infinity)
                .frame(height: 420)
                .background(
                    LinearGradient(
                        colors: [Color.orange, Color.yellow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                )
            }
        }
    }
    
    // MARK: - SEGMENT BUTTON
    func speedSegment(_ title: String, _ value: Float) -> some View {
        Button(title) {
            speed = value
        }
        .font(.custom("OpenDyslexic-Bold", size: 14))
        .foregroundColor(.black)
        .frame(minWidth: 70)
        .padding(.vertical, 10)
        .background(
            Group {
                if speed == value {
                    LinearGradient(
                        colors: [Color.yellow, Color.orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                } else {
                    Color.clear
                }
            }
        )
    }
}

#Preview {
    StoryReaderView(story: sampleStory)
}
