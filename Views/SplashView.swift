import SwiftUI

struct SplashView: View {
    
    @State private var scale: CGFloat = 0.8
    @State private var navigate = false
    
    var body: some View {
        if navigate {
            HomeView()
        } else {
            ZStack {
                
                LinearGradient(
                    colors: [
                        .appLightBlue,
                        .appPrimaryBlue
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Image("owl logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380)
                        .scaleEffect(scale)
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    scale = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation {
                        navigate = true
                    }
                }
            }
        }
    }
}

#Preview("Splash Screen") {
    SplashView()
}
