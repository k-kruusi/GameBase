//
//  BulletEntity.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/19/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import Foundation
import GameplayKit

class BulletEntity : GKEntity {

    var body: SKPhysicsBody?
    
    init(shootRight: Bool) {
        super.init()
        
        let texture = SKTexture(imageNamed: "run1")
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "idle1"))
        
        
        // Add a physics body
        body = SKPhysicsBody(circleOfRadius: (spriteComponent.node.texture?.size().width)! / 2, center: CGPoint(x: 0.0, y: 0.0))
        body?.affectedByGravity = false
        body?.isDynamic = false
        body?.categoryBitMask = PhysicsMasks.Bullet
        body?.collisionBitMask = PhysicsMasks.None // none because bullet is not dynamic a.k.a not affected by outside forces, but it can affect force of others so have to set collisionBitMask appropriately in other classes

        spriteComponent.node.physicsBody = body

        if (shootRight) {
            let shootStart = SKAction.move(by: CGVector(dx: 1000, dy: 0), duration: 5)
            let removeAction = SKAction.removeFromParent()
            spriteComponent.node.run(SKAction.sequence([shootStart, removeAction]))
        } else {
            let shootStart = SKAction.move(by: CGVector(dx: -1000, dy: 0), duration: 5)
            let removeAction = SKAction.removeFromParent()
            spriteComponent.node.run(SKAction.sequence([shootStart, removeAction]))
        }
        
        addComponent(spriteComponent)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
