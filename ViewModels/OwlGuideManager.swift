import SwiftUI
import Combine

@MainActor
final class OwlGuideManager: ObservableObject {

    static let shared = OwlGuideManager()

    // MARK: - Guide Steps

    enum Step {
        case viewAll
        case categories
        case preview
        case start
        case navigation
        case audio
        case newWords
        case vocabularyAudio
        case vocabularyBookmark
        case vocabularySwipe
        case achievements
        case adventure
        case adventureArea
        case unlockedArea
        case flashCards
        case flashCardRead
        case flashCardFlip
        case savedWords
        case savedWordUnsave
    }

    // MARK: - Current Step

    @Published var currentStep: Step? = nil

    // MARK: - First-Time User

    @AppStorage("hasSeenOwlGuide")
    private var hasSeenOwlGuide = false

    @AppStorage("hasCompletedOwlGuide")
    private var hasCompletedOwlGuide = false

    // MARK: - Guide Active

    var isGuideNeeded: Bool {
        !hasSeenOwlGuide
    }

    // MARK: - Start Guide

    func startIfNeeded() {

        guard hasSeenOwlGuide == false else {
            return
        }

        guard currentStep == nil else {
            return
        }

        currentStep = .viewAll

        // The guide has now been shown once.
        // It should not restart if the user leaves and comes back.
        hasSeenOwlGuide = true
    }

    // MARK: - Move to Next Step

    func nextStep() {

        guard hasCompletedOwlGuide == false else {
            return
        }

        switch currentStep {

        case .viewAll:
            currentStep = .categories

        case .categories:
            currentStep = .preview

        case .preview:
            currentStep = .start

        case .start:
            currentStep = .navigation

        case .navigation:
            currentStep = .audio

        case .audio:
            currentStep = .newWords

        case .newWords:
            currentStep = .vocabularyAudio

        case .vocabularyAudio:
            currentStep = .vocabularyBookmark

        case .vocabularyBookmark:
            currentStep = .vocabularySwipe

        case .vocabularySwipe:
            currentStep = .achievements

        case .achievements:
            finishGuide()

        case .adventure:
            currentStep = .adventureArea

        case .adventureArea:
            currentStep = .unlockedArea

        case .unlockedArea:
            currentStep = .flashCards

        case .flashCards:
            currentStep = .flashCardRead

        case .flashCardRead:
            currentStep = .flashCardFlip

        case .flashCardFlip:
            currentStep = .savedWords

        case .savedWords:
            currentStep = .savedWordUnsave

        case .savedWordUnsave:
            finishGuide()

        case .none:
            break
        }
    }

    // MARK: - Finish

    func finishGuide() {
        currentStep = nil
        hasCompletedOwlGuide = true
    }

    // MARK: - Reset For Testing

    func resetGuideForTesting() {
        hasSeenOwlGuide = false
        hasCompletedOwlGuide = false
        currentStep = .viewAll
    }
}
