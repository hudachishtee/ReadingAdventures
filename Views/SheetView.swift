import SwiftUI

struct StoryPreviewSheet: View {
    
    let story: Story
    let onStart: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.55, green: 0.7, blue: 0.8)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer().frame(height: 20)
                
                // TOP BAR
                HStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 5)
                        .frame(maxWidth: .infinity)
                }
                .overlay(alignment: .trailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                }
                
                Spacer().frame(height: 30)
                
                // IMAGE + TITLE
                HStack(alignment: .top, spacing: 16) {
                    
                    Image(story.previewImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(story.title)
                        .font(.custom("OpenDyslexic-Bold", size: 22))
                        .foregroundColor(.black)
                        .lineLimit(2)
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                Spacer().frame(height: 80)
                
                // DESCRIPTION
                Text(story.shortDescription)
                    .font(.custom("OpenDyslexic-Regular", size: 26))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 400)
                
                Spacer()
                
                // START BUTTON
                Button {
                    dismiss()
                    onStart()
                } label: {
                    Text("START")
                        .font(.custom("OpenDyslexic-Bold", size: 26))
                        .foregroundColor(.black)
                        .frame(maxWidth: 400)
                        .padding(.vertical, 18)
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(20)
                }
                
                Spacer().frame(height: 30)
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
