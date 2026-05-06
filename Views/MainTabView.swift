import SwiftUI

//==============================================================
// MainTabContainerView
//==============================================================

struct MainTabContainerView: View {
    
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                
                Color(red: 0.56, green: 0.78, blue: 0.96)
                    .ignoresSafeArea()
                
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .games:
                        GameHubView()
                    case .badges:
                        BadgesView()
                    }
                }
                
                PremiumTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 14)
            }
        }
    }
}

//==============================================================
// TAB ITEMS
//==============================================================

enum TabItem: CaseIterable {
    case home
    case games
    case badges
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .games: return "gamecontroller.fill"
        case .badges: return "medal.fill"
        }
    }
}

//==============================================================
// TAB BAR (WAVE VERSION)
//==============================================================

struct PremiumTabBar: View {
    
    @Binding var selectedTab: TabItem
    @ObservedObject var progress = ProgressManager.shared
    
    @State private var wave = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(TabItem.allCases, id: \.self) { tab in
                
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                        selectedTab = tab
                        
                        if tab == .badges {
                            progress.markAchievementsAsSeen()
                            wave = false
                        }
                    }
                } label: {
                    
                    ZStack {
                        
                        if selectedTab == tab {
                            Circle()
                                .fill(Color.white.opacity(0.95))
                                .frame(width: 46, height: 46)
                                .shadow(color: .black.opacity(0.10), radius: 5, y: 3)
                        }
                        
                        ZStack {
                            
                            // 🌊 BADGES WAVE (STRONG)
                            if tab == .badges && progress.hasUnseenAchievements {
                                Circle()
                                    .fill(Color.red.opacity(0.19))
                                    .frame(width: 100, height: 100)
                                    .scaleEffect(wave ? 2.2 : 1)
                                    .opacity(wave ? 0 : 0.9)
                            }
                            
                            // 🌊 GAMES WAVE (SUBTLE)
                            if tab == .games && progress.hasUnseenAchievements {
                                Circle()
                                    .fill(Color.blue.opacity(0.12))
                                    .frame(width: 30, height: 30)
                                    .scaleEffect(wave ? 2.0 : 1)
                                    .opacity(wave ? 0 : 0.5)
                            }
                            
                            Image(systemName: tab.icon)
                                .font(.system(size: 21, weight: .semibold))
                                .foregroundColor(
                                    selectedTab == tab
                                    ? .black
                                    : .black.opacity(0.38)
                                )
                            
                            // 🔴 Badge dot
                            if tab == .badges && progress.hasUnseenAchievements {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10, height: 10)
                                    .offset(x: 10, y: -10)
                            }
                        }
                        .onAppear {
                            startWaveIfNeeded()
                        }
                        .onChange(of: progress.hasUnseenAchievements) { _ in
                            startWaveIfNeeded()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                }
            }
        }
        .padding(.horizontal, 14)
        .frame(width: 300, height: 68)
        .background(
            Capsule()
                .fill(Color(red: 0.83, green: 0.91, blue: 0.78).opacity(0.95))
                .shadow(color: .black.opacity(0.10), radius: 10, y: 6)
        )
    }
    
    // MARK: Wave Animation
    
    private func startWaveIfNeeded() {
        guard progress.hasUnseenAchievements else {
            wave = false
            return
        }
        
        withAnimation(
            .easeOut(duration: 1.0)
            .repeatForever(autoreverses: false)
        ) {
            wave = true
        }
    }
}

//==============================================================
// GAME HUB (UNCHANGED)
//==============================================================

struct GameHubView: View {
    
    @StateObject private var progress = ProgressManager.shared
    @State private var selectedStory: Story?
    @State private var showLockedAlert = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
//        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 24) {
                
                Text("Story Games")
                    .font(.custom("OpenDyslexic-Regular", size: 28))
                    .tracking(3)
                    .padding(.top, 70)
                
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach(sampleStories) { story in
                        
                        let unlocked = progress.isGameUnlocked(for: story)
                        
                        Button {
                            if unlocked {
                                selectedStory = story
                            } else {
                                showLockedAlert = true
                            }
                        } label: {
                            gridItem(story: story, unlocked: unlocked)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer(minLength: 120)
            }
        }
        
        .navigationDestination(isPresented: Binding(
            get: { selectedStory != nil },
            set: { if !$0 { selectedStory = nil } }
        )) {
            if let story = selectedStory {
                MiniGameView(story: story, onFinish: {})
            }
        }
        
        .alert("Locked", isPresented: $showLockedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Finish reading the story to unlock this game")
        }
    }
}

//==============================================================
// GRID ITEM (UNCHANGED)
//==============================================================

extension GameHubView {
    
    func gridItem(story: Story, unlocked: Bool) -> some View {
        
        VStack(spacing: 10) {
            
            ZStack {
                
                Image(story.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(18)
                    .opacity(unlocked ? 1 : 0.35)
                
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.black.opacity(unlocked ? 0.0 : 0.25))
                
                if unlocked {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 120)
            
            Text(story.title)
                .font(.custom("OpenDyslexic-Regular", size: 13))
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

//==============================================================
// BADGES PAGE
//==============================================================

struct BadgesView: View {
    var body: some View {
        AchievementsView(stories: sampleStories)
    }
}

//==============================================================
// PREVIEW
//==============================================================

#Preview {
    MainTabContainerView()
}
