//
//  Untitled.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 05/04/2026.
//

import Foundation

// MARK: - Story Model
struct Story: Identifiable {
    let id = UUID()
    let title: String
    let level: StoryLevel
    let imageName: String
    let pages: [Page]
    let moral: String
    let vocabulary: [VocabularyWord]
    let games: [GameQuestion]
}

// MARK: - Story Level
enum StoryLevel: String, CaseIterable {
    case beginner = "Beginner"
    case explorer = "Explorer"
    case advanced = "Advanced"
}

// MARK: - Page Model
struct Page: Identifiable {
    let id = UUID()
    let text: String
    let imageName: String
    let audioName: String
}

// MARK: - Vocabulary Model
struct VocabularyWord: Identifiable {
    let id = UUID()
    let word: String
    let meaning: String
    let example: String
    let audioName: String
}

// MARK: - Game Model
struct GameQuestion: Identifiable {
    let id = UUID()
    let type: GameType
    let question: String
    let options: [String]
    let correctAnswer: String
}

// MARK: - Game Types
enum GameType {
    case tapWord
    case meaning
    case buildWord
}
