import SwiftUI

let sampleStories: [Story] = [

    // =========================
    // BEGINNER STORIES
    // =========================

    Story(
        title: "The Extra Sandwich",
        level: .beginner,
        category: .moral,
        imageName: "sandwich_cover",
        theme: StoryTheme(primary: .orange, secondary: .yellow),

        pages: [
            Page(text: "Nora packed two sandwiches today.\nShe did not know why.\nIt just felt right.", imageName: "sandwich1", audioName: "sandwich1"),
            Page(text: "At school, a boy sat alone.\nHe looked at her sandwich.\nNora walked over slowly.", imageName: "sandwich2", audioName: "sandwich2"),
            Page(text: "She shared the extra sandwich.\nThe boy smiled and said thank you.\nNora felt warm inside.", imageName: "sandwich3", audioName: "sandwich3")
        ],

        moral: "A small kindness can make a big difference.",

        vocabulary: [
            VocabularyWord(word: "Kind", meaning: "Caring and helpful", example: "He was kind to his friends.", audioName: "kind"),
            VocabularyWord(word: "Share", meaning: "To give part to others", example: "She shared her sandwich.", audioName: "share"),
            VocabularyWord(word: "Extra", meaning: "More than usual", example: "I brought an extra apple.", audioName: "extra"),
            VocabularyWord(word: "Alone", meaning: "Without anyone else", example: "He felt alone in the playground.", audioName: "alone")
        ],

        games: []
    ),

    Story(
        title: "The Brave Little Wave",
        level: .beginner,
        category: .adventure,
        imageName: "wave_cover",
        theme: StoryTheme(primary: .blue, secondary: .cyan),

        pages: [
            Page(text: "A little wave lived far out in the ocean.\nIt watched the shore from a distance.\nThe shore looked big and loud.", imageName: "wave1", audioName: "wave1"),
            Page(text: "The little wave felt scared.\nOther waves rushed forward bravely.\nThey whispered, \"You can do it.\"", imageName: "wave2", audioName: "wave2"),
            Page(text: "The little wave took a deep breath.\nIt rolled toward the shore.\nThe shore welcomed it with a splash.", imageName: "wave3", audioName: "wave3")
        ],

        moral: "Being brave means trying even when you feel scared.",

        vocabulary: [
            VocabularyWord(word: "Brave", meaning: "To not give up even when you are afraid", example: "The little wave was brave.", audioName: "brave"),
            VocabularyWord(word: "Encourage", meaning: "To help someone feel strong", example: "Friends encourage each other.", audioName: "encourage"),
            VocabularyWord(word: "Ocean", meaning: "A very large body of water", example: "Fish live in the ocean.", audioName: "ocean"),
            VocabularyWord(word: "Splash", meaning: "Water hitting something", example: "The wave made a splash.", audioName: "splash")
        ],

        games: []
    ),

    // =========================
    // EXPLORER STORIES
    // =========================

    Story(
        title: "The Rainy Day Surprise",
        level: .explorer,
        category: .moral,
        imageName: "rain_story",
        theme: StoryTheme(primary: .orange, secondary: .yellow),

        pages: [
            Page(text: "Lina woke up to gray clouds.\nRain tapped softly on the window.", imageName: "rain1", audioName: "rain1"),
            Page(text: "She felt a little sad.\nHer mother said, “Let’s make today special.”", imageName: "rain2", audioName: "rain2"),
            Page(text: "They built a tent and read stories.\nLina smiled. Rainy days can be fun too.", imageName: "rain3", audioName: "rain3")
        ],

        moral: "Even a rainy day can become special with a little creativity.",

        vocabulary: [
            VocabularyWord(word: "Surprise", meaning: "Something unexpected", example: "The gift was a surprise.", audioName: "surprise"),
            VocabularyWord(word: "Special", meaning: "Something important", example: "Today felt special.", audioName: "special"),
            VocabularyWord(word: "Tent", meaning: "A small shelter", example: "They built a tent indoors.", audioName: "tent"),
            VocabularyWord(word: "Creativity", meaning: "Using imagination", example: "She used creativity.", audioName: "creativity")
        ],

        games: [
            GameQuestion(type: .tapWord, question: "Tap the word 'Rain'", options: ["Sun","Rain","Tree"], correctIndex: 1),
            GameQuestion(type: .meaning, question: "What does 'Special' mean?", options: ["Boring","Important or nice","Loud"], correctIndex: 1),
            GameQuestion(type: .buildWord, question: "Build 'TENT'", options: ["T","E","N","T"], correctIndex: 0)
        ]
    ),

    // =========================
    // ADVANCED STORIES
    // =========================

    Story(
        title: "The Light in the Dark",
        level: .advanced,
        category: .moral,
        imageName: "light_cover",
        theme: StoryTheme(primary: .purple, secondary: .blue),

        pages: [
            Page(text: "It was very dark.\nLina could not see the path.\nShe felt a little scared.", imageName: "light1", audioName: "light1"),
            Page(text: "She saw a tiny light ahead.\nIt flickered softly.\nLina walked toward it.", imageName: "light2", audioName: "light2"),
            Page(text: "The light grew brighter.\nIt showed her the way home.\nLina felt brave again.", imageName: "light3", audioName: "light3"),
            Page(text: "She smiled and kept walking.\nThe dark felt smaller now.\nThe light stayed with her.", imageName: "light4", audioName: "light4")
        ],

        moral: "Even a small light can guide you through dark times.",

        vocabulary: [
            VocabularyWord(word: "Flicker", meaning: "A small unsteady light", example: "The candle flickered.", audioName: "flicker"),
            VocabularyWord(word: "Path", meaning: "A way to go", example: "She followed the path.", audioName: "path"),
            VocabularyWord(word: "Brave", meaning: "Not giving up", example: "She felt brave.", audioName: "brave"),
            VocabularyWord(word: "Guide", meaning: "To show the way", example: "The light guided her.", audioName: "guide")
        ],

        games: [
            GameQuestion(type: .tapWord, question: "Tap 'Light'", options: ["Light","Dark","Path"], correctIndex: 0),
            GameQuestion(type: .meaning, question: "Brave means?", options: ["Fear","Courage","Sleep"], correctIndex: 1),
            GameQuestion(type: .buildWord, question: "Build 'PATH'", options: ["P","A","T","H"], correctIndex: 0)
        ]
    )
]
