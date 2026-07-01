import SwiftUI

struct MiniFlashCard: View {

    var body: some View {

        RoundedRectangle(cornerRadius: 30)
            .fill(
                Color("MiniGameOption3")
                    .opacity(0.85)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            )
            .shadow(
                color: .black.opacity(0.12),
                radius: 12,
                x: 0,
                y: 6
            )
    }
}
