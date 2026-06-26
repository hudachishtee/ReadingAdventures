import SwiftUI

struct StoryReaderView: View {

    let story: Story
    @State private var currentPage: Int
    init(story: Story) {

        self.story = story

        if ProgressManager.shared.lastOpenedStoryTitle == story.title {

            _currentPage = State(
                initialValue: ProgressManager.shared.lastOpenedPage
            )

        } else {

            _currentPage = State(initialValue: 0)
        }
    }
    @State private var goToMoral = false
    @State private var lastScrolledLine = 0

    @StateObject private var audioManager = AudioManager.shared
    @ObservedObject private var progress = ProgressManager.shared

    var body: some View {

        let page = story.pages[currentPage]

        GeometryReader { geo in

            let isIPad =
                UIDevice.current.userInterfaceIdiom == .pad

            VStack(spacing: 0) {

                // MARK: - IMAGE

                Image(page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geo.size.width,
                        height: isIPad
                        ? geo.size.height * 0.58
                        : geo.size.height * 0.43
                    )
//                    .clipped()
                    .offset(
                        y: isIPad
                        ? page.imageOffset
                        : page.imageOffset * 0.25
                    )
                // MARK: - CARD

                StoryReadingCardView(
                    story: story,
                    currentPage: currentPage,
                    isIPad: isIPad,
                    audioManager: audioManager,
                    goToMoral: $goToMoral,
                    lastScrolledLine: $lastScrolledLine
                )
                .offset(y: isIPad ? 35 : 45)                .zIndex(1)
            }
            .frame(maxHeight: .infinity)

            // MARK: - SWIPE

            .gesture(
                DragGesture()
                    .onEnded { value in

                        let horizontalAmount =
                            value.translation.width

                        if horizontalAmount < -50 {

                            if currentPage < story.pages.count - 1 {

                                withAnimation(
                                    .interactiveSpring(
                                        response: 0.4,
                                        dampingFraction: 0.85
                                    )
                                ) {

                                    currentPage += 1
                                    audioManager.stop()
                                }

                            } else {

                                goToMoral = true
                            }
                        }

                        if horizontalAmount > 50 {

                            if currentPage > 0 {

                                withAnimation(
                                    .interactiveSpring(
                                        response: 0.4,
                                        dampingFraction: 0.85
                                    )
                                ) {

                                    currentPage -= 1
                                    audioManager.stop()
                                }
                            }
                        }
                    }
            )
        }
        .navigationDestination(
            isPresented: $goToMoral
        ) {
            MoralView(story: story)
        }

        .onAppear {

            progress.lastOpenedStoryTitle = story.title
            progress.lastOpenedStoryCompleted = false

            progress.lastOpenedPage = currentPage
            progress.lastOpenedStoryCoverImage = story.coverImage
            progress.lastOpenedStoryTotalPages = story.pages.count
        }
        .onChange(of: currentPage) { newPage in

            progress.lastOpenedStoryTitle = story.title
            progress.lastOpenedPage = newPage
            progress.lastOpenedStoryCoverImage = story.coverImage
            progress.lastOpenedStoryTotalPages = story.pages.count
        }
    }
}

#Preview {
    StoryReaderView(
        story: sampleStories[0]
    )
}
