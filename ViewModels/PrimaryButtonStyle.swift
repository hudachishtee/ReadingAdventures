import SwiftUI

// MARK: - SHARED GLASS BACKGROUND

struct GlassBackground: View {
    
    var cornerRadius: CGFloat
    var themeColor: Color
    
    var isActive: Bool = false
    
    var activeOpacity: Double = 1.0
    var tintOpacity: Double = 0.20
    
    var body: some View {
        
        ZStack {
            
            // MARK: - GLASS BASE
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.ultraThinMaterial)
            
            // MARK: - THEME TINT / ACTIVE STATE
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(
                        colors: [
                            themeColor.opacity(
                                isActive
                                ? activeOpacity
                                : tintOpacity
                            ),
                            
                            themeColor.opacity(
                                isActive
                                ? activeOpacity * 0.7
                                : tintOpacity * 0.6
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            // MARK: - BORDER
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    Color.white.opacity(0.6),
                    lineWidth: 1.2
                )
        }
    }
}


// MARK: - PRIMARY BUTTON (Listen / Pause)

struct PrimaryButtonStyle: ButtonStyle {
    
    var isActive: Bool
    var themeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundStyle(.primary)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(
                GlassBackground(
                    cornerRadius: 20,
                    themeColor: themeColor,
                    isActive: isActive,
                    activeOpacity: 1.0,
                    tintOpacity: 0
                )
            )
            .shadow(
                color: themeColor.opacity(
                    isActive ? 0.40 : 0.15
                ),
                radius: 6,
                x: 0,
                y: 3
            )
            .scaleEffect(
                configuration.isPressed ? 0.95 : 1
            )
            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
            .animation(
                .easeInOut(duration: 0.2),
                value: isActive
            )
    }
}


// MARK: - OUTLINE BUTTON (Back / Next)

struct OutlineButtonStyle: ButtonStyle {
    
    var themeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.custom("OpenDyslexic-Bold", size: 16))
            .foregroundStyle(.primary)
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            .background(
                GlassBackground(
                    cornerRadius: 18,
                    themeColor: themeColor,
                    tintOpacity: 0.25
                )
            )
            .shadow(
                color: themeColor.opacity(0.15),
                radius: 4,
                x: 0,
                y: 2
            )
            .scaleEffect(
                configuration.isPressed ? 0.95 : 1
            )
            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}


// MARK: - SPEED CONTROL BACKGROUND

struct SpeedControlBackground: View {
    
    var themeColor: Color
    
    var body: some View {
        
        GlassBackground(
            cornerRadius: 24,
            themeColor: themeColor,
            tintOpacity: 0.18
        )
    }
}


// MARK: - PREVIEW

#Preview("Buttons Preview") {
    
    @Previewable @State var isPlaying = false
    
    let theme = Color.blue
    
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
        
        VStack(spacing: 24) {
            
            // MARK: - PRIMARY
            
            Button(isPlaying ? "Pause" : "Listen") {
                isPlaying.toggle()
            }
            .buttonStyle(
                PrimaryButtonStyle(
                    isActive: isPlaying,
                    themeColor: theme
                )
            )
            
            // MARK: - OUTLINE
            
            HStack(spacing: 20) {
                
                Button("Back") {}
                    .buttonStyle(
                        OutlineButtonStyle(
                            themeColor: theme
                        )
                    )
                
                Button("Next") {}
                    .buttonStyle(
                        OutlineButtonStyle(
                            themeColor: theme
                        )
                    )
            }
            
            // MARK: - SPEED CONTROL PREVIEW
            
            HStack {
                
                Text("−")
                    .font(.headline.bold())
                
                Spacer()
                
                Text("1.0x")
                    .font(.subheadline.weight(.medium))
                
                Spacer()
                
                Text("+")
                    .font(.headline.bold())
            }
            .foregroundStyle(.primary)
            .padding(.horizontal, 16)
            .frame(width: 220, height: 48)
            .background(
                SpeedControlBackground(
                    themeColor: theme
                )
            )
        }
        .padding()
    }
}
