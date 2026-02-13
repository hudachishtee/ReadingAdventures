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

                // TITLE BANNER — BIGGER & STRONGER
                ZStack {
                    Color(red: 0.90, green: 0.96, blue: 0.90)
                        .frame(width: 620, height: 140)
                        .clipShape(TicketMask(), style: FillStyle(eoFill: true))

                    Text(story.title)
                        .font(OpenDyslexicFont.bold(size: 40))
                        .foregroundColor(
                            Color(red: 47/255, green: 93/255, blue: 98/255)
                        )
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }

                Spacer().frame(height: 20)

                // STORY IMAGE — MUCH BIGGER (HERO)
                Image(story.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 420, height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 44))
                    .shadow(color: .black.opacity(0.14), radius: 16, y: 10)

                Spacer()

                // START READING BUTTON — BIG & CLEAR
                Button {
                    // 👉 Navigate to StoryPageView (next step)
                } label: {
                    Text("Start Reading")
                        .font(OpenDyslexicFont.bold(size: 26))
                        .foregroundColor(
                            Color(red: 47/255, green: 93/255, blue: 98/255)
                        )
                        .padding(.vertical, 18)
                        .frame(maxWidth: 320)
                        .background(
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color(red: 0.90, green: 0.96, blue: 0.90))
                        )
                }

                Spacer().frame(height: 40)
            }
        }
        .overlay(
            // Close button (top-left)
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
