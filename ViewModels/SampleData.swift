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
            Page(text: "Nora packed two sandwiches today.\nShe did not know why.\nIt just felt right.", imageName: "story1_page1", audioName: "story1_audio1"),
            Page(text: "At school, a boy sat alone.\nHe looked at her sandwich.\nNora walked over slowly.", imageName: "story1_page2", audioName: "story1_audio2"),
            Page(text: "She shared the extra sandwich.\nThe boy smiled and said thank you.\nNora felt warm inside.", imageName: "story1_page3", audioName: "story1_audio3")
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
            Page(text: "A little wave lived far out in the ocean.\nIt watched the shore from a distance.\nThe shore looked big and loud.", imageName: "story2_page1", audioName: "story2_audio1"),
            Page(text: "The little wave felt scared.\nOther waves rushed forward bravely.\nThey whispered, \"You can do it.\"", imageName: "story2_page2", audioName: "story2_audio2"),
            Page(text: "The little wave took a deep breath.\nIt rolled toward the shore.\nThe shore welcomed it with a splash.", imageName: "story2_page3", audioName: "story2_audio3")
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
            Page(text: "Two friends sat by the sea.\nThe sun began to go down.\nThe sky turned orange and pink.", imageName: "story3_page1", audioName: "story3_audio1"),
            Page(text: "The friends talked quietly.\nThey promised to meet again tomorrow.\nThey smiled and held hands.", imageName: "story3_page2", audioName: "story3_audio2"),
            Page(text: "The sun disappeared behind the water.\nThe friends waved goodbye.\nTheir promise stayed warm in their hearts.", imageName: "story3_page3", audioName: "story3_audio3")
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
    ),

    // 👉 Explorer + Advanced can be appended here (kept your app stable for now)

Story(
    title: "The Lost Little Bird",
    level: .explorer,
    category: .moral,
    imageName: "story8_cover",
    theme: StoryTheme(primary: .green, secondary: .yellow),

    pages: [
        Page(text: "Omar heard a soft chirp.\nA small bird sat alone.", imageName: "story8_page1", audioName: "story8_audio1"),
        Page(text: "It looked scared.\nOmar searched for its nest.", imageName: "story8_page2", audioName: "story8_audio2"),
        Page(text: "He found the nest and helped the bird.\nThe bird was safe again.", imageName: "story8_page3", audioName: "story8_audio3")
    ],

    moral: "Helping others, even in small ways, makes a big difference.",

    vocabulary: [
        VocabularyWord(word: "Chirp", meaning: "A small bird sound.", example: "The bird chirped loudly.", audioName: "chirp"),
        VocabularyWord(word: "Nest", meaning: "A bird’s home.", example: "The bird returned to its nest.", audioName: "nest"),
        VocabularyWord(word: "Safe", meaning: "Free from danger.", example: "The bird felt safe with Omar.", audioName: "safe"),
        VocabularyWord(word: "Scared", meaning: "Feeling afraid.", example: "The little bird was scared.", audioName: "scared")
    ],

    games: []
),

Story(
    title: "The Floating Balloon",
    level: .explorer,
    category: .moral,
    imageName: "story9_cover",
    theme: StoryTheme(primary: .red, secondary: .pink),

    pages: [
        Page(text: "Sara held a red balloon.\nIt was her favorite.", imageName: "story9_page1", audioName: "story9_audio1"),
        Page(text: "The wind blew strong.\nThe balloon slipped away.", imageName: "story9_page2", audioName: "story9_audio2"),
        Page(text: "Sara smiled and waved.\n\"Maybe it will make someone happy.\"", imageName: "story9_page3", audioName: "story9_audio3")
    ],

    moral: "Letting go can sometimes bring happiness to others.",

    vocabulary: [
        VocabularyWord(word: "Float", meaning: "Move in the air.", example: "The balloon floated up high.", audioName: "float"),
        VocabularyWord(word: "Slip", meaning: "To lose hold of something.", example: "The balloon slipped from Sara’s hand.", audioName: "slip"),
        VocabularyWord(word: "Wave", meaning: "Move your hand to say goodbye.", example: "Sara waved at her balloon.", audioName: "wave"),
        VocabularyWord(word: "Happiness", meaning: "A feeling of joy.", example: "Seeing someone smile gave her happiness.", audioName: "happiness")
    ],

    games: []
),

Story(
    title: "The Slow and Steady Turtle",
    level: .explorer,
    category: .moral,
    imageName: "story10_cover",
    theme: StoryTheme(primary: .green, secondary: .blue),

    pages: [
        Page(text: "A turtle walked very slowly.\nOther animals ran fast.", imageName: "story10_page1", audioName: "story10_audio1"),
        Page(text: "They laughed at him.\nBut the turtle kept going.", imageName: "story10_page2", audioName: "story10_audio2"),
        Page(text: "He reached the pond.\nSlow and steady wins.", imageName: "story10_page3", audioName: "story10_audio3")
    ],

    moral: "Patience and persistence lead to success.",

    vocabulary: [
        VocabularyWord(word: "Steady", meaning: "Not rushing.", example: "The turtle walked steadily.", audioName: "steady"),
        VocabularyWord(word: "Rush", meaning: "To move quickly.", example: "The other animals rushed past.", audioName: "rush"),
        VocabularyWord(word: "Pond", meaning: "A small body of water.", example: "The turtle reached the pond.", audioName: "pond"),
        VocabularyWord(word: "Persistence", meaning: "Keep trying even when it’s hard.", example: "The turtle showed persistence.", audioName: "persistence")
    ],

    games: []
),

Story(
    title: "The Kind Apple Tree",
    level: .explorer,
    category: .moral,
    imageName: "story11_cover",
    theme: StoryTheme(primary: .green, secondary: .orange),

    pages: [
        Page(text: "A tree grew bright apples.\nChildren came to pick them.", imageName: "story11_page1", audioName: "story11_audio1"),
        Page(text: "One day, a tired boy came.\nHe had no food.", imageName: "story11_page2", audioName: "story11_audio2"),
        Page(text: "The tree gave him apples.\nGiving made it happy.", imageName: "story11_page3", audioName: "story11_audio3")
    ],

    moral: "Kindness and giving bring happiness.",

    vocabulary: [
        VocabularyWord(word: "Freely", meaning: "Without holding back.", example: "The tree gave apples freely.", audioName: "freely"),
        VocabularyWord(word: "Tired", meaning: "Needing rest.", example: "The boy felt tired.", audioName: "tired"),
        VocabularyWord(word: "Warm", meaning: "Feeling happy inside.", example: "The boy felt warm inside.", audioName: "warm"),
        VocabularyWord(word: "Kindness", meaning: "Being caring and helpful.", example: "Showing kindness makes others happy.", audioName: "kindness")
    ],

    games: []
),

Story(
    title: "The Whispering Waves",
    level: .explorer,
    category: .adventure,
    imageName: "story12_cover",
    theme: StoryTheme(primary: .blue, secondary: .cyan),

    pages: [
        Page(text: "The ocean was wide and deep.\nOne small wave felt afraid.", imageName: "story12_page1", audioName: "story12_audio1"),
        Page(text: "\"What if I fall?\" it thought.\nThe big waves whispered, \"You are strong.\"", imageName: "story12_page2", audioName: "story12_audio2"),
        Page(text: "The small wave rose high.\n\"I did it,\" it said proudly.", imageName: "story12_page3", audioName: "story12_audio3")
    ],

    moral: "Believe in yourself even when you feel afraid.",

    vocabulary: [
        VocabularyWord(word: "Whisper", meaning: "Speak very softly.", example: "The waves whispered to the small wave.", audioName: "whisper"),
        VocabularyWord(word: "Courage", meaning: "Being brave.", example: "The small wave showed courage.", audioName: "courage"),
        VocabularyWord(word: "Proudly", meaning: "Feeling happy about yourself.", example: "The wave rose proudly.", audioName: "proudly"),
        VocabularyWord(word: "Afraid", meaning: "Feeling scared.", example: "The small wave was afraid.", audioName: "afraid"),
        VocabularyWord(word: "Ocean", meaning: "A large body of salt water.", example: "The ocean was wide and deep.", audioName: "ocean")
    ],

    games: []
),

// =========================
// ADVANCED STORIES (13–16)
// =========================

Story(
    title: "The Light in the Dark",
    level: .advanced,
    category: .moral,
    imageName: "story13_cover",
    theme: StoryTheme(primary: .black, secondary: .yellow),

    pages: [
        Page(text: "It was very dark.\nLina could not see the path.\nShe felt a little scared.", imageName: "story13_page1", audioName: "story13_audio1"),
        Page(text: "She saw a tiny light ahead.\nIt flickered softly.\nLina walked toward it.", imageName: "story13_page2", audioName: "story13_audio2"),
        Page(text: "The light grew brighter.\nIt showed her the way home.\nLina felt brave again.", imageName: "story13_page3", audioName: "story13_audio3"),
        Page(text: "She smiled and kept walking.\nThe dark felt smaller now.\nThe light stayed with her.", imageName: "story13_page4", audioName: "story13_audio4")
    ],

    moral: "Even a small light can guide you through dark times.",

    vocabulary: [
        VocabularyWord(word: "Flicker", meaning: "A small unsteady light.", example: "The candle began to flicker.", audioName: "flicker"),
        VocabularyWord(word: "Path", meaning: "A way to go.", example: "She followed the path home.", audioName: "path"),
        VocabularyWord(word: "Brave", meaning: "Not giving up when afraid.", example: "Lina felt brave in the dark.", audioName: "brave"),
        VocabularyWord(word: "Guide", meaning: "To show the way.", example: "The light helped guide her.", audioName: "guide")
    ],

    games: []
),

Story(
    title: "The Missing Piece",
    level: .advanced,
    category: .moral,
    imageName: "story14_cover",
    theme: StoryTheme(primary: .gray, secondary: .blue),

    pages: [
        Page(text: "A small circle rolled slowly.\nIt had a piece missing.\nIt did not feel whole.", imageName: "story14_page1", audioName: "story14_audio1"),
        Page(text: "It looked everywhere.\nIt tried many pieces.\nBut none of them fit.", imageName: "story14_page2", audioName: "story14_audio2"),
        Page(text: "The circle stopped and thought.\n\"Maybe I am okay like this,\" it said.\nIt smiled a little.", imageName: "story14_page3", audioName: "story14_audio3"),
        Page(text: "It rolled happily again.\nIt did not need to change.\nIt was already enough.", imageName: "story14_page4", audioName: "story14_audio4")
    ],

    moral: "You do not need to be perfect to be enough.",

    vocabulary: [
        VocabularyWord(word: "Missing", meaning: "Not there.", example: "One piece was missing.", audioName: "missing"),
        VocabularyWord(word: "Whole", meaning: "Complete.", example: "The circle wanted to feel whole.", audioName: "whole"),
        VocabularyWord(word: "Fit", meaning: "To match or belong.", example: "The piece did not fit.", audioName: "fit"),
        VocabularyWord(word: "Enough", meaning: "Just right.", example: "She knew she was enough.", audioName: "enough")
    ],

    games: []
),

Story(
    title: "The Brave Lantern",
    level: .advanced,
    category: .moral,
    imageName: "story15_cover",
    theme: StoryTheme(primary: .orange, secondary: .yellow),

    pages: [
        Page(text: "A small lantern sat quietly.\nIt was afraid of the dark.\nIt did not want to shine.", imageName: "story15_page1", audioName: "story15_audio1"),
        Page(text: "People walked in the dark.\nThey could not see the road.\nThe lantern felt worried.", imageName: "story15_page2", audioName: "story15_audio2"),
        Page(text: "It took a deep breath.\nIt began to glow softly.\nThe road became clear.", imageName: "story15_page3", audioName: "story15_audio3"),
        Page(text: "People smiled and walked safely.\nThe lantern felt proud.\nIt was brave after all.", imageName: "story15_page4", audioName: "story15_audio4")
    ],

    moral: "Being brave can help others too.",

    vocabulary: [
        VocabularyWord(word: "Lantern", meaning: "A light you can carry.", example: "The lantern lit the road.", audioName: "lantern"),
        VocabularyWord(word: "Glow", meaning: "To shine softly.", example: "The lantern began to glow.", audioName: "glow"),
        VocabularyWord(word: "Worried", meaning: "Feeling uneasy.", example: "She felt worried in the dark.", audioName: "worried"),
        VocabularyWord(word: "Proud", meaning: "Feeling happy about what you did.", example: "He felt proud of himself.", audioName: "proud")
    ],

    games: []
),

Story(
    title: "The Sky Painter",
    level: .advanced,
    category: .moral,
    imageName: "story16_cover",
    theme: StoryTheme(primary: .blue, secondary: .pink),

    pages: [
        Page(text: "Noor loved to paint the sky.\nShe used blue, pink, and gold.\nShe wanted it to be perfect.", imageName: "story16_page1", audioName: "story16_audio1"),
        Page(text: "The colors mixed too much.\nThe sky did not look right.\nNoor felt upset.", imageName: "story16_page2", audioName: "story16_audio2"),
        Page(text: "She tried again slowly.\nShe took her time.\nThe colors looked better.", imageName: "story16_page3", audioName: "story16_audio3"),
        Page(text: "Noor smiled at her work.\nIt was not perfect, but beautiful.\nShe was proud of trying.", imageName: "story16_page4", audioName: "story16_audio4")
    ],

    moral: "Trying again helps you improve and grow.",

    vocabulary: [
        VocabularyWord(word: "Perfect", meaning: "Without mistakes.", example: "She wanted it to be perfect.", audioName: "perfect"),
        VocabularyWord(word: "Upset", meaning: "Feeling sad or frustrated.", example: "Noor felt upset at first.", audioName: "upset"),
        VocabularyWord(word: "Improve", meaning: "To get better.", example: "Practice helps you improve.", audioName: "improve"),
        VocabularyWord(word: "Beautiful", meaning: "Very nice to see.", example: "The sky looked beautiful.", audioName: "beautiful")
    ],

    games: []
)
    
    ] 
