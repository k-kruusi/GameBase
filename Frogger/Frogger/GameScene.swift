//
//  GameScene.swift
//  Frogger
//
//  Created by Irving Waisman on 3/20/18.
//  Copyright © 2018 Irving and Zubair. All rights reserved.
//

import SpriteKit
//import CoreMotion


// Game States
enum GameStatus: Int {
    case waitingForTap = 0
    case waitingForPull = 1
    case playing = 2
    case gameOver = 3
}

enum PlayerStatus: Int {
    case idle = 0
    case prepForJump = 1
    case jump = 2
    case fall = 3
    case snake = 4
    case dead = 5
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Player: UInt32 = 0b1             // 1
    static let LilyPadNormal: UInt32 = 0b10    // 2
    static let LilyPadBreakable: UInt32 = 0b100// 4
    static let BugNormal: UInt32 = 0b1000      // 8
    static let BugSpecial: UInt32 = 0b10000    // 16
    static let Edges: UInt32 = 0b100000         // 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Properties
    // 1
    var lives = 5
    var bgNode: SKNode!
    var fgNode: SKNode!
    var backgroundOverlayTemplate: SKNode!
    var backgroundOverlayHeight: CGFloat!
    var gameState = GameStatus.waitingForTap
    var playerState = PlayerStatus.idle
    //let motionManager = CMMotionManager()
    //var xAcceleration = CGFloat(0)
    let cameraNode = SKCameraNode()
    var lastUpdateTimeInterval: TimeInterval = 0
    var deltaTime: TimeInterval = 0
    // 2
    var player: SKSpriteNode!
    var snake: SKSpriteNode!
    var lilyPad5Across: SKSpriteNode!
    var bugArrow: SKSpriteNode!
    var lastOverlayPosition = CGPoint.zero
    var lastOverlayHeight: CGFloat = 0.0
    var levelPositionY: CGFloat = 0.0
    // 3
    override func didMove(to view: SKView) {
        setupNodes()
        setupLevel()
        let scale = SKAction.scale(to: 600.0, duration: 0.5)
        fgNode.childNode(withName: "Ready")!.run(scale)
        setupPlayer()
        //setupCoreMotion()
        physicsWorld.contactDelegate = self
        camera?.position = CGPoint(x: size.width/2, y: size.height/2)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask ==
            PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        switch other.categoryBitMask {
        case PhysicsCategory.BugNormal:
            if let coin = other.node as? SKSpriteNode {
                coin.removeFromParent()
                jumpPlayer()
            }
        case PhysicsCategory.LilyPadNormal:
            if let _ = other.node as? SKSpriteNode {
                if player.physicsBody!.velocity.dy < 0 {
                    jumpPlayer()
                }
            } default:
            break
        }
    }
    
    func setupNodes() {
        let worldNode = childNode(withName: "World")!
        bgNode = worldNode.childNode(withName: "Background")!
        backgroundOverlayTemplate = bgNode.childNode(withName: "Overlay")!.copy() as! SKNode
        backgroundOverlayHeight = backgroundOverlayTemplate.calculateAccumulatedFrame().height
        fgNode = worldNode.childNode(withName: "Foreground")!
        player = fgNode.childNode(withName: "Player") as!
        SKSpriteNode
        fgNode.childNode(withName: "LilyPad")?.run(SKAction.hide())
        lilyPad5Across = loadForegroundOverlayTemplate("LilyPad5Across")
        bugArrow = loadForegroundOverlayTemplate("BugArrow")
        addChild(cameraNode)
        camera = cameraNode
        snake = fgNode.childNode(withName: "Snake") as! SKSpriteNode
    }
    
    func setupLevel() {
        // Place initial platform
        let initialPlatform = lilyPad5Across.copy() as! SKSpriteNode
        var overlayPosition = player.position
        overlayPosition.y = player.position.y - ((player.size.height * 0.5) + (initialPlatform.size.height * 0.20))
        initialPlatform.position = overlayPosition
        fgNode.addChild(initialPlatform)
        lastOverlayPosition = overlayPosition
        lastOverlayHeight = initialPlatform.size.height / 2.0
        
        // Create random level
        levelPositionY = bgNode.childNode(withName: "Overlay")!
            .position.y + backgroundOverlayHeight
        while lastOverlayPosition.y < levelPositionY {
            addRandomForegroundOverlay()
        }
    }
    
    func setupPlayer() {
        player.physicsBody = SKPhysicsBody(circleOfRadius:
            player.size.width * 0.3)
        player.physicsBody!.isDynamic = false
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.categoryBitMask = PhysicsCategory.Player
        player.physicsBody!.collisionBitMask = 0
    }
    
    /*func setupCoreMotion() {
        motionManager.accelerometerUpdateInterval = 0.2
        let queue = OperationQueue()
        motionManager.startAccelerometerUpdates(to: queue, withHandler:
            {
                accelerometerData, error in
                guard let accelerometerData = accelerometerData else {
                    return
                }
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
        })
    }*/
    
    func setPlayerVelocity(_ amount:CGFloat) {
        let gain: CGFloat = 1.5
        player.physicsBody!.velocity.dy = max(player.physicsBody!.velocity.dy, amount * gain)
    }
    func jumpPlayer() {
        setPlayerVelocity(800)
    }
    func leapPlayer() {
        setPlayerVelocity(900)
    }
    func superLeapPlayer() {
        setPlayerVelocity(1000)
    }
    
    // Overlay Nodes
    // 1
    func loadForegroundOverlayTemplate(_ fileName: String) ->
        SKSpriteNode {
            let overlayScene = SKScene(fileNamed: fileName)!
            let overlayTemplate =
                overlayScene.childNode(withName: "Overlay")
            return overlayTemplate as! SKSpriteNode
    }
    
    // 2
    func createForegroundOverlay(_ overlayTemplate:
        SKSpriteNode, flipX: Bool) {
        let foregroundOverlay = overlayTemplate.copy() as!
        SKSpriteNode
        lastOverlayPosition.y = lastOverlayPosition.y +
            (lastOverlayHeight + (foregroundOverlay.size.height / 2.0))
        lastOverlayHeight = foregroundOverlay.size.height / 2.0
        foregroundOverlay.position = lastOverlayPosition
        if flipX == true {
            foregroundOverlay.xScale = -1.0
        }
        fgNode.addChild(foregroundOverlay)
    }
    
    func addRandomForegroundOverlay() {
        let overlaySprite: SKSpriteNode!
        let platformPercentage = CGFloat(60)
        if CGFloat.random(min: 1, max: 100) <= platformPercentage {
            overlaySprite = lilyPad5Across
        } else {
            overlaySprite = bugArrow
        }
        createForegroundOverlay(overlaySprite, flipX: false)
    }
    
    // 3
    func createBackgroundOverlay() {
        let backgroundOverlay = backgroundOverlayTemplate.copy() as!
        SKNode
        backgroundOverlay.position = CGPoint(x: 0.0, y: levelPositionY)
        bgNode.addChild(backgroundOverlay)
        levelPositionY += backgroundOverlayHeight
    }
    
    // Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState == .waitingForTap {
            readyGame()
        } else if gameState == .gameOver {
            let newScene = GameScene(fileNamed:"GameScene")
            newScene!.scaleMode = .aspectFill
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            self.view?.presentScene(newScene!, transition: reveal)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // 1
        if lastUpdateTimeInterval > 0 {
            deltaTime = currentTime - lastUpdateTimeInterval
        } else {
            deltaTime = 0
        }
        lastUpdateTimeInterval = currentTime
        // 2
        if isPaused {
            return
        }
        // 3
        if gameState == .playing {
            updateCamera()
            updateLevel()
            updatePlayer()
            updateSnake(deltaTime)
            updateCollisionSnake()
        }
    }
    
    func updateLevel() {
        let cameraPos = camera!.position
        if cameraPos.y > levelPositionY - (size.height * 0.55) {
            createBackgroundOverlay()
            while lastOverlayPosition.y < levelPositionY {
                addRandomForegroundOverlay()
            }
        }
    }
    
    func updateSnake(_ dt: TimeInterval) {
        // 1
        let bottomOfScreenY = camera!.position.y - (size.height / 2)
        // 2
        let bottomOfScreenYFg = convert(CGPoint(x: 0, y:
            bottomOfScreenY), to: fgNode).y
        // 3
        let snakeVelocityY = CGFloat(120)
        let snakeStep = snakeVelocityY * CGFloat(dt)
        var newSnakePositionY = snake.position.y + snakeStep
        // 4
        newSnakePositionY = max(newSnakePositionY, (bottomOfScreenYFg -
            125.0))
        // 5
        snake.position.y = newSnakePositionY
    }
    
    func updateCollisionSnake() {
        if player.position.y < snake.position.y + 90 {
            playerState = .snake
            print("Snake!")
            leapPlayer()
            lives -= 1
            if lives <= 0 {
                gameOver()
            }
        }
    }
    
    func updateCamera() {
        let cameraTarget = convert(player.position, from: fgNode)
        var targetPositionY = cameraTarget.y - (size.height * 0.10)
        let snakePos = convert(snake.position, from: fgNode)
        targetPositionY = max(targetPositionY, snakePos.y)
        let diff = targetPositionY - camera!.position.y
        let cameraLagFactor = CGFloat(0.2)
        let lagDiff = diff * cameraLagFactor
        let newCameraPositionY = camera!.position.y + lagDiff
        camera!.position.y = newCameraPositionY
    }
    
    func updatePlayer() {
        // Set velocity based on core motion
        //player.physicsBody?.velocity.dx = xAcceleration * 1000.0
        // Wrap player around edges of screen
        var playerPosition = convert(player.position, from: fgNode)
        let leftLimit = sceneCropAmount()/2 - player.size.width/2
        let rightLimit = size.width - sceneCropAmount()/2
            + player.size.width/2
        if playerPosition.x < leftLimit {
            playerPosition = convert(CGPoint(x: rightLimit, y: 0.0),
                                     to: fgNode)
            player.position.x = playerPosition.x
        }
        else if playerPosition.x > rightLimit {
            playerPosition = convert(CGPoint(x:
                leftLimit, y: 0.0), to: fgNode)
            player.position.x = playerPosition.x
        }
        // Check player state
        if player.physicsBody!.velocity.dy < CGFloat(0.0) &&
            playerState != .fall {
            playerState = .fall
            print("Falling.")
        } else if player.physicsBody!.velocity.dy > CGFloat(0.0) &&
            playerState != .jump {
            playerState = .jump
            print("Jumping.")
        }
    }
    
    func readyGame() {
        gameState = .waitingForPull
        // Scale out title & ready label.
        let scale = SKAction.scale(to: 0, duration: 0.4)
        fgNode.childNode(withName: "Title")!.run(scale)
        fgNode.childNode(withName: "Ready")!.run(
            SKAction.sequence([SKAction.wait(forDuration: 0.2), scale]))
        
        // First Touch
        let scaleUp = SKAction.scale(to: 1.25, duration: 0.25)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.25)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatSeq = SKAction.repeatForever(sequence)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.run(startGame)]))
    }
    
    func startGame() {
        gameState = .playing
        player.physicsBody!.isDynamic = true
        superLeapPlayer()
    }
    
    func sceneCropAmount() -> CGFloat {
        guard let view = self.view else {
            return 0
            
        }
        let scale = view.bounds.size.height / self.size.height
        let scaledWidth = self.size.width * scale
        let scaledOverlap = scaledWidth - view.bounds.size.width
        return scaledOverlap / scale
    }
    
    func gameOver() {
        // 1
        gameState = .gameOver
        playerState = .dead
        // 2
        physicsWorld.contactDelegate = nil
        player.physicsBody?.isDynamic = false
        player.removeFromParent()
        // 3
        let moveUp = SKAction.moveBy(x: 0.0, y: size.height/2.0, duration: 0.5)
        moveUp.timingMode = .easeOut
        let moveDown = SKAction.moveBy(x: 0.0, y: -(size.height * 1.5), duration: 1.0)
        moveDown.timingMode = .easeIn
        player.run(SKAction.sequence([moveUp, moveDown]))
        // 4
        let gameOverSprite = SKSpriteNode(imageNamed: "GameOver")
        gameOverSprite.position = camera!.position
        gameOverSprite.zPosition = 10
        addChild(gameOverSprite)
    }
}
