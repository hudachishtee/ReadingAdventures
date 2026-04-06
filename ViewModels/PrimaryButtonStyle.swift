import SwiftUI

// MARK: - PRIMARY BUTTON (Listen with active state)
struct PrimaryButtonStyle: ButtonStyle {
    
    var isActive: Bool
    var themeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(
                ZStack {
                    
                    // Glass base
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                    
                    // Active state → theme color
                    if isActive {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        themeColor,
                                        themeColor.opacity(0.7)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                    
                    // Border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.6), lineWidth: 1.2)
                }
            )
            .shadow(
                color: themeColor.opacity(isActive ? 0.4 : 0.15),
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
    
    var themeColor: Color
    
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
                    
                    // Subtle theme tint
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [
                                    themeColor.opacity(0.25),
                                    themeColor.opacity(0.15)
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
            .shadow(color: themeColor.opacity(0.15), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}


// MARK: - PREVIEW
#Preview("Buttons Preview") {
    
    @Previewable @State var isPlaying = false
    
    let theme = Color.blue // 👈 change this to test different story themes
    
    return ZStack {
        LinearGradient(
            colors: [
                theme.opacity(0.3),
                theme.opacity(0.6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
        VStack(spacing: 20) {
            
            Button(isPlaying ? "Pause" : "Listen") {
                isPlaying.toggle()
            }
            .buttonStyle(
                PrimaryButtonStyle(
                    isActive: isPlaying,
                    themeColor: theme
                )
            )
            
            HStack(spacing: 20) {
                Button("Back") {}
                    .buttonStyle(
                        OutlineButtonStyle(themeColor: theme)
                    )
                
                Button("Next") {}
                    .buttonStyle(
                        OutlineButtonStyle(themeColor: theme)
                    )
            }
        }
        .padding()
    }
}
