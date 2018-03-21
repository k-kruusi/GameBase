//
//  GameScene.swift
//  SpaceShooterGame
//
//  Created by Tristan Garzon on 2018-03-07.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//


//Notes: Timer, Enemies, Firing

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Background
    var gbackground:SKEmitterNode!
    
    //Player
    var player:SKSpriteNode!
    
    //Score
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //Lives *Testing*
    var livesLabel:SKLabelNode!
    var lives:Int = 3 {
        didSet {
            livesLabel.text = "Lives: \(lives)"
        }
    }
    
    //Timer
    var secondsLabel:SKLabelNode!
    var seconds:Int = 0 {
        didSet {
            secondsLabel.text = "Timer: \(seconds)"
        }
    }
    
    //Enemy Spawn Timer
    var gameTimer:Timer!
    
    //Enemies
    var nEnemies = ["alien1", "alien2", "alien3", "alien4"]
    
    
    let nEnemiesCategory:UInt32 = 0x1 << 1
    let gunShooter:UInt32 = 0x1 << 0
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    
    //
    
    override func didMove(to view: SKView) {
        
        //Background (File, Position, Time)
        gbackground = SKEmitterNode(fileNamed: "Background")
        gbackground.position = CGPoint(x: 0, y: 1472)
        gbackground.advanceSimulationTime(10)
        self.addChild(gbackground)
        
        gbackground.zPosition = -1
        
        //Player (File, Scale, Position, Add)
        player = SKSpriteNode (imageNamed: "redfighter0005")
        player.setScale(0.4)
        player.position = CGPoint(x: self.frame.size.width / 40 - 20, y: player.size.height / 25 - 500)
        self.addChild(player)
        
        //Removes Gravity
        self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
        self.physicsWorld.contactDelegate = self
        
        //Score (Text, Position, Font, Size, Color, Default, Add)
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -300, y: -650)
        scoreLabel.fontName = "ChalkboardSE-Bold"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
        
        //Lives *Testing* (Text, Position, Font, Size, Color, Default, Add)
        livesLabel = SKLabelNode(text: "Lives: 3")
        livesLabel.position = CGPoint(x: -150, y: -650)
        livesLabel.fontName = "ChalkboardSE-Bold"
        livesLabel.fontSize = 30
        livesLabel.fontColor = UIColor.white
        lives = 3
        self.addChild(livesLabel)
        
        
        //Timer *Testing*
        restartTimer()
        secondsLabel = SKLabelNode(text: "Timer: ")
        secondsLabel.position = CGPoint(x: 0, y: -650)
        secondsLabel.fontName = "ChalkboardSE-Bold"
        secondsLabel.fontSize = 30
        secondsLabel.fontColor = UIColor.white
        seconds = 0
        self.addChild(secondsLabel)
        
        //Enemy Spawn Timer
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let acclerometerData = data {
                let acceleration = acclerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
       
        
        
    }
    
    //Add Enemy Func
    @objc func addEnemy () {
        nEnemies = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: nEnemies) as! [String]
        
        let enemies = SKSpriteNode(imageNamed: nEnemies[0])
        
        let randomEnemiesPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomEnemiesPosition.nextInt())
        
        enemies.position = CGPoint(x: position, y: self.frame.size.height + enemies.size.height)
        enemies.physicsBody = SKPhysicsBody(rectangleOf: enemies.size)
        enemies.physicsBody?.isDynamic = true
        
        enemies.physicsBody?.categoryBitMask = nEnemiesCategory
        enemies.physicsBody?.contactTestBitMask = gunShooter
        enemies.physicsBody?.collisionBitMask = 0
        
        enemies.setScale(0.5)
        
        self.addChild(enemies)
       
        let animationDuration:TimeInterval = 6
        
        var actionArray = [SKAction]()

        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -enemies.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        enemies.run(SKAction.sequence(actionArray))
    }
    
    //Touch Func for Shoot
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shootGun()
    }
    
    
    //Add Shoot func
    func shootGun() {
        //If I end up finding an audio file it goes here
       // self.run(SKAction.playSoundFileNamed("soundfilegoeshere", waitForCompletion: false))
        
        let shootNode = SKSpriteNode(imageNamed: "blast-harrier-laser-1")
        shootNode.position = player.position
        shootNode.position.y += 6
        
        shootNode.physicsBody = SKPhysicsBody(circleOfRadius: shootNode.size.width / 2)
        shootNode.physicsBody?.isDynamic = true
        
        shootNode.physicsBody?.categoryBitMask = gunShooter
        shootNode.physicsBody?.contactTestBitMask = nEnemiesCategory
        shootNode.physicsBody?.collisionBitMask = 0
        shootNode.physicsBody?.usesPreciseCollisionDetection = true
        
        shootNode.setScale(0.2)
        
        self.addChild(shootNode)
        
        let animationDuration:TimeInterval = 0.3
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        shootNode.run(SKAction.sequence(actionArray))
        
    }
    
    //Restart Timer Func *Testing*
    func restartTimer(){
        let wait:SKAction = SKAction.wait(forDuration: 1)
        let finishTimer:SKAction = SKAction.run {
            self.seconds += 1
            
            print(self.secondsLabel)
            
            self.restartTimer()
        }
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & gunShooter) != 0 && (secondBody.categoryBitMask & nEnemiesCategory) != 0 {
            shootCollideWithEnemy(shootNode: firstBody.node as! SKSpriteNode, enemiesNode: secondBody.node as! SKSpriteNode)
        }
    }
    
    func shootCollideWithEnemy (shootNode:SKSpriteNode, enemiesNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = enemiesNode.position
        self.addChild(explosion)
        
        //Explosion SFX goes herer
      //  self.run(SKAction.playSoundFileNamed("song goes here", waitForCompletion: false))
        
        shootNode.removeFromParent()
        enemiesNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2))
        {
            explosion.removeFromParent()
        }
        score += 5
    }
    
    override func didSimulatePhysics() {
        player.position.x += xAcceleration * 50
        
        if player.position.x < -20 {
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        }else if player.position.x > self.size.width + 20 {
            player.position = CGPoint(x: -20, y: player.position.y)
        }
    }
 

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
