//import SwiftUI
//
//struct StoryRowCard: View {
//
//    let story: Story
//    let imageOnLeft: Bool
//
//    var body: some View {
//        HStack(spacing: 32) {
//
//            if imageOnLeft {
//                storyImage
//                storyText
//            } else {
//                storyText
//                storyImage
//            }
//        }
//        .padding(.horizontal, 60)
//    }
//
//    // MARK: - Image
//    private var storyImage: some View {
//        Image(story.coverImage)
//            .resizable()
//            .scaledToFill()
//            .frame(width: 280, height: 210)
//            .clipShape(RoundedRectangle(cornerRadius: 36))
//            .shadow(color: .black.opacity(0.12), radius: 12, y: 8)
//    }
//
//    // MARK: - Text Bubble
//    private var storyText: some View {
//        VStack(alignment: .leading, spacing: 18) {
//
//            Text(story.title)
//                .font(OpenDyslexicFont.bold(size: 30))
//                .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.3))
//
//            Text(story.description)
//                .font(OpenDyslexicFont.regular(size: 22))
//                .foregroundColor(.secondary)
//        }
//        .padding(30)
//        .frame(maxWidth: 460, alignment: .leading)
//        .background(
//            RoundedRectangle(cornerRadius: 36)
//                .fill(Color(red: 0.9, green: 0.96, blue: 0.9))
//        )
//    }
//}
//
//#Preview {
//    StoryRowCard(
//        story: Story(
//            title: "The Extra Sandwich",
//            description: "A story about sharing and kindness.",
//            coverImage: "cover story 1"
//        ),
//        imageOnLeft: true
//    )
//}
