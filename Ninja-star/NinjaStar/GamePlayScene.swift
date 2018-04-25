//
//  GameScene.swift
//  NinjaStar
//
//  Created by Nissan Adid on 3/03/18.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import SpriteKit
import GameplayKit


class GamePlayScene: SKScene {
   
   private var label : SKLabelNode?
   private var spinnyNode : SKShapeNode?
    
    //background
    var background = SKSpriteNode()
    
    //Ground
    public let ground = SKSpriteNode()
    
    //is animating
    private var isAnimating = false
    
    //is running
    private var isRunning = false
    
    //Score variable and label
    private var Score: Float = 0.0
    let ScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    //these values will be used to detect swipes, will be used for throwing shurikens
    var didSwipe = false
    var start: CGPoint?
    var end: CGPoint?
    
    //Clock Label
    let ClockLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    //enemy array and spawn manager
    private var spawnManager: SpawnManager?
    private var enemies: [Enemy] = []
    
    
    
override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    physicsWorld.contactDelegate = self
    
    //set the ninja  position in the scene
    Ninja.ninjaInstance.position = CGPoint(x: 0, y: 100)
      
    //set-up the background position and size to fill the window
    backgroundColor = SKColor.black

    //set up parallax scrolling background
    self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    for i in 0...3{
        let background = SKSpriteNode(imageNamed: "GameBackground")
        background.name = "BackGround"
        background.size = CGSize(width: (self.scene?.size.width)!, height: (UIScreen.main.bounds.size.height))
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: CGFloat(i) * background.size.width, y: 0)
        self.addChild(background)
    }
    
    //Set-up the ground so that the player does not fall through the ground. Also place it on the same zposition as the player
    ground.color = UIColor.clear
    ground.zPosition = 1
    ground.name = "myGround"
    let sizeOfGround = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
    ground.size.width = sizeOfGround.width
    ground.size.height = sizeOfGround.height
    ground.position.y = -100
    ground.physicsBody = SKPhysicsBody(rectangleOf: sizeOfGround)
    ground.physicsBody?.affectedByGravity = false
    ground.physicsBody?.isDynamic = false
    ground.physicsBody?.contactTestBitMask = 0b1001
    addChild(ground)
    
    
    //add ninja as a child of the scene
    addChild(Ninja.ninjaInstance)
    Ninja.ninjaInstance.zPosition = 1
    Ninja.ninjaInstance.name = "myNinja"
    Ninja.ninjaInstance.position = CGPoint(x: 0, y: 0)
    Ninja.ninjaInstance.physicsBody?.contactTestBitMask = 0b1001
    
    
    //init the ninjaAnimations
    Ninja.ninjaInstance.SetNinjaAnimations(playAnim: Ninja.ninjaAnimation.IDLE)
    
    
    //Init the spawn manager
    spawnManager = SpawnManager(givenSpawnArea: CGRect(x:-700 , y: -400, width: 1200, height: 600), min: 1, max: 4);
    spawnManager?.scene = self
    
    
    //setup Timer label
    ClockLabel.fontSize = 30
    ClockLabel.fontColor = SKColor.green
    ClockLabel.position = CGPoint(x: frame.midX, y: (frame.midY + 160))
    ClockLabel.zPosition = 20
    
    //update timer
    addChild(ClockLabel)
    countdown()
    
    
    //setup Score label
    ScoreLabel.fontSize = 30
    ScoreLabel.fontColor = SKColor.green
    ScoreLabel.position = CGPoint(x: frame.maxX - 200, y: (frame.midY + 160))
    ScoreLabel.zPosition = 20
    
    addChild(ScoreLabel)
    
   }
   
    deinit {
        enemies = []
    }
    //parallax scrolling background function
    func parallax(){
        self.enumerateChildNodes(withName: "BackGround", using: ({
            (node, error) in
            node.position.x -= 2
            
            if(node.position.x < -(self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }

   
   //Create label function
   func CreateLabel(position: CGPoint, name: String, fontsize: CGFloat, color: UIColor) ->SKLabelNode{
      let Label = SKLabelNode(text: name)
      Label.position = position
      Label.fontSize = fontsize
      Label.color = color
      return Label
   }
   
   func touchDown(atPoint pos : CGPoint) {
      if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.green
         self.addChild(n)
      }
    start = pos
   }
   
   func touchMoved(toPoint pos : CGPoint) {
      if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.blue
         self.addChild(n)
      }
    didSwipe = true
   }
   
   func touchUp(atPoint pos : CGPoint) {
      if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.red
         self.addChild(n)
      }
    //if the user touches up the left side of the screen, stop running
    if(pos.x < 0){
        
    isRunning = false
    Ninja.ninjaInstance.SetNinjaAnimations(playAnim: Ninja.ninjaAnimation.IDLE)
    isAnimating = false
        
    }
    //if player swiped, then shoot a shuriken
    if(didSwipe){
        end = pos
        didSwipe = false
        Ninja.ninjaInstance.shoot(shurknOrgn: start!, shurknDir: end!)
        self.addChild(Ninja.ninjaInstance.latestShuriken!)
    }
    //if the user lifts his finger from the right side of the screen and the player is not swiping, then jump
    else if(!didSwipe){
        if(pos.x >= 0){
            Ninja.Jump()
            isRunning = true
            Ninja.ninjaInstance.SetNinjaAnimations(playAnim: Ninja.ninjaAnimation.JUMP)
            isAnimating = false
        }
    }
    
    }
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let label = self.label {
         label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
      }
      
      for t in touches { self.touchDown(atPoint: t.location(in: self))
        let location = t.location(in: self)
        //the user touched the left side of the screen
        if(location.x < 0){
            isRunning = true
            Ninja.ninjaInstance.SetNinjaAnimations(playAnim: Ninja.ninjaAnimation.RUN)
            isAnimating = false
        }
        
        
    }
   }
   
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchUp(atPoint: t.location(in: self))
        
    }
   }
   
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      for t in touches { self.touchUp(atPoint: t.location(in: self)) }
   }
   
   
   override func update(_ currentTime: TimeInterval) {
      // Called before each frame is rendered
    if(!isAnimating){
    Ninja.ninjaInstance.animateNinja()
        isAnimating = true
    }
    //parallax background
    if(isRunning){
        parallax()
    }
    
    //update the shuriken position
    Ninja.ninjaInstance.update()
    
    for enemy in enemies {
    // updating each zombie
    enemy.update(currentTime)
    
    }
    
    //deleteZombies(toBeDeleted)
    
    // spawn manager code here
    guard let enemy = spawnManager?.update(time: currentTime) else {
    return
    }
    enemies.append(enemy)
    
    
    //display score
    ScoreLabel.text = "\(Score)"
    }
    
    
    //Countdown Clock
    func countdown() {
        //setup label
        ClockLabel.fontSize = 30
        ClockLabel.fontColor = SKColor.green
        ClockLabel.position = CGPoint(x: frame.midX, y: (frame.midY + 160))
        var offset: Double = 0
        
        for x in (0...60).reversed() {
            
            run(SKAction.wait(forDuration: offset)) {
                self.ClockLabel.text = "\(x)"
                
                if x == 0 {
                    //do something when counter hits 0
                    //self.runGameOver()
                    let gameScene = UserScoreScene(fileNamed: "UserScoreScene")!
                    gameScene.myScore = self.Score
                    gameScene.scaleMode = .aspectFill
                    let myTransition = SKTransition.moveIn(with: .up, duration: 1.0)
                    self.view?.presentScene(gameScene, transition: myTransition)
                }
            }
            offset += 1.0
        }
    }
    
    //UpdateScore
    func updateScore(Amount: Float){
        Score += Amount
        ScoreLabel.text = "\(Score)"
    }
}

//Collision Detection
extension GamePlayScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.node?.name == "myGround" && contact.bodyB.node?.name == "myNinja" && Ninja.ninjaInstance.isJumping){
            Ninja.ninjaInstance.isJumping = false
            //Ninja.ninjaInstance.SetNinjaAnimations(playAnim: Ninja.ninjaAnimation.IDLE)
            isRunning = false
            print("Hit!")
        }
        if(contact.bodyA.node?.name == "easyEnemy" && contact.bodyB.node?.name == "shuriken"){
            //remove player
            contact.bodyA.node?.removeFromParent()
            //update score
            updateScore(Amount: 100)
        }
        if(contact.bodyA.node?.name == "hardEnemy" && contact.bodyB.node?.name == "shuriken"){
            contact.bodyA.node?.removeFromParent()
            updateScore(Amount: 200)
        }
        if(contact.bodyA.node?.name == "timeBonusEnemy" && contact.bodyB.node?.name == "shuriken"){
            contact.bodyA.node?.removeFromParent()
            updateScore(Amount: 300)
        }
        
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        
    }
}

