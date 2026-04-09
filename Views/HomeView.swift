import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        NavigationStack {
            
            GeometryReader { geo in
                
                ZStack {
                    
                    LinearGradient(
                        colors: [.bgTop, .bgBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Text("Choose A Story")
                            .font(.custom("OpenDyslexic-Bold", size: 25))
                            .foregroundColor(.appPrimaryText)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(Color.appCardBackground.opacity(0.6))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                        
                        ScrollView {
                            VStack(spacing: 25) {
                                ForEach(sampleStories) { story in
                                    StoryCard(story: story)
                                }
                            }
                            .padding(.bottom, 100)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "house.fill")
                            Spacer()
                            Image(systemName: "gamecontroller.fill")
                            Spacer()
                            Image(systemName: "medal.fill")
                        }
                        .font(.system(size: 22))
                        .foregroundColor(.appPrimaryText)
                        .padding(16)
                        .background(Color.appCardBackground.opacity(0.7))
                        .cornerRadius(30)
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 10)
                    
                    // ✅ THIS IS THE MAIN iPad FIX
                    .frame(maxWidth: 600)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
