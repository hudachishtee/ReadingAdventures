import Foundation

struct StoryPage: Identifiable {
    let id = UUID()
    let imageName: String
    let paragraphs: [String]
}
