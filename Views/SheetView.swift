import SwiftUI

struct StoryPreviewSheet: View {
    
    let story: Story
    let onStart: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            let scale = Scale.factor(geo)
            
            ZStack {
                
                Color(red: 0.55, green: 0.7, blue: 0.8)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer().frame(height: 20 * scale)
                    
                    // TOP BAR
                    HStack {
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 40 * scale, height: 5 * scale)
                            .frame(maxWidth: .infinity)
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10 * scale)
                                .background(Color.white.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 20 * scale)
                    }
                    
                    Spacer().frame(height: 20 * scale)
                    
                    // IMAGE + TITLE
                    HStack(alignment: .top, spacing: 16 * scale) {
                        
                        Image(story.coverImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90 * scale, height: 90 * scale)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text(story.title)
                            .font(.custom("OpenDyslexic-Bold", size: 20 * scale))
                            .foregroundColor(.black)
                            .lineLimit(2)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24 * scale)
                    
                    Spacer()
                    
                    // DESCRIPTION
                    Text(story.shortDescription)
                        .font(.custom("OpenDyslexic-Regular", size: 20 * scale))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 350)
                    
                    Spacer()
                    
                    // START BUTTON (FIXED SIZE)
                    Button {
                        dismiss()
                        onStart()
                    } label: {
                        Text("START")
                            .font(.custom("OpenDyslexic-Bold", size: 22 * scale))
                            .foregroundColor(.black)
                            .frame(maxWidth: 300)
                            .padding(.vertical, 14 * scale)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(18)
                    }
                    
                    Spacer().frame(height: 20 * scale)
                }
            }
        }
    }
}
#Preview {
    ZStack {
        
        // Background (matches HomeView)
        LinearGradient(
            colors: [.bgTop, .bgBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        StoryPreviewSheet(
            story: sampleStories[0],
            onStart: {}   // ✅ REQUIRED (empty for preview)
        )
        .padding(.top, 200) // optional: makes it look like a sheet
    }
}
