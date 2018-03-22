//
//  Projectile.swift
//  XPaceInvaders
//
//  Created by Matthew Mazza on 2018-03-21.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile : BaseGameObject{

    override init(imagedName name: String) {
        super.init(imagedName: name)
        self.name = "projectile"
        
        self.physicsBody? = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: TimeInterval){
        
    }
}
