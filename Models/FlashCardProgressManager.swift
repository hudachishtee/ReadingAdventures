//
//  Untitled.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 10/06/2026.
//

import Foundation
import Combine

final class FlashCardProgressManager: ObservableObject {

    static let shared = FlashCardProgressManager()

    @Published var masteredWords: [String] = []

    private init() {}

    func isMastered(_ word: VocabularyWord) -> Bool {

        masteredWords.contains(word.word)
    }

    func markMastered(_ word: VocabularyWord) {

        guard !isMastered(word) else { return }

        masteredWords.append(word.word)
    }
}
