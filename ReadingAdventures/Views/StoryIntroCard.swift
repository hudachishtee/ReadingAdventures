//
//  StoryIntroCard.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import SwiftUI

struct StoryIntroView: View {

    let story: Story
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 28) {

                    Image(story.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 24))

                    Text(story.title)
                        .font(OpenDyslexicFont.bold(size: 32))

                    Text(story.description)
                        .font(OpenDyslexicFont.regular(size: 20))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button("Start Reading") {
                        // Reading screen next
                    }
                    .font(OpenDyslexicFont.bold(size: 20))
                    .padding()
                    .frame(maxWidth: 240)
                    .background(Color.green.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding(40)
                .frame(maxWidth: 600)
                .background(
                    RoundedRectangle(cornerRadius: 36)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 16)
                )

                Spacer()

                Button("Close") {
                    dismiss()
                }
                .font(OpenDyslexicFont.regular(size: 18))
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            }
        }
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
