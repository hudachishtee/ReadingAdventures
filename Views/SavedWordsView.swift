//
//  SavedWordsView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 07/06/2026.
//

import SwiftUI

struct SavedWordsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var savedWordsManager = SavedWordsManager.shared
    @State private var searchText = ""
    @State private var wordToDelete: VocabularyWord?

    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    private var filteredWords: [VocabularyWord] {

        if searchText.isEmpty {
            return savedWordsManager.savedWords
        }

        return savedWordsManager.savedWords.filter {

            $0.word.localizedCaseInsensitiveContains(searchText) ||
            $0.meaning.localizedCaseInsensitiveContains(searchText)

        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: isIPad ? 24 : 18) {
                        
                        // MARK: Header
                        
                        HStack {
                            
                            Button {
                                dismiss()
                            } label: {
                                
                                ZStack {
                                    
                                    Circle()
                                        .fill(
                                            colorScheme == .dark
                                            ? Color.white.opacity(0.14)
                                            : Color.white.opacity(0.75)
                                        )
                                        .frame(
                                            width: isIPad ? 56 : 42,
                                            height: isIPad ? 56 : 42
                                        )
                                    
                                    Image(systemName: "chevron.left")
                                        .font(
                                            .system(
                                                size: isIPad ? 22 : 16,
                                                weight: .bold
                                            )
                                        )
                                        .foregroundColor(.appPrimaryText)
                                }
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: isIPad ? 14 : 10) {
                            
                            Text("Saved Words")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 38 : 28
                                    )
                                )
                                .foregroundColor(.appPrimaryText)
                                .padding(
                                    .horizontal,
                                    isIPad ? 36 : 24
                                )
                                .padding(
                                    .vertical,
                                    isIPad ? 14 : 10
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(
                                            Color.white.opacity(
                                                colorScheme == .dark ? 0.14 : 0.45
                                            )
                                        )
                                )
                            
                            Text("⭐ Your favorite words ⭐")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Regular",
                                        size: isIPad ? 19 : 15
                                    )
                                )
                                .foregroundColor(.appPrimaryText.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity)
                        
                        savedWordsCard()
                        
                        searchBar()
                        
                        if savedWordsManager.savedWords.isEmpty {
                            
                            emptyState()
                            
                        } else {
                            
                            savedWordsList()
                            
                        }
                    }
                    .padding(.horizontal, isIPad ? 42 : 20)
                    .padding(.top, isIPad ? 20 : 10)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
    // MARK: - Search Bar
    
    @ViewBuilder
    private func searchBar() -> some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(
                "Search saved words...",
                text: $searchText
            )
            .font(
                .custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 18 : 15
                )
            )
            .foregroundColor(.appPrimaryText)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, isIPad ? 18 : 14)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    colorScheme == .dark
                    ? Color.white.opacity(0.14)
                    : Color.white.opacity(0.90)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    Color.white.opacity(0.75),
                    lineWidth: 1
                )
        )
    }
    
    // MARK: - Empty State
    
    @ViewBuilder
    private func emptyState() -> some View {
        
        VStack(spacing: isIPad ? 24 : 18) {
            
            Spacer()
                .frame(height: isIPad ? 50 : 30)
            
            Image("owl_empty")
                .resizable()
                .scaledToFit()
                .frame(
                    width: isIPad ? 220 : 170
                )
            
            VStack(spacing: 10) {
                
                Text("No saved words yet!")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 28 : 22
                        )
                    )
                    .foregroundColor(.appPrimaryText)
                
                Text("Tap the bookmark while reading\nto save new vocabulary.")
                    .multilineTextAlignment(.center)
                    .font(
                        .custom(
                            "OpenDyslexic-Regular",
                            size: isIPad ? 18 : 15
                        )
                    )
                    .foregroundColor(.appPrimaryText.opacity(0.75))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, isIPad ? 40 : 20)
    }
    // MARK: - Saved Words List
    
    @ViewBuilder
    private func savedWordsList() -> some View {
        
        VStack(spacing: isIPad ? 22 : 18) {
            
            ForEach(filteredWords) { word in
                
                HStack(spacing: isIPad ? 18 : 14) {
                    
                    ZStack {

                        Circle()
                            .fill(Color.white.opacity(colorScheme == .dark ? 0.12 : 0.55))
                            .frame(
                                width: isIPad ? 42 : 34,
                                height: isIPad ? 42 : 34
                            )

                        Image(systemName: "bookmark.fill")
                            .font(.system(size: isIPad ? 17 : 14))
                            .foregroundColor(.appPrimaryText)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(word.word)
                            .font(
                                .custom(
                                    "OpenDyslexic-Bold",
                                    size: isIPad ? 24 : 20
                                )
                            )
                            .foregroundColor(.appPrimaryText)
                        
                        Text(word.meaning)
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 19 : 16
                                )
                            )
                            .foregroundColor(.appPrimaryText.opacity(0.75))
                    }
                    
                    Spacer()
                    
                    ZStack {

                        Circle()
                            .fill(Color.white.opacity(colorScheme == .dark ? 0.12 : 0.55))
                            .frame(
                                width: isIPad ? 46 : 38,
                                height: isIPad ? 46 : 38
                            )

                        Button {

                            AudioManager.shared.play(
                                audioName: word.audioName,
                                text: word.word
                            )

                        } label: {

                            ZStack {

                                Circle()
                                    .fill(Color.white.opacity(colorScheme == .dark ? 0.12 : 0.55))
                                    .frame(
                                        width: isIPad ? 40 : 34,
                                        height: isIPad ? 40 : 34
                                    )

                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: isIPad ? 16 : 13))
                                    .foregroundColor(.appPrimaryText)
                            }
                        }
                        .buttonStyle(.plain)
                            .font(.system(size: isIPad ? 18 : 15))
                            .foregroundColor(.appPrimaryText)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, isIPad ? 28 : 24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.appCardBackground)
                )

                .swipeActions(edge: .trailing) {

                    Button(role: .destructive) {

                        wordToDelete = word

                    } label: {

                        Label("Delete", systemImage: "trash")

                    }
                }
            }
        }
    }
    // MARK: - Progress Card
    
    @ViewBuilder
    private func savedWordsCard() -> some View {
        
        HStack(spacing: isIPad ? 22 : 16) {
            
            // Left Icon
            ZStack {
                
                Circle()
                    .fill(Color.white.opacity(colorScheme == .dark ? 0.12 : 0.45))
                    .frame(
                        width: isIPad ? 60 : 46,
                        height: isIPad ? 60 : 46
                    )
                Image(systemName: "bookmark.fill")
                    .font(.system(size: isIPad ? 24 : 18))
                    .foregroundColor(.appPrimaryText)
            }
            
            // Text
            VStack(
                alignment: .leading,
                spacing: isIPad ? 8 : 5
            ) {
                
                Text("\(savedWordsManager.savedWords.count) Words Saved")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 22 : 17
                        )
                    )
                    .foregroundColor(.appPrimaryText)
                
                Text("Keep practicing to remember every new word!")
                    .font(
                        .custom(
                            "OpenDyslexic-Regular",
                            size: isIPad ? 18 : 14
                        )
                    )
                    .foregroundColor(.appPrimaryText.opacity(0.72))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            // Right Icon (temporary)
            Image("moral_owl")
                .resizable()
                .scaledToFit()
                .frame(
                    width: isIPad ? 80 : 55
                )
        }
        .padding(.horizontal, isIPad ? 26 : 18)
        .padding(.vertical, isIPad ? 22 : 18)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    colorScheme == .dark
                    ? Color.white.opacity(0.14)
                    : Color.white.opacity(0.82)
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(
                    Color.white.opacity(0.75),
                    lineWidth: 1
                )
        )
        .shadow(
            color: .black.opacity(colorScheme == .dark ? 0.25 : 0.08),
            radius: 10,
            y: 4
        )    }
    
}
    #Preview {
        SavedWordsView()
    }
