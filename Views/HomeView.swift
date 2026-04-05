//
//  HomeView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 05/04/2026.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                LinearGradient(
                    colors: [
                        .appLightBlue,
                        .appPrimaryBlue
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // MARK: TITLE
                    Text("Choose A Story")
                        .font(.custom("OpenDyslexic-Bold", size: 26))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.appPrimaryBlue.opacity(0.35))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 25) {
                            
                            ForEach(sampleStories) { story in
                                StoryCard(story: story)
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    
                    Spacer()
                    
                    // MARK: BOTTOM BAR
                    HStack {
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "gamecontroller.fill")
                        Spacer()
                        Image(systemName: "medal.fill")
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
    }
}
#Preview("Home Screen") {
    HomeView()
}
