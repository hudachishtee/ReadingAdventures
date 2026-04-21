import SwiftUI

let sampleStories: [Story] = [

    // =========================
    // BEGINNER STORIES
    // =========================

    Story(
        title: "The Extra Sandwich",
        description: """
                Meet a child who brings an extra sandwich.
                
                They notice someone sitting alone.

                A story about kindness.
                """,
        shortDescription: "Two children share their food.", // ✅ ADD THIS

        level: .beginner,
        category: .moral,
        coverImage: "story1_cover",
        previewImage: "story1_preview",    // ✅ Preview screen

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

        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Sandwich",
                options: ["Apple", "Sandwich", "Chair"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Share mean?",
                options: [
                    "Keep everything",
                    "Give part to others",
                    "Run away"
                ],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word KIND",
                options: ["K", "I", "N", "D"],
                correctIndex: nil,
                correctAnswer: "KIND"
            )
        ]
    ),

    Story(
        title: "The Brave Little Wave",
        description: """
                Meet a little wave who feels nervous about reaching the shore.
                
                Can it find the courage to roll forward? 
                
                A short, splashy story about bravery and trying new things.
                """,
        shortDescription: "A small wave learns to be brave.",
        
        level: .beginner,
        category: .adventure,
        coverImage: "story2_cover",
        previewImage: "story2_preview",    // ✅ Preview screen

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

        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Brave",
                options: ["Scared", "Brave", "Sandwich"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Ocean mean?",
                options: [
                    "A very large body of water",
                    "A mountain",
                    "A road"
                ],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word WAVE",
                options: ["W", "V", "A", "E"],
                correctIndex: nil,
                correctAnswer: "WAVE"
            )
        ],
    ),

    Story(
        title: "The Sunset Promise",
        description: """
                Meet two friends who watch the sun set by the sea.
                
                Can their promise to meet again stay warm in their hearts?
                
                A short, gentle story about friendship and keeping promises.
                """,
        shortDescription: "Two friends make a promise.",
        
        level: .beginner,
        category: .moral,
        coverImage: "story3_cover",
        previewImage: "story3_preview",    // ✅ Preview screen

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

        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Promise",
                options: ["Promise", "Window", "Chair"],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Friendship mean?",
                options: [
                    "Caring about someone",
                    "Being angry",
                    "Sleeping"
                ],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word SKY",
                options: ["K", "S", "Y"],
                correctIndex: nil,
                correctAnswer: "SKY"
            )
        ]
    ),

    Story(
        title: "The Lost Crayon",
        description: """
                Meet Mia, a little artist who loses her favorite crayon.    
                
                Can she find it again and finish her drawing? 
                
                A colorful story about not giving up and keeping hope.
                """,
        shortDescription: "A girl looks for her crayon.",
        
        level: .beginner,
        category: .moral,
        coverImage: "story4_cover",
        previewImage: "story4_preview",    // ✅ Preview screen

        theme: StoryTheme(primary: .red, secondary: .orange),

        pages: [
            Page(text: "Mia had one red crayon.\nShe liked to draw hearts.\nMia looked in the box. \nThe crayon was gone.", imageName: "story4_page1", audioName: "story4_audio1"),
            Page(text: "Mia looked under the table.\nShe looked under the chair.\nShe felt sad.", imageName: "story4_page2", audioName: "story4_audio2"),
            Page(text: "Mia saw the crayon on the floor.\nIt rolled near her shoe.\nMia smiled.\nShe started to draw again.", imageName: "story4_page3", audioName: "story4_audio3")
        ],

        moral: "Do not give up. Keep looking.",

        vocabulary: [
            VocabularyWord(word: "Crayon", meaning: "A tool for drawing", example: "I used a crayon.", audioName: "crayon"),
            VocabularyWord(word: "Lost", meaning: "Not where it should be", example: "My toy is lost.", audioName: "lost"),
            VocabularyWord(word: "Draw", meaning: "To make a picture", example: "I draw flowers.", audioName: "draw"),
            VocabularyWord(word: "Smile", meaning: "A happy face", example: "She gave a smile.", audioName: "smile")
        ],

        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Crayon",
                options: ["Bottle", "Crayon", "Table"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Lost mean?",
                options: [
                    "Not where it should be",
                    "Very loud",
                    "Happy"
                ],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word DRAW",
                options: ["W", "A", "R", "D"],
                correctIndex: nil,
                correctAnswer: "DRAW"
            )
        ]
    ),

    Story(
        title: "Milo the Cat",
        description: """
                Meet Milo, a small, playful cat with soft white fur. 
                
                Can he catch his moving toy and enjoy the joy of play?
                
                A short, pouncy story about curiosity, fun, and appreciating what you love.
                """,
        shortDescription: "A playful cat chases his toy.",
        
        level: .beginner,
        category: .moral,
        coverImage: "story5_cover",
        previewImage: "story5_preview",    // ✅ Preview screen

        theme: StoryTheme(primary: .red, secondary: .orange),

        pages: [
            Page(text: "Milo is a small cat.\nHe has soft, white fur.\nMilo likes to play.", imageName: "story5_page1", audioName: "story5_audio1"),
            Page(text: "Milo sees a blue toy.\nThe toy moves.\nMilo runs and taps it.", imageName: "story5_page2", audioName: "story5_audio2"),
            Page(text: "The toy stops.\nMilo sits and smiles.\nShe smiled.\n“I like my toy,” says Milo.", imageName: "story5_page3", audioName: "story5_audio3")
        ],

        moral: "Take care of the things you love and enjoy simple moments.",

        vocabulary: [
            VocabularyWord(word: "Cat", meaning: "A small animal with fur that people keep as a pet.", example: "I  have a cat at home.", audioName: "cat"),
            VocabularyWord(word: "Soft", meaning: "Something that feels nice and not hard.", example: "My pillow is soft.", audioName: "soft"),
            VocabularyWord(word: "Toy", meaning: "Something to play with.", example: "Milo loves his toy mouse.", audioName: "toy"),
            VocabularyWord(word: "Play", meaning: "To have fun and enjoy.", example: "Milo likes to play with the ball.", audioName: "play")
        ],
        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Toy",
                options: ["Cat", "Toy", "Soft"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Soft mean?",
                options: [
                    "Something that feels nice and not hard",
                    "Very loud",
                    "Very fast"
                ],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word CAT",
                options: ["A", "C", "T"],
                correctIndex: nil,
                correctAnswer: "CAT"
            )
        ]
    ),
    
    Story(
        title: "The Quiet Moon",
        description: """
                Meet the quiet moon that watches over the night.
                
                Follow a small owl as it explores the calm, peaceful night, learning to enjoy the stillness around it. 
                
                A gentle, soothing story about calmness, observation, and the beauty of quiet moments.
                """,
        shortDescription: "A quiet night with a small owl.",
        
        level: .beginner,
        category: .moral,
        coverImage: "story6_cover",
        previewImage: "story6_preview",    // ✅ Preview screen

        theme: StoryTheme(primary: .red, secondary: .orange),

        pages: [
            Page(text: "The moon is big and bright.\nIt shines in the dark sky.\nEverything is quiet.", imageName: "story6_page1", audioName: "story6_audio1"),
            Page(text: "A small owl wakes up.\nIt looks at the moon.\n“Hello,” says the owl.", imageName: "story6_page2", audioName: "story6_audio2"),
            Page(text: "The owl sits very still.\nThe night feels calm.\nThe moon watches over all.", imageName: "story6_page3", audioName: "story6_audio3")
        ],

        moral: "Sometimes, quiet moments help us notice the beauty around us.",

        vocabulary: [
            VocabularyWord(word: "Moon", meaning: "The bright light in the night sky.", example: "Milo looks at the moon before bedtime.", audioName: "moon"),
            VocabularyWord(word: "Quiet", meaning: "No loud sounds.", example: "Milo sleeps quietly on the soft pillow.", audioName: "quiet"),
            VocabularyWord(word: "Owl", meaning: "A bird that wakes up at night.", example: "The owl flies silently in the dark.", audioName: "owl"),
            VocabularyWord(word: "Night", meaning: "The dark time after the sun goes down.", example: "Stars shine at night.", audioName: "night")
        ],
        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Moon",
                options: ["Owl", "Moon", "Night"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Night mean?",
                options: [
                    "The dark time after the sun goes down",
                    "A bright sunny day",
                    "Time to eat lunch"
                ],
                correctIndex: 0,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word OWL",
                options: ["O", "L", "W"],
                correctIndex: nil,
                correctAnswer: "OWL"
            )
        ]
    ),

    // =========================
    // EXPLORER STORIES
    // =========================

    Story(
        title: "The Lost Little Bird",
        description: """
                Meet Omar, who finds a scared little bird all alone.
                
                Can he help it return home safely? 
                
                A gentle story about kindness and helping others.
                """,
        shortDescription: "A boy helps a lost bird.",
        
        level: .explorer,
        category: .moral,
        coverImage: "story8_cover",
        previewImage: "story8_preview",    // ✅ Preview screen

        theme: StoryTheme(
            primary: Color(red: 0.95, green: 0.9, blue: 0.6),
            secondary: Color(red: 0.6, green: 0.85, blue: 0.55)
        ),
        pages: [
            Page(text: "Omar heard a soft chirp.\nA small bird sat alone.", imageName: "story8_page1", audioName: "story8_audio1"),
            Page(text: "It looked scared.\nOmar searched for its nest.", imageName: "story8_page2", audioName: "story8_audio2"),
            Page(text: "He found the nest and helped the bird.\nThe bird was safe again.", imageName: "story8_page3", audioName: "story8_audio3")
        ],
        moral: "Helping others, even in small ways, makes a big difference.",
        vocabulary: [
            VocabularyWord(
                word: "Chirp",
                meaning: "A small bird sound",
                example: "The bird chirped loudly.",
                audioName: "chirp"
            ),
            VocabularyWord(
                word: "Nest",
                meaning: "A bird’s home",
                example: "The bird returned to its nest.",
                audioName: "nest"
            ),
            VocabularyWord(
                word: "Safe",
                meaning: "Free from danger",
                example: "The bird felt safe with Omar.",
                audioName: "safe"
            ),
            VocabularyWord(
                word: "Scared",
                meaning: "Feeling afraid",
                example: "The little bird was scared.",
                audioName: "scared"
            )
        ],
        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Nest",
                options: ["Tree", "Nest", "Sky"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Safe mean?",
                options: [
                    "In danger",
                    "Protected",
                    "Fast"
                ],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word BIRD",
                options: ["I", "D", "R", "B"],
                correctIndex: nil,
                correctAnswer: "BIRD"
            )
        ]
    ),

    Story(
        title: "The Rainy Day Surprise",
        description: """
                Meet Lina, who wakes to a rainy day.
                
                Can she make the day special despite the gray clouds?
                
                A short, cheerful story about creativity and making fun in any situation.
                """,
        shortDescription: "A girl makes a rainy day fun.",
        
        level: .explorer,
        category: .moral,
        coverImage: "story7_cover",
        previewImage: "story7_preview",    // ✅ Preview screen

        theme: StoryTheme(
            primary: Color(red: 1.0, green: 0.75, blue: 0.8),
            secondary: Color(red: 1.0, green: 0.55, blue: 0.65)
        ),
        pages: [
            Page(text: "Lina woke up to gray clouds.\nRain tapped softly on the window.", imageName: "story7_page1", audioName: "story7_audio1"),
            Page(text: "She felt a little sad.\nHer mother said, “Let’s make today special.”", imageName: "story7_page2", audioName: "story7_audio2"),
            Page(text: "They built a tent and read stories.\nLina smiled.\nRainy days can be fun too.", imageName: "story7_page3", audioName: "story7_audio3")
        ],
        moral: "Even a rainy day can become special with a little creativity.",
        vocabulary: [
            VocabularyWord(
                word: "Surprise",
                meaning: "Something unexpected that makes you happy or excited",
                example: "The gift was a surprise.",
                audioName: "surprise"
            ),
            VocabularyWord(
                word: "Special",
                meaning: "Something important or different in a good way",
                example: "Today felt special.",
                audioName: "special"
            ),
            VocabularyWord(
                word: "Tent",
                meaning: "A small shelter made of cloth",
                example: "They built a tent indoors.",
                audioName: "tent"
            ),
            VocabularyWord(
                word: "Creativity",
                meaning: "Using imagination to make something fun or new",
                example: "Lina used her creativity to play inside.",
                audioName: "creativity"
            )
        ],
        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Rain",
                options: ["Sun", "Rain", "Tree"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "What does Special mean?",
                options: [
                    "Boring",
                    "Important or nice",
                    "Loud"
                ],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word TENT",
                options: ["N", "T", "T", "E"],
                correctIndex: nil,
                correctAnswer: "TENT"
            )
        ]    ),

 Story(
    title: "The Floating Balloon",
    description: """
            Sara’s red balloon slips away in the wind.
            
            Can she learn to let go and find happiness in the unexpected?
            
            A short, thoughtful story about letting go.
            """,
    shortDescription: "A girl lets her balloon go.",
    
    level: .explorer,
    category: .adventure,
    coverImage: "story9_cover",
    previewImage: "story9_preview",    // ✅ Preview screen

    theme: StoryTheme(primary: .blue, secondary: .cyan),

    pages: [
        Page(text: "Sara held a red balloon.\nIt was her favorite.", imageName: "story9_page1", audioName: "story9_audio1"),
        Page(text: "The wind blew strong.\nThe balloon slipped away.", imageName: "story9_page2", audioName: "story9_audio2"),
        Page(text: "Sara smiled and waved.\n\"Maybe it will make someone happy.”", imageName: "story9_page3", audioName: "story9_audio3")
    ],

    moral: "Letting go can sometimes bring happiness to others.",

    vocabulary: [
        VocabularyWord(
            word: "Float",
            meaning: "Move in the air",
            example: "The balloon floated up high.",
            audioName: "float"
        ),
        VocabularyWord(
            word: "Slip",
            meaning: "To lose hold of something",
            example: "The balloon slipped from Sara’s hand.",
            audioName: "slip"
        ),
        VocabularyWord(
            word: "Wave",
            meaning: "Move your hand to say goodbye",
            example: "Sara waved at her balloon.",
            audioName: "wave"
        ),
        VocabularyWord(
            word: "Happiness",
            meaning: "A feeling of joy",
            example: "Seeing someone smile gave her happiness.",
            audioName: "happiness"
        )
    ],

    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word Balloon",
            options: ["Balloon", "Apple", "Book"],
            correctIndex: 0,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .meaning,
            question: "Float = ?",
            options: [
                "Fall",
                "Stay",
                "Move in air"
            ],
            correctIndex: 2,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .buildWord,
            question: "Build the word WAVE",
            options: ["W", "A", "V", "E"],
            correctIndex: nil,
            correctAnswer: "WAVE"
        )
    ]
    ),
    Story(
        title: "The Slow and Steady Turtle",
        description: """
                A turtle walks slowly while others rush past.
                
                Can patience help him reach his goal?
                
                A story about persistence and steady progress.
                """,
        shortDescription: "A slow turtle keeps going.",
        
        level: .explorer,
        category: .moral,
        coverImage: "story10_cover",
        previewImage: "story10_preview",    // ✅ Preview screen

        theme: StoryTheme(
            primary: Color(red: 1.0, green: 0.75, blue: 0.8),
            secondary: Color(red: 1.0, green: 0.55, blue: 0.65)
        ),
        pages: [
            Page(text: "A turtle walked very slowly.\nOther animals ran fast.", imageName: "story10_page1", audioName: "story10_audio1"),
            Page(text: "They laughed at him.\nBut the turtle kept going.", imageName: "story10_page2", audioName: "story10_audio2"),
            Page(text: "He reached the pond.\nSlow and steady wins.", imageName: "story10_page3", audioName: "story10_audio3")
        ],
        moral: "Patience and persistence lead to success.",
        vocabulary: [
            VocabularyWord(
                word: "Steady",
                meaning: "Not rushing",
                example: "The turtle walked steadily.",
                audioName: "steady"
            ),
            VocabularyWord(
                word: "Rush",
                meaning: "To move quickly",
                example: "The other animals rushed past.",
                audioName: "rush"
            ),
            VocabularyWord(
                word: "Pond",
                meaning: "A small body of water",
                example: "The turtle reached the pond.",
                audioName: "pond"
            ),
            VocabularyWord(
                word: "Persistence",
                meaning: "Keep trying even when it’s hard",
                example: "The turtle showed persistence.",
                audioName: "persistence"
            )
        ],

        games: [
            GameQuestion(
                type: .tapWord,
                question: "Tap the word Turtle",
                options: ["Dog", "Turtle", "Bird"],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .meaning,
                question: "Rush = ?",
                options: [
                    "Slow",
                    "Fast movement",
                    "Sleep"
                ],
                correctIndex: 1,
                correctAnswer: nil
            ),
            
            GameQuestion(
                type: .buildWord,
                question: "Build the word POND",
                options: ["P", "N", "D", "O"],
                correctIndex: nil,
                correctAnswer: "POND"
            )
        ]
    ),


// =========================
// ADVANCED STORIES (11–16)
// =========================

Story(
    title: "The Light in the Dark",
    description: """
            Meet a child who feels lost in the dark.
            
            Can a small light help them find their way again?
            
            A thoughtful story about hope and not giving up.
            """,
    shortDescription: "A small light shows the way.",
    
    level: .advanced,
    category: .moral,
    coverImage: "story11_cover",
    previewImage: "story11_preview",    // ✅ Preview screen

    theme: StoryTheme(primary: .black, secondary: .yellow),

    pages: [
        Page(text: "It was very dark.\nLina could not see the path.\nShe felt a little scared.", imageName: "story11_page1", audioName: "story11_audio1"),
        Page(text: "She saw a tiny light ahead.\nIt flickered softly.\nLina walked toward it.", imageName: "story11_page2", audioName: "story11_audio2"),
        Page(text: "The light grew brighter.\nIt showed her the way home.\nLina felt brave again.", imageName: "story11_page3", audioName: "story11_audio3"),
        Page(text: "She smiled and kept walking.\nThe dark felt smaller now.\nThe light stayed with her.", imageName: "story11_page4", audioName: "story11_audio4")
    ],

    moral: "Even a small light can guide you through dark times.",

    vocabulary: [
        VocabularyWord(
            word: "Flicker",
            meaning: "A small unsteady light",
            example: "The candle began to flicker.",
            audioName: "flicker"
        ),
        VocabularyWord(
            word: "Path",
            meaning: "A way to go",
            example: "She followed the path home.",
            audioName: "path"
        ),
        VocabularyWord(
            word: "Brave",
            meaning: "Not giving up when afraid",
            example: "Lina felt brave in the dark.",
            audioName: "brave"
        ),
        VocabularyWord(
            word: "Guide",
            meaning: "To show the way",
            example: "The light helped guide her.",
            audioName: "guide"
        )
    ],

    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word Light",
            options: ["Light", "Dark", "Fire"],
            correctIndex: 0,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .meaning,
            question: "Brave = ?",
            options: [
                "Scared",
                "Not giving up when afraid",
                "Sleepy"
            ],
            correctIndex: 1,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .buildWord,
            question: "Build the word PATH",
            options: ["A", "T", "P", "H"],
            correctIndex: nil,
            correctAnswer: "PATH"
        )
    ]
),

Story(
    title: "The Missing Piece",
    description: """
            Meet Lina, who wakes to a rainy day.
            
            Can she make the day special despite the gray clouds?
            
            A short, cheerful story about creativity and making fun in any situation.
            """,
    shortDescription: "A circle learns it is enough.",
    
    level: .advanced,
    category: .moral,
    coverImage: "story12_cover",
    previewImage: "story12_preview",    // ✅ Preview screen

    theme: StoryTheme(primary: .gray, secondary: .blue),

    pages: [
        Page(text: "A small circle rolled slowly.\nIt had a piece missing.\nIt did not feel whole.", imageName: "story12_page1", audioName: "story12_audio1"),
        Page(text: "It looked everywhere.\nIt tried many pieces.\nBut none of them fit.", imageName: "story12_page2", audioName: "story12_audio2"),
        Page(text: "The circle stopped and thought.\n\"Maybe I am okay like this,\" it said.\nIt smiled a little.", imageName: "story12_page3", audioName: "story12_audio3"),
        Page(text: "It rolled happily again.\nIt did not need to change.\nIt was already enough.", imageName: "story12_page4", audioName: "story12_audio4")
    ],

    moral: "You do not need to be perfect to be enough.",

    vocabulary: [
        VocabularyWord(
            word: "Missing",
            meaning: "Not there",
            example: "One piece was missing.",
            audioName: "missing"
        ),
        VocabularyWord(
            word: "Whole",
            meaning: "Complete",
            example: "The circle wanted to feel whole.",
            audioName: "whole"
        ),
        VocabularyWord(
            word: "Fit",
            meaning: "To match or belong",
            example: "The piece did not fit.",
            audioName: "fit"
        ),
        VocabularyWord(
            word: "Enough",
            meaning: "Just right",
            example: "She knew she was enough.",
            audioName: "enough"
        )
    ],

    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word Fit",
            options: ["Fit", "Miss", "Stop"],
            correctIndex: 0,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .meaning,
            question: "Whole = ?",
            options: [
                "Broken",
                "Complete",
                "Small"
            ],
            correctIndex: 1,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .buildWord,
            question: "Build the word ENOUGH",
            options: ["E", "N", "O", "U", "G", "H"],
            correctIndex: nil,
            correctAnswer: "ENOUGH"
        )
    ]
),

Story(
    title: "The Brave Lantern",
    description: """
            Meet Lina, who wakes to a rainy day.
            
            Can she make the day special despite the gray clouds?
            
            A short, cheerful story about creativity and making fun in any situation.
            """,
    shortDescription: "A lantern finds courage to shine.",
    
    level: .advanced,
    category: .moral,
    coverImage: "story13_cover",
    previewImage: "story13_preview",    // ✅ Preview screen

    theme: StoryTheme(primary: .orange, secondary: .yellow),

    pages: [
        Page(text: "A small lantern sat quietly.\nIt was afraid of the dark.\nIt did not want to shine.", imageName: "story13_page1", audioName: "story13_audio1"),
        Page(text: "People walked in the dark.\nThey could not see the road.\nThe lantern felt worried.", imageName: "story13_page2", audioName: "story13_audio2"),
        Page(text: "It took a deep breath.\nIt began to glow softly.\nThe road became clear.", imageName: "story13_page3", audioName: "story13_audio3"),
        Page(text: "People smiled and walked safely.\nThe lantern felt proud.\nIt was brave after all.", imageName: "story13_page4", audioName: "story13_audio4")
    ],

    moral: "Being brave can help others too.",

    vocabulary: [
        VocabularyWord(
            word: "Lantern",
            meaning: "A light you can carry",
            example: "The lantern lit the road.",
            audioName: "lantern"
        ),
        VocabularyWord(
            word: "Glow",
            meaning: "To shine softly",
            example: "The lantern began to glow.",
            audioName: "glow"
        ),
        VocabularyWord(
            word: "Worried",
            meaning: "Feeling uneasy",
            example: "She felt worried in the dark.",
            audioName: "worried"
        ),
        VocabularyWord(
            word: "Proud",
            meaning: "Feeling happy about what you did",
            example: "He felt proud of himself.",
            audioName: "proud"
        )
    ],

    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word Glow",
            options: ["Glow", "Dark", "Light"],
            correctIndex: 0,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .meaning,
            question: "Proud = ?",
            options: [
                "Sad",
                "Feeling happy about what you did",
                "Angry"
            ],
            correctIndex: 1,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .buildWord,
            question: "Build the word LANTERN",
            options: ["L", "N", "T", "A", "R", "E", "N"],
            correctIndex: nil,
            correctAnswer: "LANTERN"
        )
    ]
),

Story(
    title: "The Sky Painter",
    description: """
            Meet Lina, who wakes to a rainy day.
            
            Can she make the day special despite the gray clouds?
            
            A short, cheerful story about creativity and making fun in any situation.
            """,
    shortDescription: "A girl learns to keep trying.",
    
    level: .advanced,
    category: .moral,
    coverImage: "story14_cover",
    previewImage: "story14_preview",    // ✅ Preview screen

    theme: StoryTheme(primary: .blue, secondary: .pink),

    pages: [
        Page(text: "Noor loved to paint the sky.\nShe used blue, pink, and gold.\nShe wanted it to be perfect.", imageName: "story14_page1", audioName: "story14_audio1"),
        Page(text: "The colors mixed too much.\nThe sky did not look right.\nNoor felt upset.", imageName: "story14_page2", audioName: "story14_audio2"),
        Page(text: "She tried again slowly.\nShe took her time.\nThe colors looked better.", imageName: "story14_page3", audioName: "story14_audio3"),
        Page(text: "Noor smiled at her work.\nIt was not perfect, but beautiful.\nShe was proud of trying.", imageName: "story14_page4", audioName: "story14_audio4")
    ],

    moral: "Trying again helps you improve and grow.",

    vocabulary: [
        VocabularyWord(
            word: "Perfect",
            meaning: "Without mistakes",
            example: "She wanted it to be perfect.",
            audioName: "perfect"
        ),
        VocabularyWord(
            word: "Upset",
            meaning: "Feeling sad or frustrated",
            example: "Noor felt upset at first.",
            audioName: "upset"
        ),
        VocabularyWord(
            word: "Improve",
            meaning: "To get better",
            example: "Practice helps you improve.",
            audioName: "improve"
        ),
        VocabularyWord(
            word: "Beautiful",
            meaning: "Very nice to see",
            example: "The sky looked beautiful.",
            audioName: "beautiful"
        )
    ],

    games: [
        GameQuestion(
            type: .tapWord,
            question: "Tap the word Beautiful",
            options: ["Beautiful", "Ugly", "Small"],
            correctIndex: 0,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .meaning,
            question: "Improve = ?",
            options: [
                "Get worse",
                "To get better",
                "Stop"
            ],
            correctIndex: 1,
            correctAnswer: nil
        ),
        
        GameQuestion(
            type: .buildWord,
            question: "Build the word PERFECT",
            options: ["P", "E", "R", "F", "E", "C", "T"],
            correctIndex: nil,
            correctAnswer: "PERFECT"
        )
    ]
),
]
