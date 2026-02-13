import SwiftUI

struct StoryIntroView: View {

    let story: Story
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {

            // Background
            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 48) {

                Spacer().frame(height: 40)

                // STORY TITLE
                ZStack {
                    TitleBannerView(title: story.title)

                    Rectangle()
                        .stroke(
                            Color(red: 125/255, green: 179/255, blue: 143/255),
                            lineWidth: 2
                        )
                        .frame(width: 800, height: 197)
                        .allowsHitTesting(false)
                }

                Spacer().frame(height: 20)

                // HERO IMAGE
                Image(story.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 750, height: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 44))
                    .shadow(color: .black.opacity(0.14), radius: 16, y: 10)

                Spacer()

                // START READING
                Button {
                    // NEXT: navigate to StoryPageView
                } label: {
                    Text("Start Reading")
                        .font(OpenDyslexicFont.bold(size: 42))
                        .foregroundColor(.black)
                        .padding(.vertical, 26)
                        .frame(width: 480)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color(red: 0.90, green: 0.96, blue: 0.90))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(
                                    Color(red: 125/255, green: 179/255, blue: 143/255),
                                    lineWidth: 2
                                )
                        )
                }

                Spacer().frame(height: 40)
            }
        }
        .overlay(
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.secondary)
                    .padding(24)
            },
            alignment: .topLeading
        )
    }
}

#Preview {
    StoryIntroView(
        story: Story(
            title: "The Extra Sandwich",
            description: "A story about sharing and kindness.",
            coverImage: "cover story 1"
        )
    )
}
