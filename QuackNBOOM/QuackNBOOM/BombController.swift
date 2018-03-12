//
//  BombController.swift
//  QuackNBOOM
//
//  Created by Benoit Neriah R. on 3/7/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// BombController handles multiple bombs and how they respond to taps.

import Foundation
import SpriteKit

class BombController {
    // TODO: create an array of bombs
    // TEMP: only one bomb for testing
    let bomb = Bomb(imagePath: "Bomb")
    
    
    
    // Initializer sets all bombs offscreen
    //
    required init() {
        bomb.position = CGPoint(x: -10, y: -10)
    }
    
    
    // Shoots a bomb at the location
    //
    // - Parameter: location: the position of the tap on the screen
    public func shootBomb(location: CGPoint){
        bomb.position = location
        bomb.resetExplosionCountdown()
    }
    
    
    // Returns all of the bombs in this BombController
    //
    public func getAllBombs()->Bomb {
        // TODO: Return the array of bombs
        return bomb
    }
    
    
    // Updates all of the bombs
    //
    // - Parameter deltaTime: the amount of time between each frame
    func update(_ deltaTime: TimeInterval){
        bomb.update(deltaTime)
    }
}
