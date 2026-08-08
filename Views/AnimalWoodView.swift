//
//  AnimalWoodView.swift
//  ReadingAdventures
//

import SwiftUI

struct AnimalWoodView: View {

    @State private var showPreview = false
    @State private var goToStory = false

    var body: some View {

        GeometryReader { geo in

            ZStack {

                Image("animal_wood")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                LevelNode(
                    number: 1,
                    state: ProgressManager.shared.isStoryCompleted(sampleStories[3])
                        ? .completed
                        : .unlocked
                ) {

                    showPreview = true

                }
                .position(
                    x: geo.size.width * 0.52,
                    y: geo.size.height * 0.55
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
