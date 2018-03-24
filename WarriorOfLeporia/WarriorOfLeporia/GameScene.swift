//
//  GameScene.swift
//  WarriorOfLeporia
//
//  Created by Kirupa Nijastan on 2/28/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsMasks {
    static let None: UInt32 = 0 // 0
    static let Player: UInt32 = 0b1 // 1
    static let Enemy: UInt32 = 0b10 // 2
    static let Bullet: UInt32 = 0b100 // 4
    static let LevelBounds: UInt32 = 0b1000 // 8
}


class GameScene: SKScene, SKPhysicsContactDelegate {

    var gameOver = false
    var lastUpdateTime : TimeInterval = 0
    
    // Button variables
    var leftButton: ButtonNode!
    var rightButton: ButtonNode!
    var jumpButton: ButtonNode!
    var shootButton: ButtonNode!

    // Game objects
    var background: SKNode?
    var entityManager: EntityManager?
    var player: PlayerEntity?
    
    // Score labels
    let scoreLabel = SKLabelNode(fontNamed: "Courier-Bold")
    var score = 0
    
    override func didMove(to view: SKView) {
        // Added bounding box around level
        background = childNode(withName: "background")
        physicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsMasks.LevelBounds
        
        // Add score label
        let score = SKSpriteNode(imageNamed: "coin")
        score.xScale = 0.5
        score.yScale = 0.5
        score.position = CGPoint(x: -340, y: 160)
        camera?.addChild(score)
        scoreLabel.fontSize = 32
        scoreLabel.fontColor = SKColor.yellow
        scoreLabel.position = CGPoint(x: -320, y: 160)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.text = "0"
        camera?.addChild(scoreLabel)
        
        // Add left button
        leftButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "left", onButtonPress: leftPressed, pressOnly: false)
        leftButton.position = CGPoint(x: -300, y: 0)
        camera?.addChild(leftButton)
        
        // Add right button
        rightButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "right", onButtonPress: rightPressed, pressOnly: false)
        rightButton.position = CGPoint(x: -200, y: 0)
        camera?.addChild(rightButton)
        
        // Add jump button
        jumpButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "jump", onButtonPress: jumpPressed, pressOnly: true)
        jumpButton.position = CGPoint(x: 300, y: 50)
        camera?.addChild(jumpButton)
        
        // Add shoot button
        shootButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "Shoot", onButtonPress: shootPressed, pressOnly: true)
        shootButton.position = CGPoint(x: 300, y: 0)
        camera?.addChild(shootButton)
        
        // Initialize player entity and manager
        entityManager = EntityManager(scene: self)
        
        player = PlayerEntity(imageName: "idle1-s", scale: 1, background: background!, camera: camera!, view: view, scene: scene!)
        if let spriteComponent = player?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager?.add(player!)
        
        // Spawn enemies over time
        spawnEnemyOverTime(time: 4.0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if gameOver {
            return
        }
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        let dt = currentTime - self.lastUpdateTime
        
        // Controls stuff
        if (leftButton.pressed) {
            leftPressed()
        } else if (rightButton.pressed) {
            rightPressed()
        }
        // Update score
        scoreLabel.text = "\(score)"
        
        player?.update(deltaTime: dt)
        self.lastUpdateTime = currentTime
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (collision == PhysicsMasks.Player | PhysicsMasks.Enemy) {
            print("You collided with enemy!")
        } else if (collision == PhysicsMasks.Enemy | PhysicsMasks.Bullet) {
            print("you shot an enemy!")
            // Remove from scene
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            score = score + 1
            // Remove from entity list
            entityManager?.remove(contact.bodyA.node!) // remove enemy which is also in entity list
            entityManager?.remove(contact.bodyB.node!)
        }
    }

    func leftPressed() {
        player?.moveLeft()
    }
    
    func rightPressed() {
        player?.moveRight()
    }
    
    func jumpPressed() {
        player?.jump()
    }
    
    func shootPressed() {
        player?.shoot()
    }
    
    func spawnEnemyOverTime(time: Double) {
        let wait:SKAction = SKAction.wait(forDuration: time)
        let finishTimer:SKAction = SKAction.run {
            self.entityManager?.spawnEnemy(ptarget: self.player!)
            
            self.spawnEnemyOverTime(time: time)
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
    }
}
