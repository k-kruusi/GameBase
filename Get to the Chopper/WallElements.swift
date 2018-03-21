//
//  WallElements.swift
//  Get to the Chopper
//
//  Created by Sacchitiello Fabio on 3/20/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit

extension GameScene {

    func createWall() -> SKNode {
        // Create collectible item and detect contact with chopper
        let collectNode = SKSpriteNode(imageNamed: "target")
        collectNode.size = CGSize(width: 40, height: 40)
        collectNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        collectNode.physicsBody = SKPhysicsBody(rectangleOf: collectNode.size)
        collectNode.physicsBody?.affectedByGravity = false
        collectNode.physicsBody?.isDynamic = false
        collectNode.physicsBody?.categoryBitMask = CollisionBitMask.collectibleCategory
        collectNode.physicsBody?.collisionBitMask = 0
        collectNode.physicsBody?.contactTestBitMask = CollisionBitMask.chopperCategory
        collectNode.color = SKColor.blue
        
        // Create top and bottom obstacles
        let wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "wall")
        let bottomWall = SKSpriteNode(imageNamed: "wall")
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
        bottomWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 420)
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.wallCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.chopperCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.chopperCategory
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: bottomWall.size)
        bottomWall.physicsBody?.categoryBitMask = CollisionBitMask.wallCategory
        bottomWall.physicsBody?.collisionBitMask = CollisionBitMask.chopperCategory
        bottomWall.physicsBody?.contactTestBitMask = CollisionBitMask.chopperCategory
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = CGFloat.pi
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        wallPair.zPosition = 1
        
        // Generate random heights for obstacles
        let randomPosition = random(min: -200, max: 200)
        wallPair.position.y = wallPair.position.y +  randomPosition
        wallPair.addChild(collectNode)
        
        wallPair.run(moveAndRemove)
        return wallPair
    }
}
