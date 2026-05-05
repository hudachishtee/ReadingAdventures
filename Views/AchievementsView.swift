//==============================================================
// AchievementsView.swift (FINAL PREMIUM SAFE VERSION)
//==============================================================

import SwiftUI

struct AchievementsView: View {
    
    @ObservedObject var progress = ProgressManager.shared
    let stories: [Story]
    
    @State private var selectedStory: Story? = nil
    
    // ✅ CHANGED: 2 columns instead of 3
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Text("My Achievements")
                    .font(.custom("OpenDyslexic-Bold", size: 32))
                    .padding(.top, 20)
                
                progressCard
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) { // slight spacing tweak
                        ForEach(stories) { story in
                            badgeItem(for: story)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            
            if let story = selectedStory {
                badgePopup(for: story)
            }
        }
    }
}

//==============================================================
// MARK: - Components
//==============================================================

extension AchievementsView {
    
    // MARK: Progress Card
    var progressCard: some View {
        let earned = progress.completedStories.count
        let total = stories.count
        
        return VStack(spacing: 10) {
            
            Text("You earned")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("\(earned) / \(total)")
                .font(.system(size: 34, weight: .bold))
            
            Text("badges")
                .font(.caption)
                .foregroundColor(.gray)
            
            ProgressView(value: Double(earned), total: Double(total))
                .tint(.blue)
                .padding(.top, 6)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: Badge Item
    func badgeItem(for story: Story) -> some View {
        let unlocked = progress.completedStories.contains(story.id)
        let color = story.theme.primary
        
        return Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                selectedStory = story
            }
        } label: {
            
            VStack(spacing: 12) {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 22)
                        .fill(
                            unlocked
                            ? color.opacity(0.25)
                            : Color.white.opacity(0.4)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(
                                    unlocked
                                    ? color.opacity(0.6)
                                    : Color.clear,
                                    lineWidth: 2
                                )
                        )
                        .shadow(
                            color: unlocked
                            ? color.opacity(0.4)
                            : .black.opacity(0.05),
                            radius: unlocked ? 12 : 4,
                            y: 5
                        )
                        .frame(height: 150) // ✅ CHANGED (was 120)
                    
                    VStack(spacing: 12) {
                        
                        ZStack {
                            Circle()
                                .fill(unlocked ? color : Color.gray.opacity(0.3))
                                .overlay(
                                    Circle()
                                        .stroke(
                                            unlocked ? color.opacity(0.5) : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                                .frame(width: 68, height: 68) // ✅ CHANGED (was 58)
                                .shadow(
                                    color: unlocked ? color.opacity(0.5) : .clear,
                                    radius: 8
                                )
                            
                            Image(systemName: unlocked ? icon(for: story) : "lock.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .bold)) // slightly bigger
                        }
                        
                        Text(story.title)
                            .font(.custom("OpenDyslexic-Regular", size: 14)) // slight bump
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(.black)
                            .opacity(unlocked ? 1 : 0.45)
                    }
                }
                .opacity(unlocked ? 1 : 0.6)
                .scaleEffect(unlocked ? 1 : 0.95)
                .animation(.spring(), value: unlocked)
            }
        }
    }
    
    // MARK: Popup
    func badgePopup(for story: Story) -> some View {
        let unlocked = progress.completedStories.contains(story.id)
        let color = story.theme.primary
        
        return ZStack {
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    selectedStory = nil
                }
            
            VStack(spacing: 16) {
                
                Text(unlocked ? "Badge Unlocked!" : "Locked Badge")
                    .font(.headline)
                
                Circle()
                    .fill(unlocked ? color : Color.gray.opacity(0.4))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: unlocked ? icon(for: story) : "lock.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                    )
                    .shadow(color: unlocked ? color.opacity(0.5) : .clear, radius: 10)
                
                Text(story.title)
                    .font(.title3)
                    .bold()
                
                Text(
                    unlocked
                    ? "You completed this story 🎉"
                    : "Finish this story to unlock this badge"
                )
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding()
            .frame(width: 260)
            .background(Color.white)
            .cornerRadius(22)
        }
    }
    
    // MARK: Icon Helper
    func icon(for story: Story) -> String {
        switch story.category {
        case .moral:
            return "heart.fill"
        case .adventure:
            return "star.fill"
        case .fantasy:
            return "sparkles"
        }
    }
}

//==============================================================
// MARK: Preview
//==============================================================

#Preview {
    let progress = ProgressManager.shared
    
    progress.resetProgress()
    
    if let first = sampleStories.first {
        progress.completedStories.insert(first.id)
    }
    
    return AchievementsView(stories: sampleStories)
}
