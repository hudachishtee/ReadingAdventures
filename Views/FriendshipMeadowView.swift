//
//  FriendshipMeadowView.swift
//  ReadingAdventures
//

import SwiftUI

struct FriendshipMeadowView: View {

    @StateObject private var progress = ProgressManager.shared

    @State private var showPreview = false
    @State private var goToStory = false

    var body: some View {
        GeometryReader { geo in

            ZStack {

                Image("friendship_meadow")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )
                    .clipped()

                LevelNode(
                    number: 1,
                    state: progress.isStoryCompleted(sampleStories[0]) ? .completed : .unlocked
                ) {

                    showPreview = true

                }
                .position(
                    x: geo.size.width * 0.49,
                    y: geo.size.height * 0.70
                )
            }
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)

        .sheet(isPresented: $showPreview) {

            StoryPreviewSheet(
                story: sampleStories[0],
                source: .adventure,
                onStart: {
                    goToStory = true
                }
            )
        }

        .navigationDestination(isPresented: $goToStory) {

            StoryReaderView(
                story: sampleStories[0],
                source: .adventure
            )
        }
    }
}

#Preview {
    NavigationStack {
        FriendshipMeadowView()
    }
}
