import SwiftUI
import AVFoundation

// MARK: - PAGE DOTS VIEW
struct PageDotsView: View {
    let total: Int
    let current: Int

    var body: some View {
        HStack(spacing: 14) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .stroke(Color.black.opacity(0.6), lineWidth: 1)
                    .background(
                        Circle()
                            .fill(index == current ? Color.green.opacity(0.6) : Color.clear)
                    )
                    .frame(width: 10, height: 10)
            }
        }
    }
}

// MARK: - STORY PAGE VIEW
struct StoryPageView: View {

    // MARK: - STORY DATA (NO MODEL)
    private let pages: [(image: String, paragraphs: [String])] = [
        (
            image: "story1_page1",
            paragraphs: [
                "Nora packed two sandwiches today.",
                "She did not know why.",
                "It just felt right."
            ]
        ),
        (
            image: "story1_page2",
            paragraphs: [
                "At school, a boy sat alone.",
                "He looked at her sandwich.",
                "Nora walked over slowly."
            ]
        ),
        (
            image: "story1_page3",
            paragraphs: [
                "She shared the extra sandwich.",
                "The boy smiled and said thank you.",
                "Nora felt warm inside."
            ]
        )
    ]

    // MARK: - Paging State
    @State private var currentPageIndex: Int = 0

    // MARK: - Narration State
    @State private var paragraphWords: [[String]] = []
    @State private var flatWords: [String] = []
    @State private var currentWordIndex: Int = -1
    @State private var isPlaying = false

    // 🎙 Voice selection
    enum VoiceOption: String, CaseIterable {
        case us = "US"
        case uk = "UK"
        case au = "AU"
    }

    @State private var selectedVoice: VoiceOption = .us
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        let page = pages[currentPageIndex]

        ZStack {

            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 36) {

                Spacer().frame(height: 60)

                Image(page.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 720, height: 470)
                    .clipShape(RoundedRectangle(cornerRadius: 36))
                    .shadow(color: .black.opacity(0.12), radius: 14, y: 8)

                // 🎙 Voice Picker
                Picker("Voice", selection: $selectedVoice) {
                    ForEach(VoiceOption.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 260)

                // 📖 TEXT
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

                // ▶️ CONTROLS (ARROWS WORK)
                HStack {

                    Button {
                        goPrevious()
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
                                Circle().stroke(Color.green, lineWidth: 2)
                            )
                    }

                    Spacer()

                    Button {
                        goNext()
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

                // 🔘 PAGE DOTS
                PageDotsView(
                    total: pages.count,
                    current: currentPageIndex
                )

                Spacer().frame(height: 24)
            }
            .onAppear { prepareText() }
        }
    }

    // MARK: - Paging
    private func goPrevious() {
        guard currentPageIndex > 0 else { return }
        stopNarration()
        currentPageIndex -= 1
        prepareText()
    }

    private func goNext() {
        guard currentPageIndex < pages.count - 1 else { return }
        stopNarration()
        currentPageIndex += 1
        prepareText()
    }

    // MARK: - Text Helpers
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

    private func prepareText() {
        paragraphWords = pages[currentPageIndex].paragraphs.map {
            $0.split(separator: " ").map(String.init)
        }
        flatWords = paragraphWords.flatMap { $0 }
        currentWordIndex = -1
    }

    private func startIndex(for paragraph: Int) -> Int {
        paragraphWords.prefix(paragraph).flatMap { $0 }.count
    }

    // MARK: - Narration
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

        utterance.voice = AVSpeechSynthesisVoice(
            language: selectedVoice == .uk ? "en-GB" :
                      selectedVoice == .au ? "en-AU" : "en-US"
        )

        utterance.rate = 0.38
        utterance.preUtteranceDelay = 0.08

        synthesizer.speak(utterance)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            speakNext()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    StoryPageView()
}
