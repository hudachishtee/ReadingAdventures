import SwiftUI

// MARK: - PRIMARY BUTTON (Listen)
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                LinearGradient(
                    colors: [Color.yellow.opacity(0.9), Color.orange.opacity(0.9)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.8), lineWidth: 1.5)
            )
            .shadow(color: Color.orange.opacity(0.4), radius: 5, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

// MARK: - OUTLINE BUTTON (Back / Next)
struct OutlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            .background(
                LinearGradient(
                    colors: [
                        Color.orange.opacity(0.5),
                        Color.yellow.opacity(0.5)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.8), lineWidth: 1.5)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
