import SwiftUI

struct StoryReadingCardView: View {

    let story: Story
    let currentPage: Int
    let isIPad: Bool

    @ObservedObject var audioManager: AudioManager

    @ObservedObject private var guideManager = OwlGuideManager.shared

    @Binding var goToMoral: Bool
    @Binding var lastScrolledLine: Int

    let nextPage: () -> Void
    let previousPage: () -> Void

    // Controls which navigation arrow the guide targets.
    @State private var navigationGuideTarget: String = "forward"

    // Remembers that the child has discovered the audio guide.
    @State private var audioGuideWasActive = false

    var body: some View {

        let page = story.pages[currentPage]

        VStack(spacing: isIPad ? 20 : 16) {

            // ====================================================
            // CONTROLS
            // ====================================================

            HStack {

                Spacer()

                Button {

                    // ====================================================
                    // AUDIO GUIDE → DISAPPEAR WHEN AUDIO IS TAPPED
                    // ====================================================

                    if guideManager.currentStep == .audio {

                        audioGuideWasActive = true
                        guideManager.currentStep = nil
                    }

                    // ====================================================
                    // NORMAL AUDIO LOGIC
                    // ====================================================

                    if audioManager.isPlaying {

                        audioManager.pause()

                    } else if audioManager.isPaused {

                        audioManager.resume()

                    } else {

                        audioManager.play(
                            audioName: page.audioName,
                            text: page.text
                        )
                    }

                } label: {

                    Image(
                        systemName:
                            audioManager.isPlaying
                            ? "pause.fill"
                            : audioManager.isPaused
                            ? "play.fill"
                            : "speaker.wave.2.fill"
                    )
                    .font(
                        .system(
                            size: isIPad ? 22 : 18,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        Color(uiColor: .label)
                    )
                    .frame(
                        width: isIPad ? 72 : 60,
                        height: isIPad ? 72 : 60
                    )
                    .background(
                        Circle()
                            .fill(Color.appAccent)
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                Color.white.opacity(0.8),
                                lineWidth: 2
                            )
                    )
                    .shadow(
                        color: .black.opacity(0.15),
                        radius: 8,
                        x: 0,
                        y: 4
                    )
                }
                .buttonStyle(.plain)

                // ====================================================
                // OWL GUIDE TARGET — AUDIO
                // ====================================================

                .owlGuideTarget("audio")
            }

            .frame(
                height: isIPad ? 70 : 58
            )

            // ====================================================
            // TEXT
            // ====================================================

            ScrollViewReader { proxy in

                ScrollView(
                    showsIndicators: false
                ) {

                    NarratedTextView(
                        text: page.text,
                        currentWordIndex:
                            audioManager.currentWordIndex,
                        themeColor: .appAccent,
                        isIPad: isIPad
                    )
                    .frame(
                        maxWidth:
                            isIPad
                            ? 650
                            : .infinity,
                        alignment: .leading
                    )
                    .padding(
                        .horizontal,
                        isIPad ? 18 : 2
                    )
                    .padding(
                        .bottom,
                        8
                    )
                }

                .onChange(
                    of: audioManager.currentWordIndex
                ) { _, newValue in

                    guard newValue >= 0 else {
                        return
                    }

                    let lines =
                        page.text
                            .components(
                                separatedBy: "\n"
                            )
                            .filter {
                                !$0.trimmingCharacters(
                                    in: .whitespaces
                                ).isEmpty
                            }

                    var runningCount = 0
                    var currentLine = 0

                    for (index, line)
                        in lines.enumerated() {

                        let words =
                            line
                                .components(
                                    separatedBy: .whitespaces
                                )
                                .filter {
                                    !$0.isEmpty
                                }

                        runningCount += words.count

                        if newValue < runningCount {

                            currentLine = index
                            break
                        }
                    }

                    guard currentLine != lastScrolledLine
                    else {
                        return
                    }

                    lastScrolledLine = currentLine

                    withAnimation(
                        .easeInOut(duration: 0.55)
                    ) {

                        proxy.scrollTo(
                            newValue,
                            anchor: .center
                        )
                    }
                }
            }

            Spacer()

            // ====================================================
            // NAVIGATION ARROWS + FINISH
            // ====================================================

            ZStack {

                HStack {

                    // ====================================================
                    // BACK / PREVIOUS PAGE
                    // ====================================================

                    Button {

                        // ====================================================
                        // AFTER FORWARD IS CLICKED:
                        // SHOW BACK GUIDE
                        // ====================================================

                        if guideManager.currentStep == .navigation &&
                            navigationGuideTarget == "back" {

                            guideManager.currentStep = .newWords
                        }

                        previousPage()

                    } label: {

                        Image(
                            systemName: "arrow.left"
                        )
                        .font(
                            .system(
                                size: isIPad ? 34 : 26,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            Color.appPrimaryText
                                .opacity(0.55)
                        )
                    }
                    .buttonStyle(.plain)

                    // ====================================================
                    // BACK ARROW GUIDE TARGET
                    // ====================================================

                    .owlGuideTarget(
                        navigationGuideTarget == "back"
                        ? "navigation"
                        : "navigationBack"
                    )

                    Spacer()

                    // ====================================================
                    // FORWARD / NEXT PAGE
                    // ====================================================

                    Button {

                        // ====================================================
                        // FORWARD GUIDE WAS CLICKED
                        // MOVE GUIDE TO BACK ARROW
                        // ====================================================

                        if guideManager.currentStep == .navigation &&
                            navigationGuideTarget == "forward" {

                            navigationGuideTarget = "back"
                        }

                        nextPage()

                    } label: {

                        Image(
                            systemName: "arrow.right"
                        )
                        .font(
                            .system(
                                size: isIPad ? 34 : 26,
                                weight: .medium
                            )
                        )
                        .foregroundStyle(
                            Color.appPrimaryText
                                .opacity(0.55)
                        )
                    }
                    .buttonStyle(.plain)

                    // ====================================================
                    // FORWARD ARROW GUIDE TARGET
                    // ====================================================

                    .owlGuideTarget(
                        navigationGuideTarget == "forward"
                        ? "navigation"
                        : "navigationForward"
                    )
                }

                // ====================================================
                // FINISH
                // ====================================================

                if currentPage == story.pages.count - 1 {

                    HStack {

                        Spacer()

                        Button("Finish") {

                            audioManager.stop()
                            goToMoral = true
                        }
                        .buttonStyle(
                            PrimaryButtonStyle(
                                isActive: true,
                                themeColor: .green
                            )
                        )
                    }
                }
            }

            .frame(
                height: isIPad ? 60 : 50
            )

            // ====================================================
            // PAGE DOTS
            // ====================================================

            HStack(spacing: 10) {

                ForEach(
                    0..<story.pages.count,
                    id: \.self
                ) { index in

                    Circle()
                        .fill(
                            index == currentPage
                            ? Color.white
                            : Color.white.opacity(0.45)
                        )
                        .frame(
                            width: 8,
                            height: 8
                        )
                }
            }

            .padding(
                .bottom,
                isIPad ? 12 : 8
            )
        }

        .padding(
            .horizontal,
            isIPad ? 34 : 20
        )

        .padding(
            .top,
            isIPad ? 30 : 20
        )

        .padding(
            .bottom,
            isIPad ? 18 : 12
        )

        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )

        .background(
            ZStack {

                Color("CardBackground")

                LinearGradient(
                    colors: [
                        Color.white.opacity(0.22),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                )

                RoundedRectangle(
                    cornerRadius: isIPad ? 50 : 40,
                    style: .continuous
                )
                .stroke(
                    Color.white.opacity(0.35),
                    lineWidth: 1.2
                )
            }
        )

        .clipShape(
            RoundedRectangle(
                cornerRadius: isIPad ? 50 : 40,
                style: .continuous
            )
        )

        .shadow(
            color: Color.black.opacity(0.15),
            radius: 10,
            x: 0,
            y: -5
        )

        // ============================================================
        // START AUDIO GUIDE
        // ============================================================

        .onAppear {

            if guideManager.currentStep == .start {

                guideManager.currentStep = .audio
            }
        }

        // ============================================================
        // AUDIO FINISHED → SHOW FORWARD GUIDE
        // ============================================================

        .onChange(
            of: audioManager.didFinishPlaying
        ) { _, didFinish in

            if didFinish && audioGuideWasActive {

                navigationGuideTarget = "forward"

                withAnimation {

                    guideManager.currentStep =
                        .navigation
                }
            }
        }
    }
}

#Preview {

    StoryReadingCardView(
        story: sampleStories[0],
        currentPage: 0,
        isIPad: false,
        audioManager: AudioManager.shared,
        goToMoral: .constant(false),
        lastScrolledLine: .constant(0),
        nextPage: {},
        previousPage: {}
    )
}
