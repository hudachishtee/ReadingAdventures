import SwiftUI

struct StoryCard: View {
    
    let story: Story
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // IMAGE (FIXED)
            Image(story.imageName)
                .resizable()
                .aspectRatio(2.5, contentMode: .fill) // ✅ prevents zoom issues
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
                .shadow(radius: 5)
            
            // TITLE
            Text(story.title)
                .font(.custom("OpenDyslexic-Bold", size: 20))
                .foregroundColor(.appPrimaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            // BOTTOM ROW
            HStack {
                
                Text(story.level.rawValue + " 🌱")
                    .font(.custom("OpenDyslexic-Regular", size: 14))
                    .foregroundColor(.appSecondaryText)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.appCardBackground)
                    .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: StoryReaderView(story: story)) {
                    Text("Read Now")
                        .font(.custom("OpenDyslexic-Bold", size: 18))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Color.appSecondaryText.opacity(0.6)
                        )
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(
            Color.appSecondaryText.opacity(0.15)
        )
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.25), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
        
        // ✅ THIS FIXES iPad STRETCHING
        .frame(maxWidth: 600)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    
    ZStack {
        LinearGradient(
            colors: [.bgTop, .bgBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        StoryCard(story: sampleStories[0])
    }
}
