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
//    private var brabbit = SKSpriteNode()
//    private var brabbitMoveFrames: [SKTexture] = []
    var gameOver = false
    var lastUpdateTime : TimeInterval = 0
    
    var leftButton: ButtonNode!
    var rightButton: ButtonNode!
    var jumpButton: ButtonNode!
    
    var shootButton: ButtonNode!
    var spinButton: ButtonNode!
    
    var entityManager: EntityManager?
    var player: PlayerEntity?
    
    override func didMove(to view: SKView) {
     //   buildBRabbitTest()
        // Added bounding box around level
        let maxAspectRatio: CGFloat = 16.0/9.0
        let maxAspectRatioHeight = size.width / maxAspectRatio
        let playableMargin: CGFloat = (size.height - maxAspectRatioHeight)/2
        let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height-playableMargin*2)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
        physicsWorld.contactDelegate = self
        physicsBody!.categoryBitMask = PhysicsMasks.LevelBounds

        // Add buttons
        leftButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "left", onButtonPress: leftPressed)
        leftButton.position = CGPoint(x: size.width * 0.15, y: 30 + leftButton.size.height/2 + size.height * 0.30)
        addChild(leftButton)
        
        rightButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "right", onButtonPress: rightPressed)
        rightButton.position = CGPoint(x: size.width * 0.15 + rightButton.size.width + 30, y: 30 + rightButton.size.height/2 + size.height * 0.30)
        addChild(rightButton)
        
        jumpButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "jump", onButtonPress: jumpPressed)
        jumpButton.position = CGPoint(x: size.width * 0.15 + jumpButton.size.width/2 + 30, y: 30 + jumpButton.size.height + size.height * 0.33)
        addChild(jumpButton)
        
        shootButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "Shoot", onButtonPress: shootPressed)
        shootButton.position = CGPoint(x: size.width * 0.80, y: 30 + shootButton.size.height/2 + size.height * 0.30)
        addChild(shootButton)
        
        spinButton = ButtonNode(iconName: "grey-squareblock-tile1", text: "Spin", onButtonPress: spinPressed)
        spinButton.position = CGPoint(x: size.width * 0.80 + spinButton.size.width + 30, y: 30 + spinButton.size.height/2 + size.height * 0.30)
        addChild(spinButton)
        
        entityManager = EntityManager(scene: self)
        
        player = PlayerEntity(imageName: "idle1", scale: 2)
        if let spriteComponent = player?.component(ofType: SpriteComponent.self) {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width/2, y: size.height/2)
        }
        entityManager?.add(player!)
        
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
        
        // stuff here
        
        self.lastUpdateTime = currentTime
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
   //     print("\(touchLocation)")
        
        if gameOver {
            let newScene = GameScene(size: size)
            newScene.scaleMode = scaleMode
            view?.presentScene(newScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            return
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
   //     moveBRabbit(location: location)
    }
    
    func leftPressed() {
        print("Left pressed!")
        player?.moveLeft()
    }
    
    func rightPressed() {
        print("Right pressed!")
        player?.moveRight()
    }
    
    func jumpPressed() {
        print("Jump pressed!")
        player?.jump()
    }
    
    func shootPressed() {
        print("Shoot pressed!")
        entityManager?.spawnBullet(shootRight: (player?.facingRight)!, shooter: player!)
    }
    
    func spinPressed() {
        print("Spin pressed!")

    }
    
    func spawnEnemyOverTime(time: Double) {
        let wait:SKAction = SKAction.wait(forDuration: time)
        let finishTimer:SKAction = SKAction.run {
            self.entityManager?.spawnEnemy()
            
            self.spawnEnemyOverTime(time: time)
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if (collision == PhysicsMasks.Player | PhysicsMasks.Enemy) {
            print("You collided with enemy!")
        } else if (collision == PhysicsMasks.Enemy | PhysicsMasks.Bullet) {
            print("you shot an enemy!")
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            // TODO: find way to remove from Set
            entityManager?.removeEmpties() // does not work atm
        }
    }
    
    
/*
    func buildBRabbitTest() {
        let brabbitAnimatedAtlas = SKTextureAtlas(named: "BRabbit-Run")
        var runFrames: [SKTexture] = []
        
        let numImages = brabbitAnimatedAtlas.textureNames.count;
        for i in 1...numImages {
            let brabbitTextureName = "run\(i)"
            runFrames.append(brabbitAnimatedAtlas.textureNamed(brabbitTextureName))
        }
        brabbitMoveFrames = runFrames
        let firstFrameTexture = brabbitMoveFrames[0]
        brabbit = SKSpriteNode(texture: firstFrameTexture)
        brabbit.position = CGPoint(x: frame.midX, y: frame.midY)
//        brabbit.xScale = 2
//        brabbit.yScale = 2
        addChild(brabbit)
    }
    
    func animateBRabbitTest() {
        brabbit.run(SKAction.repeatForever(
            SKAction.animate(with: brabbitMoveFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey:"movingInPlaceBRabbit")
    }
    
    func brabbitMoveEnded() {
        brabbit.removeAllActions()
    }
    
    func moveBRabbit(location: CGPoint) {
        var multiplierForDirection: CGFloat
        let brabbitSpeed = frame.size.width / 3.0
        let moveDifference = CGPoint(x: location.x - brabbit.position.x, y: location.y - brabbit.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / brabbitSpeed
        

        if moveDifference.x < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        brabbit.xScale = abs(brabbit.xScale) * multiplierForDirection
        
        if (brabbit.action(forKey: "movingInPlaceBRabbit") == nil) {
            animateBRabbitTest()
        }
        let moveAction = SKAction.move(to: location, duration: (TimeInterval(moveDuration)))
        let doneAction = SKAction.run({ [weak self] in
            self?.brabbitMoveEnded()
        })
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        brabbit.run(moveActionWithDone, withKey:"brabbitMoving")
    }
 */
}
