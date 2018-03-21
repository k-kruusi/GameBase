//
//  AIComponent.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/20/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

class AIComponent : GKComponent {
    let target: PlayerEntity
    let node: SKSpriteNode
    var facingRight: Bool
    var jumpForce: CGFloat = 100.0
    
    init(target: PlayerEntity, node: SKSpriteNode, facingRight: Bool) {
        self.target = target
        self.node = node
        self.facingRight = facingRight
        super.init()
        
        attackPlayer()
    }
    
    func attackPlayer() {
        let wait:SKAction = SKAction.wait(forDuration: 1.0)
        let attackTimer:SKAction = SKAction.run {
            let difference = (self.target.spriteComponent?.node.position)! - (self.node.position)
            let direction = difference.normalized()
            
            // face the target/player
            self.facingRight = (direction.x < 0.0) ? false : true
            if (self.facingRight && (self.node.xScale) > 0.0) {
                self.node.xScale *= -1
            }
            if (!self.facingRight && (self.node.xScale) < 0.0) {
                self.node.xScale *= -1
            }
            
            self.node.physicsBody?.applyForce(CGVector(dx: direction.x * self.jumpForce, dy: direction.y * self.jumpForce))
            
        }
        let seq:SKAction = SKAction.sequence([wait, attackTimer])
        self.node.run(SKAction.repeatForever(seq), withKey:"attackingPlayer")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
