//
//  AdventureMapView.swift
//  ReadingAdventures
//

import SwiftUI

// MARK: - Adventure Areas

let adventureAreas: [AdventureArea] = [

    AdventureArea(
        name: "Friendship Meadow",
        imageName: "friendship_meadow",
        isUnlocked: true,
        x: 341,
        y: 180,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Animal Wood",
        imageName: "animal_wood",
        isUnlocked: false,
        x: 351,
        y: 534,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Kindness Garden",
        imageName: "kindness",
        isUnlocked: false,
        x: 352,
        y: 849,
        width: 0.55,
        height: 0.13
    ),

    AdventureArea(
        name: "Bedtime Village",
        imageName: "bedtime_village",
        isUnlocked: false,
        x: 349,
        y: 1162,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Adventure Island",
        imageName: "adventure_island",
        isUnlocked: false,
        x: 349,
        y: 1498,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Courage Forest",
        imageName: "courage_forest",
        isUnlocked: false,
        x: 349,
        y: 1822,
        width: 0.55,
        height: 0.14
    )
]

// MARK: - Adventure Map

    struct AdventureMapView: View {

        @State private var selectedArea: AdventureArea?

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            Image("map")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

                .overlay(alignment: .topLeading) {
                    GeometryReader { geo in

                        ZStack {

                            // MARK: - Invisible tap areas
                            ForEach(adventureAreas) { area in

                                Button {

                                    guard area.isUnlocked else { return }
                                    selectedArea = area

                                } label: {

                                    Color.clear
                                }
                                .frame(
                                    width: geo.size.width * area.width,
                                    height: geo.size.height * area.height
                                )
                                .position(
                                    x: geo.size.width * (area.x / 724),
                                    y: geo.size.height * (area.y / 2172)
                                )
                            }

                            // MARK: - Locked Areas
                            ForEach(adventureAreas.filter { !$0.isUnlocked }) { area in

                                ZStack {

                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.gray.opacity(0.45))
                                        .frame(
                                            width: geo.size.width * area.width,
                                            height: geo.size.height * area.height
                                        )
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(.white.opacity(0.2), lineWidth: 2)
                                        }

                                    Circle()
                                        .fill(.white.opacity(0.9))
                                        .frame(width: 58, height: 58)
                                        .shadow(radius: 6)

                                    Image(systemName: "lock.fill")
                                        .font(.system(size: 26, weight: .bold))
                                        .foregroundStyle(.gray)
                                }
                                .position(
                                    x: geo.size.width * (area.x / 724),
                                    y: geo.size.height * (area.y / 2172)
                                )
                            }
                        }
                    }
                }

                .padding(.bottom, 40)
        }

        .background(
            LinearGradient(
                colors: [.bgTop, .bgBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )

        .toolbar(.hidden, for: .navigationBar)

        .navigationDestination(item: $selectedArea) { area in

            switch area.name {

            case "Friendship Meadow":
                FriendshipMeadowView()

            case "Animal Wood":
                AnimalWoodView()

            case "Kindness Garden":
                KindnessGardenView()

            case "Bedtime Village":
                BedtimeVillageView()

            case "Adventure Island":
                AdventureIslandView()
                
            case "Courage Forest":
                CourageForestView()

            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AdventureMapView()
    }
}
