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

                Image("courage_forest")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

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

        .navigationDestination(isPresented: $goToStory) {
            if let story = selectedStory {
                StoryReaderView(
                    story: story,
                    source: .adventure
                )
            }
        }
    }

    private func levelState(for index: Int) -> LevelState {

        let story = courageStories[index]

        if progress.isStoryCompleted(story) {
            return .completed
        }

        if index == 0 {
            return .unlocked
        }

        let previousStory = courageStories[index - 1]

        if progress.isStoryCompleted(previousStory) {
            return .unlocked
        }

        return .locked
    }

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
        CourageForestView()
    }
}
