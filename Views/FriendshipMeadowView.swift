//
//  FriendshipMeadowView.swift
//  ReadingAdventures
//

import SwiftUI

struct FriendshipMeadowView: View {

    var body: some View {

        GeometryReader { geo in

            Image("friendship_meadow")
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
        FriendshipMeadowView()
    }
}
