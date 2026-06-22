import SwiftUI

struct FlashCardPracticeView: View {

    private let allWords = sampleStories.flatMap(\.vocabulary)

    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var practiceWords: [VocabularyWord] = []

    @ObservedObject var audioManager = AudioManager.shared

    private var currentWord: VocabularyWord {
        allWords[currentIndex]
    }

    var body: some View {

        GeometryReader { geo in

            let isIPad = UIDevice.current.userInterfaceIdiom == .pad

            ZStack {

                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: isIPad ? 24 : 16) {

                    Spacer()
                        .frame(height: isIPad ? 20 : 10)

                    Text("Flash Card Practice")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 32 : 22
                        ))
                        .foregroundColor(.appPrimaryText)

                    Text("Word \(currentIndex + 1) of \(allWords.count)")
                        .font(.custom(
                            "OpenDyslexic-Regular",
                            size: isIPad ? 18 : 14
                        ))
                        .foregroundColor(.appPrimaryText)

                    ProgressView(
                        value: Double(currentIndex + 1),
                        total: Double(allWords.count)
                    )
                    .tint(Color("VocabularyAccent"))
                    .frame(width: isIPad ? 420 : 260)

                    Spacer()

                    FlipCard(
                        word: currentWord,
                        isFlipped: $isFlipped,
                        isIPad: isIPad,
                        audioManager: audioManager
                    )

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct FlipCard: View {

    let word: VocabularyWord

    @Binding var isFlipped: Bool

    let isIPad: Bool

    let audioManager: AudioManager

    var body: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .fill(Color("MiniGameOption3"))

            // FRONT

            VStack {

                Spacer()

                Text(word.word)
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 54 : 36
                    ))
                    .foregroundColor(.appPrimaryText)

                Spacer()

                HStack {

                    Spacer()

                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: isIPad ? 28 : 22))
                        .foregroundColor(
                            Color("VocabularyAccent")
                        )
                }
                .padding(.trailing, 18)
                .padding(.bottom, 18)
            }
            .opacity(isFlipped ? 0 : 1)

            // BACK

            VStack(
                alignment: .leading,
                spacing: isIPad ? 20 : 12
            ) {

                HStack {

                    Text(word.word)
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 26
                        ))
                        .foregroundColor(.appPrimaryText)

                    Spacer()

                    Button {

                        audioManager.play(
                            audioName: word.audioName,
                            text: ""
                        )

                    } label: {

                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(
                                size: isIPad ? 24 : 18
                            ))
                            .foregroundColor(
                                Color("VocabularyAccent")
                            )
                            .padding(10)
                            .background(
                                Circle()
                                    .fill(
                                        Color("SpeakerBackground")
                                    )
                            )
                    }
                }

                Divider()

                Text("Meaning")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 18 : 14
                    ))
                    .foregroundColor(.appPrimaryText)

                Text(word.meaning)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 22 : 16
                    ))
                    .foregroundColor(.appPrimaryText)

                Text("Example")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 18 : 14
                    ))
                    .foregroundColor(.appPrimaryText)

                Text(word.example)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 22 : 16
                    ))
                    .foregroundColor(.appPrimaryText)

                Spacer()
            }
            .padding(isIPad ? 30 : 20)
            .opacity(isFlipped ? 1 : 0)
            .scaleEffect(x: -1)
        }
        .frame(
            width: isIPad ? 560 : 320,
            height: isIPad ? 520 : 380
        )
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(
            .easeInOut(duration: 0.5),
            value: isFlipped
        )
        .onTapGesture {

            withAnimation {

                isFlipped.toggle()
            }
        }
    }
}


#Preview {
    FlashCardPracticeView()
}
