//
//  GameObject.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/12/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
// Example taken from kevin's in class lav
//

import Foundation
import SpriteKit

/// GameObject class for gameobjects to share common functions
class GameObject: SKSpriteNode {
    
    // increment the zposition of each gameobject in the init so they all stay on screen
    static var zCounter: CGFloat = 1
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        GameObject.zCounter = GameObject.zCounter + 1
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = GameObject.zCounter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// update injecting time from the game loop
    ///
    /// - Parameter currentTime: current time from the game loops
    func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        
        // calculating delta time
        deltaTime = currentTime - lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
    
    /// A simple collision detection function that will let you check if this item colides with other game objects
    ///
    /// - Parameter items: the game objects you wish to test against
    /// - Returns: an array of game objects you collided with, could be empty if no collisions
    func collision(items:[GameObject]) -> [GameObject] {
        
        var collision: Bool
        var colliders: [GameObject] = []
        
        for item in items {
            
            if item !== self {
                collision = self.frame.intersects(item.frame)
                if collision {
                    colliders.append(item)
                }
            }
        }
        
        return colliders
    }
    
    func cleanUp() {
        
        removeFromParent()
    }
    
}
