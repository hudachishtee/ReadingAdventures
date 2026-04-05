//
//  StoryCardView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 05/04/2026.
//

import SwiftUI

struct StoryCard: View {
    
    let story: Story
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            // IMAGE
            Image(story.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)
            
            // TITLE
            Text(story.title)
                .font(.custom("OpenDyslexic-Bold", size: 20))
                .foregroundColor(.black)
            
            // BOTTOM ROW
            HStack {
                
                Text(story.level.rawValue + " 🌱")
                    .font(.custom("OpenDyslexic-Regular", size: 14))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: StoryReaderView(story: story)) {
                    Text("Read Now")
                        .font(.custom("OpenDyslexic-Bold", size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.5))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.green.opacity(0.25))
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }
}
#Preview("Story Card") {
    
    ZStack {
        LinearGradient(
            colors: [
                .appLightBlue,
                .appPrimaryBlue
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        StoryCard(story: sampleStories[0])
    }
}
