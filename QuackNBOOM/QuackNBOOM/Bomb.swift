//
//  Bomb.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Bomb inherits from GameObject with addd functionality specific to the bomb.

import Foundation
import SpriteKit

class Bomb: GameObject {
    let explosionSprite: SKSpriteNode
    // The value as to what to reset the countdown to
    let startExplodeCountdown = CGFloat(0.5)
    // The explosionCountdown explodes the bomb when it reaches 0
    var explodeCountdown = CGFloat(0.5)
    
    // Sets both sprites' images
    required init(imagePath: String, explosionImagePath: String){
        explosionSprite = SKSpriteNode(imageNamed: explosionImagePath)
        super.init(imagePath: imagePath)
        zPos = 2.0
        // Proper scale for the bombs
        scale = CGSize(width: 0.75, height: 0.75)
        
        // Sets the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
        
    }
    
    // Automatically sets the explosion sprite
    required init(imagePath: String){
        explosionSprite = SKSpriteNode(imageNamed: "Explode")
        super.init(imagePath: imagePath)
        zPos = 2.0
        // Proper scale for the bombs
        scale = CGSize(width: 0.75, height: 0.75)
        
        // Sets the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
    }
    
    func resetExplosionCountdown() {
        explodeCountdown = startExplodeCountdown
        
        // Sets the sprites' visibility
        sprite.isHidden = false
        explosionSprite.isHidden = true
    }
    
    // Update is called every frame and holds the main functionality of the bomb
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
        explosionSprite.position = pos
        explosionSprite.zPosition = zPos
        explosionSprite.xScale = scale.width
        explosionSprite.yScale = scale.height
        
        handleExplosion(_deltaTime: _deltaTime)
        //setSpriteVisibilityFromExploded()
    }
    
    // Handles the counting down feature
    fileprivate func handleExplosion(_deltaTime: TimeInterval) {
        if(explodeCountdown > 0){
            explodeCountdown -= CGFloat(_deltaTime)
        }
        else if (explodeCountdown != -100) {
            sprite.isHidden = true
            explosionSprite.isHidden = false
            explodeCountdown = -100 // Setting to -100 so visibility isn't set every frame
        }
    }
}
