import SwiftUI

struct SplashView: View {

    @Environment(\.colorScheme) private var colorScheme

    @State private var navigate = false

    @State private var showReading = false
    @State private var showAdventures = false
    @State private var showIPadTitle = false

    var body: some View {

        if navigate {

            MainTabContainerView()

        } else {

            GeometryReader { geometry in

                let isIPad = geometry.size.width > 700

                ZStack {

                    Image(colorScheme == .dark ? "splash_dark" : "splash_light")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                        .clipped()

                    VStack {

                        if isIPad {

                            Text("Reading Adventures")
                                .font(
                                    .system(
                                        size: 52,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundStyle(
                                    colorScheme == .dark
                                    ? .white
                                    : Color.blue.opacity(0.85)
                                )
                                .shadow(
                                    color: .black.opacity(
                                        colorScheme == .dark ? 0.3 : 0.1
                                    ),
                                    radius: 4,
                                    x: 0,
                                    y: 2
                                )
                                .scaleEffect(showIPadTitle ? 1 : 0.5)
                                .opacity(showIPadTitle ? 1 : 0)
                                .animation(
                                    .spring(
                                        response: 0.45,
                                        dampingFraction: 0.7
                                    ),
                                    value: showIPadTitle
                                )

                        } else {

                            VStack(spacing: 0) {

                                Text("Reading")
                                    .font(
                                        .system(
                                            size: 34,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundStyle(
                                        colorScheme == .dark
                                        ? .white
                                        : Color.blue.opacity(0.85)
                                    )
                                    .shadow(
                                        color: .black.opacity(
                                            colorScheme == .dark ? 0.3 : 0.1
                                        ),
                                        radius: 4,
                                        x: 0,
                                        y: 2
                                    )
                                    .scaleEffect(showReading ? 1 : 0.5)
                                    .opacity(showReading ? 1 : 0)
                                    .animation(
                                        .spring(
                                            response: 0.45,
                                            dampingFraction: 0.7
                                        ),
                                        value: showReading
                                    )

                                Text("Adventures")
                                    .font(
                                        .system(
                                            size: 34,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundStyle(
                                        colorScheme == .dark
                                        ? .white
                                        : Color.blue.opacity(0.85)
                                    )
                                    .shadow(
                                        color: .black.opacity(
                                            colorScheme == .dark ? 0.3 : 0.1
                                        ),
                                        radius: 4,
                                        x: 0,
                                        y: 2
                                    )
                                    .scaleEffect(showAdventures ? 1 : 0.5)
                                    .opacity(showAdventures ? 1 : 0)
                                    .animation(
                                        .spring(
                                            response: 0.45,
                                            dampingFraction: 0.7
                                        ),
                                        value: showAdventures
                                    )
                            }
                        }

                        Spacer()
                    }
                    .padding(
                        .top,
                        isIPad
                        ? geometry.size.height * 0.14
                        : geometry.size.height * 0.10
                    )
                }
            }
            .ignoresSafeArea()
            .onAppear {

                if UIDevice.current.userInterfaceIdiom == .pad {

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.5
                    ) {
                        showIPadTitle = true
                    }

                } else {

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.3
                    ) {
                        showReading = true
                    }

                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + 0.8
                    ) {
                        showAdventures = true
                    }
                }

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 2.2
                ) {
                    navigate = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
