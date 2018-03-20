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
            return 10.0
        case .kamikaze:
            return 20.0
        case .smarter:
            return 5.0
        }
    }
}



class EnemyPlane: SKSpriteNode{
    let type: EnemyPlaneType
    var vel : CGPoint?
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdatedTime: TimeInterval?
    
    
    init(type: EnemyPlaneType, imageName: String)
    {
        self.type = type
        
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size:texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //update loop
    func update(_ currentTime: TimeInterval)
    {
        guard let lastUpdatedTime = lastUpdatedTime else
        {
            self.lastUpdatedTime = currentTime
            return
        }
        
        deltaTime = currentTime - lastUpdatedTime
        
        self.lastUpdatedTime = currentTime
        
        guard var direction = vel?.asUnitVector else {
            return
        }
        direction = CGPoint(x: direction.x * -1, y: direction.y)
        
        position = position.travel(inDirection: direction, atVelocity: type.speed, for: deltaTime)
    }
    
}
