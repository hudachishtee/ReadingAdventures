//==============================================================
// ProgressManager.swift
// FINAL VERSION (Works with UUID - NO model changes needed)
//==============================================================

import SwiftUI
import Combine

class ProgressManager: ObservableObject {

static let shared = ProgressManager()

// MARK: - Published State
@Published var completedStories: Set<UUID> = []
@Published var unlockedGames: Set<UUID> = []

private init() {}

// MARK: - Story Completion
func completeStory(_ story: Story) {
    completedStories.insert(story.id)
    unlockedGames.insert(story.id)
}

// MARK: - Checks

func isStoryCompleted(_ story: Story) -> Bool {
    return completedStories.contains(story.id)
}

func isGameUnlocked(for story: Story) -> Bool {
    return unlockedGames.contains(story.id)
}

// MARK: - Optional Reset (useful for testing)

func resetProgress() {
    completedStories.removeAll()
    unlockedGames.removeAll()
}

}
