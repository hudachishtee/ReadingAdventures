import SwiftUI

struct HomeView: View {
    
    @State private var selectedStory: Story?
    @State private var navigateToReader = false
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                ZStack {
                    
                    // BACKGROUND
                    LinearGradient(
                        colors: [.bgTop, .bgBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        // TITLE
                        Text("Choose A Story")
                            .font(.custom("OpenDyslexic-Bold", size: 25))
                            .foregroundColor(.appPrimaryText)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(Color.appCardBackground.opacity(0.6))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                        
                        // STORIES
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
                        
                        // TAB BAR
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
            
            // ✅ NAVIGATION TO READER
            .navigationDestination(isPresented: $navigateToReader) {
                if let selectedStory {
                    StoryReaderView(story: selectedStory)
                }
            }
        }
        
        // ✅ SHEET
        .sheet(item: $selectedStory) { story in
            StoryPreviewSheet(
                story: story,
                onStart: {
                    // 🔥 FIX: delay navigation until sheet fully closes
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        navigateToReader = true
                    }
                }
            )
            .presentationDetents([.large])
            .presentationCornerRadius(30)
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    HomeView()
}
