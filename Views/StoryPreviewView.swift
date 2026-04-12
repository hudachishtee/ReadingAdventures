import SwiftUI

struct StoryPreviewView: View {
    
    let story: Story
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            
            ZStack {
                
                // MARK: IMAGE
                Image(story.previewImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .ignoresSafeArea()
                
                // MARK: CARD
                VStack(alignment: .leading, spacing: max(16, 20 * scale)) {
                    
                    Text(story.title)
                        .font(.custom("OpenDyslexic-Bold", size: 20 * scale))
                    
                    previewText(story.description, scale: scale)
                    
                    // MARK: BUTTON
                    NavigationLink(destination: StoryReaderView(story: story)) {
                        Text("READ NOW")
                            .font(.custom("OpenDyslexic-Bold", size: 18 * scale))
                            .foregroundColor(.black)
                            .frame(maxWidth: 240)
                            .padding(.vertical, 8 * scale)
                            .background(
                                LinearGradient(
                                    colors: [
                                        story.theme.secondary,
                                        story.theme.primary
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(10 * scale)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // ✅ SMART PADDING (balanced for iPhone + iPad)
                .padding(
                    EdgeInsets(
                        top: 30,
                        leading: min(40, 20 * scale),
                        bottom: 24,
                        trailing: min(24, 20 * scale)
                    )
                )
                
                // ✅ WIDTH (your “longer card” idea but controlled)
                .frame(
                    width: min(geo.size.width, 850) // 🔥 better than 850 (prevents weird stretch)
                )
                
                // ✅ FLEXIBLE HEIGHT (prevents text truncation)
                .frame(
                    maxHeight: geo.size.height * 0.5,
                    alignment: .top
                )
                
                // ✅ BACKGROUND
                .background(
                    LinearGradient(
                        colors: [
                            story.theme.secondary.opacity(0.95),
                            story.theme.primary.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                .clipShape(
                    RoundedRectangle(cornerRadius: 45 * scale, style: .continuous)
                )
                
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: -5)
                
                // ✅ POSITION (keeps your perfect layout)
                .position(
                    x: geo.size.width / 2,
                    y: geo.size.height * 0.83
                )
            }
        }
    }
    
    // MARK: TEXT BUILDER
    func previewText(_ text: String, scale: CGFloat) -> some View {
        
        let lines = text
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        return VStack(alignment: .leading, spacing: max(12, 16 * scale)) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .font(.custom("OpenDyslexic-Regular", size: 16 * scale))
        .frame(maxWidth: 420, alignment: .leading) // 🔥 improves readability (VERY important)
    }
}

// MARK: PREVIEW
#Preview {
    NavigationStack {
        StoryPreviewView(story: sampleStories[0])
    }
}
