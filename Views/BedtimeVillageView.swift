//
//  BedtimeVillageView.swift
//  ReadingAdventures
//

import SwiftUI

struct BedtimeVillageView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false
    @State private var selectedStory: Story?

    // All stories that belong to Bedtime Village
    private var bedtimeStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == .bedtime
        }
    }

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // MARK: - Background

                Image("bedtime_village")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // MARK: - Story Levels

                ForEach(
                    Array(bedtimeStories.enumerated()),
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
                        x: geo.size.width * 0.50,
                        y: geo.size.height * 0.55
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

        let story = bedtimeStories[index]

        // Story already completed
        if progress.isStoryCompleted(story) {
            return .completed
        }

        // First story is always unlocked
        if index == 0 {
            return .unlocked
        }

        return .locked
    }
}

#Preview {
    NavigationStack {
        BedtimeVillageView()
    }
}
