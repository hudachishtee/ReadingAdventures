//
//  AudioManager.swift
//  ReadingAdventures
//

import Foundation
import AVFoundation
import Combine

class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    
    @Published var isPlaying = false
    @Published var currentWordIndex = -1
    
    private var narratedWords: [String] = []
    
    override init() {
        super.init()
        configureAudioSession()
    }
    
    // MARK: - Configure Audio Session
    
    private func configureAudioSession() {
        
        do {
            
            let session = AVAudioSession.sharedInstance()
            
            try session.setCategory(
                .playback,
                mode: .default,
                options: []
            )
            
            try session.setActive(true)
            
        } catch {
            
            print(
                "Audio session error:",
                error.localizedDescription
            )
        }
    }
    
    // MARK: - Main Play Function
    
    func play(
        audioName: String,
        text: String,
        speed: Float = 1.0
    ) {
        
        guard let url = Bundle.main.url(
            forResource: audioName,
            withExtension: "mp3"
        ) else {
            
            print("Audio not found:", audioName)
            return
        }
        
        do {
            
            stop()
            
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.enableRate = true
            player?.rate = speed
            
            player?.delegate = self
            
            player?.prepareToPlay()
            
            let duration = player?.duration ?? 0
            
            player?.play()
            
            narratedWords = cleanedWords(from: text)
            
            currentWordIndex = -1
            
            DispatchQueue.main.async {
                self.isPlaying = true
            }
            
            startWordHighlighting(
                text: text,
                audioDuration: duration,
                speed: speed
            )
            
        } catch {
            
            print(
                "Audio error:",
                error.localizedDescription
            )
        }
    }
    
    // MARK: - Convenience Function
    
    func playSound(
        named audioName: String,
        text: String,
        speed: Float = 1.0
    ) {
        
        play(
            audioName: audioName,
            text: text,
            speed: speed
        )
    }
    
    // MARK: - Clean Words
    
    private func cleanedWords(from text: String) -> [String] {
        
        text
            .replacingOccurrences(of: "\n", with: " ")
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
    }
    
    // MARK: - Word Highlighting
    
    private func startWordHighlighting(
        text: String,
        audioDuration: Double,
        speed: Float
    ) {
        
        let words = text
            .replacingOccurrences(of: "\n", with: " ")
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        
        guard !words.isEmpty else {
            return
        }
        
        currentWordIndex = 0
        
        // MARK: - Build Natural Timing Weights
        
        var weights: [Double] = []
        
        for word in words {
            
            // Slightly faster overall pacing
            
            var weight =
                Double(word.count) * 0.072
            
            // Short words should move quicker
            
            if word.count <= 3 {
                weight *= 0.72
            }
            
            // Longer words stay highlighted slightly longer
            
            if word.count >= 8 {
                weight *= 1.12
            }
            
            // Comma pause
            
            if word.contains(",") {
                weight += 0.16
            }
            
            // Sentence ending pause
            
            if word.contains(".") ||
                word.contains("!") ||
                word.contains("?") {
                
                weight += 0.38
            }
            
            weights.append(weight)
        }
        
        let totalWeight =
            weights.reduce(0, +)
        
        var cumulativeTime = 0.0
        
        for index in words.indices {
            
            let wordDuration =
                (weights[index] / totalWeight)
                * (audioDuration / Double(speed))
            
            DispatchQueue.main.asyncAfter(
                deadline: .now() + cumulativeTime
            ) { [weak self] in
                
                guard let self else { return }
                
                if self.isPlaying {
                    self.currentWordIndex = index
                }
            }
            
            cumulativeTime += wordDuration
        }
    }
    
    // MARK: - Stop
    
    func stop() {
        
        player?.stop()
        player = nil
        
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentWordIndex = -1
        }
    }
    
    // MARK: - Delegate
    
    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ) {
        
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentWordIndex = -1
        }
    }
}
