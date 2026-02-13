import SwiftUI
import AVFoundation
import ObjectiveC

struct StoryPageView: View {

    let page: StoryPage

    var onPrevious: (() -> Void)?
    var onNext: (() -> Void)?

    // Paragraph → words
    @State private var paragraphWords: [[String]] = []

    // Narration state
    @State private var currentFlatIndex: Int = -1
    @State private var totalWordCount: Int = 0
    @State private var isPlaying = false

    private let synthesizer = AVSpeechSynthesizer()

    private var flatWords: [String] {
        paragraphWords.flatMap { $0 }
    }

    var body: some View {
        ZStack {

            // Background
            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer().frame(height: 28)

                // Image
                Image(page.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 720, height: 470)
                    .clipShape(RoundedRectangle(cornerRadius: 36))
                    .shadow(color: .black.opacity(0.12), radius: 14, y: 8)

                Spacer().frame(height: 20)

                // TEXT AREA (STABLE – NO REFLOW)
                VStack(spacing: 18) {
                    ForEach(paragraphWords.indices, id: \.self) { pIndex in
                        let words = paragraphWords[pIndex]

                        let start = flatStartIndex(for: pIndex)
                        let end = start + words.count - 1

                        let highlightedIndex: Int? =
                            (currentFlatIndex >= start && currentFlatIndex <= end)
                            ? currentFlatIndex - start
                            : nil

                        FlexibleView(
                            data: words.indices,
                            spacing: 10,
                            alignment: .leading
                        ) { wIndex in
                            Text(words[wIndex])
                                .font(OpenDyslexicFont.regular(size: 28))
                                .foregroundColor(.primary)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 4)
                                .background(
                                    isPlaying && highlightedIndex == wIndex
                                    ? Color.yellow.opacity(0.6)
                                    : Color.clear
                                )
                                .cornerRadius(6)
                        }
                        .frame(maxWidth: 720, alignment: .leading)
                        .padding(.horizontal, 40)
                    }
                }

                Spacer()

                // CONTROLS
                HStack {

                    Button {
                        stopNarrationIfNeeded()
                        onPrevious?()
                    } label: {
                        Text("<")
                            .font(OpenDyslexicFont.bold(size: 28))
                            .frame(width: 56, height: 56)
                    }

                    Spacer()

                    Button {
                        isPlaying ? pauseNarration() : startNarration()
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
                                    .stroke(
                                        Color(red: 125/255, green: 179/255, blue: 143/255),
                                        lineWidth: 2
                                    )
                            )
                    }

                    Spacer()

                    Button {
                        stopNarrationIfNeeded()
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
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(
                            Color(red: 125/255, green: 179/255, blue: 143/255),
                            lineWidth: 2
                        )
                )
                .frame(width: 720)

                Spacer().frame(height: 28)
            }
            .onAppear {
                prepareWords()
                _ = SpeechDelegateConnector.shared(for: synthesizer)
            }
            .onDisappear {
                stopNarrationIfNeeded()
            }
        }
    }

    // MARK: - Narration Helpers

    private func prepareWords() {
        paragraphWords = page.paragraphs.map {
            $0.components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
        }
        totalWordCount = paragraphWords.reduce(0) { $0 + $1.count }
        currentFlatIndex = -1
    }

    private func flatStartIndex(for paragraphIndex: Int) -> Int {
        paragraphWords.prefix(paragraphIndex).reduce(0) { $0 + $1.count }
    }

    private func startNarration() {
        guard !isPlaying else { return }

        stopNarrationIfNeeded()
        isPlaying = true
        currentFlatIndex = -1

        SpeechDelegateConnector.shared(for: synthesizer).onDidFinish = {
            speakNextWord()
        }

        speakNextWord()
    }

    private func pauseNarration() {
        stopNarrationIfNeeded()
    }

    private func stopNarrationIfNeeded() {
        synthesizer.stopSpeaking(at: .immediate)
        isPlaying = false
        currentFlatIndex = -1
        SpeechDelegateConnector.shared(for: synthesizer).onDidFinish = nil
    }

    private func speakNextWord() {
        currentFlatIndex += 1

        guard currentFlatIndex < totalWordCount else {
            stopNarrationIfNeeded()
            return
        }

        let utterance = AVSpeechUtterance(string: flatWords[currentFlatIndex])
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.42

        synthesizer.speak(utterance)
    }
}

// MARK: - Speech Delegate Connector

final class SpeechDelegateConnector: NSObject, AVSpeechSynthesizerDelegate {

    var onDidFinish: (() -> Void)?

    init(synthesizer: AVSpeechSynthesizer) {
        super.init()
        synthesizer.delegate = self
    }

    static func shared(for synthesizer: AVSpeechSynthesizer) -> SpeechDelegateConnector {
        if let existing = objc_getAssociatedObject(
            synthesizer,
            &AssocKey
        ) as? SpeechDelegateConnector {
            return existing
        }

        let connector = SpeechDelegateConnector(synthesizer: synthesizer)
        objc_setAssociatedObject(
            synthesizer,
            &AssocKey,
            connector,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        return connector
    }

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        DispatchQueue.main.async {
            self.onDidFinish?()
        }
    }

    private static var AssocKey: UInt8 = 0
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
