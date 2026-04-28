import SwiftUI

// MARK: - Story Theme
struct StoryTheme {
    let primary: Color
    let secondary: Color
}

// MARK: - Story Category
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
    let description: String
    let shortDescription: String

    let level: StoryLevel
    let category: StoryCategory

    // MARK: Images
    let coverImage: String
    let previewImage: String

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
    
    let imageAlignment: Alignment
    let imageOffset: CGFloat
    
    init(
        text: String,
        imageName: String,
        audioName: String,
        imageAlignment: Alignment = .center,
        imageOffset: CGFloat = 0
    ) {
        self.text = text
        self.imageName = imageName
        self.audioName = audioName
        self.imageAlignment = imageAlignment
        self.imageOffset = imageOffset
    }
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
struct GameQuestion {
    let id = UUID()

    let type: GameType
    let question: String
    let options: [String]
    let correctIndex: Int?
    let correctAnswer: String?
}
// MARK: - Game Types
enum GameType {
    case tapWord
    case meaning
    case buildWord
}
