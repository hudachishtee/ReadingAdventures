//
//  AnimalWoodView.swift
//  ReadingAdventures
//

import SwiftUI

struct AnimalWoodView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // Background
                Image("animal_wood")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                // Story 1
                LevelNode(
                    number: 1,
                    state: progress.isStoryCompleted(sampleStories[3])
                        ? .completed
                        : .unlocked
                ) {
                    showPreview = true
                }
                // Story 1
                .position(
                    x: geo.size.width * 0.52,
                    y: geo.size.height * 0.62
                )

                // Story 2
                LevelNode(
                    number: 2,
                    state: .locked
                ) {

                }
                .position(
                    x: geo.size.width * 0.40,
                    y: geo.size.height * 0.46
                )

                // Story 3
                LevelNode(
                    number: 3,
                    state: .locked
                ) {

                }
                .position(
                    x: geo.size.width * 0.63,
                    y: geo.size.height * 0.33
                )
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)

        .sheet(isPresented: $showPreview) {

            StoryPreviewSheet(
                story: sampleStories[3],
                source: .adventure,
                onStart: {
                    goToStory = true
                }
            )
        }

        .navigationDestination(isPresented: $goToStory) {

            StoryReaderView(
                story: sampleStories[3],
                source: .adventure
            )
        }
    }
}

#Preview {
    NavigationStack {
        AnimalWoodView()
    }
}
