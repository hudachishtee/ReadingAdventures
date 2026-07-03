import SwiftUI

struct DashboardView: View {
    
    @Environment(\.colorScheme) private var colorScheme

    private var isDarkMode: Bool {
        colorScheme == .dark
    }
    @ObservedObject private var progress = ProgressManager.shared
    @ObservedObject private var savedWordsManager = SavedWordsManager.shared
    @State private var selectedTheme: DashboardTheme = .courage
    @State private var selectedStory: Story?
    @State private var showPreview = false
    @State private var showAllStories = false
    @State private var navigateToReader = false
    @State private var storyForReader: Story?
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
    var body: some View {

        GeometryReader { geo in

            let responsive = Responsive(
                width: geo.size.width,
                height: geo.size.height,
                safeTop: geo.safeAreaInsets.top,
                safeBottom: geo.safeAreaInsets.bottom
            )

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading,
                       spacing: responsive.isPad ? 18 : 12)
                {
                    heroSection(responsive)

                    continueReadingSection(responsive)

                    browseByThemeSection(responsive)
                        .padding(.top, 10)

                    Spacer(minLength: 120)
                }
//                .frame(maxWidth: responsive.contentWidth)
                .frame(maxWidth: .infinity)
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
            .sheet(isPresented: $showPreview) {

                if let story = selectedStory {

                    StoryPreviewSheet(story: story) {

                        storyForReader = story
                        showPreview = false

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            navigateToReader = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $showAllStories) {
                HomeView()
            }
            .navigationDestination(isPresented: $navigateToReader) {

                if let story = storyForReader {
                    StoryReaderView(story: story)
                }
            }
        }
    }
}
// MARK: - Hero

private extension DashboardView {

    func heroSection(_ responsive: Responsive) -> some View {
        Group {
            if responsive.isPad {
                ipadHero(responsive)
            } else {
                iphoneHero(responsive)
            }
        }
    }

    //==========================
    // iPad Hero (YOUR ORIGINAL)
    //==========================

    func ipadHero(_ responsive: Responsive) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: responsive.isPad ? 40 : 32)
                .fill(Color("BackgroundBottom"))

            Circle()
                .fill(
                    Color.white.opacity(
                        isDarkMode ? 0.08 : 0.18
                    )
                )
                .frame(
                    width: responsive.heroWidth * 1.3,
                    height: responsive.heroWidth * 1.3
                )
                .offset(
                    x: responsive.heroWidth * 0.35,
                    y: -responsive.heroHeight * 0.55
                )

            Circle()
                .fill(
                    Color.white.opacity(
                        isDarkMode ? 0.04 : 0.10
                    )
                )
                .frame(
                    width: responsive.heroWidth * 1.6,
                    height: responsive.heroWidth * 1.6
                )
                .offset(
                    x: -responsive.heroWidth * 0.30,
                    y: responsive.heroHeight * 0.60
                )

            Image(systemName: "star.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: 28))
                .offset(
                    x: responsive.heroWidth * 0.18,
                    y: -responsive.heroHeight * 0.22
                )
            
            Image(systemName: "moon.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: 32))
                .offset(
                    x: responsive.heroWidth * 0.28,
                    y: -responsive.heroHeight * 0.30
                )
            Image(systemName: "star.fill")
                .foregroundColor(.blue.opacity(0.55))
                .font(.system(size: 24))
                .offset(
                    x: responsive.heroWidth * 0.02,
                    y: -responsive.heroHeight * 0.04
                )
            
            HStack(spacing: responsive.spacing(12)) {

                VStack(alignment: .leading,
                       spacing: responsive.spacing(8)) {

                    Text("Hi,\nReader!")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: responsive.heroTitleSize
                        ))
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)

                    Text("Ready for a new\nadventure?")
                        .font(.custom(
                            "OpenDyslexic-Regular",
                            size: responsive.heroSubtitleSize
                        ))
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)

                Image("owl_logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: responsive.heroOwlWidth)
            }
            .padding(responsive.spacing(18))
        }
        .frame(height: responsive.heroHeight)
        .frame(width: responsive.heroWidth)
        .clipShape(
            RoundedRectangle(cornerRadius: responsive.heroCornerRadius)
        )
        .padding(.horizontal, responsive.horizontalPadding)
    }

    //==========================
    // iPhone Hero
    //==========================

    func iphoneHero(_ responsive: Responsive) -> some View {

        ZStack {

            RoundedRectangle(cornerRadius: responsive.isPad ? 40 : 32)
                .fill(Color("BackgroundBottom"))
            
            Circle()
                .fill(Color.white.opacity(0.18))
                .frame(
                    width: responsive.width(0.80),
                    height: responsive.width(0.80)
                )
                .offset(x: 120, y: -150)

            Circle()
                .fill(Color.blue.opacity(0.10))
                .frame(
                    width: responsive.width(1.05),
                    height: responsive.width(1.05)
                )
                .offset(
                    x: -responsive.heroWidth * 0.22,
                    y: responsive.heroHeight * 0.35
                )
            
            HStack(alignment: .center) {

                VStack(alignment: .leading, spacing: 10) {
                    Text("Hi,\nReader!")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: responsive.heroTitleSize
                        ))
                        .foregroundColor(.appPrimaryText)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Ready for a new\nadventure?")
                        .font(.custom("OpenDyslexic-Regular", size: responsive.heroSubtitleSize))
                        .foregroundColor(.appPrimaryText)
                        .lineSpacing(4)
                }

                Spacer(minLength: responsive.spacing(12))

                Image("owl_logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: responsive.heroOwlWidth)
                    .padding(.trailing, responsive.spacing(8))
            }
            .padding(.horizontal, responsive.horizontalPadding)
            .padding(.vertical, responsive.spacing(12))
        }
        .frame(height: responsive.heroHeight)
        .frame(width: responsive.heroWidth)
        .clipShape(
            RoundedRectangle(cornerRadius: responsive.heroCornerRadius)
        )
        .padding(.horizontal, responsive.horizontalPadding)
    }
}
// MARK: - Continue Reading

private extension DashboardView {

    func continueReadingSection(_ responsive: Responsive) -> some View {

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
                        size: responsive.isPad ? 30 : 16
                    )
                )

                Spacer()

                HStack(spacing: 6) {

                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(
                            width: responsive.isPad ? 10 : 7,
                            height: responsive.isPad ? 10 : 7
                        )

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(
                            width: responsive.isPad ? 10 : 7,
                            height: responsive.isPad ? 10 : 7
                        )

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(
                            width: responsive.isPad ? 10 : 7,
                            height: responsive.isPad ? 10 : 7
                        )
                }
                .padding(.trailing, 25)
            }
            .padding(.leading, responsive.horizontalPadding)
            .padding(.trailing, responsive.horizontalPadding)
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 16) {

                    if hasReadingProgress,
                       let story = lastOpenedStory {

                        continueCard(
                            story: story,
                            responsive: responsive
                        )

                    } else {

                        continueCard(
                            story: sampleStories[1],
                            responsive: responsive
                        )

                        continueCard(
                            story: sampleStories[0],
                            responsive: responsive
                        )

                        continueCard(
                            story: sampleStories[2],
                            responsive: responsive
                        )
                    }
                }
                .padding(.leading, responsive.horizontalPadding)
                .padding(.trailing, responsive.horizontalPadding)            }
        }
    }

    func continueCard(
        story: Story,
        responsive: Responsive
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Image(story.coverImage)
                .resizable()
                .scaledToFill()
                .frame(
                    width: responsive.storyCardWidth,
                    height: responsive.storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: responsive.isPad ? 24 : 20
                    )
                )

            Text(story.title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: responsive.isPad ? 20 : 13
                    )
                )
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(
                    height: responsive.isPad ? 48 : 40,
                    alignment: .topLeading
                )
        }
        .onTapGesture {

            if hasReadingProgress &&
               progress.lastOpenedStoryTitle == story.title {

                storyForReader = story
                navigateToReader = true

            } else {

                selectedStory = story
                showPreview = true
            }
        }
    }
}
// MARK: - Browse Theme

private extension DashboardView {

    func browseByThemeSection(_ responsive: Responsive) -> some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("Browse by Theme")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: responsive.isPad ? 30 : 18
                        )
                    )

                Spacer()

                Button {
                    showAllStories = true
                } label: {
                    Text("View All")
                        .font(
                            .custom(
                                "OpenDyslexic-Regular",
                                size: responsive.isPad ? 13 : 11
                            )
                        )
                        .lineLimit(1)
                        .fixedSize()
                }
                .foregroundColor(.appPrimaryText.opacity(0.65))
                .offset(x: responsive.isPad ? 0 : -12)
            }
            .padding(.leading, responsive.horizontalPadding)
            .padding(.trailing, responsive.horizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 12) {

                    ForEach(DashboardTheme.allCases, id: \.self) { theme in

                        themeChip(
                            title: theme.rawValue,
                            selected: selectedTheme == theme,
                            responsive: responsive
                        )
                        .onTapGesture {
                            selectedTheme = theme
                        }
                    }
                }
                .padding(.leading, responsive.horizontalPadding)
                .padding(.trailing, responsive.horizontalPadding)
            }

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 20) {

                    ForEach(filteredStories) { story in

                        storyCard(
                            image: story.coverImage,
                            title: story.title,
                            responsive: responsive
                        )
                        .onTapGesture {

                            selectedStory = story
                            showPreview = true
                        }
                    }
                }
                .padding(.leading, responsive.horizontalPadding)
                .padding(.trailing, responsive.horizontalPadding)
            }
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
                    "OpenDyslexic-Regular",
                    size: responsive.isPad ? 20 : 12                )
            )
            .foregroundColor(
                selected ? .appPrimaryText : .appPrimaryText
            )
            .padding(.horizontal, responsive.isPad ? 27 : 18)
            .padding(.vertical, responsive.isPad ? 13 : 9)
            .background(
                Capsule()
                    .fill(
                        selected
                        ? Color.appCardBackground
                        : Color.appCardBackground.opacity(0.80)
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
                    width: responsive.storyCardWidth,
                    height: responsive.storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: responsive.isPad ? 24 : 20
                    )
                )

            Text(title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: responsive.isPad ? 20 : 12
                    )
                )
                .padding()

                .foregroundColor(.appPrimaryText)
                .frame(
                    height: responsive.isPad ? 48 : 40,
                    alignment: .topLeading
                )
        }
        .frame(width: responsive.storyCardWidth)    }
}
#Preview {
    NavigationStack {
        DashboardView()
    }
}

