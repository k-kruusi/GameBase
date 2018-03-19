//
//  PlayerEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerEntity : CharacterEntity
{
    var facingRight = true
    
    convenience init(imageName: String, scale: CGFloat) {
        self.init(imageName: imageName)
        
        spriteComponent?.node.xScale = scale
        spriteComponent?.node.yScale = scale
        body?.categoryBitMask = PhysicsMasks.Player
        body?.collisionBitMask = PhysicsMasks.Enemy | PhysicsMasks.LevelBounds // player should only colide with the enemy and bounds, not its own bullets
        
        body?.contactTestBitMask = PhysicsMasks.Enemy // callback for when it collides with enemy
    }
    
    func moveRight() {
        body?.applyForce(CGVector(dx: 250, dy: 0))
        facingRight = true
        if (facingRight && (spriteComponent?.node.xScale)! < CGFloat(0)) {
            spriteComponent?.node.xScale *= -1
        }
    }
    
    func moveLeft() {
        body?.applyForce(CGVector(dx: -250, dy: 0))
        facingRight = false
        if (!facingRight && (spriteComponent?.node.xScale)! > CGFloat(0)) {
            spriteComponent?.node.xScale *= -1
        }
    }
    
    func jump() {
        body?.applyForce(CGVector(dx: 0, dy: 500))
    }
    
}
