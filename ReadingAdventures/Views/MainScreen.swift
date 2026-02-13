import SwiftUI

struct MainScreenView: View {

    @State private var selectedStory: Story?
    @State private var showDetails: Bool = false

    let stories: [Story] = [
        Story(
            title: "The Extra Sandwich",
            description: "A story about sharing and kindness.",
            coverImage: "cover story 1"
        ),
        Story(
            title: "The Lost Crayon",
            description: "A story about not giving up.",
            coverImage: "cover story 2"
        ),
        Story(
            title: "The Quiet Duck",
            description: "A story about quiet strength.",
            coverImage: "cover story 3"
        )
    ]

    var body: some View {
        ZStack(alignment: .topLeading) {

            // Background (LOCKED)
            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            // Title Banner — PIXEL LOCKED
            TitleBannerView()
                .padding(.leading, 180)
                .padding(.top, 87)

            VStack(spacing: 70) {

                Spacer().frame(height: 300)

                ForEach(stories) { story in
                    if selectedStory?.id == story.id {
                        expandedCard(for: story)
                            .onTapGesture { collapseCard() }
                            .transition(.opacity)
                    } else {
                        StorySelectionCard(
                            story: story,
                            isSelected: false
                        )
                        .onTapGesture {
                            expandCard(story)
                        }
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Actions

    private func expandCard(_ story: Story) {
        showDetails = false

        withAnimation(.easeInOut(duration: 0.35)) {
            selectedStory = story
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut(duration: 0.25)) {
                showDetails = true
            }
        }
    }

    private func collapseCard() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showDetails = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedStory = nil
            }
        }
    }

    // MARK: - Expanded Card (FINAL TYPOGRAPHY)

    @ViewBuilder
    private func expandedCard(for story: Story) -> some View {
        HStack(spacing: 24) {

            Image(story.coverImage)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: showDetails ? -24 : 0)
                .animation(.easeInOut(duration: 0.35), value: showDetails)

            VStack(alignment: .leading, spacing: 16) {
                if showDetails {

                    // 🟢 STORY TITLE — ACCESSIBLE SIZE
                    Text(story.title)
                        .font(OpenDyslexicFont.bold(size: 30))
                        .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.3))
                        .transition(.move(edge: .trailing).combined(with: .opacity))

                    // 🟢 STORY DESCRIPTION — ACCESSIBLE SIZE
                    Text(story.description)
                        .font(OpenDyslexicFont.regular(size: 19))
                        .foregroundColor(.secondary)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: showDetails)

            Spacer()
        }
        .padding(28)
        .frame(maxWidth: 720)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(red: 0.9, green: 0.96, blue: 0.9))
        )
    }
}

#Preview {
    MainScreenView()
}
