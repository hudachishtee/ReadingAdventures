//
//  VocabularyHubView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 07/06/2026.
//

import SwiftUI

struct VocabularyHubView: View {
    
    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // MARK: Background
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: isIPad ? 30 : 22) {
                        
                        Spacer()
                            .frame(height: isIPad ? 20 : 10)
                        
                        // MARK: Header
                        
                        VStack(spacing: 10) {
                            
                            Text("Vocabulary")
                                .font(.custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 34 : 27
                                ))
                                .foregroundColor(.appPrimaryText)
                                .padding(.horizontal, 28)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 22,
                                        style: .continuous
                                    )
                                    .fill(Color.appCardBackground)
                                )
                            
                            Spacer()
                                .frame(height: isIPad ? 40 : 10)
                            
                            Text("Learn new words from your stories!")
                                .font(.custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 28 : 16
                                ))
                                .foregroundColor(.appPrimaryText)
                                .multilineTextAlignment(.center)
                        }
                        
//                        Spacer()
//                            .frame(height: isIPad ?  : 1)
                        
                        // MARK: Vocabulary Stats
                        
                        HStack(spacing: isIPad ? 20 : 12) {

                            statCard(
                                icon: "star.fill",
                                iconColor: .yellow,
                                number: "12",
                                title: "Saved Words",
                                backgroundColor: Color("StoryCardBackground")
                            )

                            statCard(
                                icon: "book.fill",
                                iconColor: .orange,
                                number: "35",
                                title: "Words Learned",
                                backgroundColor: Color("StoryCardBackground")
                            )
                        }
                        .padding(.horizontal, isIPad ? 0 : -8)
                        
                        Spacer()
                            .frame(height: isIPad ? 20 : 12)
                        
                        // MARK: Flash Cards
                        
                        NavigationLink {
                            FlashCardPracticeView()
                        } label: {
                            
                            hubCard(
                                icon: "square.stack.3d.up.fill",
                                iconColor: .purple,
                                title: "Flash Card Practice",
                                subtitle: "Review all words from your stories",
                                backgroundColor: Color("MiniGameOption3")
                            )
                        }
                        .buttonStyle(.plain)
                        
                        // MARK: Saved Words
                        
                        NavigationLink {
                            SavedWordsView()
                        } label: {
                            
                            hubCard(
                                icon: "bookmark.fill",
                                iconColor: .brown,
                                title: "Saved Words",
                                subtitle: "Practice words you have saved",
                                backgroundColor: Color("MiniGameOption1")
                            )
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                            .frame(height: isIPad ? 20 : 10)
                        
                        Spacer(minLength: isIPad ? 80 : 60)
                    }
                    .padding(.horizontal, isIPad ? 40 : 20)
                    .padding(.top, 5)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: Hub Card
    
    private func hubCard(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String,
        backgroundColor: Color
    ) -> some View {
        
        HStack(spacing: 1) {
            
            Image(systemName: icon)
                .font(.system(size: isIPad ? 42 : 30))
                .foregroundColor(iconColor)
                .frame(width: isIPad ? 80 : 60)
            
            VStack(
                alignment: .leading,
                spacing: isIPad ? 10 : 6
            ) {
                
                Text(title)
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 24 : 17
                    ))
                    .foregroundColor(.appPrimaryText)
                
                Text(subtitle)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 20 : 14
                    ))
                    .foregroundColor(.appPrimaryText)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(
                    size: isIPad ? 22 : 18,
                    weight: .semibold
                ))
                .foregroundColor(.appPrimaryText)
        }
        .padding(.horizontal, isIPad ? 40 : 20)
        .padding(.vertical, isIPad ? 50 : 20)
        .frame(maxWidth: isIPad ? 950 : 650)
        .background(
            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
            .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: 28,
                style: .continuous
            )
            .stroke(
                Color.white.opacity(0.45),
                lineWidth: 1.2
            )
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            x: 0,
            y: 4
        )
    }
    
    // MARK: Stat Card
    
    private func statCard(
        icon: String,
        iconColor: Color,
        number: String,
        title: String,
        backgroundColor: Color
    ) -> some View {
        
        VStack(spacing: isIPad ? 8 : 4) {

            Image(systemName: icon)
                .font(.system(size: isIPad ? 34 : 24))
                .foregroundColor(iconColor)

            Text(number)
                .font(.custom(
                    "OpenDyslexic-Bold",
                    size: isIPad ? 28 : 18
                ))
                .foregroundColor(.appPrimaryText)

            Text(title)
                .font(.custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 18 : 13
                ))
                .foregroundColor(.appPrimaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, isIPad ? 24 : 16)
        .padding(.vertical, isIPad ? 20 : 16)
        .background(
            RoundedRectangle(
                cornerRadius: 22,
                style: .continuous
            )
            .fill(backgroundColor)
        )    }
}

#Preview {
    VocabularyHubView()
}
