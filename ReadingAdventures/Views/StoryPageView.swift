import SwiftUI
import AVFoundation

struct StoryPageView: View {

    let page: StoryPage

    var onPrevious: (() -> Void)?
    var onNext: (() -> Void)?

    // MARK: - State
    @State private var paragraphWords: [[String]] = []
    @State private var flatWords: [String] = []

    @State private var currentWordIndex: Int = -1
    @State private var isPlaying = false

    private let synthesizer = AVSpeechSynthesizer()

    // MARK: - View
    var body: some View {
        ZStack {

            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer().frame(height: 28)

                Image(page.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 720, height: 470)
                    .clipShape(RoundedRectangle(cornerRadius: 36))
                    .shadow(color: .black.opacity(0.12), radius: 14, y: 8)

                Spacer().frame(height: 20)

                // 📖 TEXT AREA (SAFE)
                VStack(spacing: 22) {
                    ForEach(paragraphWords.indices, id: \.self) { pIndex in
                        Text(
                            attributedParagraph(
                                words: paragraphWords[pIndex],
                                paragraphStartIndex: startIndex(for: pIndex)
                            )
                        )
                        .font(OpenDyslexicFont.regular(size: 28))
                        .frame(maxWidth: 720, alignment: .leading)
                        .padding(.horizontal, 40)
                    }
                }

                Spacer()

                // ▶️ CONTROLS
                HStack {

                    Button {
                        stopNarration()
                        onPrevious?()
                    } label: {
                        Text("<")
                            .font(OpenDyslexicFont.bold(size: 28))
                            .frame(width: 56, height: 56)
                    }

                    Spacer()

                    Button {
                        isPlaying ? stopNarration() : startNarration()
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 26, weight: .semibold))
                            .frame(width: 64, height: 64)
                            .background(
                                Circle()
                                    .fill(Color(red: 0.90, green: 0.96, blue: 0.90))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }

                    Spacer()

                    Button {
                        stopNarration()
                        onNext?()
                    } label: {
                        Text(">")
                            .font(OpenDyslexicFont.bold(size: 28))
                            .frame(width: 56, height: 56)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color(red: 0.90, green: 0.96, blue: 0.90))
                )
                .frame(width: 720)

                Spacer().frame(height: 28)
            }
            .onAppear {
                prepareText()
            }
            .onDisappear {
                stopNarration()
            }
        }
    }

    // MARK: - Text Builder (SAFE)

    private func attributedParagraph(
        words: [String],
        paragraphStartIndex: Int
    ) -> AttributedString {

        var result = AttributedString()

        for (index, word) in words.enumerated() {
            var part = AttributedString(word)

            if isPlaying && paragraphStartIndex + index == currentWordIndex {
                part.backgroundColor = .yellow.opacity(0.6)
            }

            result.append(part)

            if index < words.count - 1 {
                result.append(AttributedString(" "))
            }
        }

        return result
    }

    // MARK: - Narration (NO DELEGATES)

    private func prepareText() {
        paragraphWords = page.paragraphs.map {
            $0.split(separator: " ").map(String.init)
        }
        flatWords = paragraphWords.flatMap { $0 }
        currentWordIndex = -1
    }

    private func startIndex(for paragraph: Int) -> Int {
        paragraphWords.prefix(paragraph).flatMap { $0 }.count
    }

    private func startNarration() {
        stopNarration()
        isPlaying = true
        speakNext()
    }

    private func stopNarration() {
        synthesizer.stopSpeaking(at: .immediate)
        isPlaying = false
        currentWordIndex = -1
    }

    private func speakNext() {
        currentWordIndex += 1

        guard isPlaying, currentWordIndex < flatWords.count else {
            stopNarration()
            return
        }

        let utterance = AVSpeechUtterance(string: flatWords[currentWordIndex])
        utterance.rate = 0.38

        synthesizer.speak(utterance)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            speakNext()
        }
    }
}

#Preview {
    StoryPageView(
        page: StoryPage(
            imageName: "story1_page1",
            paragraphs: [
                "Nora packed two sandwiches today.",
                "She did not know why.",
                "It just felt right."
            ]
        )
    )
}
