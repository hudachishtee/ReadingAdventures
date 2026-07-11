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
//    @State private var showPreview = false
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
            .sheet(item: $selectedStory) { story in

                StoryPreviewSheet(story: story) {

                    storyForReader = story

                    selectedStory = nil

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        navigateToReader = true
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
    // iPad Hero
    //==========================

    func ipadHero(_ responsive: Responsive) -> some View {

        GeometryReader { heroGeo in

            let w = heroGeo.size.width
            let h = heroGeo.size.height

            ZStack {

                RoundedRectangle(cornerRadius: responsive.heroCornerRadius)
                    .fill(Color("BackgroundBottom"))

                Circle()
                    .fill(Color.white.opacity(isDarkMode ? 0.08 : 0.18))
                    .frame(width: w * 1.3, height: w * 1.3)
                    .offset(x: w * 0.35, y: -h * 0.55)

                Circle()
                    .fill(Color.white.opacity(isDarkMode ? 0.04 : 0.10))
                    .frame(width: w * 1.6, height: w * 1.6)
                    .offset(x: -w * 0.30, y: h * 0.60)

                Image(systemName: "star.fill")
                    .foregroundColor(.yellow.opacity(0.9))
                    .font(.system(size: w * 0.035))
                    .offset(
                        x: w * 0.18,
                        y: -h * 0.20
                    )

                Image(systemName: "moon.fill")
                    .foregroundColor(.yellow.opacity(0.9))
                    .font(.system(size: w * 0.04))
                    .offset(
                        x: w * 0.30,
                        y: -h * 0.30
                    )

                Image(systemName: "star.fill")
                    .foregroundColor(.blue.opacity(0.55))
                    .font(.system(size: w * 0.03))
                    .offset(
                        x: w * 0.02,
                        y: -h * 0.05
                    )

                HStack(spacing: w * 0.04) {

                    VStack(alignment: .leading, spacing: h * 0.05) {

                        Text("Hi,\nReader!")
                            .font(.custom("OpenDyslexic-Bold", size: w * 0.065))
                            .foregroundColor(.appPrimaryText)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .minimumScaleFactor(0.7)

                        Text("Ready for a new\nadventure?")
                            .font(.custom("OpenDyslexic-Regular", size: w * 0.036))
                            .foregroundColor(.appPrimaryText)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }
                    .layoutPriority(2)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer(minLength: 0)

                    Image("owl_logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: min(w * 0.22, 220))
                        .padding(.trailing, w * 0.02)
                }
                .frame(width: w * 0.88, alignment: .leading)
                .offset(x: -w * 0.02)
            }
            .frame(width: w, height: h) // <- THE FIX: ZStack now fills the reader's bounds
        }
        .frame(height: responsive.heroHeight)
        .frame(width: responsive.heroWidth)
        .clipShape(RoundedRectangle(cornerRadius: responsive.heroCornerRadius))
        .padding(.horizontal, responsive.horizontalPadding)
    }

    //==========================
    // iPhone Hero
    //==========================

    func iphoneHero(_ responsive: Responsive) -> some View {

        GeometryReader { heroGeo in

            let w = heroGeo.size.width
            let h = heroGeo.size.height

            ZStack {

                RoundedRectangle(cornerRadius: responsive.heroCornerRadius)
                    .fill(Color("BackgroundBottom"))

                Circle()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: w * 0.80, height: w * 0.80)
                    .offset(x: w * 0.30, y: -h * 0.65)

                Circle()
                    .fill(Color.blue.opacity(0.10))
                    .frame(width: w * 1.05, height: w * 1.05)
                    .offset(x: -w * 0.22, y: h * 0.55)
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow.opacity(0.9))
                    .font(.system(size: w * 0.045))
                    .offset(
                        x: w * 0.16,
                        y: -h * 0.22
                    )

                Image(systemName: "moon.fill")
                    .foregroundColor(.yellow.opacity(0.9))
                    .font(.system(size: w * 0.05))
                    .offset(
                        x: w * 0.28,
                        y: -h * 0.30
                    )

                Image(systemName: "star.fill")
                    .foregroundColor(.blue.opacity(0.55))
                    .font(.system(size: w * 0.04))
                    .offset(
                        x: w * 0.02,
                        y: -h * 0.08
                    )

                HStack(alignment: .center, spacing: w * 0.04) {

                    VStack(alignment: .leading, spacing: h * 0.06) {

                        Text("Hi,\nReader!")
                            .font(.custom("OpenDyslexic-Bold", size: w * 0.078))
                            .foregroundColor(.appPrimaryText)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .minimumScaleFactor(0.7)

                        Text("Ready for a new\nadventure?")
                            .font(.custom("OpenDyslexic-Regular", size: w * 0.044))
                            .foregroundColor(.appPrimaryText)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                    }
                    .layoutPriority(2)
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 0)

                    Image("owl_logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: min(w * 0.22, 110))
                        .padding(.trailing, w * 0.02)
                }
                .frame(width: w * 0.88)
                .padding(.horizontal, w * 0.02)
            }
            .frame(width: w, height: h) // <- THE FIX: ZStack now fills the reader's bounds
        }
        .frame(height: responsive.heroHeight)
        .frame(width: responsive.heroWidth)
        .clipShape(RoundedRectangle(cornerRadius: responsive.heroCornerRadius))
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

//                HStack(spacing: 6) {
//
//                    Circle()
//                        .fill(Color.blue.opacity(0.5))
//                        .frame(
//                            width: responsive.isPad ? 10 : 7,
//                            height: responsive.isPad ? 10 : 7
//                        )
//
//                    Circle()
//                        .fill(Color.blue.opacity(0.25))
//                        .frame(
//                            width: responsive.isPad ? 10 : 7,
//                            height: responsive.isPad ? 10 : 7
//                        )
//
//                    Circle()
//                        .fill(Color.blue.opacity(0.25))
//                        .frame(
//                            width: responsive.isPad ? 10 : 7,
//                            height: responsive.isPad ? 10 : 7
//                        )
//                }
//                .padding(.trailing, 25)
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
//                showPreview = true
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
                .offset(x: responsive.isPad ? 0 : 6)
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
//                            showPreview = true
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
                    "OpenDyslexic-Bold",
                    size: responsive.isPad ? 20 : 12
                )
            )
            .foregroundColor(
                selected ? .white : .appPrimaryText
            )
            .padding(.horizontal, responsive.isPad ? 27 : 18)
            .padding(.vertical, responsive.isPad ? 13 : 9)
            .background(
                Capsule()
                    .fill(
                        selected
                        ? Color("ButtonColor")      // darker green
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
                color: selected ? .black.opacity(0.18) : .clear,
                radius: 6,
                y: 3
            )
            .scaleEffect(selected ? 1.05 : 1.0)
            .animation(.spring(duration: 0.25), value: selected)
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

