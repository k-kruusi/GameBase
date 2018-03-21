//
//  Bomb.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Bomb is derived from GameObject. It's weapon used by the player to kill the ducks.
//      The bomb goes to the tapped area and explodes after a countdown.
//      The explosion works by hiding the bomb is displaying the explosion - two different sprites. A removal countdown
//      then starts to move the explosion out of view from the player.
//
//      NOTES:
//          Inactive bomb: A bomb which is currently not being used - it is not on the screen.
//              The inactive position is: CGPoint(x: -10, y: -10)
//          Inactive countdowns: A countdown which has already hit zero and the programed event has already
//              been carried out.
//              The inactive value is: CGPoint(-100.0)
//      These inactive values are important for the correct workings of this class.

import Foundation
import SpriteKit
import AVFoundation

class Bomb: GameObject {
    let explosionSprite: SKSpriteNode               // Another sprite for the explosion
    let explosionRange = CGFloat(100)               // The killing range of the explosion
    let startExplodeCountdown = CGFloat(0.5)        // The value as to what to reset the explodeCcountdown to
    var explodeCountdown = CGFloat(0.0)             // The explosionCountdown explodes the bomb when it reaches 0. When the bomb has been exploded, it's set to -100
    let startBombRemovalCountdown = CGFloat(0.2)    // The value as to what to reset the bombRemovalCountdown to
    var bombRemovalCountdown = CGFloat(0.0)         // Moves the object after the bomb has exploded. Stats to countdown when the bomb explodes
    
    var bombSFX1 = AVAudioPlayer() //;w; audio components
    var bombSFX2 = AVAudioPlayer()
    var bombSFX3 = AVAudioPlayer()
    var bombSFX4 = AVAudioPlayer()
    let explodeSound1 = Bundle.main.path(forResource: "ExplosionSound1", ofType: "wav")
    let explodeSound2 = Bundle.main.path(forResource: "ExplosionSound2", ofType: "wav")
    let explodeSound3 = Bundle.main.path(forResource: "ExplosionSound3", ofType: "wav")
    let explodeSound4 = Bundle.main.path(forResource: "ExplosionSound4", ofType: "wav")
    
    // Initializes both sprites and the attributes
    //
    // - Parameters:
    //      - imagePath: bomb's image
    //      - explosionImagePath: explosionSprite's image
    required init(imagePath: String, explosionImagePath: String){
        // Set images
        explosionSprite = SKSpriteNode(imageNamed: explosionImagePath)
        super.init(imagePath: imagePath)
        
        // Set attributes
        position = CGPoint(x: -10, y: -10)  // Set as inactive
        xScale = 0.75
        yScale = 0.75
        explosionSprite.xScale = 0.75
        explosionSprite.yScale = 0.75
        explosionSprite.zPosition = zPosition   // Same zPos since the explosion and bomb will never apear at the same time
        
        // Set the sprites' visibility
        isHidden = false
        explosionSprite.isHidden = true
        
        //;w; initialize the audio components
        do{
            try bombSFX1 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound1!))
        } catch{
            //error
            print("EXPLODING SOUND 1 CANNOT BE FOUND!")
        }
        do{
            try bombSFX2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound2!))
        } catch{
            //error
            print("EXPLODING SOUND 2 CANNOT BE FOUND!")
        }
        do{
            try bombSFX3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound3!))
        } catch{
            //error
            print("EXPLODING SOUND 3 CANNOT BE FOUND!")
        }
        do{
            try bombSFX4 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: explodeSound4!))
        } catch{
            //error
            print("EXPLODING SOUND 4 CANNOT BE FOUND!")
        }
    }
    
    // Initializer. Automatically sets the explosion sprite
    //
    // - Parameter: imagePath: bomb's' image
    convenience required init(imagePath: String){
        self.init(imagePath: imagePath, explosionImagePath: "Explode")
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been found")
    }
    
    
    // Update - runs  once every frame. Sets the explosionSprite's attributes to those of this Bomb.
    //      Also runs through the explosion and removal functions
    //
    // - Parameter deltaTime: the amount of time between each frame
    override func update(_ deltaTime: TimeInterval) {
        super.update(deltaTime)
        
        // Update the explosionSprite's attributes
        explosionSprite.position = position
        
        // Explode countdown
        if(!isExploded()){
            handleExplosion(deltaTime)
        }
        // Bomb removal countdown
        else if(bombRemovalCountdown != -100){
            handleBombRemoval(deltaTime)
        }
        // Reset since the bomb has been placed in a new location!
        else if(self.position != CGPoint(x: -10, y: -10)){
            resetExplosionCountdown()
        }
    }
    
    
    // Handles the counting down and exploding
    //
    // - Parameter deltaTime: the amount of time between each frame
    fileprivate func handleExplosion(_ deltaTime: TimeInterval) {
        // Countdown
        if(explodeCountdown > CGFloat(0.0)){
            explodeCountdown -= CGFloat(deltaTime)
        }
        // EXPLODE!
        else if (explodeCountdown != CGFloat(-100.0)) {
            isHidden = true
            explosionSprite.isHidden = false
            explodeCountdown = CGFloat(-100.0) // Setting to -100 so visibility isn't set every frame
            bombRemovalCountdown = CGFloat(startBombRemovalCountdown)   // Reset the countdown for bomb removal
            
            // Play an explosion sound effect at random
            let rand = Int(arc4random_uniform(4))
            switch rand {
            case 0:
                bombSFX1.play()
                break
            case 1:
                bombSFX2.play()
                break
            case 2:
                bombSFX3.play()
                break
            case 3:
                bombSFX4.play()
                break
            default:
                print("Major error in Bomb.swift for randomizing sound effects")
            }
        }
    }
    
    // Handles the counting down and bomb removal - moves the bomb out of the player's view
    //
    // - Parameter deltaTime: the amount of time between each frame
    fileprivate func handleBombRemoval(_ deltaTime: TimeInterval){
        // Countdown
        if(bombRemovalCountdown > CGFloat(0.0)){
            bombRemovalCountdown-=CGFloat(deltaTime)
        }
        // Remove/move the bomb
        else if(bombRemovalCountdown != CGFloat(-100.0)){
            self.position = CGPoint(x: -10, y: -10)
            bombRemovalCountdown = CGFloat(-100.0)
        }
    }
    
    
    // Resets the explode countdown and the sprites' visibility
    //
    func resetExplosionCountdown() {
        explodeCountdown = startExplodeCountdown
        
        // Sets the sprites' visibility
        isHidden = false
        explosionSprite.isHidden = true
    }
    
    
    // Returns true if the bomb has exploded
    //
    public func isExploded()->Bool {
        if(explodeCountdown == CGFloat(-100.0)) {
            return true
        }
        return false
    }
    
    
    // Returns true if self is labeled as inactive
    //
    public func isInactive()->Bool {
        if(self.position == CGPoint(x: -10, y: -10)){
            return true
        }
        return false
    }
}
