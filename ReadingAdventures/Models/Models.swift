import SwiftUI

// MARK: - Story Theme
struct StoryTheme {
    let primary: Color
    let secondary: Color
}

// MARK: - Story Category (for future screens)
enum StoryCategory {
    case adventure
    case moral
    case fantasy
}

// MARK: - Story Level
enum StoryLevel: String, CaseIterable {
    case beginner = "Beginner"
    case explorer = "Explorer"
    case advanced = "Advanced"
}

// MARK: - Story Model
struct Story: Identifiable {
    let id = UUID()
    
    let title: String
    let description: String   // ✅ For StoryPreviewView
    
    let level: StoryLevel
    let category: StoryCategory
    
    // ✅ NEW: Separate images for different screens
    let coverImage: String     // HomeView / StoryCard
    let previewImage: String   // StoryPreviewView
    
    let theme: StoryTheme
    
    let pages: [Page]
    let moral: String
    let vocabulary: [VocabularyWord]
    let games: [GameQuestion]
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
    let correctIndex: Int
}

// MARK: - Game Types
enum GameType {
    case tapWord
    case meaning
    case buildWord
}
