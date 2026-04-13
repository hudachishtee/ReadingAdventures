import SwiftUI

struct HomeView: View {
    
    @State private var selectedStory: Story?
    @State private var navigateToReader = false
    
    // ✅ NEW (holds story AFTER sheet closes)
    @State private var storyForReader: Story?
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                ZStack {
                    
                    LinearGradient(
                        colors: [.bgTop, .bgBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Text("Choose A Story")
                            .font(.custom("OpenDyslexic-Bold", size: 25))
                            .foregroundColor(.appPrimaryText)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(Color.appCardBackground.opacity(0.6))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                        
                        ScrollView {
                            VStack(spacing: 25) {
                                ForEach(sampleStories) { story in
                                    
                                    StoryCard(
                                        story: story,
                                        onPreview: {
                                            selectedStory = story
                                        }
                                    )
                                }
                            }
                            .padding(.bottom, 100)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "house.fill")
                            Spacer()
                            Image(systemName: "gamecontroller.fill")
                            Spacer()
                            Image(systemName: "medal.fill")
                        }
                        .font(.system(size: 22))
                        .foregroundColor(.appPrimaryText)
                        .padding(16)
                        .background(Color.appCardBackground.opacity(0.7))
                        .cornerRadius(30)
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: 600)
                    .frame(maxWidth: .infinity)
                }
            }
            
            // ✅ FIXED NAVIGATION
            .navigationDestination(isPresented: $navigateToReader) {
                if let story = storyForReader {
                    StoryReaderView(story: story)
                }
            }
        }
        
        .sheet(item: $selectedStory) { story in
            StoryPreviewSheet(
                story: story,
                onStart: {
                    
                    // ✅ SAVE STORY FIRST
                    storyForReader = story
                    
                    // ✅ CLOSE SHEET
                    selectedStory = nil
                    
                    // ✅ THEN NAVIGATE
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        navigateToReader = true
                    }
                }
            )
            .presentationDetents(
                UIDevice.current.userInterfaceIdiom == .pad
                ? [.large]
                : [.fraction(0.6)]
            )
            .presentationCornerRadius(30)
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeView()
}
