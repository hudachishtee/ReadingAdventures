//
//  FriendshipMeadowView.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 22/07/2026.
//

import SwiftUI

struct FriendshipMeadowView: View {

    var body: some View {

        ZStack {

            Color.bgTop
                .ignoresSafeArea()

            Image("friendship_meadow")
                .resizable()
                .scaledToFit()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Friendship Meadow")
    }
}
