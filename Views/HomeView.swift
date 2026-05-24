//==============================================================
// HomeView.swift
// FINAL CLEAN VERSION
//==============================================================

import SwiftUI

struct HomeView: View {
    
    //==========================================================
    // STATES
    //==========================================================
    
    @State private var selectedStory: Story?
    @State private var navigateToReader = false
    @State private var storyForReader: Story?
    
    @State private var selectedFilter: String = "All"
    @State private var showMenu = false
    
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
            
        case "Not Completed":
            return sampleStories.filter {
                !progress.completedStories.contains($0.id)
            }
            
        default:
            return sampleStories
        }
    }
    
    //==========================================================
    // BODY
    //==========================================================
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack(alignment: .top) {
                
                //==================================================
                // BACKGROUND
                //==================================================
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                //==================================================
                // MAIN CONTENT
                //==================================================
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    //==================================================
                    // TITLE
                    //==================================================
                    
                    Text("Choose A Story")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: UIDevice.current.userInterfaceIdiom == .pad
                                ? 38
                                : 23
                            )
                        )
                        .foregroundColor(.appPrimaryText)
                        .padding(
                            UIDevice.current.userInterfaceIdiom == .pad
                            ? 28
                            : 14
                        )
                        .frame(maxWidth: .infinity)
                        .shadow(
                            color: Color.black.opacity(0.22),
                            radius: 25,
                            x: 0,
                            y: 10
                        )
                        .background(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .fill(
                                Color.appCardBackground.opacity(0.72)
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .stroke(
                                Color.white.opacity(0.45),
                                lineWidth: 1.2
                            )
                        )
                        .padding(.horizontal, 16)
                    
                    //==================================================
                    // FILTER AREA
                    //==================================================
                    
                    ZStack(alignment: .topTrailing) {
                        
                        HStack(spacing: 8) {
                            
                            //==========================================
                            // FILTER PILLS
                            //==========================================
                            
                            ScrollView(
                                .horizontal,
                                showsIndicators: false
                            ) {
                                
                                HStack(spacing: 12) {
                                    
                                    filterButton(title: "All")
                                    
                                    filterButton(title: "Beginner")
                                    
                                    filterButton(title: "Explorer")
                                    
                                    filterButton(title: "Advanced")
                                }
                                .padding(.leading, 14)
                                .padding(.vertical, 2)
                                .padding(.trailing, 8)
                            }
                            
                            //==========================================
                            // MENU BUTTON
                            //==========================================
                            
                            Button {
                                
                                withAnimation(
                                    .spring(
                                        response: 0.32,
                                        dampingFraction: 0.82
                                    )
                                ) {
                                    showMenu.toggle()
                                }
                                
                            } label: {
                                
                                ZStack {
                                    
                                    Circle()
                                        .stroke(
                                            showMenu
                                            ? Color.red
                                            : Color.black.opacity(0.65),
                                            lineWidth: 2.0
                                        )
                                        .frame(width: 38, height: 38)
                                    
                                    Image(systemName: "line.3.horizontal")
                                        .font(
                                            .system(
                                                size: 13,
                                                weight: .bold
                                            )
                                        )
                                        .foregroundColor(
                                            showMenu
                                            ? .red
                                            : .black.opacity(0.65)
                                        )
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(.trailing, 16)
                            .offset(x: -2, y: 2)
                        }
                        
                        //==================================================
                        // FLOATING DROPDOWN
                        //==================================================
                        
                        if showMenu {
                            
                            VStack(spacing: 0) {
                                
                                Button {
                                    
                                    withAnimation(.spring()) {
                                        selectedFilter = "Completed"
                                        showMenu = false
                                    }
                                    
                                } label: {
                                    
                                    Text("Completed")
                                        .font(
                                            .custom(
                                                "OpenDyslexic-Bold",
                                                size: 14
                                            )
                                        )
                                        .foregroundColor(
                                            .black.opacity(0.78)
                                        )
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 42)
                                }
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.35))
                                    .frame(height: 1)
                                    .padding(.horizontal, 12)
                                
                                Button {
                                    
                                    withAnimation(.spring()) {
                                        selectedFilter = "Not Completed"
                                        showMenu = false
                                    }
                                    
                                } label: {
                                    
                                    Text("Not Completed")
                                        .font(
                                            .custom(
                                                "OpenDyslexic-Bold",
                                                size: 14
                                            )
                                        )
                                        .foregroundColor(
                                            .black.opacity(0.78)
                                        )
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 42)
                                }
                            }
                            .frame(width: 176)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(
                                    cornerRadius: 18,
                                    style: .continuous
                                )
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: 18,
                                    style: .continuous
                                )
                                .stroke(
                                    Color.cyan.opacity(0.35),
                                    lineWidth: 1.2
                                )
                            )
                            .shadow(
                                color: .black.opacity(0.18),
                                radius: 16,
                                x: 0,
                                y: 10
                            )
                            .offset(x: -8, y: 58)
                            .zIndex(999999)
                        }
                    }
                    .zIndex(999999)
                    
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
        
        .navigationDestination(
            isPresented: $navigateToReader
        ) {
            
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
                    
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.1
                    ) {
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
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: UIDevice.current.userInterfaceIdiom == .pad
                        ? 16
                        : 13
                    )
                )
                .tracking(0.2)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .foregroundColor(.black)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(
                    ZStack {
                        
                        Capsule(style: .continuous)
                            .fill(
                                selectedFilter == title
                                ? Color(
                                    red: 0.35,
                                    green: 0.57,
                                    blue: 0.63
                                )
                                : Color.white.opacity(0.92)
                            )
                        
                        Capsule(style: .continuous)
                            .stroke(
                                selectedFilter == title
                                ? Color.black.opacity(0.10)
                                : Color.white.opacity(0.75),
                                lineWidth: 0.9
                            )
                        
                        if selectedFilter == title {
                            
                            Capsule(style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.18),
                                            .clear
                                        ],
                                        startPoint: .top,
                                        endPoint: .center
                                    )
                                )
                                .padding(.horizontal, 0.5)
                                .padding(.vertical, 0.5)
                                .blendMode(.plusLighter)
                        }
                    }
                )
                .shadow(
                    color: .black.opacity(0.12),
                    radius: 5,
                    x: 0,
                    y: 3
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
