//==============================================================
// HomeView.swift (FILTER VERSION)
//==============================================================

import SwiftUI

struct HomeView: View {
    
    @State private var selectedStory: Story?
    @State private var navigateToReader = false
    @State private var storyForReader: Story?
    
    //==========================================================
    // FILTERS
    //==========================================================
    
    @State private var selectedFilter: String = "All"
    
    @ObservedObject private var progress = ProgressManager.shared
    
    //==========================================================
    // FILTERED STORIES
    //==========================================================
    
    var filteredStories: [Story] {
        
        switch selectedFilter {
            
        case "Beginner":
            return sampleStories.filter {
                $0.level == .beginner
            }
            
        case "Explorer":
            return sampleStories.filter {
                $0.level == .explorer
            }
            
        case "Advanced":
            return sampleStories.filter {
                $0.level == .advanced
            }
            
        case "Completed":
            return sampleStories.filter {
                progress.completedStories.contains($0.id)
            }
            
        default:
            return sampleStories
        }
    }
    
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
                    
                    //==================================================
                    // TITLE
                    //==================================================
                    
                    Text("Choose A Story")
                        .font(.custom("OpenDyslexic-Bold", size: 25))
                        .foregroundColor(.appPrimaryText)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .shadow(
                            color: Color.black.opacity(0.22),
                            radius: 25,
                            x: 0,
                            y: 10
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color.appCardBackground.opacity(0.72))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.white.opacity(0.45), lineWidth: 1.2)
                        )
                        .padding(.horizontal, 16)
                        .padding(
                            .bottom,
                            UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0
                        )
                    //==================================================
                    // FILTER BAR
                    //==================================================
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 12) {
                            
                            filterButton(title: "All")
                            
                            filterButton(title: "Beginner")
                            
                            filterButton(title: "Explorer")
                            
                            filterButton(title: "Advanced")
                            
                            if !progress.completedStories.isEmpty {
                                filterButton(title: "Completed")
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    //==================================================
                    // STORIES
                    //==================================================
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 25) {
                            
                            ForEach(filteredStories) { story in
                                
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
        
        //======================================================
        // NAVIGATION
        //======================================================
        
        .navigationDestination(isPresented: $navigateToReader) {
            
            if let story = storyForReader {
                StoryReaderView(story: story)
            }
        }
        
        //======================================================
        // STORY PREVIEW SHEET
        //======================================================
        
        .sheet(item: $selectedStory) { story in
            
            StoryPreviewSheet(
                story: story,
                onStart: {
                    
                    storyForReader = story
                    selectedStory = nil
                    
                    // IMPORTANT:
                    // Delay avoids SwiftUI race condition
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
    }
}

//==============================================================
// MARK: FILTER BUTTON
//==============================================================

extension HomeView {
    
    func filterButton(title: String) -> some View {
        
        Button {
            
            withAnimation(.spring(response: 0.3)) {
                selectedFilter = title
            }
            
        } label: {
            
            Text(title)
                .font(.custom("OpenDyslexic-Bold", size: 14))
                .foregroundColor(
                    selectedFilter == title
                    ? .black
                    : .appPrimaryText
                )
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(
                            selectedFilter == title
                            ? Color(
                                red: 0.36,
                                green: 0.56,
                                blue: 0.62
                            )
                            : Color(
                                UIColor { trait in
                                    trait.userInterfaceStyle == .dark
                                    ? UIColor.white.withAlphaComponent(0.18)
                                    : UIColor.white.withAlphaComponent(0.45)
                                }
                            )
                        )
                )
                .overlay(
                    Capsule()
                        .stroke(
                            Color.white.opacity(0.5),
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

//==============================================================
// MARK: PREVIEW
//==============================================================

#Preview {
    NavigationStack {
        HomeView()
    }
}
