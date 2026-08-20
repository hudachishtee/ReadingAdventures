//
//  CourageForestView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 20/08/2026.
//

import SwiftUI

struct CourageForestView: View {

    @StateObject private var progress = ProgressManager.shared
    @State private var showPreview = false
    @State private var goToStory = false
    @State private var selectedStory: Story?

    private var courageStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == .courage
        }
    }

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // MARK: - Background

                Image("courage_forest")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // MARK: - Story Nodes

                ForEach(
                    Array(courageStories.enumerated()),
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

    // MARK: - Story Unlock State

    private func levelState(for index: Int) -> LevelState {

        let story = courageStories[index]

        // Already completed
        if progress.isStoryCompleted(story) {
            return .completed
        }

        // First story is always available
        if index == 0 {
            return .unlocked
        }

        // Unlock this story when the previous one is completed
        let previousStory = courageStories[index - 1]

        if progress.isStoryCompleted(previousStory) {
            return .unlocked
        }

        return .locked
    }

    // MARK: - Node Positions

    private func nodeXPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.50       // Story 1 - bottom center

        case 1:
            return 0.38       // Story 2 - lower left

        case 2:
            return 0.62       // Story 3 - middle right

        case 3:
            return 0.40       // Story 4 - middle left

        case 4:
            return 0.60       // Story 5 - upper right

        case 5:
            return 0.50       // Story 6 - top center

        default:
            return 0.50
        }
    }

    private func nodeYPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.82       // Story 1

        case 1:
            return 0.68       // Story 2

        case 2:
            return 0.54       // Story 3

        case 3:
            return 0.40       // Story 4

        case 4:
            return 0.26       // Story 5

        case 5:
            return 0.12       // Story 6

        default:
            return 0.82
        }
    }
}

#Preview {
    NavigationStack {
        CourageForestView()
    }
}
