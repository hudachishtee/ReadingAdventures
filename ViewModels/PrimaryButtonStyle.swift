import SwiftUI

// MARK: - PRIMARY BUTTON (Listen with active state)
struct PrimaryButtonStyle: ButtonStyle {
    
    var isActive: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    
                    if isActive {
                        // ✅ ACTIVE → strong gradient
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [Color.yellow, Color.orange],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    } else {
                        // ✅ IDLE → glass look (same as other buttons)
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.ultraThinMaterial)
                        
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.yellow.opacity(0.4),
                                        Color.orange.opacity(0.4)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                    
                    // Border (same for both)
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1.2)
                }
            )
            .shadow(
                color: Color.orange.opacity(isActive ? 0.4 : 0.15),
                radius: 6,
                x: 0,
                y: 3
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .animation(.easeInOut(duration: 0.2), value: isActive)
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
                ZStack {
                    // Glass base
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.ultraThinMaterial)
                    
                    // Light gradient tint
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.yellow.opacity(0.4),
                                    Color.orange.opacity(0.4)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    // Border
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.7), lineWidth: 1.2)
                }
            )
            .shadow(color: Color.orange.opacity(0.15), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}


// MARK: - PREVIEW
#Preview("Buttons Preview") {
    
    @Previewable @State var isPlaying = false
    
    return ZStack {
        LinearGradient(
            colors: [Color.yellow.opacity(0.3), Color.orange.opacity(0.6)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        VStack(spacing: 20) {
            
            Button(isPlaying ? "Pause" : "Listen") {
                isPlaying.toggle()
            }
            .buttonStyle(PrimaryButtonStyle(isActive: isPlaying))
            
            HStack(spacing: 20) {
                Button("Back") {}
                    .buttonStyle(OutlineButtonStyle())
                
                Button("Next") {}
                    .buttonStyle(OutlineButtonStyle())
            }
        }
        .padding()
    }
}
