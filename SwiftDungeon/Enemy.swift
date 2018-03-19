//
//  Enemy.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 3/19/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Entity {
    
    //Speed of Enemy
    private var velocity: CGFloat = 100
    
    // Position of target to chase
    private var targetPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    init() {
        super.init(imageName: "slime_idle_01")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetTarget(_ position: CGPoint) {
        targetPosition = position
    }
    
    func MoveToTarget() {
        if(position.x > targetPosition.x) {
            position = CGPoint(x: position.x - (velocity * CGFloat(deltaTime)), y: position.y)
        }
        else if(position.x < targetPosition.x) {
            position = CGPoint(x: position.x + (velocity * CGFloat(deltaTime)), y: position.y)
        }
        
        if(position.y > targetPosition.y) {
            position = CGPoint(x: position.x, y: position.y - (velocity * CGFloat(deltaTime)))
        }
        else if(position.y < targetPosition.y) {
            position = CGPoint(x: position.x, y: position.y + (velocity * CGFloat(deltaTime)))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        MoveToTarget()
    }
    
}

