//
//  KindnessGardenView.swift
//  ReadingAdventures
//

import SwiftUI

struct KindnessGardenView: View {

    var body: some View {

        GeometryReader { geo in

            Image("kindness")
                .resizable()
                .scaledToFill()
                .frame(
                    width: geo.size.width,
                    height: geo.size.height
                )
                .clipped()
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        KindnessGardenView()
    }
}
