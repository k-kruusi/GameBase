//
//  GameScene.swift
//  Search For The Light
//
//  Created by Kramarczyk Jessica N. on 2/28/18.
//  Copyright © 2018 Kramarczyk Jessica N. All rights reserved.
//

import SpriteKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    
   let player = SKSpriteNode(imageNamed: "playerImg")
   let bulletSound = SKAction.playSoundFileNamed("bulletSoundEffect.wav", waitForCompletion: false)
   let explosionSound = SKAction.playSoundFileNamed("explosionSoundEffect.wav", waitForCompletion: false)
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var starfield:SKEmitterNode!
    
    let PlayerCategory:UInt32 = 0x1 << 2
    let asteroidsCategory:UInt32 = 0x1 << 1
    let photonBulletCategory:UInt32 = 0x1 << 0
    
    var livesArray:[SKSpriteNode]!
    
    //setting up physics categories so some items will be affected by other items and some won't
    struct PhyscisCategories{
        static let None: UInt32 = 0         //0
        static let Player: UInt32 = 0b1     //1
        static let Bullet: UInt32 = 0b10    //2
        static let Enemy: UInt32 = 0b100    //4
    }

    //generate random between a range (min, and max)
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    let gameArea: CGRect
    
    override init(size: CGSize){
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth)/2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        
        super.init(size: size)
    }
    
    required init? (coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to: SKView){
        addLives()
        self.physicsWorld.contactDelegate = self
        
        
        createBG()
        
      
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 700, y: 2472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        starfield.zPosition = 1
        
        
        player.setScale(1)     //normal size, 0 = very small, 2 = double the size
        player.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        player.zPosition = 2
        
        
        
        //player.physicsBody = SKPhysicsBody(rectangleOf: player.size) //player will be affected by forces like gravity
        //player.physicsBody!.affectedByGravity = false     //the player has a physics body but won't be affected by gravity
        
        //what category of the physicsbody is the player in
        //player.physicsBody!.categoryBitMask = PhyscisCategories.Player
        
        
        //player.physicsBody!.collisionBitMask = PhyscisCategories.None    //what they cannot make conntact with
        //what we want the player to make contact with
       // player.physicsBody!.contactTestBitMask = PhyscisCategories.Enemy
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 350, y: self.frame.size.height-100)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 72
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
        startNewLevel()
    }
    
    override func update(_ currentTime: CFTimeInterval){
        moveBG()
    }
    
    func addLives(){
        livesArray = [SKSpriteNode]()
        
        for live in 1 ... 3{
            let liveNode = SKSpriteNode(imageNamed: "playerImg")
            liveNode.position = CGPoint(x: self.frame.size.width - CGFloat(4 - live) * liveNode.size.width, y: self.frame.size.height - 60)
            self.addChild(liveNode)
            livesArray.append(liveNode)
        }
    }
    
    
    //will run when two physics bodies that can make contact have made contact
    func didBeginContact (contact: SKPhysicsContact){ //contact hold the info of whihc objects have made contact: object A and B
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        //grab category A's body number and category B's number and if its less than
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            //they are in numeric order
            body1 = contact.bodyA    //the lower category number is assigned body1
            body2 = contact.bodyB    //the higher category number is assigned body2
        }
        else{
            body1 = contact.bodyB    //the lower category number is assigned body1
            body2 = contact.bodyA    //the higher category number is assigned body2
        }
        
        //body with the lowest number    //if player has hit the enemy
        if body1.categoryBitMask == PhyscisCategories.Player && body2.categoryBitMask == PhyscisCategories.Enemy {
            
            //only run if there is an object
            if body1.node != nil{
                spawnExplosion(spawnPosition:body1.node!.position)    //passing the position of body1 which is the player
            }
            
            if body2.node != nil{
                spawnExplosion(spawnPosition:body2.node!.position)    //! means it has to run
            }
            
            body1.node?.removeFromParent()    //delete body1
            body2.node?.removeFromParent()    //delete body2        //? means its opptional
        }
        
        
        
        if body1.categoryBitMask == PhyscisCategories.Bullet && body2.categoryBitMask == PhyscisCategories.Enemy{ //remove the final condition from here
            
            //The following bit has changed
            
            if body2.node != nil{
                if body2.node!.position.y > self.size.height{
                    return //if the enemy is off the top of the screen, 'return'. This will stop running this code here, therefore doing nothing unless we hit the enemy when it's on the screen. As we are already checking that body2.node isn't nothing, we can safely unwrap (with '!)' this here.
                }
                else{
                    spawnExplosion(spawnPosition: body2.node!.position)
                }
            }
            
            //changes end here
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
        }
        
        
        
        //if bullet hit the enemy & the enemy is on the screen
        /*if body1.categoryBitMask == PhyscisCategories.Bullet && body2.categoryBitMask == PhyscisCategories.Enemy
            /*&& body2.node?.position.y < self.size.height*/ {
                
                if body2.node != nil{
                    if body2.node!.position.y > self.size.height{
                        return
                    }
                    else{
                        spawnExplosion(spawnPosition:body2.node!.position)
                    }
                }
                
                body1.node?.removeFromParent()
                body2.node?.removeFromParent()
        }*/
    }
    
    //dealing with the explosion
    func spawnExplosion(spawnPosition: CGPoint){
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        explosion.run(_: explosionSequence)
        
    }
    
    func startNewLevel(){
        //this action will run the following function in parenthese
        let spawn = SKAction.run(_: spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])    //spawn and wait for a second
        let spawnForever = SKAction.repeatForever(_: spawnSequence) //will keep on spawning the enemy
        self.run(_: spawnForever)
        
    }
    
    //firing a bullet
    func fireBullet(){
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2) //player will be affected by forces like
        bullet.physicsBody?.isDynamic = true
        
        //gravity and it will match the size of the bullet
        bullet.physicsBody!.affectedByGravity = false     //the player has a physics body but won't be affected by gravity
        bullet.physicsBody!.categoryBitMask = photonBulletCategory
        bullet.physicsBody!.collisionBitMask = PhyscisCategories.None
        //we want the enemy to collide with the enemy
        //what we want the enemy to make contact with
        bullet.physicsBody!.contactTestBitMask = asteroidsCategory
        
        
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent() //deletes the Bullet
        
        //Bullet Sequence
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(_: bulletSequence)
        
        
        
    }
    
    func spawnEnemy(){
        
        //generate a random x
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        //where the enemy will start and where it will end
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2) //20% above the screen
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)    //20% below the screen
        
        let enemy = SKSpriteNode(imageNamed: "enemyObject")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size) //player will be affected by forces like gravity
        enemy.physicsBody!.affectedByGravity = false     //the player has a physics body but won't be affected by gravity
        enemy.physicsBody!.categoryBitMask = asteroidsCategory
        enemy.physicsBody!.collisionBitMask = 0
        //we want the enemy to collide with the player and the bullet
        //what we want the enemy to make contact with
        enemy.physicsBody!.contactTestBitMask = photonBulletCategory
        
        
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy]) //move to the end point and delete
        enemy.run(_: enemySequence)
        
        //finding out the difference in x and difference in y
        let dx = endPoint.x - startPoint.x //figuring out difference between where we started and where we ended with x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx) //figuring out how much to rotate by
        enemy.zRotation = amountToRotate    //actually rotating
        
        
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
        
        if (firstBody.categoryBitMask & photonBulletCategory) != 0 && (secondBody.categoryBitMask & asteroidsCategory) != 0 {
            torpedoDidCollideWithAlien(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    
    func torpedoDidCollideWithAlien (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 5
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            //coordinates of where we are touching the screen right now
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            //difference of the two points
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragged
            
            //this takes into account the ships width
            //greater than the furthest right position of the game area
            
            if player.position.x > gameArea.maxX - player.size.width/2{
                //don't let us go any further right
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            //less than the furthest left position of the game area
            if player.position.x < gameArea.minX + player.size.width/2{
                //don't let us go any further left
                player.position.x = gameArea.minX + player.size.width/2
            }
        }
    }
    
    
    func createBG(){
        for i in 0...3 {
            
            let background = SKSpriteNode(imageNamed: "background")
            
            background.name = "BG"
            background.size = self.size //get the background and set it to be the same size as the scene
            
            background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            
            background.zPosition = -1 // the lower the number the further back
            
            self.addChild(background)    // take all of the above and make it
            
            
        }
    }
    
    func moveBG(){
       
        self.enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.y -= 1
            if node.position.y < -((self.scene?.size.height)!) {
                node.position.y -= (self.scene?.size.height)! * 2
            }
        }))
    }
    
    
}
    /*
    override func didMoveToView(view: SKView){
        
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size //get the background and set it to be the same size as the scene
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0 // the lower the number the further back
        self.addChild(background)    // take all of the above and make it
        
        
        
        player.setScale(1)     //normal size, 0 = very small, 2 = double the size
        player.position = CGPoint(x: self.size.width/2, y: self.size.height*0.2)
        player.zPosition = 2
        self.addChild(player)
        
    }
    
    //firing a bullet
    func fireBullet(){
        let bullet = SKSpriteNode(imageNamed:"bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveToY(y:self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent() //deletes the Bullet
        
        //Bullet Sequence
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.runAction(bulletSequence)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        fireBullet()
        
    }
    
    //executes whenever you touch your finger around the screen
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?){
        for touch: AnyObject in touches{
            //coordinates of where we are touching the screen right now
            
            let pointOfTouch = touch.locationInNode(self)
            let previousPointOfTouch = touch.previousLocationInNode(self)
            //difference of the two points
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragged
            
            
        }
        
}

*/






