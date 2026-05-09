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
            
            print("Audio session error:", error.localizedDescription)
        }
    }
    
    // MARK: - Main Play Function
    
    func play(audioName: String, speed: Float = 1.0) {
        
        guard let url = Bundle.main.url(
            forResource: audioName,
            withExtension: "mp3"
        ) else {
            
            print("Audio not found:", audioName)
            return
        }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.enableRate = true
            player?.rate = speed
            
            player?.delegate = self
            
            player?.prepareToPlay()
            player?.play()
            
            DispatchQueue.main.async {
                self.isPlaying = true
            }
            
        } catch {
            
            print("Audio error:", error.localizedDescription)
        }
    }
    
    // MARK: - Convenience Function
    
    func playSound(named audioName: String, speed: Float = 1.0) {
        
        play(audioName: audioName, speed: speed)
    }
    
    // MARK: - Stop
    
    func stop() {
        
        player?.stop()
        player = nil
        
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    // MARK: - Delegate
    
    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ) {
        
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
}
