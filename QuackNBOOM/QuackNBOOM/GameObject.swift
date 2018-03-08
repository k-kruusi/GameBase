//
//  GameObject.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// Basic GameObject holds only a single sprite and an initializer to set the image. Will be
//      used by objects with no functionality such as backgrounds.

import Foundation
import SpriteKit

class GameObject {
    // Position of the GameObject
    var pos = CGPoint(x: 0, y: 0)
    var zPos = CGFloat(-1)
    // Scale is preset for the background
    var scale = CGSize(width: 0.6, height: 0.75)
    
    // Main sprite of the GameObject
    let sprite: SKSpriteNode
    
    // Sets the sprite's image
    required init(imagePath: String){
        sprite = SKSpriteNode(imageNamed: imagePath)
    }
    
    func update(_deltaTime: TimeInterval){
        // Updates sprite position with the object's position
        sprite.position = pos
        sprite.zPosition = zPos
        sprite.xScale = scale.width
        sprite.yScale = scale.height
    }
}
