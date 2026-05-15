import SwiftUI

struct StoryCard: View {
    
    let story: Story
    let onPreview: () -> Void   // ✅ NEW
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // MARK: IMAGE
            Image(story.coverImage)
                .resizable()
                .aspectRatio(2.5, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
                .shadow(radius: 5)
            
            // MARK: TITLE
            Text(story.title)
                .font(.custom("OpenDyslexic-Bold", size: 20))
                .foregroundColor(.appPrimaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            // MARK: BOTTOM ROW
            HStack {
                
                Text(story.level.rawValue + " 🌱")
                    .font(.custom("OpenDyslexic-Regular", size: 12))
                    .foregroundColor(
                        Color(
                            UIColor { trait in
                                trait.userInterfaceStyle == .dark
                                ? .white
                                : .black
                            }
                        )
                    )                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(
                                Color(
                                    UIColor { trait in
                                        trait.userInterfaceStyle == .dark
                                        ? UIColor.black.withAlphaComponent(0.22)
                                        : UIColor.white.withAlphaComponent(0.4)
                                    }
                                )
                            )
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                Color.white.opacity(0.55),
                                lineWidth: 1
                            )
                    )
                Spacer()
                
                // ✅ UPDATED BUTTON (NO NavigationLink)
                Button {
                    onPreview()
                } label: {
                    Text("Preview")
                        .font(.custom("OpenDyslexic-Bold", size: 18))
                        .foregroundColor(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .fill(
                                Color.appSecondaryText.opacity(0.7)
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .stroke(
                                Color.white.opacity(0.45),
                                lineWidth: 1.1
                            )
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(
            Color.appSecondaryText.opacity(0.15)
        )
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.25), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
        
        // MARK: iPad FIX
        .frame(maxWidth: 600)
        .frame(maxWidth: .infinity)
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
                onPreview: {} // ✅ REQUIRED
            )
        }
    }
}
