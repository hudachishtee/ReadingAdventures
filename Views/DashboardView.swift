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
    
    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    private var heroHeight: CGFloat {
        isIPad ? 330 : 200
    }
    
    private var storyCardWidth: CGFloat {
        isIPad ? 460 : 230
    }
    
    private var storyImageHeight: CGFloat {
        isIPad ? 260 : 125
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
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading,
                   spacing: isIPad ? 18 : 12)
            {
                
                heroSection
                
                continueReadingSection
                
                browseByThemeSection
                    .padding(.top, 10)
                
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
        .sheet(isPresented: $showPreview) {

            if let story = selectedStory {

                StoryPreviewSheet(
                    story: story
                ) {

                    storyForReader = story
                    showPreview = false

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.1
                    ) {
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
// MARK: - Hero

// MARK: - Hero

private extension DashboardView {

    var heroSection: some View {
        Group {
            if isIPad {
                ipadHero
            } else {
                iphoneHero
            }
        }
    }

    //==========================
    // iPad Hero (YOUR ORIGINAL)
    //==========================

    var ipadHero: some View {

        ZStack {

            RoundedRectangle(cornerRadius: isIPad ? 40 : 32)
                .fill(Color("BackgroundBottom"))

            Circle()
                .fill(
                    Color.white.opacity(
                        isDarkMode ? 0.08 : 0.18
                    )
                )
                .frame(width: 700, height: 700)
                .offset(x: 260, y: -320)

            Circle()
                .fill(
                    Color.white.opacity(
                        isDarkMode ? 0.04 : 0.10
                    )
                )
                .frame(width: 900, height: 900)
                .offset(x: -220, y: 320)

            Image(systemName: "star.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: 28))
                .offset(x: 120, y: -90)

            Image(systemName: "moon.fill")
                .foregroundColor(.yellow.opacity(0.9))
                .font(.system(size: 32))
                .offset(x: 180, y: -120)

            Image(systemName: "star.fill")
                .foregroundColor(.blue.opacity(0.55))
                .font(.system(size: 24))
                .offset(x: 40, y: -20)

            HStack {

                VStack(alignment: .leading, spacing: 18) {

                    Text("Hi, Reader!")
                        .font(.custom("OpenDyslexic-Bold", size: 48))

                    Text("Ready for a new\nadventure?")
                        .font(.custom("OpenDyslexic-Regular", size: 28))
                        .lineSpacing(8)
                }

                Spacer()

                Image("owl_logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450)
            }
            .padding(24)
        }
        .frame(height: 330)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .padding(.horizontal, isIPad ? 22 : 16)
    }

    //==========================
    // iPhone Hero
    //==========================

    var iphoneHero: some View {

        ZStack {

            RoundedRectangle(cornerRadius: isIPad ? 40 : 32)
                .fill(Color("BackgroundBottom"))
            
            Circle()
                .fill(Color.white.opacity(0.18))
                .frame(width: 320, height: 320)
                .offset(x: 120, y: -150)

            Circle()
                .fill(Color.blue.opacity(0.10))
                .frame(width: 420, height: 420)
                .offset(x: -100, y: 150)

            HStack(alignment: .center) {

                VStack(alignment: .leading, spacing: 10) {

                    Text("Hi, Reader!")
                        .font(.custom("OpenDyslexic-Bold", size: 28))
                        .foregroundColor(.appPrimaryText)

                    Text("Ready for a new\nadventure?")
                        .font(.custom("OpenDyslexic-Regular", size: 16))
                        .foregroundColor(.appPrimaryText)
                        .lineSpacing(4)
                }

                Spacer()

                Image("owl_logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            .padding(.horizontal, 18)
            .padding(.top, -12)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .padding(.horizontal, 16)
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
                        size: isIPad ? 30 : 16
                    )
                )

                Spacer()

                HStack(spacing: 6) {

                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(
                            width: isIPad ? 10 : 7,
                            height: isIPad ? 10 : 7
                        )

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(
                            width: isIPad ? 10 : 7,
                            height: isIPad ? 10 : 7
                        )

                    Circle()
                        .fill(Color.blue.opacity(0.25))
                        .frame(
                            width: isIPad ? 10 : 7,
                            height: isIPad ? 10 : 7
                        )
                }
                .padding(.trailing, 25)
            }
            .padding(.leading, isIPad ? 30 : 28)
            .padding(.trailing, isIPad ? 12 : 16)
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 16) {

                    if hasReadingProgress,
                       let story = lastOpenedStory {

                        continueCard(
                            story: story
                        )

                    } else {

                        continueCard(
                            story: sampleStories[1]
                        )

                        continueCard(
                            story: sampleStories[0]
                        )

                        continueCard(
                            story: sampleStories[2]
                        )
                    }
                }
                .padding(.leading, isIPad ? 30 : 28)
                .padding(.trailing, isIPad ? 30 : 28)
            }
        }
    }

    func continueCard(
        story: Story
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Image(story.coverImage)
                .resizable()
                .scaledToFill()
                .frame(
                    width: storyCardWidth,
                    height: storyImageHeight
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: isIPad ? 24 : 20
                    )
                )

            Text(story.title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 20 : 13
                    )
                )
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(
                    height: isIPad ? 48 : 40,
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

    var browseByThemeSection: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text("Browse by Theme")
                    .font(
                        .custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 30 : 18
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
                                size: isIPad ? 13 : 11
                            )
                        )
                        .lineLimit(1)
                        .fixedSize()
                }
                .foregroundColor(.appPrimaryText.opacity(0.65))
                .offset(x: isIPad ? 0 : -12)
            }
            .padding(.leading, isIPad ? 30 : 30)
            .padding(.trailing, isIPad ? 12 : 20)
            
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 12) {

                    ForEach(DashboardTheme.allCases, id: \.self) { theme in

                        themeChip(
                            title: theme.rawValue,
                            selected: selectedTheme == theme
                        )
                        .onTapGesture {
                            selectedTheme = theme
                        }
                    }
                }
                .padding(.leading, isIPad ? 30 : 28)
                .padding(.trailing, isIPad ? 30 : 28)
            }

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 20) {

                    ForEach(filteredStories) { story in

                        storyCard(
                            image: story.coverImage,
                            title: story.title
                        )
                        .onTapGesture {

                            selectedStory = story
                            showPreview = true
                        }
                    }
                }
                .padding(.leading, isIPad ? 30 : 30)
                .padding(.trailing, isIPad ? 30 : 30)
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
                    size: isIPad ? 20 : 12
                )
            )
            .foregroundColor(
                selected ? .appPrimaryText : .appPrimaryText
            )
            .padding(.horizontal, isIPad ? 27 : 18)
            .padding(.vertical, isIPad ? 13 : 9)
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
                    RoundedRectangle(
                        cornerRadius: isIPad ? 24 : 20
                    )
                )

            Text(title)
                .font(
                    .custom(
                        "OpenDyslexic-Bold",
                        size: isIPad ? 20 : 12
                    )
                )
                .padding()

                .foregroundColor(.appPrimaryText)
                .frame(
                    height: isIPad ? 48 : 40,
                    alignment: .topLeading
                )
        }
        .frame(width: storyCardWidth)
    }
}
#Preview {
    NavigationStack {
        DashboardView()
    }
}
