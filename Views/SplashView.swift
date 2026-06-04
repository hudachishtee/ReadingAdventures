import SwiftUI

struct SplashView: View {
    
    @State private var scale: CGFloat = 0.8
    @State private var navigate = false
    
    private var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        
        if navigate {
            
            MainTabContainerView()
            
        } else {
            
            ZStack {
                
                LinearGradient(
                    colors: [.bgTop, .bgBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                Image("owl_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: isIPad ? 650 : 260
                    )
                    .scaleEffect(scale)
            }
            .onAppear {
                
                withAnimation(.easeIn(duration: 1.2)) {
                    scale = 1.0
                }
                
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 2.2
                ) {
                    navigate = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
