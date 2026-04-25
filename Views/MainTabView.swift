//==============================================================
// MainTabContainerView.swift
//==============================================================

import SwiftUI

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
                
                // TAB BAR ONLY ON ROOT SCREENS
                if selectedTab == .home ||
                    selectedTab == .games ||
                    selectedTab == .badges {
                    
                    PremiumTabBar(selectedTab: $selectedTab)
                        .padding(.bottom, 14)
                }
            }
        }
    }
}

// MARK: - TAB ITEMS

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

// MARK: - PREMIUM TAB BAR

struct PremiumTabBar: View {
    
    @Binding var selectedTab: TabItem
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(TabItem.allCases, id: \.self) { tab in
                
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                        selectedTab = tab
                    }
                } label: {
                    
                    ZStack {
                        
                        if selectedTab == tab {
                            Circle()
                                .fill(Color.white.opacity(0.95))
                                .frame(width: 46, height: 46)
                                .shadow(color: .black.opacity(0.10), radius: 5, y: 3)
                        }
                        
                        Image(systemName: tab.icon)
                            .font(.system(size: 21, weight: .semibold))
                            .foregroundColor(
                                selectedTab == tab
                                ? .black
                                : .black.opacity(0.38)
                            )
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
}

// MARK: - GAMES PAGE

struct GameHubView: View {
    
    let games = [
        ("Tap The Word", "hand.tap.fill", Color.yellow),
        ("Picture Match", "photo.fill", Color.green),
        ("Quiz Time", "questionmark.circle.fill", Color.blue),
        ("Memory Game", "brain.head.profile", Color.pink)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                
                Text("Games")
                    .font(.custom("OpenDyslexic-Regular", size: 30))
                    .tracking(5)
                    .padding(.top, 70)
                
                ForEach(games, id: \.0) { game in
                    HStack {
                        Image(systemName: game.1)
                            .font(.system(size: 25))
                        
                        Text(game.0)
                            .font(.custom("OpenDyslexic-Regular", size: 22))
                        
                        Spacer()
                        
                        Image(systemName: "play.fill")
                    }
                    .padding(.horizontal, 22)
                    .frame(height: 88)
                    .background(game.2.opacity(0.78))
                    .cornerRadius(22)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 120)
        }
    }
}

// MARK: - BADGES PAGE

struct BadgesView: View {
    
    var body: some View {
        Text("Badges")
            .font(.largeTitle)
    }
}

#Preview {
    MainTabContainerView()
}
