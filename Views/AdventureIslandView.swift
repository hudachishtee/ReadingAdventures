//
//  AdventureIslandView.swift
//  ReadingAdventures
//

import SwiftUI

struct AdventureIslandView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false
    @State private var selectedStory: Story?

    // All stories that belong to Adventure Island
    private var adventureStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == .adventure
        }
    }

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // MARK: - Background

                Image("adventure_island")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // MARK: - Story Levels

                ForEach(
                    Array(adventureStories.enumerated()),
                    id: \.element.id
                ) { index, story in

                    LevelNode(
                        number: index + 1,
                        state: levelState(for: index)
                    ) {
                        selectedStory = story
                        showPreview = true
                    }
                    .position(
                        x: nodeXPosition(for: index) * geo.size.width,
                        y: nodeYPosition(for: index) * geo.size.height
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

        let story = adventureStories[index]

        // Story already completed
        if progress.isStoryCompleted(story) {
            return .completed
        }

        // First story is always unlocked
        if index == 0 {
            return .unlocked
        }

        // Later stories unlock after previous story is completed
        let previousStory = adventureStories[index - 1]

        if progress.isStoryCompleted(previousStory) {
            return .unlocked
        }

        return .locked
    }

    // MARK: - Node Positions

    private func nodeXPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.50

        case 1:
            return 0.38

        case 2:
            return 0.62

        default:
            return 0.50
        }
    }

    private func nodeYPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.70

        case 1:
            return 0.52

        case 2:
            return 0.35

        default:
            return 0.70
        }
    }
}

#Preview {
    NavigationStack {
        AdventureIslandView()
    }
}
