//==============================================================
// AchievementsView.swift
// FINAL WORKING VERSION
//==============================================================

import SwiftUI

struct AchievementsView: View {
    
    @ObservedObject var progress = ProgressManager.shared
    let stories: [Story]
    
    @State private var selectedStory: Story? = nil
    
    //==========================================================
    // GRID
    //==========================================================
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        
        ZStack {
            
            //==================================================
            // BACKGROUND
            //==================================================
            
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                //==================================================
                // TITLE
                //==================================================
                
                titleBanner
                    .padding(.top, 30)
                
                //==================================================
                // PROGRESS
                //==================================================
                
                progressCard
                
                //==================================================
                // GRID
                //==================================================
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(
                        columns: columns,
                        spacing: 16
                    ) {
                        
                        ForEach(stories) { story in
                            badgeItem(for: story)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    .padding(.bottom, 40)
                }
            }
        }
        .overlay {
            
            if let story = selectedStory {
                
                badgePopup(for: story)
//                    .transition(
//                        .scale.combined(with: .opacity)
//                    )
            }
        }
    }
}

//==============================================================
// MARK: COMPONENTS
//==============================================================

extension AchievementsView {
    
    //==========================================================
    // TITLE BANNER
    //==========================================================
    
    var titleBanner: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 26)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 1.0, green: 0.95, blue: 0.78),
                            Color(red: 1.0, green: 0.83, blue: 0.52)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 82)
            
            RoundedRectangle(cornerRadius: 26)
                .stroke(
                    Color.white.opacity(0.9),
                    lineWidth: 3
                )
                .frame(height: 82)
            
            HStack(spacing: 8) {
                
                Image(systemName: "star.fill")
                    .font(.system(size: 15))
                    .foregroundColor(.yellow)
                
                Text("My Achievements")
                    .font(.custom("OpenDyslexic-Bold", size: 20))
                    .foregroundColor(.black)
                
                Image(systemName: "star.fill")
                    .font(.system(size: 15))
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal, 20)
    }
    
    //==========================================================
    // PROGRESS CARD
    //==========================================================
    
    var progressCard: some View {
        
        let earned = progress.completedStories.count
        let total = stories.count
        
        return HStack {
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("You earned")
                    .font(.custom("OpenDyslexic-Regular", size: 13))
                    .foregroundColor(.appSecondaryText)
                
                Text("\(earned) / \(total)")
                    .font(.system(size: 34, weight: .heavy))
                    .foregroundColor(.appPrimaryText)
                
                Text("badges")
                    .font(.custom("OpenDyslexic-Regular", size: 12))
                    .foregroundColor(.appSecondaryText)
                
                ProgressView(
                    value: Double(earned),
                    total: Double(total)
                )
                .tint(.blue)
                .scaleEffect(y: 1.5)
                .padding(.top, 8)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                
                Image(systemName: "star.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                
                Text("Great job!")
                    .font(.custom("OpenDyslexic-Bold", size: 13))
                    .foregroundColor(.orange)
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.16, green: 0.30, blue: 0.22),
                            Color(red: 0.12, green: 0.22, blue: 0.17)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(
                    Color.white.opacity(0.18),
                    lineWidth: 2
                )
        )
        .shadow(
            color: .black.opacity(0.25),
            radius: 16,
            y: 8
        )
        .padding(.horizontal, 20)
    }
    
    //==========================================================
    // BADGE ITEM
    //==========================================================
    
    func badgeItem(for story: Story) -> some View {
        
        let unlocked = progress.completedStories.contains(story.id)
        
        return Button {
            
            withAnimation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.82
                )
            ) {
                selectedStory = story
            }
            
        } label: {
            
            Image(badgeImage(for: story))
                .resizable()
                .scaledToFit()
                .saturation(unlocked ? 1 : 0)
                .opacity(unlocked ? 1 : 0.5)
                .shadow(
                    color: unlocked
                    ? .yellow.opacity(0.12)
                    : .black.opacity(0.08),
                    radius: unlocked ? 18 : 8,
                    y: unlocked ? 10 : 4
                )
                .scaleEffect(unlocked ? 1 : 0.98)
        }
        .buttonStyle(.plain)
    }
    
    //==========================================================
    // POPUP
    //==========================================================
    
    func badgePopup(for story: Story) -> some View {
        
        let unlocked = progress.completedStories.contains(story.id)
        
        return ZStack {
            
            Color.black.opacity(0.25)                .ignoresSafeArea()
                .onTapGesture {
                    
                    withAnimation {
                        selectedStory = nil
                    }
                }
            
            VStack(spacing: 20) {
                
                Text(
                    unlocked
                    ? "Badge\nUnlocked!"
                    : "Locked Badge"
                )
                .font(.custom("OpenDyslexic-Bold", size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(.appPrimaryText)
                
                Image(badgeImage(for: story))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230)
                    .saturation(unlocked ? 1 : 0)
                    .opacity(unlocked ? 1 : 0.55)
                
                Text(
                    unlocked
                    ? "You completed this story!"
                    : "Finish this story to unlock this badge."
                )
                .font(.custom("OpenDyslexic-Regular", size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.appSecondaryText)
                .padding(.horizontal, 10)
            }
            .padding(28)
            .frame(width: 340)
            .background(
                RoundedRectangle(cornerRadius: 34)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.appCardBackground,
                                Color.appCardBackground.opacity(0.92)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 34)
                    .stroke(
                        Color.white.opacity(0.08),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: .black.opacity(0.35),
                radius: 30,
                y: 15
            )
        }
    }
    
    //==========================================================
    // BADGE IMAGE HELPER
    //==========================================================
    
    func badgeImage(for story: Story) -> String {
        
        switch story.title {
            
        case "The Extra Sandwich":
            return "story1_badge"
            
        case "The Brave Little Wave":
            return "story2_badge"
            
        case "The Sunset Promise":
            return "story3_badge"
            
        case "The Lost Crayon":
            return "story4_badge"
            
        case "Milo the Cat":
            return "story5_badge"
            
        case "The Quiet Moon":
            return "story6_badge"
            
        case "The Lost Little Bird":
            return "story7_badge"
            
        case "The Rainy Day Surprise":
            return "story8_badge"
            
        case "The Floating Balloon":
            return "story9_badge"
            
        case "The Slow and Steady Turtle":
            return "story10_badge"
            
        case "The Light in the Dark":
            return "story11_badge"
            
        case "The Missing Piece":
            return "story12_badge"
            
        case "The Brave Lantern":
            return "story13_badge"
            
        case "The Sky Painter":
            return "story14_badge"
            
        default:
            return "story1_badge"
        }
    }
}

//==============================================================
// MARK: PREVIEW
//==============================================================

#Preview {
    
    let progress = ProgressManager.shared
    
    progress.resetProgress()
    
    if let first = sampleStories.first {
        progress.completedStories.insert(first.id)
    }
    
    return AchievementsView(stories: sampleStories)
}
