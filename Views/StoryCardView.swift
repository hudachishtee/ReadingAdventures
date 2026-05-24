import SwiftUI

struct StoryCard: View {
    
    let story: Story
    let onPreview: () -> Void
    
    var body: some View {
        
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        VStack(alignment: .leading, spacing: isPad ? 18 : 14) {
            
            //==================================================
            // IMAGE
            //==================================================
            
            ZStack(alignment: .topLeading) {
                
                Image(story.coverImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: isPad ? 270 : 170)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(isPad ? 28 : 22)
                
                Text(story.level.rawValue)
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isPad ? 15 : 12
                        )
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal, isPad ? 18 : 14)
                    .padding(.vertical, isPad ? 8 : 6)
                    .background(
                        Capsule()
                            .fill(
                                Color(
                                    red: 0.82,
                                    green: 0.90,
                                    blue: 1.0
                                )
                            )
                    )
                    .padding(isPad ? 16 : 12)
            }
            
            //==================================================
            // TITLE
            //==================================================
            
            Text(story.title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isPad ? 28 : 18
                    )
                )
                .foregroundColor(.black)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 4)
            
            //==================================================
            // BUTTON
            //==================================================
            
            Button {
                onPreview()
            } label: {
                
                Text("Preview")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isPad ? 22 : 18
                        )
                    )
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, isPad ? 14 : 12)
                    .background(
                        RoundedRectangle(
                            cornerRadius: isPad ? 18 : 14,
                            style: .continuous
                        )
                        .fill(
                            Color(
                                red: 0.33,
                                green: 0.49,
                                blue: 0.53
                            )
                        )
                    )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, isPad ? 28 : 18)
        }
        .padding(isPad ? 22 : 14)
        .background(
            RoundedRectangle(
                cornerRadius: isPad ? 34 : 26,
                style: .continuous
            )
            .fill(
                Color(
                    red: 0.56,
                    green: 0.74,
                    blue: 0.90
                )
                .opacity(0.55)
            )
        )
        .shadow(
            color: Color.blue.opacity(0.18),
            radius: isPad ? 16 : 10,
            x: 0,
            y: isPad ? 8 : 5
        )
        .padding(.horizontal, isPad ? 20 : 14)
        //==================================================
        // WIDTH CONTROL
        //==================================================
        
        .frame(maxWidth: isPad ? 760 : 500)        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        
        ZStack {
            
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            StoryCard(
                story: sampleStories[0],
                onPreview: {}
            )
        }
    }
}
