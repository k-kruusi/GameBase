//
//  Bread.swift
//  QuackNBOOM
//
//  Created by Benoit Neriah R. on 3/7/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//

import Foundation
import SpriteKit

class Bread: GameObject {
    // Sets the sprite's image
    required init(imagePath: String){
        super.init(imagePath: imagePath)
        zPos = 0.0
        scale = CGSize(width: 0.75, height: 0.75)
    }
    
    // Update is called every frame and updates the sprite with the object's attributes
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
    }
}
