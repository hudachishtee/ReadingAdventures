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
        x: 341,
        y: 180,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Animal Wood",
        imageName: "animal_wood",
        x: 351,
        y: 534,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Kindness Garden",
        imageName: "kindness",
        x: 352,
        y: 849,
        width: 0.55,
        height: 0.13
    ),

    AdventureArea(
        name: "Bedtime Village",
        imageName: "bedtime_village",
        x: 349,
        y: 1162,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Adventure Island",
        imageName: "adventure_island",
        x: 349,
        y: 1498,
        width: 0.55,
        height: 0.15
    ),

    AdventureArea(
        name: "Courage Forest",
        imageName: "courage_forest",
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

    // Locked popup
    @State private var showLockedPopup = false
    @State private var lockedAreaName = ""
    @State private var requiredAreaName = ""

    // Castle chains position
    @State private var chainsX: CGFloat = 352.455
    @State private var chainsY: CGFloat = 2035.779

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            Image("map")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

                // MARK: Dark overlay

                .overlay {

                    Color.black
                        .opacity(showDarkOverlay ? 0.45 : 0)
                        .animation(
                            .easeInOut(duration: 0.35),
                            value: showDarkOverlay
                        )
                }

                // MARK: Map Overlay

                .overlay(alignment: .topLeading) {

                    GeometryReader { geo in

                        ZStack {

                            // MARK: - Castle Chains

                            // MARK: - Castle

                            Button {

                                requiredAreaName = "Courage Forest"
                                lockedAreaName = "Castle"
                                showLockedPopup = true

                            } label: {

                                Image("chains")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: geo.size.width * 0.55
                                    )
                            }
                            .buttonStyle(.plain)
                            .position(
                                x: geo.size.width * (chainsX / 724),
                                y: geo.size.height * (chainsY / 2172)
                            )

                            // MARK: - Unlocked Area Tap Areas

                            ForEach(adventureAreas) { area in

                                if isAreaUnlocked(area.name) {

                                    Button {

                                        pressedArea = area

                                        withAnimation {
                                            showSparkles = true
                                            showDarkOverlay = true
                                        }

                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 1.1
                                        ) {

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
                                        pressedArea?.id == area.id
                                        ? 0.95
                                        : 1
                                    )

                                    .animation(
                                        .spring(
                                            response: 0.25,
                                            dampingFraction: 0.6
                                        ),
                                        value: pressedArea
                                    )

                                    .position(
                                        x: geo.size.width * (area.x / 724),
                                        y: geo.size.height * (area.y / 2172)
                                    )
                                }
                            }

                            // MARK: - Tap Sparkles

                            if showSparkles,
                               let area = pressedArea {

                                LottieView(
                                    animationName: "Magic Sparcle Burst"
                                )
                                .frame(
                                    width: geo.size.width * 0.8,
                                    height: geo.size.width * 0.8
                                )
                                .position(
                                    x: geo.size.width * (area.x / 724),
                                    y: geo.size.height * (area.y / 2172)
                                )
                                .allowsHitTesting(false)
                            }

                            // MARK: - Locked Areas

                            ForEach(
                                adventureAreas.filter {
                                    !isAreaUnlocked($0.name)
                                }
                            ) { area in

                                Button {

                                    if let requiredArea =
                                        requiredArea(for: area.name) {

                                        requiredAreaName = requiredArea
                                        lockedAreaName = area.name

                                        showLockedPopup = true
                                    }

                                } label: {

                                    ZStack {

                                        RoundedRectangle(
                                            cornerRadius: 30
                                        )
                                        .fill(
                                            .gray.opacity(0.45)
                                        )
                                        .frame(
                                            width: geo.size.width * area.width,
                                            height: geo.size.height * area.height
                                        )
                                        .overlay {

                                            RoundedRectangle(
                                                cornerRadius: 30
                                            )
                                            .stroke(
                                                .white.opacity(0.2),
                                                lineWidth: 2
                                            )
                                        }

                                        Circle()
                                            .fill(
                                                .white.opacity(0.9)
                                            )
                                            .frame(
                                                width: 58,
                                                height: 58
                                            )
                                            .shadow(radius: 6)

                                        Image(
                                            systemName: "lock.fill"
                                        )
                                        .font(
                                            .system(
                                                size: 26,
                                                weight: .bold
                                            )
                                        )
                                        .foregroundStyle(.gray)
                                    }
                                }

                                .buttonStyle(.plain)

                                .position(
                                    x: geo.size.width * (area.x / 724),
                                    y: geo.size.height * (area.y / 2172)
                                )
                            }

                            // MARK: - Unlock Sparkles

                            if let areaName =
                                unlockAnimation.unlockedArea,

                               let area =
                                adventureAreas.first(
                                    where: {
                                        $0.name == areaName
                                    }
                                ) {

                                LottieView(
                                    animationName: "Sparkle Stars"
                                )
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

        // MARK: - Background

        .background(

            LinearGradient(
                colors: [
                    .bgTop,
                    .bgBottom
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )

        .toolbar(
            .hidden,
            for: .navigationBar
        )

        // MARK: - Area Navigation

        .navigationDestination(
            item: $selectedArea
        ) { area in

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

        // MARK: - Locked Area Popup

        .overlay {

            if showLockedPopup {

                LockedAreaPopupView(
                    requiredArea: requiredAreaName,
                    lockedArea: lockedAreaName
                ) {

                    showLockedPopup = false
                }
            }
        }
    }

    // MARK: - Check Area Unlock

    private func isAreaUnlocked(
        _ areaName: String
    ) -> Bool {

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

    // MARK: - Required Area

    private func requiredArea(
        for areaName: String
    ) -> String? {

        switch areaName {

        case "Animal Wood":
            return "Friendship Meadow"

        case "Kindness Garden":
            return "Animal Wood"

        case "Bedtime Village":
            return "Kindness Garden"

        case "Adventure Island":
            return "Bedtime Village"

        case "Courage Forest":
            return "Adventure Island"

        default:
            return nil
        }
    }
}

// MARK: - Preview

#Preview {

    NavigationStack {

        AdventureMapView()
    }
}
