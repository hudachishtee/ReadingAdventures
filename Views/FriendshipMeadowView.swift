//
//  FriendshipMeadowView.swift
//  ReadingAdventures
//

import SwiftUI

struct FriendshipMeadowView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false
    @State private var selectedStory: Story?

    // All stories that belong to Friendship Meadow
    private var friendshipStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == .friendship
        }
    }

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // MARK: - Background

                Image("friendship_meadow")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // MARK: - Level 1

                LevelNode(
                    number: 1,
                    state: levelState(for: 0)
                ) {
                    selectedStory = friendshipStories[0]
                    showPreview = true
                }
                .position(
                    x: geo.size.width * 0.49,
                    y: geo.size.height * 0.70
                )

                // MARK: - Level 2

                if friendshipStories.count > 1 {

                    LevelNode(
                        number: 2,
                        state: levelState(for: 1)
                    ) {
                        selectedStory = friendshipStories[1]
                        showPreview = true
                    }
                    .position(
                        x: geo.size.width * 0.49,
                        y: geo.size.height * 0.86
                    )
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)

        // MARK: - Story Preview

        .sheet(isPresented: $showPreview) {

            if let story = selectedStory {

                StoryPreviewSheet(
                    story: story,
                    source: .adventure,
                    onStart: {
                        showPreview = false
                        goToStory = true
                    }
                )
            }
        }

        // MARK: - Story Reader

        .navigationDestination(isPresented: $goToStory) {

            if let story = selectedStory {

                StoryReaderView(
                    story: story,
                    source: .adventure
                )
            }
        }
    }

    // MARK: - Level State

    private func levelState(for index: Int) -> LevelState {

        let story = friendshipStories[index]

        // Already completed
        if progress.isStoryCompleted(story) {
            return .completed
        }

        // First story is always unlocked
        if index == 0 {
            return .unlocked
        }

        // Later stories unlock when the previous story is completed
        let previousStory = friendshipStories[index - 1]

        if progress.isStoryCompleted(previousStory) {
            return .unlocked
        }

        return .locked
    }
}

#Preview {
    NavigationStack {
        FriendshipMeadowView()
    }
}
