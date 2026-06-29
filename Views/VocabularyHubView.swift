import SwiftUI

struct VocabularyHubView: View {
    @Environment(\.colorScheme)
    private var colorScheme
    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var body: some View {

        NavigationStack {

            ZStack {

                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(alignment: .leading,
                           spacing: isIPad ? 28 : 22) {

                        Spacer()
                            .frame(height: isIPad ? 6 : 0)
                        // MARK: Header

                        VStack(spacing: isIPad ? 16 : 10) {

                            Text("Vocabulary")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 40 : 27
                                    )
                                )
                                .foregroundColor(.appPrimaryText)

                            Text("Learn new words from your stories!")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Regular",
                                        size: isIPad ? 20 : 15
                                    )
                                )
                                .foregroundColor(
                                    .appPrimaryText.opacity(0.85)
                                )
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)

                        statisticsCard()

                        Spacer()
                            .frame(height: isIPad ? 14 : 10)

                        VStack(alignment: .leading,
                               spacing: isIPad ? 18 : 14) {

                            HStack {

                                Text("Practice")
                                    .font(
                                        .custom(
                                            "OpenDyslexic-Bold",
                                            size: isIPad ? 40 : 18
                                        )
                                    )

                                Rectangle()
                                    .fill(Color.white.opacity(0.25))
                                    .frame(height: 1)

                            }
                            .foregroundColor(.appPrimaryText)
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size: isIPad ? 24 : 18
                                    )
                                )
                                .foregroundColor(.appPrimaryText)

                            NavigationLink {

                                FlashCardPracticeView()

                            } label: {

                                hubCard(
                                    icon: "square.stack.3d.up.fill",
                                    iconColor: Color("VocabularyAccent"),
                                    title: "Flash Cards",
                                    subtitle: "Practice every new word.",
                                    backgroundColor: Color.appCardBackground.opacity(0.92)
                                )
                            }
                            .buttonStyle(.plain)

                            NavigationLink {

                                SavedWordsView()

                            } label: {

                                hubCard(
                                    icon: "bookmark.fill",
                                    iconColor: .orange,
                                    title: "Saved Words",
                                    subtitle: "Review your saved words.",
                                    backgroundColor: Color.appCardBackground.opacity(0.92)
                                )
                            }
                            .buttonStyle(.plain)
                        }

                        Spacer(minLength: isIPad ? 80 : 60)
                    }
                    .padding(.horizontal,
                             isIPad ? 42 : 20)
                    .padding(.top, 8)
                }
            }
            .navigationBarHidden(true)
        }
    }
        // MARK: Statistics Card

        @ViewBuilder
        private func statisticsCard() -> some View {

            HStack(spacing: isIPad ? 40 : 14) {

                VStack(spacing: isIPad ? 10 : 6) {

                    ZStack {

                        Circle()
                            .fill(Color.yellow.opacity(0.18))
                            .frame(
                                width: isIPad ? 68 : 46,
                                height: isIPad ? 68 : 46
                            )

                        Image(systemName: "star.fill")
                            .font(.system(size: isIPad ? 28 : 22))
                            .foregroundColor(.yellow)
                    }

                    Text("12")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 36 : 22
                            )
                        )
                        .foregroundColor(.appPrimaryText)

                    Text("Saved Words")
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 20 : 15.5
                            )
                        )
                        .foregroundColor(.appPrimaryText)
                }

                Divider()
                    .frame(height: isIPad ? 95 : 75)

                VStack(spacing: isIPad ? 10 : 6) {

                    ZStack {

                        Circle()
                            .fill(Color.orange.opacity(0.18))
                            .frame(
                                width: isIPad ? 74 : 50,
                                height: isIPad ? 74 : 50
                            )

                        Image(systemName: "book.fill")
                            .font(.system(size: isIPad ? 28 : 22))
                            .foregroundColor(.orange)
                    }

                    Text("35")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 32 : 22
                            )
                        )
                        .foregroundColor(.appPrimaryText)

                    Text("Words Learned")
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 20 : 13
                            )
                        )
                        .foregroundColor(.appPrimaryText)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, isIPad ? 22 : 18)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(
                        colorScheme == .dark
                        ? Color.white.opacity(0.14)
                        : Color.white.opacity(0.78)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.75), lineWidth: 1.2)
            )
        .shadow(
                    color: .black.opacity(
                        colorScheme == .dark ? 0.30 : 0.10
                    ),
                radius: 14,
                y: 5
            )
        }

        // MARK: Activity Card

        @ViewBuilder
        private func hubCard(
            icon: String,
            iconColor: Color,
            title: String,
            subtitle: String,
            backgroundColor: Color
        ) -> some View {

            HStack(spacing: isIPad ? 20 : 16) {

                ZStack {

                    Circle()
                        .fill(Color.white.opacity(
                        colorScheme == .dark ? 0.16 : 0.45
                        ))
                        .frame(
                            width: isIPad ? 80 : 48,
                            height: isIPad ? 80 : 48
                        )

                    Image(systemName: icon)
                        .font(
                            .system(
                                size: isIPad ? 34 : 20,
                                weight: .semibold
                            )
                        )
                        .foregroundColor(iconColor)
                }

                VStack(
                    alignment: .leading,
                    spacing: isIPad ? 12 : 6
                ) {

                    Text(title)
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 24 : 15.5
                            )
                        )
                        .foregroundColor(.appPrimaryText)

                    Text(subtitle)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 22.3 : 14
                            )
                        )
                        .foregroundColor(
                            colorScheme == .dark
                            ? Color.white.opacity(0.88)
                            : Color.appPrimaryText.opacity(0.80)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                ZStack {

                    Circle()
                    .fill(
                    Color.white.opacity(
                    colorScheme == .dark ? 0.22 : 0.75
                    )
                    )
                        .frame(
                            width: isIPad ? 52 : 34,
                            height: isIPad ? 52 : 34
                        )

                    Image(systemName: "chevron.right")
                        .font(
                            .system(
                                size: isIPad ? 20 : 14,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.appPrimaryText)
                }
            }
            .padding(
                .horizontal,
                isIPad ? 48 : 14
            )
            .padding(
                .vertical,
                isIPad ? 60 : 16
            )
            .frame(
                maxWidth: isIPad ? 900 : 500
            )
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 26)
                    .stroke(
                        Color.white.opacity(
                            colorScheme == .dark ? 0.10 : 0.55
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: .black.opacity(0.08),
                radius: 10,
                y: 4
            )
        }
    }

    #Preview {
        VocabularyHubView()
    }
