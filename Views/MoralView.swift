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
                    Text("Moral of the Story")
                        .font(.custom(
                            "OpenDyslexic-Bold",
                            size: isIPad ? 30 : 24
                        ))
                        .foregroundColor(.appPrimaryText)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 18)
                        .padding(.horizontal, 22)
                        .frame(maxWidth: isIPad ? 620 : 330)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.75))
                        )
                    
                    Spacer()
                    
                    // MORAL CARD + OWL
                    ZStack(alignment: .topTrailing) {
                        
                        Text(story.moral)
                            .font(.custom(
                                "OpenDyslexic-Regular",
                                size: isIPad ? 28 : 22
                            ))
                            .foregroundColor(.appPrimaryText)
                            .multilineTextAlignment(.center)
                            .lineSpacing(20)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 34)
                            .frame(maxWidth: isIPad ? 650 : 340)
                            .background(
                                RoundedRectangle(cornerRadius: 36)
                                    .fill(Color.white.opacity(0.78))
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
                            )
                    }
                    
                    Spacer(minLength: 24)
                    
                    // BOTTOM BAR
                    HStack {
                        Image(systemName: "house.fill")
                        Spacer()
                        Image(systemName: "gamecontroller.fill")
                        Spacer()
                        Image(systemName: "medal.fill")
                    }
                    .font(.system(size: isIPad ? 26 : 22))
                    .foregroundColor(.appPrimaryText)
                    .padding(.horizontal, 34)
                    .padding(.vertical, 18)
                    .frame(maxWidth: isIPad ? 620 : .infinity)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.55))
                    )
                    .padding(.horizontal, 22)
                    .padding(.bottom, 10)
                }
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
