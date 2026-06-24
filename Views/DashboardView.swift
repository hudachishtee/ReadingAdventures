import SwiftUI

struct DashboardView: View {

    @ObservedObject private var progress = ProgressManager.shared
    @ObservedObject private var savedWordsManager = SavedWordsManager.shared

    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    private var heroHeight: CGFloat {
        isIPad ? 330 : 250
    }

    private var storyCardWidth: CGFloat {
        isIPad ? 460 : 300
    }

    private var storyImageHeight: CGFloat {
        isIPad ? 260 : 180
    }
    
    private var hasReadingProgress: Bool {
        progress.lastOpenedStoryTitle != nil
    }
    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading,
                   spacing: isIPad ? 18 : 12)
            {

                heroSection

                continueReadingSection
                
                browseByThemeSection
                    .padding(.top, 10)
//                exploreButton

                Spacer(minLength: 120)
            }
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
        .background(
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

// MARK: - Hero

private extension DashboardView {

    var heroSection: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 40)
                .fill(Color(red: 0.86, green: 0.93, blue: 1.0))

            Circle()
                .fill(Color.white.opacity(0.18))
                .frame(
                    width: isIPad ? 700 : 500,
                    height: isIPad ? 700 : 500
                )
                .offset(
                    x: isIPad ? 260 : 180,
                    y: isIPad ? -320 : -220
                )

            Circle()
                .fill(Color.blue.opacity(0.10))
                .frame(
                    width: isIPad ? 900 : 650,
                    height: isIPad ? 900 : 650
                )
                .offset(
                    x: isIPad ? -220 : -140,
                    y: isIPad ? 320 : 220
                )

            Image(systemName: "star.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: isIPad ? 28 : 18))
                .offset(
                    x: isIPad ? 120 : 80,
                    y: isIPad ? -90 : -65
                )
            Image(systemName: "moon.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: isIPad ? 32 : 22))
                .offset(
                    x: isIPad ? 180 : 110,
                    y: isIPad ? -120 : -85
                )
            Image(systemName: "star.fill")
                .foregroundColor(.blue.opacity(0.55))
                .font(.system(size: isIPad ? 24 : 14))
                .offset(
                    x: isIPad ? 40 : 20,
                    y: isIPad ? -20 : -10
                )

            HStack(alignment: .center) {

                VStack(
                    alignment: .leading,
                    spacing: isIPad ? 18 : 12
                ) {

                    Text("Hi, Reader!")
                        .font(
                            .custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 48 : 36
                            )
                        )
                        .foregroundColor(.appPrimaryText)

                    Text("Ready for a new\nadventure?")
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 28 : 22
                            )
                        )
                        .foregroundColor(.appPrimaryText)
                        .lineSpacing(8)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .offset(y: -5)

                Spacer()

                Image("owl_logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: isIPad ? 500 : 360
                    )
                    .offset(y: 10)
            }
            .padding(isIPad ? 24 : 14)
        }
        .frame(height: heroHeight)
        .clipShape(
            RoundedRectangle(cornerRadius: 40)
        )
        .padding(.horizontal, 22)
//        .padding(.horizontal, 22)
    }
}

// MARK: - Continue Reading

private extension DashboardView {

    var continueReadingSection: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                Text(
                    hasReadingProgress
                    ? "Continue Reading"
                    : "Recommended Stories"
                )
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 30 : 22
                        )
                    )

                Spacer()

                HStack(spacing: 6) {

                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: 10, height: 10)

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(width: 10, height: 10)

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.horizontal, 22)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 16) {

                    if hasReadingProgress {

                        continueCard(
                            image: progress.lastOpenedStoryCoverImage ?? "story1_cover",
                            title: progress.lastOpenedStoryTitle ?? "The Brave Little Wave"
                        )

                    } else {

                        continueCard(
                            image: "story2_cover",
                            title: "The Brave Little Wave"
                        )

                        continueCard(
                            image: "story1_cover",
                            title: "The Extra Sandwich"
                        )
                    }

                    continueCard(
                        image: "story2_cover",
                        title: "The Sunset Promise"
                    )
                }
                .padding(.horizontal, 22)
            }
        }
    }

    func continueCard(
        image: String,
        title: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(
                    width: storyCardWidth,
                    height: storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )

            Text(title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 18 : 16
                    )
                )
        }
    }
}

// MARK: - Browse Theme

private extension DashboardView {

    var browseByThemeSection: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("Browse by Theme")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 30 : 22
                        )
                    )

                Spacer()

                Button("View All") { }
                    .foregroundColor(.appPrimaryText.opacity(0.75))
            }
            .padding(.horizontal, 22)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 12) {

                    themeChip(
                        title: "Friendship",
                        selected: true
                    )

                    themeChip(
                        title: "Courage",
                        selected: false
                    )

                    themeChip(
                        title: "Kindness",
                        selected: false
                    )

                    themeChip(
                        title: "Bedtime",
                        selected: false
                    )
                }
                .padding(.horizontal, 22)
            }

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 20) {

                    storyCard(
                        image: progress.lastOpenedStoryCoverImage ?? "story1_cover",
                        title: progress.lastOpenedStoryTitle ?? "The Brave Little Wave"
                    )

                    storyCard(
                        image: "story2_cover",
                        title: "The Sunset Promise"
                    )
                }
                .padding(.horizontal, 22)
            }
        }
    }

    func themeChip(
        title: String,
        selected: Bool
    ) -> some View {

        Text(title)
            .font(
                .custom(
                    "OpenDyslexic-Regular",
                    size: isIPad ? 16 : 14
                )
            )
            .foregroundColor(
                selected ? .white : .appPrimaryText
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .fill(
                        selected
                        ? Color.green.opacity(0.7)
                        : Color(red: 0.88, green: 0.95, blue: 0.85)
                    )
            )
            .overlay(
                Capsule()
                    .stroke(
                        Color.green.opacity(0.5),
                        lineWidth: selected ? 0 : 1
                    )
            )
    }

    func storyCard(
        image: String,
        title: String
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(
                    width: storyCardWidth,
                    height: storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )

            Text(title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 18 : 16
                    )
                )
                .foregroundColor(.appPrimaryText)

//            Text(subtitle)
//                .font(
//                    .custom(
//                        "OpenDyslexic-Regular",
//                        size: isIPad ? 15 : 13
//                    )
//                )
//                .foregroundColor(.appPrimaryText.opacity(0.85))
        }
        .frame(width: storyCardWidth)
    }
}

//// MARK: - Explore Button
//
//private extension DashboardView {
//
//    var exploreButton: some View {
//
//        NavigationLink {
//
//            HomeView()
//
//        } label: {
//
//            HStack(spacing: 10) {
//
//                Image(systemName: "book.fill")
//
//                Text("Explore All Stories")
//                    .font(
//                        .custom(
//                            "OpenDyslexic-Bold",
//                            size: isIPad ? 22 : 18
//                        )
//                    )
//            }
//            .foregroundColor(.white)
//            .frame(maxWidth: .infinity)
//            .frame(height: isIPad ? 64 : 58)
//            .background(
//                Capsule()
//                    .fill(Color("ButtonColor"))
//            )
//            .padding(.horizontal, 22)
//        }
//    }
//}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
