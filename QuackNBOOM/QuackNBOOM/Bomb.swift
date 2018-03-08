//
//  Bomb.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Bomb is derived from GameObject. It's weapon used by the player to kill the ducks.
//      The bomb goes to the tapped area and explodes after a countdown.
//      The explosion works by hiding the bomb is displaying the explosion - two different sprites

import Foundation
import SpriteKit

class Bomb: GameObject {
    let explosionSprite: SKSpriteNode           // Another sprite for the explosion
    let startExplodeCountdown = CGFloat(0.5)    // The value as to what to reset the countdown to
    var explodeCountdown = CGFloat(0.5)         // The explosionCountdown explodes the bomb when it reaches 0. When the bomb has been exploded, it's set to -100
    
    
    
    // Initializes both sprites and the attributes
    //
    // - Parameters:
    //      - imagePath: bomb.sprite image
    //      - explosionImagePath: explosionSprite image
    required init(imagePath: String, explosionImagePath: String){
        // Set images
        explosionSprite = SKSpriteNode(imageNamed: explosionImagePath)
        super.init(imagePath: imagePath)
        
        // Set attributes
        zPos = 2.0
        scale = CGSize(width: 0.75, height: 0.75)
        
        // Set the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
    }
    
    // Initializer. Automatically sets the explosion sprite
    //
    // - Parameter: imagePath: bomb.sprite image
    required init(imagePath: String){
        // Set images
        explosionSprite = SKSpriteNode(imageNamed: "Explode")   // Automatically sets image name
        super.init(imagePath: imagePath)
        
        // Set attributes
        zPos = 2.0
        scale = CGSize(width: 0.75, height: 0.75)
        
        // Sets the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
    }
    
    
    // Resets the explode countdown and the sprites' visibility
    //
    func resetExplosionCountdown() {
        explodeCountdown = startExplodeCountdown
        
        // Sets the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
    }
    
    // Update - runs  once every frame. Sets the sprites attributes to those of this Bomb
    //
    // - Parameter deltaTime: the amount of time between each frame
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
        // Update the explosionSprite's attributes
        explosionSprite.position = pos
        explosionSprite.zPosition = zPos
        explosionSprite.xScale = scale.width
        explosionSprite.yScale = scale.height
        
        handleExplosion(_deltaTime: _deltaTime)
    }
    
    
    // Handles the counting down and exploding
    //
    // - Parameter deltaTime: the amount of time between each frame
    fileprivate func handleExplosion(_deltaTime: TimeInterval) {
        // Countdown
        if(explodeCountdown > 0){
            explodeCountdown -= CGFloat(_deltaTime)
        }
        // EXPLODE!
        else if (explodeCountdown != -100) {
            sprite.isHidden = true
            explosionSprite.isHidden = false
            explodeCountdown = -100 // Setting to -100 so visibility isn't set every frame
        }
    }
    
    
    // Returns true if the bomb has exploded
    //
    public func isExploded()->Bool {
        if(explodeCountdown == -100) {
            return true
        }
        return false
    }
}
