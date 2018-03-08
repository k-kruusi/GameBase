//
//  GameObject.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// GameObject is the base for al other objects. This class holds only a single sprite, some
//      attributes, and an initializer. GameObject will often be derived from but will
//      also be used by objects with no functionality such as backgrounds.

import Foundation
import SpriteKit

class GameObject {
    var pos = CGPoint(x: 0, y: 0)                   // Position of the GameObject
    var zPos = CGFloat(-1)                          // zPosition defines what object is drawn first (lowest first, highest last)
    var scale = CGSize(width: 0.6, height: 0.75)    // The scale or size of the object -- is preset for the background
    let sprite: SKSpriteNode                        // Main sprite of the GameObject
    
    
    // Initialize the sprite's image
    //
    // - Parameter imagePath: the path to the image for the gameObject.sprite
    required init(imagePath: String){
        sprite = SKSpriteNode(imageNamed: imagePath)
    }
    
    // Update - runs once every frame to update the sprites attributes with those of this gameObject
    //
    // - Parameter deltaTime: the amount of time between each frame
    func update(_deltaTime: TimeInterval){
        sprite.position = pos
        sprite.zPosition = zPos
        sprite.xScale = scale.width
        sprite.yScale = scale.height
    }
}
