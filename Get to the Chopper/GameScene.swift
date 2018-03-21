//
//  GameScene.swift
//  Get to the Chopper
//
//  Created by Sacchitiello Fabio on 3/20/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isGameStarted = false
    var isDead = false
    let collectSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var playLabel = SKLabelNode()
    var restartButton = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()

    var chopperSprites: [SKTexture] = [SKTexture(imageNamed: "img1"), SKTexture(imageNamed: "img2"), SKTexture(imageNamed: "img3"), SKTexture(imageNamed: "img4")]
    var chopper = SKSpriteNode.init(imageNamed: "img1")
    var repeatActionChopper = SKAction()
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isGameStarted {
            isGameStarted =  true
            chopper.physicsBody?.affectedByGravity = true
            createPauseButton()
            logoImg.run(SKAction.scale(to: 0.5, duration: 0.3), completion: {
                self.logoImg.removeFromParent()
            })
            playLabel.removeFromParent()
            self.chopper.run(repeatActionChopper)
            
            let spawn = SKAction.run({
                () in
                self.wallPair = self.createWall()
                self.addChild(self.wallPair)
            })
            
            let delay = SKAction.wait(forDuration: 1.5)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width + wallPair.frame.width)
            let moveWall = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
            let removeWall = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([moveWall, removeWall])
            
            chopper.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            chopper.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
            if !isDead {
                chopper.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                chopper.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
        
        // if dead show restart button
        // if pause was pressed pause game and show continue button
        for touch in touches{
            let location = touch.location(in: self)
            if isDead {
                if restartButton.contains(location){
                    if UserDefaults.standard.object(forKey: "highestScore") != nil {
                        let highscore = UserDefaults.standard.integer(forKey: "highestScore")
                        if highscore < Int(scoreLabel.text!)!{
                            UserDefaults.standard.set(scoreLabel.text, forKey: "highestScore")
                        }
                    } else {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    restartScene()
                }
            } else {
                if pauseButton.contains(location){
                    if self.isPaused == false{
                        self.isPaused = true
                        pauseButton.texture = SKTexture(imageNamed: "play")
                    } else {
                        self.isPaused = false
                        pauseButton.texture = SKTexture(imageNamed: "pause")
                    }
                }
            }
        }
    }
    
    // restart game when player id dead
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDead = false
        isGameStarted = false
        score = 0
        createScene()
    }
    
    func createScene(){
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.chopperCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.chopperCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
        self.chopper = createChopper()
        self.addChild(chopper)
        //animate and repeat the chopper animation
        let animateChopper = SKAction.animate(with: self.chopperSprites, timePerFrame: 0.1)
        self.repeatActionChopper = SKAction.repeatForever(animateChopper)
        chopper.run(repeatActionChopper)
        
        scoreLabel = createScoreLabel()
        self.addChild(scoreLabel)
        
        highscoreLabel = createHighscoreLabel()
        self.addChild(highscoreLabel)
        
        createLogo()
        
        playLabel = createPlayLabel()
        self.addChild(playLabel)
    }
    
    // checks if player collides with ground or wall then game over
    // if player collides with a collectible add to the score
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.chopperCategory && secondBody.categoryBitMask == CollisionBitMask.wallCategory || firstBody.categoryBitMask == CollisionBitMask.wallCategory && secondBody.categoryBitMask == CollisionBitMask.chopperCategory || firstBody.categoryBitMask == CollisionBitMask.chopperCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.chopperCategory{
            enumerateChildNodes(withName: "wallPair", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDead == false{
                isDead = true
                createRestartButton()
                pauseButton.removeFromParent()
                self.chopper.removeAllActions()
            }
        } else if firstBody.categoryBitMask == CollisionBitMask.chopperCategory && secondBody.categoryBitMask == CollisionBitMask.collectibleCategory {
            run(collectSound)
            score += 1
            scoreLabel.text = "\(score)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.collectibleCategory && secondBody.categoryBitMask == CollisionBitMask.chopperCategory {
            run(collectSound)
            score += 1
            scoreLabel.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isGameStarted {
            if !isDead {
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                }))
            }
        }
    }
}
