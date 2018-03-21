//
//  ChopperElements.swift
//  Get to the Chopper
//
//  Created by Sacchitiello Fabio on 3/20/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func createChopper() -> SKSpriteNode {
        //create sprite node
        let chopper = SKSpriteNode(texture: SKTextureAtlas(named: "player").textureNamed("img1"))
        chopper.size = CGSize(width: 50, height: 50)
        chopper.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //add physics body to object
        chopper.physicsBody = SKPhysicsBody(circleOfRadius: chopper.size.width / 2)
        chopper.physicsBody?.linearDamping = 1.0
        chopper.physicsBody?.restitution = 0
        //check for collisions in the game
        chopper.physicsBody?.categoryBitMask = CollisionBitMask.chopperCategory
        chopper.physicsBody?.collisionBitMask = CollisionBitMask.wallCategory | CollisionBitMask.groundCategory
        chopper.physicsBody?.contactTestBitMask = CollisionBitMask.wallCategory | CollisionBitMask.collectibleCategory | CollisionBitMask.groundCategory
        //set gravity with when screen is touched
        chopper.physicsBody?.affectedByGravity = false
        chopper.physicsBody?.isDynamic = true
        
        return chopper
    }
}
