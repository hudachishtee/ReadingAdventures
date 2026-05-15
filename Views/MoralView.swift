import SwiftUI

enum MoralBackgroundStyle {
    case appTheme
    case storyTheme
}

struct MoralView: View {
    
    let story: Story
    
    @State private var goToVocabulary = false
    
    // TEST HERE
    let backgroundStyle: MoralBackgroundStyle = .appTheme
    // .appTheme
    // .storyTheme
    
    var body: some View {
        
        GeometryReader { geo in
            
            let scale = Scale.factor(geo)
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            
            ZStack {
                
                backgroundView
                
                VStack(spacing: 0) {
                    
                    Spacer(minLength: 24 * scale)
                    
                    // TITLE
                    // TITLE
                    Text("Moral of the Story")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 32 : 25
                        ))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .padding(12)
                        .frame(maxWidth: isIPad ? 620 : .infinity)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                            .fill(Color.appCardBackground.opacity(0.6))
                        )
                        .padding(.horizontal, isIPad ? 60 : 4)
                    
                    Spacer()
                    
                    // MORAL CARD + OWL
                    ZStack(alignment: .topTrailing) {
                        
                        Text(story.moral)
                            .font(.custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 28 : 22
                            ))
                            .foregroundColor(.black)                            .multilineTextAlignment(.center)
                            .lineSpacing(20)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 34)
                            .frame(maxWidth: isIPad ? 650 : 340)
                            .background(
                                RoundedRectangle(cornerRadius: 36)
                                    .fill(Color("MiniGameOption"))
                            )
                        
                        // OWL ON SIDE
                        Image("moral_owl")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isIPad ? 180 : 95)
                            .offset(
                                x: isIPad ? -5 : 12,
                                y: isIPad ? -150 : -42
                            )
                    }
                    
                    Spacer()
                    
                    // BUTTON
                    Button {
                        goToVocabulary = true
                    } label: {
                        Text("Learn New Words!")
                            .font(.custom(
                                "OpenDyslexic-Bold",
                                size: isIPad ? 24 : 20
                            ))
                            .foregroundColor(.black)
                            .padding(.horizontal, 34)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(
                                                    red: 253/255,
                                                    green: 232/255,
                                                    blue: 109/255
                                                ),
                                                Color(
                                                    red: 241/255,
                                                    green: 247/255,
                                                    blue: 252/255
                                                )
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(
                                                Color.white.opacity(0.7),
                                                lineWidth: 2
                                            )
                                    )
                            )
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea()
        }
        .navigationDestination(isPresented: $goToVocabulary) {
            VocabularyView(story: story)
        }
    }
    
    @ViewBuilder
    var backgroundView: some View {
        
        switch backgroundStyle {
            
        case .appTheme:
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            
        case .storyTheme:
            LinearGradient(
                colors: [
                    story.theme.secondary,
                    story.theme.primary
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    MoralView(story: sampleStories[6])
}
