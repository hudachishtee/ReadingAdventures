import SwiftUI

struct StoryPreviewView: View {
    
    let story: Story
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            let isIPad = geo.size.width > 600
            
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
                            .padding(.vertical, 10 * scale)
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
                
                // ✅ PERFECT PADDING (device-aware)
                .padding(
                    EdgeInsets(
                        top: isIPad ? 30 : 20,
                        leading: isIPad ? 40 : 20,
                        bottom: isIPad ? 28 : 20,
                        trailing: isIPad ? 40 : 20
                    )
                )
                
                // ✅ FULL WIDTH (THIS FIXES YOUR MAIN ISSUE)
                .frame(width: geo.size.width)
                
                // ✅ FLEXIBLE HEIGHT (prevents text cutting)
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
                
                // ✅ POSITION (keeps your layout)
                .position(
                    x: geo.size.width / 2,
                    y: geo.size.height * 0.83
                )
            }
        }
    }
    
    // MARK: TEXT
    func previewText(_ text: String, scale: CGFloat) -> some View {
        
        let lines = text
            .components(separatedBy: "\n")
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        
        return VStack(alignment: .leading, spacing: max(12, 16 * scale)) {
            ForEach(lines, id: \.self) { line in
                Text(line)
                    .lineLimit(nil) // ✅ no "..."
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .font(.custom("OpenDyslexic-Regular", size: 16 * scale))
    }
}

// MARK: PREVIEW
#Preview {
    NavigationStack {
        StoryPreviewView(story: sampleStories[4])
    }
}
