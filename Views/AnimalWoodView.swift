//
//  AnimalWoodView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//

import SwiftUI

struct AnimalWoodView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("animal_wood")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("Animal Wood")
        .navigationBarTitleDisplayMode(.inline)
    }
}
