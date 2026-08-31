import SwiftUI

// ================================================================
// OWL GUIDE VIEW
// ================================================================

struct OwlGuideView: View {

    // MARK: - Animation

    @State private var handOffset: CGFloat = 0

    // MARK: - Content

    let message: String
    let targetRect: CGRect

    // MARK: - Configuration

    var owlImageName: String = "owl_think"

    // Shape of the highlighted target.
    var targetShape: OwlGuideTargetShape = .capsule

    // MARK: - Body

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // ====================================================
                // DIM EVERYTHING EXCEPT THE TARGET
                // ====================================================

                SpotlightDimView(
                    targetRect: targetRect,
                    targetShape: targetShape
                )
                .ignoresSafeArea()

                // ====================================================
                // OWL + SPEECH BUBBLE
                // ====================================================

                VStack(spacing: 6) {

                    Image(owlImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width:
                                UIDevice.current.userInterfaceIdiom == .pad
                                ? 120
                                : 88
                        )

                    Text(message)
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size:
                                    UIDevice.current.userInterfaceIdiom == .pad
                                    ? 21
                                    : 16
                            )
                        )
                        .multilineTextAlignment(.center)
                        .foregroundStyle(
                            Color("PrimaryText")
                        )
                        .lineLimit(nil)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .fill(
                                Color("MoralBackground")
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(
                                Color("PrimaryText").opacity(0.15),
                                lineWidth: 1
                            )
                        )
                        .shadow(
                            color: .black.opacity(0.18),
                            radius: 12,
                            x: 0,
                            y: 6
                        )
                }
                .frame(
                    maxWidth:
                        UIDevice.current.userInterfaceIdiom == .pad
                        ? 330
                        : 260
                )
                .position(
                    x: owlXPosition(
                        screenWidth: geo.size.width
                    ),
                    y: owlYPosition(
                        screenHeight: geo.size.height
                    )
                )
                .zIndex(2)

                // ====================================================
                // POINTING HAND
                // ====================================================
                //
                // The hand sits to the LEFT of the target
                // and points RIGHT toward it.
                // It gently moves up and down to attract attention.
                // ====================================================

                Image(systemName: "hand.point.right.fill")
                    .font(
                        .system(
                            size:
                                UIDevice.current.userInterfaceIdiom == .pad
                                ? 38
                                : 30
                        )
                    )
                    .foregroundStyle(
                        Color(.white)
                    )
                    .shadow(
                        color: .black.opacity(0.18),
                        radius: 4,
                        x: 0,
                        y: 2
                    )
                    .position(
                        x: handXPosition(
                            screenWidth: geo.size.width
                        ),
                        y: handYPosition(
                            screenHeight: geo.size.height
                        )
                    )
                    .offset(x: handOffset)
                    .allowsHitTesting(false)
                    .zIndex(3)
                    .onAppear {

                        withAnimation(
                            .easeInOut(duration: 0.7)
                            .repeatForever(
                                autoreverses: true
                            )
                        ) {
                            handOffset = 5
                        }
                    }
            }
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }

    // MARK: - Owl Position

    private func owlXPosition(
        screenWidth: CGFloat
    ) -> CGFloat {

        let offset: CGFloat =
            UIDevice.current.userInterfaceIdiom == .pad
            ? 100
            : 80

        // Target is on the right → owl sits to the left.
        if targetRect.midX > screenWidth / 2 {
            return targetRect.midX - offset
        }

        // Target is on the left → owl sits to the right.
        return targetRect.midX + offset
    }

    private func owlYPosition(
        screenHeight: CGFloat
    ) -> CGFloat {

        let topSpace: CGFloat =
            UIDevice.current.userInterfaceIdiom == .pad
            ? 140
            : 110

        // Keep the owl above the target.
        return max(
            targetRect.minY - 145,
            topSpace
        )
    }

    // MARK: - Hand Position

    private func handXPosition(
        screenWidth: CGFloat
    ) -> CGFloat {

        let offset: CGFloat =
            UIDevice.current.userInterfaceIdiom == .pad
            ? 42
            : 32

        // Put the hand to the LEFT of the target.
        return targetRect.minX - offset
    }

    private func handYPosition(
        screenHeight: CGFloat
    ) -> CGFloat {

        // Align the hand with the center of the target.
        return targetRect.midY
    }
}


// ================================================================
// TARGET SHAPE
// ================================================================

enum OwlGuideTargetShape {

    case capsule
    case roundedRectangle
}


// ================================================================
// SPOTLIGHT DIM VIEW
// ================================================================
//
// Dims the screen while leaving the REAL target completely
// untouched and at its original brightness.
// ================================================================

struct SpotlightDimView: View {

    let targetRect: CGRect
    let targetShape: OwlGuideTargetShape

    var body: some View {

        GeometryReader { geometry in

            ZStack {

                // ====================================================
                // DIM LAYER
                // ====================================================

                Color.black
                    .opacity(0.66)
                    .mask {

                        SpotlightMask(
                            targetRect: targetRect,
                            targetShape: targetShape
                        )
                    }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .allowsHitTesting(false)
    }
}


// ================================================================
// SPOTLIGHT MASK
// ================================================================
//
// White = dim
// Black = transparent / do not dim
//
// The target area is therefore completely untouched.
// ================================================================

struct SpotlightMask: View {

    let targetRect: CGRect
    let targetShape: OwlGuideTargetShape

    var body: some View {

        Canvas { context, size in

            // ====================================================
            // ENTIRE SCREEN = WHITE
            // ====================================================

            context.fill(
                Path(
                    CGRect(
                        origin: .zero,
                        size: size
                    )
                ),
                with: .color(.white)
            )

            // ====================================================
            // TARGET = BLACK
            // ====================================================

            let padding: CGFloat = 10

            let highlightRect = targetRect.insetBy(
                dx: -padding,
                dy: -padding
            )

            var targetPath = Path()

            switch targetShape {

            case .capsule:

                targetPath.addRoundedRect(
                    in: highlightRect,
                    cornerSize: CGSize(
                        width: highlightRect.height / 2,
                        height: highlightRect.height / 2
                    )
                )

            case .roundedRectangle:

                targetPath.addRoundedRect(
                    in: highlightRect,
                    cornerSize: CGSize(
                        width: 18,
                        height: 18
                    )
                )
            }

            context.blendMode = .destinationOut

            context.fill(
                targetPath,
                with: .color(.black)
            )
        }
        .compositingGroup()
    }
}


// ================================================================
// PREVIEW
// ================================================================

#Preview("Real Target Test") {

    OwlGuideTargetTestView()
}


// ================================================================
// TEMPORARY TARGET TEST VIEW
// ================================================================

struct OwlGuideTargetTestView: View {

    var body: some View {

        ZStack {

            // ====================================================
            // TEST BACKGROUND
            // ====================================================

            LinearGradient(
                colors: [
                    .bgTop,
                    .bgBottom
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // ====================================================
            // TEST CONTENT
            // ====================================================

            VStack(spacing: 30) {

                Text("Choose A Story")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: 28
                        )
                    )

                Button {

                    print("VIEW ALL BUTTON TAPPED")

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
            }
        }

        // ========================================================
        // OWL GUIDE
        // ========================================================

        .overlayPreferenceValue(
            OwlGuideTargetPreferenceKey.self
        ) { preferences in

            GeometryReader { proxy in

                if let anchor = preferences["viewAll"] {

                    OwlGuideView(
                        message: "Tap View All!",
                        targetRect: proxy[anchor],
                        targetShape: .capsule
                    )
                }
            }
            .ignoresSafeArea()
        }
    }
}
