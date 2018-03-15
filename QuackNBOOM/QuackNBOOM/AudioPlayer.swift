 //
 //  AudioPlayer.swift
 //  QuackNBOOM
 //
 //  Created by Benoit Neriah R. on 3/14/18.
 //  Copyright © 2018 Neriah and Neenee. All rights reserved.
 //
 
 
 //;w;w;w;w; DISCARD?
 
 
 import Foundation
 import AVFoundation
 
 final class AudioPlayer {
    //;w; setting the class as a singleton
    static let sharedInstance: AudioPlayer = AudioPlayer()
    //;w; creating the AVPlayer and the AVPlayerItem in order to store the audio components for later use
    var player = AVAudioPlayer()
    var playerItem: AVPlayerItem?
    //;w; the file paths of each song
    let quackSound1 = Bundle.main.path(forResource: "DemonicQuack1", ofType: "wav")
    let quackSound2 = Bundle.main.path(forResource: "DemonicQuack2", ofType: "wav")
    let explodeSound1 = Bundle.main.path(forResource: "ExplosionSound1", ofType: "wav")
    let explodeSound2 = Bundle.main.path(forResource: "ExplosionSound2", ofType: "wav")
    let explodeSound3 = Bundle.main.path(forResource: "ExplosionSound3", ofType: "wav")
    let explodeSound4 = Bundle.main.path(forResource: "ExplosionSound4", ofType: "wav")
    let gameOverSound = Bundle.main.path(forResource: "GameOverSound", ofType: "wav")
    let shootSound1 = Bundle.main.path(forResource: "ShootingSound1", ofType: "wav")
    let shootSound2 = Bundle.main.path(forResource: "ShootingSound2", ofType: "wav")
    
    //;w; list of enums
    // TODO: Create public Enum of sound effects to play
    public enum sounds{
        case quack1
        case quack2
        case explode1
        case explode2
        case explode3
        case explode4
        case gameOver
        case shoot1
        case shoot2
    }
    
    // Initialization of the AudioPlayer
    //
    fileprivate init() {
        
    }
    
    
    // TODO: Create a public function that plays the sound effects specified
    //      from the enum entered into the parameter
    
    //public void playSoundEffect(SoundEffects soundEffect) { // Where SoundEffects is an Enum
    
    //;w; trying to code out the public function
    public func playSound(sound: sounds){
        switch sound{
        case sounds.quack1:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: quackSound1!))
            } catch{
                //error
                print("QUACK SOUND 1 CANNOT BE FOUND!")
            }
        case .quack2:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: quackSound2!))
            } catch{
                //error
                print("QUACK SOUND 2 CANNOT BE FOUND!")
            }
        case .explode1:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound1!))
            } catch{
                //error
                print("EXPLODING SOUND 1 CANNOT BE FOUND!")
            }
        case .explode2:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound2!))
            } catch{
                //error
                print("EXPLODING SOUND 2 CANNOT BE FOUND!")
            }
        case .explode3:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound3!))
            } catch{
                //error
                print("EXPLODING SOUND 3 CANNOT BE FOUND!")
            }
        case .explode4:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound4!))
            } catch{
                //error
                print("EXPLODING SOUND 4 CANNOT BE FOUND!")
            }
        case .gameOver:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gameOverSound!))
            } catch{
                //error
                print("GAME OVER SOUND CANNOT BE FOUND!")
            }
        case .shoot1:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: shootSound1!))
            } catch{
                //error
                print("SHOOT SOUND 2 CANNOT BE FOUND!")
            }
        case .shoot2:
            do{
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: shootSound2!))
            } catch{
                //error
                print("SHOOT SOUND 2 CANNOT BE FOUND!")
            }
        }
        player.play()
    }
 }

