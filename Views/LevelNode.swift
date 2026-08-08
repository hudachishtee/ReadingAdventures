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

    var body: some View {

        Button {

            guard state != .locked else { return }

            action()

        } label: {

            ZStack {

                Circle()
                    .fill(backgroundColor)
                    .frame(width: 100, height: 100)

                    Circle()
                        .stroke(.white, lineWidth: 5)
                        .frame(width: 100, height: 100)

                content
            }
            .shadow(color: .black.opacity(0.25), radius: 6, y: 4)
            .scaleEffect(isPressed ? 0.92 : 1)
            .animation(.spring(response: 0.25), value: isPressed)
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

    @ViewBuilder
    private var content: some View {

        switch state {

        case .locked:

            Image(systemName: "lock.fill")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.white)

        case .unlocked:

            Text("\(number)")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)

        case .completed:

            Image(systemName: "checkmark")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}

#Preview {

    VStack(spacing: 30) {

        LevelNode(number: 1, state: .unlocked) {}

        LevelNode(number: 2, state: .locked) {}

        LevelNode(number: 3, state: .completed) {}
    }
}
