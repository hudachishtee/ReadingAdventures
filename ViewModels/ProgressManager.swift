//==============================================================
// ProgressManager.swift
//==============================================================

import SwiftUI
import Combine

class ProgressManager: ObservableObject {

    static let shared = ProgressManager()

    // MARK: - Published State

    @Published var completedStories: Set<String> = [] {
        didSet {
            UserDefaults.standard.set(
                Array(completedStories),
                forKey: "completedStories"
            )
        }
    }

    @Published var unlockedGames: Set<String> = []

    // Badge notification
    @Published var hasUnseenAchievements: Bool = false

    // Continue Reading
    @Published var lastOpenedStoryTitle: String?
    @Published var lastOpenedPage: Int = 0
    @Published var lastOpenedStoryCoverImage: String?
    @Published var lastOpenedStoryTotalPages: Int = 0
    @Published var lastOpenedStoryCompleted = false

    private init() {

        completedStories = Set(
            UserDefaults.standard.stringArray(
                forKey: "completedStories"
            ) ?? []
        )
    }

    //==========================================================
    // MARK: - Story Completion
    //==========================================================

    func completeStory(_ story: Story) {

        completedStories.insert(story.id)
        unlockedGames.insert(story.id)

        if lastOpenedStoryTitle == story.title {
            lastOpenedStoryCompleted = true
        }

        hasUnseenAchievements = true
    }

    //==========================================================
    // MARK: - Story Checks
    //==========================================================

    func isStoryCompleted(_ story: Story) -> Bool {
        completedStories.contains(story.id)
    }

    func isGameUnlocked(for story: Story) -> Bool {
        unlockedGames.contains(story.id)
    }

    //==========================================================
    // MARK: - Area Progression
    //==========================================================

    func hasCompletedTheme(_ theme: DashboardTheme) -> Bool {

        let storiesInTheme = sampleStories.filter {
            $0.dashboardTheme == theme
        }

        return storiesInTheme.allSatisfy {
            completedStories.contains($0.id)
        }
    }

    func isFriendshipUnlocked() -> Bool {
        true
    }

    func isAnimalUnlocked() -> Bool {
        hasCompletedTheme(.friendship)
    }

    func isKindnessUnlocked() -> Bool {
        hasCompletedTheme(.animals)
    }

    func isBedtimeUnlocked() -> Bool {
        hasCompletedTheme(.kindness)
    }

    func isAdventureUnlocked() -> Bool {
        hasCompletedTheme(.bedtime)
    }

    func isCourageUnlocked() -> Bool {
        hasCompletedTheme(.adventure)
    }

    //==========================================================
    // MARK: - Notification Handling
    //==========================================================

    func markAchievementsAsSeen() {
        hasUnseenAchievements = false
    }

    //==========================================================
    // MARK: - Reset Progress
    //==========================================================

    func resetProgress() {

        completedStories.removeAll()
        unlockedGames.removeAll()

        hasUnseenAchievements = false

        UserDefaults.standard.removeObject(
            forKey: "completedStories"
        )
    }
}
