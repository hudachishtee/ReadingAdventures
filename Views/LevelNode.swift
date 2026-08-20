//
//  LevelNode.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 08/08/2026.
//

import SwiftUI

enum LevelState {
    case locked
    case unlocked
    case completed
}

struct LevelNode: View {

    let number: Int
    let state: LevelState
    let action: () -> Void

    @State private var isPressed = false

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // MARK: - Responsive Size

    private var nodeSize: CGFloat {
        horizontalSizeClass == .compact ? 76 : 100
    }

    private var borderWidth: CGFloat {
        horizontalSizeClass == .compact ? 4 : 5
    }

    private var iconSize: CGFloat {
        horizontalSizeClass == .compact ? 28 : 36
    }

    private var numberSize: CGFloat {
        horizontalSizeClass == .compact ? 32 : 40
    }

    var body: some View {

        Button {

            guard state != .locked else {
                return
            }

            action()

        } label: {

            ZStack {

                // MARK: - Background Circle

                Circle()
                    .fill(backgroundColor)
                    .frame(
                        width: nodeSize,
                        height: nodeSize
                    )

                // MARK: - White Border

                Circle()
                    .stroke(.white, lineWidth: borderWidth)
                    .frame(
                        width: nodeSize,
                        height: nodeSize
                    )

                // MARK: - Content

                content
            }
            .shadow(
                color: .black.opacity(0.25),
                radius: horizontalSizeClass == .compact ? 5 : 6,
                y: horizontalSizeClass == .compact ? 3 : 4
            )
            .scaleEffect(isPressed ? 0.92 : 1)
            .animation(
                .spring(response: 0.25),
                value: isPressed
            )
        }
        .buttonStyle(.plain)
        .simultaneousGesture(

            DragGesture(minimumDistance: 0)

                .onChanged { _ in
                    isPressed = true
                }

                .onEnded { _ in
                    isPressed = false
                }
        )
    }

    // MARK: - Background Color

    private var backgroundColor: Color {

        switch state {

        case .locked:
            return .gray

        case .unlocked:
            return Color.green

        case .completed:
            return Color.orange
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {

        switch state {

        case .locked:

            Image(systemName: "lock.fill")
                .font(
                    .system(
                        size: iconSize,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)

        case .unlocked:

            Text("\(number)")
                .font(
                    .system(
                        size: numberSize,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)

        case .completed:

            Image(systemName: "checkmark")
                .font(
                    .system(
                        size: iconSize,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
        }
    }
}

#Preview {

    VStack(spacing: 30) {

        LevelNode(
            number: 1,
            state: .unlocked
        ) {}

        LevelNode(
            number: 2,
            state: .locked
        ) {}

        LevelNode(
            number: 3,
            state: .completed
        ) {}
    }
}
