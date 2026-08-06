//
//  KindnessGardenView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//

import SwiftUI

struct KindnessGardenView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("kindness")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("Kindness Garden")
        .navigationBarTitleDisplayMode(.inline)
    }
}
