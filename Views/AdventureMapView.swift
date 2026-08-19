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
//        isUnlocked: true,
        x: 341,
        y: 180,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Animal Wood",
        imageName: "animal_wood",
//        isUnlocked: false,
        x: 351,
        y: 534,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Kindness Garden",
        imageName: "kindness",
//        isUnlocked: false,
        x: 352,
        y: 849,
        width: 0.55,
        height: 0.13
    ),

    AdventureArea(
        name: "Bedtime Village",
        imageName: "bedtime_village",
//        isUnlocked: false,
        x: 349,
        y: 1162,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Adventure Island",
        imageName: "adventure_island",
//        isUnlocked: false,
        x: 349,
        y: 1498,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Courage Forest",
        imageName: "courage_forest",
//        isUnlocked: false,
        x: 349,
        y: 1822,
        width: 0.55,
        height: 0.14
    )
]

// MARK: - Adventure Map

struct AdventureMapView: View {

    @StateObject private var progress = ProgressManager.shared
    @StateObject private var unlockAnimation = UnlockAnimationManager.shared

    @State private var selectedArea: AdventureArea?
    @State private var pressedArea: AdventureArea?
    @State private var showSparkles = false
    @State private var showDarkOverlay = false

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            Image("map")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay {

                    Color.black
                        .opacity(showDarkOverlay ? 0.45 : 0)
                        .animation(.easeInOut(duration: 0.35), value: showDarkOverlay)

                }

                .overlay(alignment: .topLeading) {
                    GeometryReader { geo in

                        ZStack {

                            // MARK: - Invisible tap areas
                            ForEach(adventureAreas) { area in

                                Button {

                                    guard isAreaUnlocked(area.name) else { return }

                                    pressedArea = area

                                    withAnimation {
                                        showSparkles = true
                                        showDarkOverlay = true
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {

                                        selectedArea = area

                                        pressedArea = nil
                                        showSparkles = false
                                        showDarkOverlay = false
                                    }

                                } label: {

                                    Color.clear
                                }
                                .frame(
                                    width: geo.size.width * area.width,
                                    height: geo.size.height * area.height
                                )
                                .scaleEffect(
                                    pressedArea?.id == area.id ? 0.95 : 1
                                )
                                .animation(
                                    .spring(response: 0.25, dampingFraction: 0.6),
                                    value: pressedArea
                                )
                                .position(
                                    x: geo.size.width * (area.x / 724),
                                    y: geo.size.height * (area.y / 2172)
                                )
                            }
                            
                            if showSparkles,
                               let area = pressedArea {

                                LottieView(animationName: "Magic Sparcle Burst")
                                    .frame(
                                        width: geo.size.width * 0.8,
                                        height: geo.size.width * 0.8
                                    )
                                    .position(
                                        x: geo.size.width * (area.x / 724),
                                        y: geo.size.height * (area.y / 2172)
                                    )
                            }
                            // MARK: - Locked Areas
                            ForEach(adventureAreas.filter { !isAreaUnlocked($0.name) }) { area in

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
                            if let areaName = unlockAnimation.unlockedArea,
                               let area = adventureAreas.first(where: { $0.name == areaName }) {

                                LottieView(animationName: "Sparkle Stars")
                                    .frame(
                                        width: geo.size.width * 0.75,
                                        height: geo.size.width * 0.75
                                    )
                                    .position(
                                        x: geo.size.width * (area.x / 724),
                                        y: geo.size.height * (area.y / 2172)
                                    )
                                    .allowsHitTesting(false)
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
    private func isAreaUnlocked(_ areaName: String) -> Bool {

        switch areaName {

        case "Friendship Meadow":
            return progress.isFriendshipUnlocked()

        case "Animal Wood":
            return progress.isAnimalUnlocked()

        case "Kindness Garden":
            return progress.isKindnessUnlocked()

        case "Bedtime Village":
            return progress.isBedtimeUnlocked()

        case "Adventure Island":
            return progress.isAdventureUnlocked()

        case "Courage Forest":
            return progress.isCourageUnlocked()

        default:
            return false
        }
    }
}

#Preview {
    NavigationStack {
        AdventureMapView()
    }
}
