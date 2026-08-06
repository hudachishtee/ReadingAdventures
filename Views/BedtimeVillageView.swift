//
//  BedtimeVillageView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//

import SwiftUI

struct BedtimeVillageView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("bedtime_village")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("Bedtime Village")
        .navigationBarTitleDisplayMode(.inline)
    }
}
