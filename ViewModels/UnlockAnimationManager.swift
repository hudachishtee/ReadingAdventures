//
//  UnlockAnimationManager.swift
//  ReadingAdventures
//

import SwiftUI
import Combine

final class UnlockAnimationManager: ObservableObject {

    static let shared = UnlockAnimationManager()

    @Published var unlockedArea: String?

    private init() { }

    func play(for area: String) {
        unlockedArea = area
    }

    func clear() {
        unlockedArea = nil
    }
}
