//
//  GameObject.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import SpriteKit


//Inspired by the zombieConga gameobject class
class GameObject: SKSpriteNode {
    
    // a counter for the position that auto increments with each new game object in the init
    static var Counter: CGFloat = 1
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    init(texture: SKTexture, color: UIColor, boxSize: CGSize) {
        GameObject.Counter = GameObject.Counter + 1
        //set the size of the enemy sprite
        super.init(texture: texture, color: .clear, size: boxSize)
        self.zPosition = GameObject.Counter
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
    
}
