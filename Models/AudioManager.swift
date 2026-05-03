//
//  AudioManager.swift
//  ReadingAdventures
//
//  Created by Huda Chishtee on 05/04/2026.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    
    @Published var isPlaying = false
    
    func play(audioName: String, speed: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: audioName, withExtension: "mp3") else {
            print("Audio not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.enableRate = true
            player?.rate = speed
            
            player?.delegate = self   // ✅ ADD THIS
            
            player?.play()
            
            DispatchQueue.main.async {
                self.isPlaying = true
            }
            
        } catch {
            print("Audio error:", error)
        }
    }
    
    func stop() {
        player?.stop()
        player = nil
        
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    // ✅ THIS FIXES YOUR ISSUE
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
}
