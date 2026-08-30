//
//  OwlGuideOverlay.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 30/08/2026.
//

import SwiftUI

// ================================================================
// OWL GUIDE OVERLAY
// ================================================================
//
// Reusable Owl Guide system.
//
// Each screen only needs:
//
//     .owlGuideTarget("targetID")
//     .owlGuideOverlay()
//
// The manager decides which step is active.
//
// The overlay also blocks interaction everywhere EXCEPT
// the currently highlighted target.
// ================================================================

struct OwlGuideOverlayModifier: ViewModifier {

    @ObservedObject private var guideManager = OwlGuideManager.shared

    func body(content: Content) -> some View {

        content
            .overlayPreferenceValue(
                OwlGuideTargetPreferenceKey.self
            ) { preferences in

                GeometryReader { proxy in

                    if let step = guideManager.currentStep {

                        let targetID = targetID(for: step)

                        if let anchor = preferences[targetID] {

                            let targetRect = proxy[anchor]

                            ZStack {

                                // ====================================================
                                // BLOCK EVERYTHING EXCEPT THE TARGET
                                // ====================================================

                                OwlGuideInteractionBlocker(
                                    targetRect: targetRect
                                )
                                .ignoresSafeArea()

                                // ====================================================
                                // OWL GUIDE
                                // ====================================================

                                OwlGuideView(
                                    message: message(for: step),
                                    targetRect: targetRect,
                                    targetShape: targetShape(for: step)
                                )
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
    }

    // ============================================================
    // TARGET ID
    // ============================================================

    private func targetID(
        for step: OwlGuideManager.Step
    ) -> String {

        switch step {

        case .viewAll:
            return "viewAll"

        case .categories:
            return "categories"

        case .preview:
            return "preview"

        case .start:
            return "start"

        case .navigation:
            return "navigation"

        case .audio:
            return "audio"

        case .newWords:
            return "newWords"

        case .vocabularyAudio:
            return "vocabularyAudio"

        case .vocabularyBookmark:
            return "vocabularyBookmark"

        case .vocabularySwipe:
            return "vocabularySwipe"

        case .achievements:
            return "achievements"

        case .adventure:
            return "adventure"

        case .adventureArea:
            return "adventureArea"

        case .unlockedArea:
            return "unlockedArea"

        case .flashCards:
            return "flashCards"

        case .flashCardRead:
            return "flashCardRead"

        case .flashCardFlip:
            return "flashCardFlip"

        case .savedWords:
            return "savedWords"

        case .savedWordUnsave:
            return "savedWordUnsave"
        }
    }

    // ============================================================
    // OWL MESSAGE
    // ============================================================

    private func message(
        for step: OwlGuideManager.Step
    ) -> String {

        switch step {

        case .viewAll:
            return "Tap View All!"

        case .categories:
            return "Pick a level!"

        case .preview:
            return "Tap Preview!"

        case .start:
            return "Tap Start!"

        case .navigation:
            return "Use these to move through the story."

        case .audio:
            return "Tap here to listen."

        case .newWords:
            return "Learn new words!"

        case .vocabularyAudio:
            return "Tap to hear the word."

        case .vocabularyBookmark:
            return "Tap to save this word."

        case .vocabularySwipe:
            return "Swipe to explore!"

        case .achievements:
            return "Tap here to see your badge!"

        case .adventure:
            return "Start your adventure!"

        case .adventureArea:
            return "Tap an area to read!"

        case .unlockedArea:
            return "New area unlocked!"

        case .flashCards:
            return "Try Flash Cards!"

        case .flashCardRead:
            return "Tap Read to hear it."

        case .flashCardFlip:
            return "Tap the card to flip it."

        case .savedWords:
            return "Here are your saved words."

        case .savedWordUnsave:
            return "Tap again to remove it."
        }
    }

    // ============================================================
    // TARGET SHAPE
    // ============================================================

    private func targetShape(
        for step: OwlGuideManager.Step
    ) -> OwlGuideTargetShape {

        switch step {

        case .navigation:
            return .roundedRectangle

        case .audio:
            return .capsule

        default:
            return .capsule
        }
    }
}


// ================================================================
// INTERACTION BLOCKER
// ================================================================
//
// Creates four invisible hit-testing areas around the target.
//
// This means the highlighted target remains completely tappable,
// while everything around it is blocked.
//
// We do NOT put one large transparent layer over the screen,
// because that would also block the target itself.
// ================================================================

struct OwlGuideInteractionBlocker: View {

    let targetRect: CGRect

    var body: some View {

        GeometryReader { geometry in

            ZStack {

                // ====================================================
                // TOP BLOCKER
                // ====================================================

                Color.clear
                    .contentShape(Rectangle())
                    .frame(
                        width: geometry.size.width,
                        height: max(targetRect.minY, 0)
                    )
                    .position(
                        x: geometry.size.width / 2,
                        y: max(targetRect.minY, 0) / 2
                    )

                // ====================================================
                // BOTTOM BLOCKER
                // ====================================================

                Color.clear
                    .contentShape(Rectangle())
                    .frame(
                        width: geometry.size.width,
                        height: max(
                            geometry.size.height - targetRect.maxY,
                            0
                        )
                    )
                    .position(
                        x: geometry.size.width / 2,
                        y:
                            targetRect.maxY
                            + max(
                                geometry.size.height - targetRect.maxY,
                                0
                            ) / 2
                    )

                // ====================================================
                // LEFT BLOCKER
                // ====================================================

                Color.clear
                    .contentShape(Rectangle())
                    .frame(
                        width: max(targetRect.minX, 0),
                        height: targetRect.height
                    )
                    .position(
                        x: max(targetRect.minX, 0) / 2,
                        y: targetRect.midY
                    )

                // ====================================================
                // RIGHT BLOCKER
                // ====================================================

                Color.clear
                    .contentShape(Rectangle())
                    .frame(
                        width: max(
                            geometry.size.width - targetRect.maxX,
                            0
                        ),
                        height: targetRect.height
                    )
                    .position(
                        x:
                            targetRect.maxX
                            + max(
                                geometry.size.width - targetRect.maxX,
                                0
                            ) / 2,
                        y: targetRect.midY
                    )
            }
        }
        .allowsHitTesting(true)
    }
}


// ================================================================
// VIEW EXTENSION
// ================================================================

extension View {

    /// Adds the reusable Owl Guide to a screen.
    func owlGuideOverlay() -> some View {

        modifier(
            OwlGuideOverlayModifier()
        )
    }
}


// ================================================================
// PREVIEW
// ================================================================

#Preview("Reusable Owl Guide") {

    OwlGuideOverlayPreview()
}


// ================================================================
// PREVIEW TEST VIEW
// ================================================================

struct OwlGuideOverlayPreview: View {

    @ObservedObject private var guideManager =
        OwlGuideManager.shared

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    .bgTop,
                    .bgBottom
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {

                Text("Choose A Story")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: 28
                        )
                    )
                    .foregroundStyle(
                        Color("PrimaryText")
                    )

                Button {

                    print("VIEW ALL TAPPED")

                } label: {

                    Text("View All")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: 18
                            )
                        )
                        .foregroundStyle(
                            Color("PrimaryText")
                        )
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(
                            Capsule()
                                .fill(
                                    Color("ButtonColor")
                                )
                        )
                }
                .buttonStyle(.plain)
                .owlGuideTarget("viewAll")

                Button {

                    print("OTHER BUTTON TAPPED")

                } label: {

                    Text("Other Button")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: 18
                            )
                        )
                        .foregroundStyle(
                            Color("PrimaryText")
                        )
                }
            }
        }

        .owlGuideOverlay()

        .onAppear {

            guideManager.currentStep = .viewAll
        }

        .onDisappear {

            guideManager.currentStep = nil
        }
    }
}
