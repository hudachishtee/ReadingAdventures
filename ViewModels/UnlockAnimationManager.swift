//
//  UnlockAnimationManager.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 08/08/2026.
//

import SwiftUI
import Combine

final class UnlockAnimationManager: ObservableObject {

    static let shared = UnlockAnimationManager()

    @Published var unlockedArea: String?

    private init() { }

    func play(for area: String) {

        unlockedArea = area

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            self.unlockedArea = nil
        }
    }
}
