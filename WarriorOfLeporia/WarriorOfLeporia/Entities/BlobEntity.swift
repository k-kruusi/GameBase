//
//  BlobEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

class BlobEntity: CharacterEntity {
    var facingRight = true
    
    convenience init(imageName: String, scale: CGFloat) {
        self.init(imageName: imageName)
        
        spriteComponent?.node.xScale = scale
        spriteComponent?.node.yScale = scale
        
        body?.categoryBitMask = PhysicsMasks.Enemy
        body?.collisionBitMask = PhysicsMasks.LevelBounds | PhysicsMasks.Player | PhysicsMasks.Bullet
        
        body?.contactTestBitMask = PhysicsMasks.Bullet // callback when bullet hits enemy
    }
    
    
}
