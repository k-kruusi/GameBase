//
//  Projectile.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/12/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate extension Projectile{
    
    static let projectileZPositionOffset: CGFloat = 500
}

struct EnemyValues {
    
    //Slow and Big
    static let enemy1Scale : CGFloat = 2
    static let enemy1Speed : CGFloat = 400.0
    
    //Medium and shoots
    static let playerScale : CGFloat = 1
    static let playerSpeed : CGFloat = 500.0
}

enum ProjectileType: UInt32 {
    case enemy = 0
    case player
}

class Projectile: GameObject {
    
    let type: ProjectileType
    var vel: CGPoint?
    var moveSpeed: CGFloat = 0
    var scale: CGFloat = 0
    
    
    /// create the projectiles
    init(type: ProjectileType) {
        self.type = type
        
        super.init(imageName: "Bullet")
        self.zPosition = Projectile.projectileZPositionOffset
        
        switch type {
        case .enemy:
            moveSpeed = EnemyValues.enemy1Speed
            scale = EnemyValues.enemy1Scale
        case .player:
            moveSpeed = EnemyValues.playerSpeed
            scale = EnemyValues.playerScale
        default:
            moveSpeed = 0
            scale = 1        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// - Parameter currentTime: the current time
    override func update(_ currentTime: TimeInterval) {
        
        // in order to use the functionality provided in GameObject we need to call super here
        // since we will want to use the calculation of delta time
        super.update(currentTime)
        
        guard let direction = vel?.asUnitVector else {
            return
        }
        
        position = position.travel(inDirection: direction, atVelocity: moveSpeed, for: deltaTime)
        
        
        
    }
    
    
}
