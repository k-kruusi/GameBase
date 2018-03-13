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
    let numberOfBombs = 5
    var bombs:[Bomb] = []
    
    
    // Initializer sets all bombs offscreen
    //
    required init() {
        // Add the specified amount of bombs to the array
        var i = 0
        while(i < numberOfBombs){
            let bomb = Bomb(imagePath: "Bomb")
            bombs.append(bomb)
            i+=1
        }
    }
    
    
    // Shoots a bomb at the location
    //
    // - Parameter: location: the position of the tap on the screen
    public func shootBomb(location: CGPoint){
        for bomb in bombs {
            // Find and shoot a bomb that is currently not in use
            if(bomb.isInactive()){
                bomb.position = location
                break
            }
        }
        // If no bombs are found that are not currently in use, than don't do anything
    }
    
    
    // Returns all of the bombs in this BombController
    //
    public func getAllBombs()->Array<Bomb> {
        return bombs
    }
    
    
    // Updates all of the bombs
    //
    // - Parameter deltaTime: the amount of time between each frame
    func update(_ deltaTime: TimeInterval){
        for bomb in bombs {
            bomb.update(deltaTime)
        }
    }
}
