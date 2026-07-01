//
//  Untitled.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 01/07/2026.
//
import SwiftUI
struct FlipCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let word: VocabularyWord

    @Binding var currentIndex: Int

    let totalWords: Int

    @Binding var isFlipped: Bool

    @State private var dragOffset: CGSize = .zero

    let isIPad: Bool

    private var isBackground: Bool {
        currentIndex == -1
    }

    let audioManager: AudioManager
    let showSwipeHint: Bool

    var body: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .fill(Color("MiniGameOption3"))

            // FRONT

            // FRONT

            VStack {

                Spacer()

                VStack(spacing: isIPad ? 42 : 30) {

                    Text(word.word)
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 56 : 38
                            )
                        )
                        .foregroundColor(.appPrimaryText)

                    Spacer()
                        .frame(height: isIPad ? 18 : 12)

                    VStack(spacing: isIPad ? 12 : 10) {

                        Button {

                            audioManager.play(
                                audioName: word.audioName,
                                text: ""
                            )

                        } label: {

                            ZStack {

                                Circle()
                                    .fill(Color.white.opacity(0.70))
                                    .frame(
                                        width: isIPad ? 82 : 62,
                                        height: isIPad ? 82 : 62
                                    )

                                Image(systemName: "speaker.wave.2.fill")
                                    .font(
                                        .system(size: isIPad ? 30 : 24)
                                    )
                                    .foregroundColor(Color("VocabularyAccent"))
                            }
                        }

                        Text("Tap to hear")
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 18 : 14
                                )
                            )
                            .foregroundColor(.appPrimaryText.opacity(0.75))
                        if showSwipeHint {

                            HStack(spacing: 6) {

                                Image(systemName: "chevron.left")

                                Text("Swipe")

                                Image(systemName: "chevron.right")
                            }
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: isIPad ? 16 : 12
                                )
                            )
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(
                                            colorScheme == .dark
                                            ? Color.white.opacity(0.35)
                                            : Color.white.opacity(0.55)
                                        )
                            )
                            .foregroundColor(
                                colorScheme == .dark
                                ? Color.white
                                : Color.black.opacity(0.65)
                            )
                            .shadow(
                                color: .black.opacity(colorScheme == .dark ? 0.35 : 0),
                                radius: 2,
                                x: 0,
                                y: 1
                            )
                            .padding(.top, 10)
                        }
                    }
                }

                Spacer()

            }
            .opacity(isFlipped ? 0 : 1)
            // BACK

            VStack(
                alignment: .leading,
                spacing: isIPad ? 28 : 14
            ) {

                HStack {

                    Text(word.word)
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 34 : 22
                        ))
                        .foregroundColor(.appPrimaryText)

                    Spacer()

                    Button {

                        audioManager.play(
                            audioName: word.audioName,
                            text: ""
                        )

                    } label: {

                        ZStack {
                            
                            Circle()
                                .fill(Color.white.opacity(0.70))
                                .frame(
                                    width: isIPad ? 52 : 38,
                                    height: isIPad ? 52 : 38
                                )

                            Image(systemName: "speaker.wave.2.fill")
                                .font(
                                    .system(size: isIPad ? 20 : 14)
                                )
                                .foregroundColor(Color("VocabularyAccent"))
                        }
                    }
                }

                Divider()
                    .padding(.vertical, 2)

                Text("Meaning")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 20 : 15
                    ))
                    .foregroundColor(.appPrimaryText)
                
                Text(word.meaning)
                    .font(.custom(
                        "OpenDyslexic-Regular",
                        size: isIPad ? 22 : 15
                    ))
                    .foregroundColor(.appPrimaryText)

                Spacer(minLength: isIPad ? 8 : 18)

                Text("Example")
                    .font(.custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 20 : 15
                    ))
                    .foregroundColor(.appPrimaryText)
                
                Text(word.example)
                    .font(
                        .custom(
                            "OpenDyslexic-Regular",
                            size: isIPad ? 24 : 15
                        )
                    )
                    .foregroundColor(.appPrimaryText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(isIPad ? 36 : 24)
            .opacity(isFlipped ? 1 : 0)
            .scaleEffect(x: -1)
        }
        .frame(
            width: isIPad ? 530 : 320,
            height: isIPad ? 490 : 390
        )
        .shadow(
            color: .black.opacity(0.15),
            radius: 15,
            x: 0,
            y: 8
        )

        //        .offset(dragOffset)
        //        .rotationEffect(.degrees(dragOffset.width / 28))

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
