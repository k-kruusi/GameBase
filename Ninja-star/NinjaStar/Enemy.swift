//
//  Enemy.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-23.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import SpriteKit


// Enemy Enumerator
enum EnemyType: UInt32 {
    case EasyEnemy = 0
    case HardEnemy
    case TimeBonusEnemy
    
    var speed: CGFloat {
        switch self {
        case .TimeBonusEnemy:
            return 20.0
        case .HardEnemy:
            return 15.0
        case .EasyEnemy:
            return 10.0
        }
    }
}


/// A enemy class
class Enemy: GameObject {
    
    let type: EnemyType
    var vel : CGPoint?
    
    
    
    /// create an enemy, base code borrowed from the ZombieConga
    init(type: EnemyType) {
        self.type = type
        //set the texture and the box size
        let texture = SKTexture(imageNamed: "BirdA-1")
        let boxSize: CGSize = CGSize(width: texture.size().width / 10, height: texture.size().height / 10)
        super.init(texture: texture, color: .clear, boxSize: boxSize)
        
        zPosition = 10
        
        //1. Textures Animation that will be set based on the type of enemy
        //2. Set the enmy name based on the type of enemy created
        var textureAnimation :[SKTexture] = [SKTexture]()
        if(type == EnemyType.EasyEnemy){
           textureAnimation = [SKTexture(imageNamed: "BirdA-1"),
                                    SKTexture(imageNamed: "BirdA-2"),
                                    SKTexture(imageNamed: "BirdA-3"),
                                    SKTexture(imageNamed: "BirdA-4"),
                                    SKTexture(imageNamed: "BirdA-3"),
                                    SKTexture(imageNamed: "BirdA-2")]
                                    name = "easyEnemy"
        } else if(type == EnemyType.HardEnemy){
           textureAnimation = [SKTexture(imageNamed: "BirdB-1"),
                                    SKTexture(imageNamed: "BirdB-2"),
                                    SKTexture(imageNamed: "BirdB-3"),
                                    SKTexture(imageNamed: "BirdB-4"),
                                    SKTexture(imageNamed: "BirdB-3"),
                                    SKTexture(imageNamed: "BirdB-2")]
                                    name = "hardEnemy"
        } else if(type == EnemyType.TimeBonusEnemy){
            textureAnimation = [SKTexture(imageNamed: "BirdC-1"),
                                    SKTexture(imageNamed: "BirdC-2"),
                                    SKTexture(imageNamed: "BirdC-3"),
                                    SKTexture(imageNamed: "BirdC-4"),
                                    SKTexture(imageNamed: "BirdC-3"),
                                    SKTexture(imageNamed: "BirdC-2")]
                                    name = "timeBonusEnemy"
        }
        
        
        let animationAction = SKAction.animate(with: textureAnimation, timePerFrame: 0.5)
        let repeatAction = SKAction.repeatForever(animationAction)
        
        //phyiscs body
        self.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
        self.physicsBody?.affectedByGravity = false
        if let physics = physicsBody {
            physics.mass = 0
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = true
            physics.contactTestBitMask = 0b0001
            //physics.usesPreciseCollisionDetection = true
            
        }
        
        self.run(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        super.update(currentTime)
        
        let direction = Normalize(vector: (vel)!)
        
        position = move(inDirection: direction, atVelocity: type.speed, for: deltaTime)
    }
    
    func Normalize(vector: CGPoint)-> CGPoint{
        //find the magnitude
        let magnitude = sqrt((vector.x * vector.x) + (vector.y * vector.y))
        //find the unit vector
        let unitVector = CGPoint(x: vector.x/magnitude, y:vector.y/magnitude)
        return unitVector
    }
    
    
    //move the enemy function
    func move(inDirection direction: CGPoint, atVelocity velocity: CGFloat, for time: TimeInterval) -> CGPoint {
        return CGPoint(x: velocity * CGFloat(time) * direction.x + self.position.x, y: velocity * CGFloat(time) * direction.y + self.position.y)
    }
    
}
