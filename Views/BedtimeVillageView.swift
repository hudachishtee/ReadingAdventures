//
//  BedtimeVillageView.swift
//  ReadingAdventures
//

import SwiftUI

struct BedtimeVillageView: View {

    var body: some View {

        GeometryReader { geo in

            Image("bedtime_village")
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
        BedtimeVillageView()
    }
}
