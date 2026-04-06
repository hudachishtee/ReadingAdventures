import SwiftUI

let sampleStories: [Story] = [

    // =========================
    // BEGINNER STORIES
    // =========================

    Story(
        title: "The Extra Sandwich",
        level: .beginner,
        category: .moral,
        imageName: "story1_cover",
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
        imageName: "story2_cover",
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

    Story(
        title: "The Sunset Promise",
        level: .beginner,
        category: .moral,
        imageName: "story3_cover",
        theme: StoryTheme(primary: .orange, secondary: .pink),

        pages: [
            Page(text: "Two friends sat by the sea.\nThe sun began to go down.\nThe sky turned orange and pink.", imageName: "sunset1", audioName: "sunset1"),
            Page(text: "The friends talked quietly.\nThey promised to meet again tomorrow.\nThey smiled and held hands.", imageName: "sunset2", audioName: "sunset2"),
            Page(text: "The sun disappeared behind the water.\nThe friends waved goodbye.\nTheir promise stayed warm in their hearts.", imageName: "sunset3", audioName: "sunset3")
        ],

        moral: "Friendship and promises stay in your heart.",

        vocabulary: [
            VocabularyWord(word: "Promise", meaning: "Saying you will do something", example: "I made a promise to help my friend.", audioName: "promise"),
            VocabularyWord(word: "Friendship", meaning: "Caring about someone", example: "Our friendship is special.", audioName: "friendship"),
            VocabularyWord(word: "Sunset", meaning: "When the sun goes down", example: "We watched the sunset.", audioName: "sunset"),
            VocabularyWord(word: "Sky", meaning: "The space above us", example: "Birds fly in the sky.", audioName: "sky")
        ],

        games: []
    ),

    Story(
        title: "The Lost Crayon",
        level: .beginner,
        category: .moral,
        imageName: "story4_cover",
        theme: StoryTheme(primary: .red, secondary: .orange),

        pages: [
            Page(text: "Mia had one red crayon.\nShe liked to draw hearts.\nThe crayon was gone.", imageName: "crayon1", audioName: "crayon1"),
            Page(text: "Mia looked under the table.\nShe looked under the chair.\nShe felt sad.", imageName: "crayon2", audioName: "crayon2"),
            Page(text: "Mia saw the crayon on the floor.\nIt rolled near her shoe.\nShe smiled.", imageName: "crayon3", audioName: "crayon3")
        ],

        moral: "Do not give up. Keep looking.",

        vocabulary: [
            VocabularyWord(word: "Crayon", meaning: "A tool for drawing", example: "I used a crayon.", audioName: "crayon"),
            VocabularyWord(word: "Lost", meaning: "Not where it should be", example: "My toy is lost.", audioName: "lost"),
            VocabularyWord(word: "Draw", meaning: "To make a picture", example: "I draw flowers.", audioName: "draw"),
            VocabularyWord(word: "Smile", meaning: "A happy face", example: "She gave a smile.", audioName: "smile")
        ],

        games: []
    ),

    Story(
        title: "Milo the Cat",
        level: .beginner,
        category: .adventure,
        imageName: "story5_cover",
        theme: StoryTheme(primary: .blue, secondary: .cyan),

        pages: [
            Page(text: "Milo is a small cat.\nHe has soft, white fur.\nMilo likes to play.", imageName: "milo1", audioName: "milo1"),
            Page(text: "Milo sees a blue toy.\nThe toy moves.\nMilo runs and taps it.", imageName: "milo2", audioName: "milo2"),
            Page(text: "The toy stops.\nMilo sits and smiles.\n'I like my toy,' says Milo.", imageName: "milo3", audioName: "milo3")
        ],

        moral: "Enjoy simple moments.",

        vocabulary: [
            VocabularyWord(word: "Cat", meaning: "A small pet animal", example: "I have a cat.", audioName: "cat"),
            VocabularyWord(word: "Soft", meaning: "Not hard", example: "The pillow is soft.", audioName: "soft"),
            VocabularyWord(word: "Toy", meaning: "Something to play with", example: "He loves his toy.", audioName: "toy"),
            VocabularyWord(word: "Play", meaning: "To have fun", example: "Children play.", audioName: "play")
        ],

        games: []
    ),

    Story(
        title: "The Quiet Moon",
        level: .beginner,
        category: .adventure,
        imageName: "story6_cover",
        theme: StoryTheme(primary: .purple, secondary: .blue),

        pages: [
            Page(text: "The moon is big and bright.\nIt shines in the dark sky.\nEverything is quiet.", imageName: "moon1", audioName: "moon1"),
            Page(text: "A small owl wakes up.\nIt looks at the moon.\n'Hello,' says the owl.", imageName: "moon2", audioName: "moon2"),
            Page(text: "The owl sits very still.\nThe night feels calm.\nThe moon watches over all.", imageName: "moon3", audioName: "moon3")
        ],

        moral: "Quiet moments are beautiful.",

        vocabulary: [
            VocabularyWord(word: "Moon", meaning: "Light in the night sky", example: "The moon is bright.", audioName: "moon"),
            VocabularyWord(word: "Quiet", meaning: "No loud sounds", example: "The room is quiet.", audioName: "quiet"),
            VocabularyWord(word: "Owl", meaning: "A night bird", example: "The owl flies.", audioName: "owl"),
            VocabularyWord(word: "Night", meaning: "Dark time", example: "Stars shine at night.", audioName: "night")
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
        imageName: "rain_cover",
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

    Story(
        title: "The Lost Little Bird",
        level: .explorer,
        category: .moral,
        imageName: "bird_cover",
        theme: StoryTheme(primary: .yellow, secondary: .orange),

        pages: [
            Page(text: "Omar heard a soft chirp.\nA small bird sat alone.", imageName: "bird1", audioName: "bird1"),
            Page(text: "It looked scared.\nOmar searched for its nest.", imageName: "bird2", audioName: "bird2"),
            Page(text: "He found the nest and helped the bird.\nThe bird was safe again.", imageName: "bird3", audioName: "bird3")
        ],

        moral: "Helping others makes a big difference.",

        vocabulary: [
            VocabularyWord(word: "Chirp", meaning: "Bird sound", example: "The bird chirped.", audioName: "chirp"),
            VocabularyWord(word: "Nest", meaning: "Bird home", example: "The bird went to its nest.", audioName: "nest"),
            VocabularyWord(word: "Safe", meaning: "Free from danger", example: "The bird was safe.", audioName: "safe"),
            VocabularyWord(word: "Scared", meaning: "Afraid", example: "The bird was scared.", audioName: "scared")
        ],

        games: [
            GameQuestion(type: .tapWord, question: "Tap 'Nest'", options: ["Tree","Nest","Sky"], correctIndex: 1),
            GameQuestion(type: .meaning, question: "Safe means?", options: ["Danger","Protected","Fast"], correctIndex: 1),
            GameQuestion(type: .buildWord, question: "Build 'BIRD'", options: ["B","I","R","D"], correctIndex: 0)
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
    ),

    Story(
        title: "The Missing Piece",
        level: .advanced,
        category: .moral,
        imageName: "missing_cover",
        theme: StoryTheme(primary: .green, secondary: .blue),

        pages: [
            Page(text: "A small circle rolled slowly.\nIt had a piece missing.\nIt did not feel whole.", imageName: "missing1", audioName: "missing1"),
            Page(text: "It looked everywhere.\nIt tried many pieces.\nBut none fit.", imageName: "missing2", audioName: "missing2"),
            Page(text: "The circle stopped and thought.\n'Maybe I am okay like this.'", imageName: "missing3", audioName: "missing3"),
            Page(text: "It rolled happily again.\nIt was already enough.", imageName: "missing4", audioName: "missing4")
        ],

        moral: "You do not need to be perfect to be enough.",

        vocabulary: [
            VocabularyWord(word: "Missing", meaning: "Not there", example: "A piece was missing.", audioName: "missing"),
            VocabularyWord(word: "Whole", meaning: "Complete", example: "It felt whole.", audioName: "whole"),
            VocabularyWord(word: "Fit", meaning: "Match", example: "It did not fit.", audioName: "fit"),
            VocabularyWord(word: "Enough", meaning: "Just right", example: "She is enough.", audioName: "enough")
        ],

        games: []
    )
]
