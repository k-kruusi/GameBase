//
//  Entity.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/12/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Entity : SKSpriteNode {
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        
        deltaTime = currentTime - lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
    
    func collision(items:[Entity]) -> [Entity] {
        
        var collision: Bool
        var colliders: [Entity] = []
        
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
    
}
