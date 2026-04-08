import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                let s = Scale.factor(geo)
                
                ZStack {
                    
                    LinearGradient(
                        colors: [.bgTop, .bgBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20 * s) {
                        Spacer()
                        Text("Choose A Story")
                            .font(.custom("OpenDyslexic-Bold", size: 25 * s))
                            .foregroundColor(.appPrimaryText)
                            .padding(12 * s)
                            .frame(maxWidth: .infinity)
                            .background(Color.appCardBackground.opacity(0.6))
                            .cornerRadius(12)
                            .padding(.horizontal, 16 * s)
                        
                        ScrollView {
                            VStack(spacing: 25 * s) {
                                ForEach(sampleStories) { story in
                                    StoryCard(story: story)
                                }
                            }
                            .padding(.bottom, 100 * s)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "house.fill")
                            Spacer()
                            Image(systemName: "gamecontroller.fill")
                            Spacer()
                            Image(systemName: "medal.fill")
                        }
                        .font(.system(size: 22 * s))
                        .foregroundColor(.appPrimaryText)
                        .padding(16 * s)
                        .background(Color.appCardBackground.opacity(0.7))
                        .cornerRadius(30)
                        .padding(.horizontal, 16 * s)
                    }
                    .padding(.top, 10 * s)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
