//
//  StoryPreviewView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 09/04/2026.
//

import SwiftUI

struct StoryPreviewView: View {
    
    let story: Story
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                // MARK: BACKGROUND IMAGE
                Image(story.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .ignoresSafeArea()
                
                // MARK: TOP BAR
                VStack {
                    HStack {
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Text("Book Detail")
                            .font(.custom("OpenDyslexic-Bold", size: 18))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                        
                        Spacer()
                        
                        // Empty for symmetry
                        Circle().fill(Color.clear).frame(width: 36)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                // MARK: BOTTOM CARD
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text(story.title)
                            .font(.custom("OpenDyslexic-Bold", size: 22))
                            .foregroundColor(.black)
                        
                        Text(story.description)
                            .font(.custom("OpenDyslexic-Regular", size: 16))
                            .foregroundColor(.black.opacity(0.85))
                            .lineSpacing(6)
                        
                        // BUTTON
                        NavigationLink(destination: StoryReaderView(story: story)) {
                            Text("READ NOW")
                                .font(.custom("OpenDyslexic-Bold", size: 16))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(
                                    LinearGradient(
                                        colors: [
                                            story.theme.secondary,
                                            story.theme.primary
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(14)
                        }
                        .padding(.top, 10)
                    }
                    .padding(20)
                    .frame(width: geo.size.width)
                    .background(
                        ZStack {
                            
                            // MAIN GRADIENT
                            LinearGradient(
                                colors: [
                                    story.theme.secondary.opacity(0.95),
                                    story.theme.primary.opacity(0.9)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            
                            // GLOSS EFFECT
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        }
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 40, style: .continuous)
                    )
                    .shadow(radius: 10)
                }
            }
        }
    }
}

