//
//  AnimalWoodView.swift
//  ReadingAdventures
//

import SwiftUI

struct AnimalWoodView: View {

    var body: some View {

        GeometryReader { geo in

            Image("animal_wood")
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
        AnimalWoodView()
    }
}
