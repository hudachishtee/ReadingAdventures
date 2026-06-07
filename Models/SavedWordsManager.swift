//
//  SavedWordsManager.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 06/06/2026.
//

//
//  SavedWordsManager.swift
//  ReadingAdventures
//

import Foundation
import Combine

final class SavedWordsManager: ObservableObject {

    static let shared = SavedWordsManager()

    @Published var savedWords: [VocabularyWord] = []

    private init() {}

    func isSaved(_ word: VocabularyWord) -> Bool {
        savedWords.contains {
            $0.word == word.word
        }
    }

    func toggle(_ word: VocabularyWord) {

        if isSaved(word) {

            savedWords.removeAll {
                $0.word == word.word
            }

        } else {

            savedWords.append(word)
        }
    }
}
