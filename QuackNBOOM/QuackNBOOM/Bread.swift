//
//  Bread.swift
//  QuackNBOOM
//
//  Created by Benoit Neriah R. on 3/7/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Bread is a background object with no other functionality other than decoration. Derives from
//      GameObject, the purpose of this class is to set the attributes specifically to the bread sprite.

import Foundation
import SpriteKit

class Bread: GameObject {
    // Initializes the attributes
    //
    // - Parameter: imagePath: bread sprite image
    required init(imagePath: String){
        super.init(imagePath: imagePath)
        
        // Setting the attributes
        xScale = 0.75
        yScale = 0.75
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been found")
    }
    
    // Update - runs once every frame
    //
    // - Parameter deltaTime: the amount of time between each frame
    override func update(_deltaTime: TimeInterval) {
        super.update(_deltaTime: _deltaTime)
    }
}
