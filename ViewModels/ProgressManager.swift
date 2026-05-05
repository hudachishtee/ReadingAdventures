//==============================================================
// ProgressManager.swift
// FINAL VERSION (with badge notification support)
//==============================================================

import SwiftUI
import Combine

class ProgressManager: ObservableObject {

    static let shared = ProgressManager()

    // MARK: - Published State
    @Published var completedStories: Set<UUID> = []
    @Published var unlockedGames: Set<UUID> = []
    
    // ✅ NEW: Badge notification state
    @Published var hasUnseenAchievements: Bool = false

    private init() {}

    // MARK: - Story Completion
    func completeStory(_ story: Story) {
        completedStories.insert(story.id)
        unlockedGames.insert(story.id)
        
        // ✅ Trigger notification dot
        hasUnseenAchievements = true
    }

    // MARK: - Checks

    func isStoryCompleted(_ story: Story) -> Bool {
        return completedStories.contains(story.id)
    }

    func isGameUnlocked(for story: Story) -> Bool {
        return unlockedGames.contains(story.id)
    }
    
    // MARK: - Notification Handling
    
    func markAchievementsAsSeen() {
        hasUnseenAchievements = false
    }

    // MARK: - Optional Reset (useful for testing)

    func resetProgress() {
        completedStories.removeAll()
        unlockedGames.removeAll()
        hasUnseenAchievements = false // ✅ keep consistent
    }
}
