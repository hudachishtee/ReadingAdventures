//
//  SampleData.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 05/04/2026.
//

import Foundation

let sampleStory = Story(
    title: "The Rainy Day Surprise",
    level: .explorer,
    imageName: "rain_story",
    
    pages: [
        Page(
            text: "Lina woke up to gray clouds.\nRain tapped softly on the window.",
            imageName: "rain1",
            audioName: "rain1"
        ),
        Page(
            text: "She felt a little sad.\nHer mother said, “Let’s make today special.”",
            imageName: "rain2",
            audioName: "rain2"
        ),
        Page(
            text: "They built a tent and read stories.\nLina smiled. Rainy days can be fun too.",
            imageName: "rain3",
            audioName: "rain3"
        )
    ],
    
    moral: "Even a rainy day can become special with a little creativity.",
    
    vocabulary: [
        VocabularyWord(
            word: "Surprise",
            meaning: "Something unexpected",
            example: "The gift was a surprise.",
            audioName: "surprise"
        ),
        VocabularyWord(
            word: "Special",
            meaning: "Something important or different",
            example: "Today felt special.",
            audioName: "special"
        ),
        VocabularyWord(
            word: "Tent",
            meaning: "A small cloth shelter",
            example: "They built a tent indoors.",
            audioName: "tent"
        )
    ],
    
    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word 'Rain'",
            options: ["Sun", "Rain", "Tree"],
            correctAnswer: "Rain"
        ),
        GameQuestion(
            type: .meaning,
            question: "What does 'Special' mean?",
            options: ["Boring", "Important or nice", "Loud"],
            correctAnswer: "Important or nice"
        ),
        GameQuestion(
            type: .buildWord,
            question: "Build the word 'TENT'",
            options: ["T", "E", "N", "T"],
            correctAnswer: "TENT"
        )
    ]
)
