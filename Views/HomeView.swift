//==============================================================
// HomeView.swift
//==============================================================

import SwiftUI

struct HomeView: View {
    
    @State private var selectedStory: Story?
    @State private var navigateToReader = false
    @State private var storyForReader: Story?
    
    var body: some View {
        
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
                    
                    ScrollView(showsIndicators: false) {
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
                        .padding(.horizontal, 16)
                        .padding(.bottom, 120)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
        }
        
        // MARK: Navigate to Story Reader
        .navigationDestination(isPresented: $navigateToReader) {
            if let story = storyForReader {
                StoryReaderView(story: story)
            }
        }
        
        // MARK: Story Preview Sheet
        .sheet(item: $selectedStory) { story in
            
            StoryPreviewSheet(
                story: story,
                onStart: {
                    
                    storyForReader = story
                    selectedStory = nil
                    
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
        }
        
        // MARK: Reset Navigation State When Returning Home
        .onAppear {
            navigateToReader = false
            storyForReader = nil
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
