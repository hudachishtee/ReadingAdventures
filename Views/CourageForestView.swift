//
//  CourageForest.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//


import SwiftUI

struct CourageForestView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("courage_forest")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("Courage Forest")
        .navigationBarTitleDisplayMode(.inline)
    }
}
