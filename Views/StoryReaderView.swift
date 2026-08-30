import SwiftUI

struct StoryReaderView: View {

    let story: Story
    let source: StorySource

    @State private var currentPage: Int

    init(
        story: Story,
        source: StorySource
    ) {
        self.story = story
        self.source = source

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

    // Owl Guide
    @ObservedObject private var guideManager = OwlGuideManager.shared

    //==========================================================
    // MARK: - NEXT PAGE
    //==========================================================

    func nextPage() {

        if currentPage < story.pages.count - 1 {

            currentPage += 1
            audioManager.stop()

        } else {

            goToMoral = true
        }
    }

    //==========================================================
    // MARK: - PREVIOUS PAGE
    //==========================================================

    func previousPage() {

        if currentPage > 0 {

            currentPage -= 1
            audioManager.stop()
        }
    }

    //==========================================================
    // MARK: - BODY
    //==========================================================

    var body: some View {

        let page = story.pages[currentPage]

        GeometryReader { geo in

            let isIPad =
                UIDevice.current.userInterfaceIdiom == .pad

            VStack(spacing: 0) {

                //==================================================
                // IMAGE
                //==================================================

                Image(page.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geo.size.width,
                        height:
                            isIPad
                            ? geo.size.height * 0.58
                            : geo.size.height * 0.43
                    )
                    .offset(
                        y:
                            isIPad
                            ? page.imageOffset
                            : page.imageOffset * 0.25
                    )

                //==================================================
                // CARD
                //==================================================

                StoryReadingCardView(
                    story: story,
                    currentPage: currentPage,
                    isIPad: isIPad,
                    audioManager: audioManager,
                    goToMoral: $goToMoral,
                    lastScrolledLine: $lastScrolledLine,
                    nextPage: nextPage,
                    previousPage: previousPage
                )
                .offset(
                    y: isIPad ? 35 : 45
                )
                .zIndex(1)
            }
            .frame(maxHeight: .infinity)

            //======================================================
            // MARK: - SWIPE
            //======================================================

            .gesture(

                DragGesture()

                    .onEnded { value in

                        //==================================================
                        // IMPORTANT:
                        // While the Audio OR Navigation guide is showing,
                        // do NOT allow the child to swipe.
                        //
                        // Audio must be discovered first.
                        // Then Forward must be tapped.
                        // Then Back must be tapped.
                        //==================================================

                        guard guideManager.currentStep != .audio &&
                              guideManager.currentStep != .navigation
                        else {
                            return
                        }

                        let horizontalAmount =
                            value.translation.width

                        //==================================================
                        // SWIPE LEFT → NEXT PAGE
                        //==================================================

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

                        //==================================================
                        // SWIPE RIGHT → PREVIOUS PAGE
                        //==================================================

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

        //==========================================================
        // NAVIGATION TO MORAL
        //==========================================================

        .navigationDestination(
            isPresented: $goToMoral
        ) {

            MoralView(
                story: story,
                source: source
            )
        }

        //==========================================================
        // ON APPEAR
        //==========================================================

        .onAppear {

            progress.lastOpenedStoryTitle =
                story.title

            progress.lastOpenedStoryCompleted =
                false

            progress.lastOpenedPage =
                currentPage

            progress.lastOpenedStoryCoverImage =
                story.coverImage

            progress.lastOpenedStoryTotalPages =
                story.pages.count

            //======================================================
            // START AUDIO GUIDE
            //======================================================

            if guideManager.currentStep == .start {

                guideManager.currentStep = .audio
            }
        }

        //==========================================================
        // PAGE CHANGE
        //==========================================================

        .onChange(of: currentPage) { newPage in

            progress.lastOpenedStoryTitle =
                story.title

            progress.lastOpenedPage =
                newPage

            progress.lastOpenedStoryCoverImage =
                story.coverImage

            progress.lastOpenedStoryTotalPages =
                story.pages.count
        }

        //==========================================================
        // OWL GUIDE OVERLAY
        //==========================================================

        .owlGuideOverlay()
    }
}

//==============================================================
// PREVIEW
//==============================================================

#Preview {

    StoryReaderView(
        story: sampleStories[0],
        source: .library
    )
}
