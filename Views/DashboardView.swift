import SwiftUI

struct DashboardView: View {

    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool {
        colorScheme == .dark
    }

    @ObservedObject private var progress = ProgressManager.shared
    @ObservedObject private var savedWordsManager = SavedWordsManager.shared
    @ObservedObject private var owlGuide = OwlGuideManager.shared

    @State private var selectedTheme: DashboardTheme = .courage
    @State private var selectedStory: Story?
    @State private var showAdventureMap = false
    @State private var showAllStories = false
    @State private var navigateToReader = false
    @State private var storyForReader: Story?

    @State private var containerSize: CGSize = .zero
    @State private var safeAreaTop: CGFloat = 0
    @State private var safeAreaBottom: CGFloat = 0

    private var filteredStories: [Story] {
        sampleStories.filter {
            $0.dashboardTheme == selectedTheme
        }
    }

    private var hasReadingProgress: Bool {
        progress.lastOpenedStoryTitle != nil &&
        !progress.lastOpenedStoryCompleted
    }

    private var lastOpenedStory: Story? {
        sampleStories.first {
            $0.title == progress.lastOpenedStoryTitle
        }
    }

    private var responsive: Responsive {
        Responsive(
            width: containerSize.width,
            height: containerSize.height,
            safeTop: safeAreaTop,
            safeBottom: safeAreaBottom
        )
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(
                alignment: .leading,
                spacing: responsive.isPad ? 18 : 12
            ) {

                heroSection(responsive)

                continueReadingSection(responsive)

                browseByThemeSection(responsive)
                    .padding(.top, 10)
                    .allowsHitTesting(
                        owlGuide.currentStep == nil
                    )

                Spacer(minLength: 120)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
            .padding(.bottom, 30)
        }
        .scrollDisabled(
            owlGuide.currentStep != nil
        )

        // Measure available size WITHOUT wrapping content in GeometryReader.
        .background(
            GeometryReader { geo in

                Color.clear
                    .onAppear {

                        containerSize = geo.size
                        safeAreaTop = geo.safeAreaInsets.top
                        safeAreaBottom = geo.safeAreaInsets.bottom
                    }
                    .onChange(of: geo.size) { newSize in

                        containerSize = newSize
                    }
            }
        )

        .background(
            LinearGradient(
                colors: [
                    .bgTop,
                    .bgBottom
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )

        .sheet(item: $selectedStory) { story in

            StoryPreviewSheet(
                story: story,
                source: .library
            ) {

                storyForReader = story
                selectedStory = nil

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 0.1
                ) {

                    navigateToReader = true
                }
            }

            .presentationDetents(
                UIDevice.current.userInterfaceIdiom == .pad
                ? [.large]
                : [.fraction(0.6)]
            )

            .presentationCornerRadius(30)
        }

        .navigationDestination(
            isPresented: $showAllStories
        ) {

            HomeView()
        }

        .navigationDestination(
            isPresented: $showAdventureMap
        ) {

            AdventureMapView()
        }

        .navigationDestination(
            isPresented: $navigateToReader
        ) {

            if let story = storyForReader {

                StoryReaderView(
                    story: story,
                    source: .library
                )
            }
        }

        // ============================================================
        // OWL GUIDE
        // ============================================================

        .overlayPreferenceValue(
            OwlGuideTargetPreferenceKey.self
        ) { preferences in

            GeometryReader { proxy in

                if owlGuide.currentStep == .viewAll,
                   let anchor = preferences["viewAll"] {

                    OwlGuideView(
                        message: "Tap View All!",
                        targetRect: proxy[anchor],
                        targetShape: .capsule
                    )
                }
            }
            .ignoresSafeArea()
        }

        .onAppear {
            owlGuide.startIfNeeded()
        }
    }
}


// MARK: - Hero

private extension DashboardView {

    func heroSection(
        _ responsive: Responsive
    ) -> some View {

        Group {

            if responsive.isPad {

                ipadHero(responsive)

            } else {

                iphoneHero(responsive)
            }
        }
    }


    // ==========================
    // iPad Hero
    // ==========================

    func ipadHero(
        _ responsive: Responsive
    ) -> some View {

        GeometryReader { heroGeo in

            let w = heroGeo.size.width
            let h = heroGeo.size.height

            ZStack {

                RoundedRectangle(
                    cornerRadius: responsive.heroCornerRadius
                )
                .fill(
                    Color("BackgroundBottom")
                )

                Circle()
                    .fill(
                        Color.white.opacity(
                            isDarkMode ? 0.08 : 0.18
                        )
                    )
                    .frame(
                        width: w * 1.3,
                        height: w * 1.3
                    )
                    .offset(
                        x: w * 0.35,
                        y: -h * 0.55
                    )

                Circle()
                    .fill(
                        Color.white.opacity(
                            isDarkMode ? 0.04 : 0.10
                        )
                    )
                    .frame(
                        width: w * 1.6,
                        height: w * 1.6
                    )
                    .offset(
                        x: -w * 0.30,
                        y: h * 0.60
                    )

                HStack(
                    spacing: w * 0.04
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: h * 0.05
                    ) {

                        Text("Hi,\nReader!")
                            .font(
                                .custom(
                                    "OpenDyslexic-Bold",
                                    size: w * 0.065
                                )
                            )
                            .foregroundColor(
                                .appPrimaryText
                            )
                            .multilineTextAlignment(
                                .leading
                            )
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                            .minimumScaleFactor(0.7)

                        Text("Ready for a new\nadventure?")
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: w * 0.036
                                )
                            )
                            .foregroundColor(
                                .appPrimaryText
                            )
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }

                    .layoutPriority(2)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                    Spacer(minLength: 0)

                    Image("owl_logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: min(
                                w * 0.38,
                                340
                            )
                        )
                        .padding(
                            .trailing,
                            -w * 0.01
                        )
                }

                .frame(
                    width: w * 0.88,
                    alignment: .leading
                )
                .offset(
                    x: -w * 0.02
                )
            }

            .frame(
                width: w,
                height: h
            )
        }

        .frame(
            height: responsive.heroHeight
        )

        .frame(
            width: responsive.heroWidth
        )

        .clipShape(
            RoundedRectangle(
                cornerRadius: responsive.heroCornerRadius
            )
        )

        .padding(
            .horizontal,
            responsive.horizontalPadding
        )
    }


    // ==========================
    // iPhone Hero
    // ==========================

    func iphoneHero(
        _ responsive: Responsive
    ) -> some View {

        GeometryReader { heroGeo in

            let w = heroGeo.size.width
            let h = heroGeo.size.height

            ZStack {

                RoundedRectangle(
                    cornerRadius: responsive.heroCornerRadius
                )
                .fill(
                    Color("BackgroundBottom")
                )

                Circle()
                    .fill(
                        Color.white.opacity(0.18)
                    )
                    .frame(
                        width: w * 0.80,
                        height: w * 0.80
                    )
                    .offset(
                        x: w * 0.30,
                        y: -h * 0.65
                    )

                Circle()
                    .fill(
                        Color.blue.opacity(0.10)
                    )
                    .frame(
                        width: w * 1.05,
                        height: w * 1.05
                    )
                    .offset(
                        x: -w * 0.22,
                        y: h * 0.55
                    )

                HStack(
                    alignment: .center,
                    spacing: w * 0.04
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: h * 0.06
                    ) {

                        Text("Hi,\nReader!")
                            .font(
                                .custom(
                                    "OpenDyslexic-Bold",
                                    size: w * 0.072
                                )
                            )
                            .foregroundColor(
                                .appPrimaryText
                            )
                            .multilineTextAlignment(
                                .leading
                            )
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                            .minimumScaleFactor(0.7)

                        Text("Ready for a new\nadventure?")
                            .font(
                                .custom(
                                    "OpenDyslexic-Regular",
                                    size: w * 0.040
                                )
                            )
                            .foregroundColor(
                                .appPrimaryText
                            )
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }

                    .layoutPriority(2)
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                    Spacer(minLength: 0)

                    Image("owl_logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: min(
                                w * 0.42,
                                180
                            )
                        )
                        .padding(
                            .trailing,
                            -w * 0.02
                        )
                }

                .frame(
                    width: w * 0.94
                )
                .padding(
                    .horizontal,
                    w * 0.02
                )
            }

            .frame(
                width: w,
                height: h
            )
        }

        .frame(
            height: responsive.heroHeight
        )

        .frame(
            width: responsive.heroWidth
        )

        .clipShape(
            RoundedRectangle(
                cornerRadius: responsive.heroCornerRadius
            )
        )

        .padding(
            .horizontal,
            responsive.horizontalPadding
        )
    }
}


// MARK: - Continue Reading

private extension DashboardView {

    func continueReadingSection(
        _ responsive: Responsive
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 14
        ) {

            HStack {

                Text(
                    hasReadingProgress
                    ? "Continue Reading"
                    : "Recommended Stories"
                )
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: responsive.isPad ? 30 : 16
                    )
                )

                Spacer()

                Button("View All") {

                    owlGuide.nextStep()
                    showAllStories = true
                }
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: responsive.isPad ? 18 : 14
                    )
                )
                .foregroundColor(
                    Color("PrimaryText")
                )
                .owlGuideTarget("viewAll")
            }

            .padding(
                .leading,
                responsive.horizontalPadding
            )

            .padding(
                .trailing,
                responsive.horizontalPadding
            )


            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {

                HStack(spacing: 16) {

                    if hasReadingProgress,
                       let story = lastOpenedStory {

                        continueCard(
                            story: story,
                            responsive: responsive
                        )
                        .allowsHitTesting(
                            owlGuide.currentStep == nil
                        )

                    } else {

                        continueCard(
                            story: sampleStories[1],
                            responsive: responsive
                        )
                        .allowsHitTesting(
                            owlGuide.currentStep == nil
                        )

                        continueCard(
                            story: sampleStories[0],
                            responsive: responsive
                        )
                        .allowsHitTesting(
                            owlGuide.currentStep == nil
                        )

                        continueCard(
                            story: sampleStories[2],
                            responsive: responsive
                        )
                        .allowsHitTesting(
                            owlGuide.currentStep == nil
                        )
                    }
                }

                .padding(
                    .horizontal,
                    responsive.horizontalPadding
                )
            }

            .frame(
                height:
                    responsive.storyImageHeight
                    + (responsive.isPad ? 110 : 90)
            )
        }
    }


    func continueCard(
        story: Story,
        responsive: Responsive
    ) -> some View {

        Button {

            selectedStory = story

        } label: {

            VStack(
                alignment: .leading,
                spacing: 12
            ) {

                Image(story.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width:
                            responsive.storyCardWidth - 24,
                        height:
                            responsive.storyImageHeight
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius:
                                responsive.isPad ? 22 : 18
                        )
                    )
                    .padding(.top, 12)
                    .padding(.horizontal, 12)

                Text(story.title)
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size:
                                responsive.isPad ? 22 : 17
                        )
                    )
                    .foregroundColor(
                        .appPrimaryText
                    )
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 16)
            }

            .frame(
                width: responsive.storyCardWidth
            )

            .background(
                Color.appCardBackground
            )

            .clipShape(
                RoundedRectangle(
                    cornerRadius:
                        responsive.isPad ? 28 : 22
                )
            )

            .shadow(
                color:
                    .black.opacity(
                        colorScheme == .dark
                        ? 0.18
                        : 0.08
                    ),
                radius: 8,
                y: 3
            )

            .contentShape(Rectangle())
        }

        .buttonStyle(.plain)
    }
}


// MARK: - Browse Theme

private extension DashboardView {

    func browseByThemeSection(
        _ responsive: Responsive
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            HStack {

                Text("Adventure")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size:
                                responsive.isPad ? 30 : 18
                        )
                    )

                Spacer()
            }

            .padding(
                .horizontal,
                responsive.horizontalPadding
            )


            Button {

                showAdventureMap = true

            } label: {

                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {

                    Image("map")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity
                        )
                        .frame(
                            height:
                                responsive.adventurePreviewHeight
                        )
                        .clipped()
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius:
                                    responsive.isPad ? 20 : 16
                            )
                        )
                        .padding(8)
                        .background(
                            Color.appCardBackground
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius:
                                    responsive.isPad ? 24 : 20
                            )
                        )
                        .shadow(
                            color:
                                .black.opacity(
                                    colorScheme == .dark
                                    ? 0.25
                                    : 0.08
                                ),
                            radius: 8,
                            y: 3
                        )


                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Text("Explore Magical Worlds")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Bold",
                                        size:
                                            responsive.adventureTitleSize
                                    )
                                )
                                .foregroundColor(
                                    .appPrimaryText
                                )

                            Text("Tap to begin your adventure!")
                                .font(
                                    .custom(
                                        "OpenDyslexic-Regular",
                                        size:
                                            responsive.adventureSubtitleSize
                                    )
                                )
                                .foregroundColor(
                                    .primary
                                )
                        }

                        HStack {

                            Spacer()

                            Label(
                                "Explore",
                                systemImage:
                                    "arrow.right.circle.fill"
                            )
                            .font(
                                .custom(
                                    "OpenDyslexic-Bold",
                                    size:
                                        responsive.adventureButtonSize
                                )
                            )
                            .foregroundColor(
                                Color("ButtonColor")
                            )
                        }
                    }
                    .padding()
                }

                .background(
                    Color.appCardBackground
                )

                .clipShape(
                    RoundedRectangle(
                        cornerRadius:
                            responsive.isPad ? 28 : 22
                    )
                )

                .contentShape(Rectangle())
            }

            .buttonStyle(.plain)

            .padding(
                .horizontal,
                responsive.horizontalPadding
            )
        }
    }


    func themeChip(
        title: String,
        selected: Bool,
        responsive: Responsive
    ) -> some View {

        Text(title)
            .font(
                .custom(
                    "OpenDyslexic-Bold",
                    size:
                        responsive.isPad ? 20 : 12
                )
            )
            .foregroundColor(
                selected
                ? .white
                : .appPrimaryText
            )
            .padding(
                .horizontal,
                responsive.isPad ? 27 : 18
            )
            .padding(
                .vertical,
                responsive.isPad ? 13 : 9
            )
            .background(
                Capsule()
                    .fill(
                        selected
                        ? Color("ButtonColor")
                        : Color.appCardBackground
                    )
            )
            .overlay(
                Capsule()
                    .stroke(
                        selected
                        ? Color.clear
                        : Color.green.opacity(0.45),
                        lineWidth: 1
                    )
            )
            .shadow(
                color:
                    selected
                    ? .black.opacity(0.18)
                    : .clear,
                radius: 6,
                y: 3
            )
            .scaleEffect(
                selected ? 1.05 : 1.0
            )
            .animation(
                .spring(duration: 0.25),
                value: selected
            )
    }


    func storyCard(
        image: String,
        title: String,
        responsive: Responsive
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(
                    width:
                        responsive.storyCardWidth,
                    height:
                        responsive.storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius:
                            responsive.isPad ? 24 : 20
                    )
                )

            Text(title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size:
                            responsive.isPad ? 20 : 12
                    )
                )
                .foregroundColor(
                    .appPrimaryText
                )
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(
                            Color.appCardBackground.opacity(0.9)
                        )
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
        }

        .frame(
            width: responsive.storyCardWidth
        )
    }
}


#Preview {

    NavigationStack {

        DashboardView()
    }
}
