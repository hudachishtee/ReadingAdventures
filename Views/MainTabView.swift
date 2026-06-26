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
                        DashboardView()
                        
                    case .games:
                        GameHubView(selectedTab: $selectedTab)
                        
                    case .vocabulary:
                        VocabularyHubView()
                        
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
    case vocabulary
    case badges
    
    var icon: String {
        switch self {
            
        case .home:
            return "house.fill"
            
        case .games:
            return "gamecontroller.fill"
            
        case .vocabulary:
            return "book.fill"
            
        case .badges:
            return "medal.fill"
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
    
    @Binding var selectedTab: TabItem
    
    @StateObject private var progress = ProgressManager.shared
    
    @State private var selectedStory: Story?
    @State private var lockedStory: Story?
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var isPhone: Bool {
        horizontalSizeClass == .compact
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        
        ZStack {
            
            //==================================================
            // BACKGROUND GRADIENT
            //==================================================
            
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            //==================================================
            // CONTENT
            //==================================================
            
            ScrollView {
                
                VStack(spacing: 40) {
                    
                    Spacer()
                    
                    Text("Story Games")
                        .font(.custom("OpenDyslexic-Bold", size: 25))
                        .foregroundColor(.appPrimaryText)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .fill(Color.appCardBackground.opacity(0.6))
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
                        .padding(.horizontal, 20)
                    
                    LazyVGrid(columns: columns, spacing: 25) {
                        
                        ForEach(sampleStories) { story in
                            
                            let unlocked = progress.isGameUnlocked(for: story)
                            
                            Button {
                                if unlocked {
                                    selectedStory = story
                                } else {
                                    lockedStory = story
                                }
                            } label: {
                                
                                gridItem(
                                    story: story,
                                    unlocked: unlocked
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 120)
                }
            }
        }
        
        //==================================================
        // NAVIGATION
        //==================================================
        
        .navigationDestination(isPresented: Binding(
            get: { selectedStory != nil },
            set: { if !$0 { selectedStory = nil } }
        )) {
            
            if let story = selectedStory {
                
                MiniGameView(
                    story: story,
                    selectedTab: $selectedTab,
                    onFinish: {}
                )
            }
        }
        
        //==================================================
        // CUSTOM LOCKED POPUP
        //==================================================
        
        .overlay {
            
            if let story = lockedStory {
                
                ZStack {
                    
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                lockedStory = nil
                            }
                        }
                    
                    VStack(spacing: 16) {
                        
                        Text("Locked Game")
                            .font(.headline)
                        
                        Circle()
                            .fill(Color.gray.opacity(0.35))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                            )
                        
                        Text(story.title)
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("Finish reading this story to unlock the game")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            withAnimation {
                                lockedStory = nil
                            }
                        } label: {
                            
                            Text("OK")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    Capsule()
                                        .fill(Color.gray.opacity(0.15))
                                )
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: 320)
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.white.opacity(0.96))
                    )
                    .shadow(radius: 20)
                    .padding(.horizontal, 30)
                }
                .transition(.opacity)
            }
        }
    }
}

//==============================================================
// GRID ITEM
//==============================================================

extension GameHubView {
    
    func gridItem(
        story: Story,
        unlocked: Bool
    ) -> some View {
        
        VStack(spacing: 10) {
            
            GeometryReader { geo in
                
                let width = geo.size.width
                let height = width * 0.62
                
                ZStack {
                    
                    Image(story.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(18)
                        .opacity(unlocked ? 1 : 0.35)
                    
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            Color.black.opacity(
                                unlocked ? 0.0 : 0.25
                            )
                        )
                    
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
            }
            .aspectRatio(1.0 / 0.62, contentMode: .fit)
            
            Text(story.title)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isPhone ? 15 : 19
                ))
                .foregroundColor(.black)
                .lineLimit(isPhone ? 2 : 1)
                .minimumScaleFactor(0.75)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .frame(height: isPhone ? 52 : 24)
        }
    }
}//==============================================================
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
