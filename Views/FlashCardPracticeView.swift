import SwiftUI

struct FlashCardPracticeView: View {

    @Environment(\.colorScheme) private var colorScheme

    private let allWords = sampleStories.flatMap(\.vocabulary)

    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var dragOffset: CGSize = .zero

    @ObservedObject var audioManager = AudioManager.shared

    private var currentWord: VocabularyWord {
        allWords[currentIndex]
    }

    var body: some View {

        let isIPad = UIDevice.current.userInterfaceIdiom == .pad

        ZStack {

            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: isIPad ? 40 : 20) {

                Spacer()
                    .frame(height: 4)

                VStack(spacing: isIPad ? 14 : 10) {

                    Text("Flash Cards")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 48 : 34
                            )
                        )

                    Text("Practice every new word.")
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 24 : 17
                            )
                        )
                        .foregroundColor(.appPrimaryText.opacity(0.8))
                }

                VStack(spacing: 12) {

                    Text("\(currentIndex + 1) / \(allWords.count)")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 22 : 18
                            )
                        )

                    ProgressView(
                        value: Double(currentIndex + 1),
                        total: Double(allWords.count)
                    )
                    .tint(Color("VocabularyAccent"))
                    .scaleEffect(y: 1.8)
                }
                .padding(.horizontal, isIPad ? 70 : 24)
                .padding(.vertical, isIPad ? 26 : 20)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            colorScheme == .dark
                            ? Color.white.opacity(0.15)
                            : Color.white.opacity(0.8)
                        )
                )

                Spacer()
                    .frame(height: 38)

                ZStack {

                    ForEach(Array(allWords[currentIndex...].prefix(3).enumerated().reversed()),
                            id: \.element.word) { index, vocab in

                        if index == 0 {

                            FlipCard(
                                word: vocab,
                                currentIndex: $currentIndex,
                                totalWords: allWords.count,
                                isFlipped: $isFlipped,
                                isIPad: isIPad,
                                audioManager: audioManager,
                                showSwipeHint: currentIndex == 0
                            )
                            .offset(dragOffset)
                            .rotationEffect(.degrees(Double(dragOffset.width) / 25))
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        dragOffset = value.translation
                                    }
                                    .onEnded { value in

                                        let threshold: CGFloat = 120

                                        if value.translation.width < -threshold {

                                            guard currentIndex < allWords.count - 1 else {
                                                withAnimation(.spring()) {
                                                    dragOffset = .zero
                                                }
                                                return
                                            }

                                            withAnimation(.easeOut(duration: 0.22)) {
                                                dragOffset.width = -900
                                            }

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {

                                                currentIndex += 1
                                                isFlipped = false
                                                dragOffset = .zero

                                            }

                                        }

                                        else if value.translation.width > threshold {

                                            guard currentIndex > 0 else {
                                                withAnimation(.spring()) {
                                                    dragOffset = .zero
                                                }
                                                return
                                            }

                                            withAnimation(.easeOut(duration: 0.22)) {
                                                dragOffset.width = 900
                                            }

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {

                                                currentIndex -= 1
                                                isFlipped = false
                                                dragOffset = .zero

                                            }

                                        }

                                        else {

                                            withAnimation(.spring(response: 0.35,
                                                                  dampingFraction: 0.82)) {

                                                dragOffset = .zero

                                            }

                                        }
                                    }
                            )
                            .zIndex(3)
                        } else {

                            MiniFlashCard()
                                .frame(
                                    width: isIPad ? 530 : 320,
                                    height: isIPad ? 490 : 390
                                )
                                .scaleEffect(1 - CGFloat(index) * 0.06)
                                .offset(
                                    x: CGFloat(index) * 28,
                                    y: CGFloat(index) * -10
                                )
                                .opacity(index == 1 ? 0.8 : 0.55)
                                .zIndex(Double(2 - index))
                        }

                    }

                }

                Spacer()

            }
            .padding()

        }
    }
}

#Preview {
    FlashCardPracticeView()
}
