//
//  AdventureIslandView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//

import SwiftUI

struct AdventureIslandView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("adventure_island")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("Adventure Island")
        .navigationBarTitleDisplayMode(.inline)
    }
}
