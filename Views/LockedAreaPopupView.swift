import SwiftUI

struct LockedAreaPopupView: View {

    let requiredArea: String
    let lockedArea: String
    let onDismiss: () -> Void

    var body: some View {

        GeometryReader { geo in

            let isPad = geo.size.width >= 600

            // MARK: - Responsive Sizes

            let popupWidth: CGFloat = isPad
                ? min(geo.size.width * 0.62, 620)
                : geo.size.width * 0.86

            let owlSize: CGFloat = isPad
                ? 180
                : min(popupWidth * 0.38, 140)

            let messageSize: CGFloat = isPad
                ? 23
                : 18

            ZStack(alignment: .topTrailing) {

                // MARK: - Popup

                VStack(spacing: 0) {

                    // MARK: - Owl

                    Image("owl_think")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: owlSize,
                            height: owlSize
                        )

                    // MARK: - Message

                    VStack(spacing: 4) {

                        Text("Finish \(requiredArea)")
                            .font(
                                .custom(
                                    "OpenDyslexic-Bold",
                                    size: messageSize
                                )
                            )
                            .multilineTextAlignment(.center)

                        Text("to unlock \(lockedArea)!")
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: messageSize
                                )
                            )
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal, isPad ? 40 : 20)
                    .padding(.top, 18)
                    .padding(.bottom, isPad ? 32 : 24)
                }
                .frame(width: popupWidth)
                .padding(.top, isPad ? 20 : 12)
                .background(
                    RoundedRectangle(
                        cornerRadius: isPad ? 36 : 30
                    )
                    .fill(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: isPad ? 36 : 30
                        )
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.95),
                                    .blue.opacity(0.15)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: isPad ? 36 : 30
                        )
                        .stroke(
                            Color.white.opacity(0.7),
                            lineWidth: 1.5
                        )
                    }
                )

                // MARK: - Close Button

                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(
                            .system(
                                size: isPad ? 22 : 18,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(.red)
                        .frame(
                            width: isPad ? 52 : 44,
                            height: isPad ? 52 : 44
                        )
                        .background(
                            Circle()
                                .fill(.white.opacity(0.8))
                        )
                        .overlay {
                            Circle()
                                .stroke(
                                    Color.red.opacity(0.8),
                                    lineWidth: 1
                                )
                        }
                }
                .buttonStyle(.plain)
                .offset(
                    x: isPad ? 20 : 15,
                    y: isPad ? -25 : -20
                )
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
        }
    }
}

#Preview("iPhone") {

    ZStack {

        LinearGradient(
            colors: [.bgTop, .bgBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        LockedAreaPopupView(
            requiredArea: "Friendship Meadow",
            lockedArea: "Animal Wood"
        ) {
            print("Dismissed")
        }
    }
}

#Preview("iPad") {

    ZStack {

        LinearGradient(
            colors: [.bgTop, .bgBottom],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        LockedAreaPopupView(
            requiredArea: "Friendship Meadow",
            lockedArea: "Animal Wood"
        ) {
            print("Dismissed")
        }
    }
}
