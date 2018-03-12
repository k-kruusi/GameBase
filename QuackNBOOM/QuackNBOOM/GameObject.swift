//
//  GameObject.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah R. on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//
// GameObject is the base for all other objects. GameObject will often be derived from but will
//      also be used by objects with no functionality such as backgrounds.

import Foundation
import SpriteKit

class GameObject: SKSpriteNode {
    static var zCounter = CGFloat(-1)   // Sets the zPosition - increments for every new GameObject created
    
    // Initialize the sprite's image
    //
    // - Parameter imagePath: the path to the image for the sprite
    required init(imagePath: String){
        let texture = SKTexture(imageNamed: imagePath)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        // Set attributes
        zPosition = GameObject.zCounter
        GameObject.zCounter += 1
        xScale = 0.6    // Resizing the object - is preset for the background
        yScale = 0.75
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been found")
    }
    
    // Update - runs once every frame
    //
    // - Parameter deltaTime: the amount of time between each frame
    func update(_deltaTime: TimeInterval){
        // Empty
    }
}
