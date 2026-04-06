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
            Page(text: "Nora packed two sandwiches today.\nShe did not know why.\nIt just felt right.", imageName: "story1_page1", audioName: "sandwich1"),
            Page(text: "At school, a boy sat alone.\nHe looked at her sandwich.\nNora walked over slowly.", imageName: "story1_page2", audioName: "sandwich2"),
            Page(text: "She shared the extra sandwich.\nThe boy smiled and said thank you.\nNora felt warm inside.", imageName: "story1_page3", audioName: "sandwich3")
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
            Page(text: "A little wave lived far out in the ocean.\nIt watched the shore from a distance.\nThe shore looked big and loud.", imageName: "story2_page1", audioName: "wave1"),
            Page(text: "The little wave felt scared.\nOther waves rushed forward bravely.\nThey whispered, \"You can do it.\"", imageName: "story2_page2", audioName: "wave2"),
            Page(text: "The little wave took a deep breath.\nIt rolled toward the shore.\nThe shore welcomed it with a splash.", imageName: "story2_page3", audioName: "wave3")
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
            Page(text: "Two friends sat by the sea.\nThe sun began to go down.\nThe sky turned orange and pink.", imageName: "story3_page1", audioName: "sunset1"),
            Page(text: "The friends talked quietly.\nThey promised to meet again tomorrow.\nThey smiled and held hands.", imageName: "story3_page2", audioName: "sunset2"),
            Page(text: "The sun disappeared behind the water.\nThe friends waved goodbye.\nTheir promise stayed warm in their hearts.", imageName: "story3_page3", audioName: "sunset3")
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
            Page(text: "Mia had one red crayon.\nShe liked to draw hearts.\nThe crayon was gone.", imageName: "story4_page1", audioName: "crayon1"),
            Page(text: "Mia looked under the table.\nShe looked under the chair.\nShe felt sad.", imageName: "story4_page2", audioName: "crayon2"),
            Page(text: "Mia saw the crayon on the floor.\nIt rolled near her shoe.\nShe smiled.", imageName: "story4_page3", audioName: "crayon3")
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
            Page(text: "Milo is a small cat.\nHe has soft, white fur.\nMilo likes to play.", imageName: "story5_page1", audioName: "milo1"),
            Page(text: "Milo sees a blue toy.\nThe toy moves.\nMilo runs and taps it.", imageName: "story5_page2", audioName: "milo2"),
            Page(text: "The toy stops.\nMilo sits and smiles.\n'I like my toy,' says Milo.", imageName: "story5_page3", audioName: "milo3")
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
            Page(text: "The moon is big and bright.\nIt shines in the dark sky.\nEverything is quiet.", imageName: "story6_page1", audioName: "moon1"),
            Page(text: "A small owl wakes up.\nIt looks at the moon.\n'Hello,' says the owl.", imageName: "story6_page2", audioName: "moon2"),
            Page(text: "The owl sits very still.\nThe night feels calm.\nThe moon watches over all.", imageName: "story6_page3", audioName: "moon3")
        ],

        moral: "Quiet moments are beautiful.",

        vocabulary: [
            VocabularyWord(word: "Moon", meaning: "Light in the night sky", example: "The moon is bright.", audioName: "moon"),
            VocabularyWord(word: "Quiet", meaning: "No loud sounds", example: "The room is quiet.", audioName: "quiet"),
            VocabularyWord(word: "Owl", meaning: "A night bird", example: "The owl flies.", audioName: "owl"),
            VocabularyWord(word: "Night", meaning: "Dark time", example: "Stars shine at night.", audioName: "night")
        ],

        games: []
    )

    // 👉 Explorer + Advanced can be appended here (kept your app stable for now)
]
