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
    // Sets the sprite's image
    required init(imagePath: String){
        super.init(imagePath: imagePath)
    }
    
    // Update is called every frame and holds the main functionality of the bomb
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
    }
}
