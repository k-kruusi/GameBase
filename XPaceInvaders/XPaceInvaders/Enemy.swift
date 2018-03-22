//
//  BaseEnemy.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : BaseGameObject {
    //put stuff here
    
    var health = 10
    var bIsDead = false
    
    override init(imagedName name: String) {
        super.init(imagedName: name)
        self.name = "enemy"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage(damageTaken: Int){
        if(health - damageTaken <= 0){
            death()
        }
        else{
            health -= damageTaken
        }
    }
    
    func death(){
        self.removeFromParent()
        bIsDead = true
    }
    
    override func update(currentTime: TimeInterval) {
        
    }
    
}
