//
//  SplashScreen.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 13/02/2026.
//

import SwiftUI

struct SplashView: View {

    @State private var navigateToMain = false

    var body: some View {
        ZStack {
            Color(red: 0.93, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            Image("owl")
                .resizable()
                .scaledToFit()
                .frame(width: 500)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navigateToMain = true
            }
        }
        .fullScreenCover(isPresented: $navigateToMain) {
            MainScreenView()
        }
    }
}

#Preview {
    SplashView()
}
