//
//  AnimalWoodView.swift
//  ReadingAdventures
//

import SwiftUI

struct AnimalWoodView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false
    @State private var selectedStory: Story?

    // All stories that belong to Animal Wood
    private var animalStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == .animals
        }
    }

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // MARK: - Background

                Image("animal_wood")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // MARK: - Story Levels

                ForEach(
                    Array(animalStories.enumerated()),
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

        let story = animalStories[index]

        // Story already completed
        if progress.isStoryCompleted(story) {
            return .completed
        }

        // First story is always unlocked
        if index == 0 {
            return .unlocked
        }

        // Later stories unlock when the previous story is completed
        let previousStory = animalStories[index - 1]

        if progress.isStoryCompleted(previousStory) {
            return .unlocked
        }

        return .locked
    }

    // MARK: - Node Position

    private func nodeXPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.52

        case 1:
            return 0.40

        case 2:
            return 0.63

        default:
            return 0.52
        }
    }

    private func nodeYPosition(for index: Int) -> CGFloat {

        switch index {

        case 0:
            return 0.62

        case 1:
            return 0.46

        case 2:
            return 0.33

        default:
            return 0.62
        }
    }
}

#Preview {
    NavigationStack {
        AnimalWoodView()
    }
}
