//
//  EnemyPlane.swift
//  Space-X Defense Program
//
//  Created by Favero Miguel Fernando on 3/13/18.
//  Copyright © 2018 Miguel Haifeng. All rights reserved.
//

import Foundation
import SpriteKit

//Plane enum
//testing only one for now, might have 3
//one shoots straight
//one has a tracking missle
//one is a fast kamikaze
enum EnemyPlaneType: UInt32{
    case normal = 0
    case kamikaze
    case smarter
    
    var speed: CGFloat{
        switch self{
        case .normal:
            return 50.0
        case .kamikaze:
            return 200.0
        case .smarter:
            return 100.0
        }
    }
}

class EnemyPlane: GameObject
{
    let type: EnemyPlaneType
    var vel : CGPoint?
    
    var canShoot: Bool = true
    
    
    init(type: EnemyPlaneType)
    {
        self.type = type
        
        if type == EnemyPlaneType.normal
        {
            super.init(imageName: "Bullet")
        }
        else
        {
            super.init(imageName: "enemyPlane-1")
            size = CGSize(width: size.width/4, height: size.width/4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //update loop
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
        
        guard let direction = vel?.asUnitVector else {
            return
        }
        //direction = CGPoint(x: direction.x * -1, y: direction.y)
        
        position = position.travel(inDirection: direction, atVelocity: type.speed, for: deltaTime)
    }
}
