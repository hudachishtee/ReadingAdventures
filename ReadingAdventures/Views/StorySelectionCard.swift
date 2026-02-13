//
//  StorySelectionCard.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import SwiftUI

struct StorySelectionCard: View {

    let story: Story
    let isSelected: Bool

    private let cardWidth: CGFloat = 433
    private let cardHeight: CGFloat = 289
    private let cornerRadius: CGFloat = 36

    var body: some View {
        Image(story.coverImage)
            .resizable()
            .scaledToFill()
            .frame(width: cardWidth, height: cardHeight)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isSelected ? Color.green.opacity(0.5) : Color.clear,
                        lineWidth: 4
                    )
            )
            .shadow(color: .black.opacity(0.12), radius: 12, y: 8)
    }
}

#Preview {
    StorySelectionCard(
        story: Story(
            title: "The Extra Sandwich",
            description: "",
            coverImage: "cover story 1"
        ),
        isSelected: false
    )
}
