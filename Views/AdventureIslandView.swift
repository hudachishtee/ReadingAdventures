//
//  AdventureIslandView.swift
//  ReadingAdventures
//

import SwiftUI

struct AdventureIslandView: View {

    var body: some View {

        GeometryReader { geo in

            Image("adventure_island")
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
        AdventureIslandView()
    }
}
