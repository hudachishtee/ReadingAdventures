//
//  CourageForestView.swift
//  ReadingAdventures
//

import SwiftUI

struct CourageForestView: View {

    var body: some View {

        GeometryReader { geo in

            Image("courage_forest")
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
        CourageForestView()
    }
}
