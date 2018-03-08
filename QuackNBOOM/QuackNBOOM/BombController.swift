//
//  BombController.swift
//  QuackNBOOM
//
//  Created by Benoit Neriah R. on 3/7/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//

import Foundation
import SpriteKit

class BombController {
    // TEMP: only one bomb for testing
    let bomb = Bomb(imagePath: "Bomb")
    
    required init() {
        bomb.pos = CGPoint(x: -10, y: -10)
    }
    
    // Shoots the bomb at the location
    public func shootBomb(location: CGPoint){
        bomb.pos = location
        bomb.resetExplosionCountdown()
    }
    
    // TODO: Return the array of bombs
    // Returns all of the bombs in this BombController
    public func getAllBombs()->Bomb {
        return bomb
    }
    
    // Updates all of the bombs
    func update(_deltaTime: TimeInterval){
        bomb.update(_deltaTime: _deltaTime)
    }
}
