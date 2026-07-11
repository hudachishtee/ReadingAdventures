//
//  LearnedWordsManager.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 11/07/2026.
//

import Foundation
import Combine

final class LearnedWordsManager: ObservableObject {

    static let shared = LearnedWordsManager()

    @Published var learnedWords: Set<String> = []

    private init() {}

    func markWordsAsLearned(from story: Story) {
        learnedWords.formUnion(
            story.vocabulary.map { $0.word }
        )
    }
}
