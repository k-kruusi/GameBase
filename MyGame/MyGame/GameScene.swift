//
//  GameScene.swift
//  MyGame
//
//  Created by Sacchitiello Fabio on 2/28/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //store score and display labels
    var isGameStarted = Bool (false)
    var isDead = Bool (false)
    let collectSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    
    var scoreLable = SKLabelNode()
    var highscoreLable = SKLabelNode()
    var playLable = SKLabelNode()
    
    var restartButton = SKSpriteNode()
    var pauseButon = SKSpriteNode()
    var logoImg = SKSpriteNode()
    
    var wallBlocks = SKNode()
    var moveAndRemove = SKAction()
    
    //Chopper atlas for animation
    //let chopperAtlas = SKTextureAtlas(named: "player")
    var chopperSprites: [SKTexture] = [SKTexture(imageNamed: "img1"), SKTexture(imageNamed: "img2"), SKTexture(imageNamed: "img3"), SKTexture(imageNamed: "img4")]
    var chopper = SKSpriteNode.init(imageNamed: "img1")
    var repeatActionChopper = SKAction()
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        createScene()
        
        self.chopper = createChopper()
        self.addChild(chopper)
        //animate and repeat the chopper animation
        let animateChopper = SKAction.animate(with: self.chopperSprites, timePerFrame: 0.1)
        self.repeatActionChopper = SKAction.repeatForever(animateChopper)
        chopper.run(repeatActionChopper)
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //moving background left when game begins
        if isGameStarted == true {
            if isDead == false {
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                }))
            }
        }
    }
    
    //create physics body around the screen
    func createScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.chopperCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.chopperCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 190.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        
        //set background in the scene beside each other for parallaxing
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y: 0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        //add textures to the sprite array
        //chopperSprites.append(chopperAtlas.textureNamed("img1"))
        //chopperSprites.append(chopperAtlas.textureNamed("img2"))
        //chopperSprites.append(chopperAtlas.textureNamed("img3"))
        //chopperSprites.append(chopperAtlas.textureNamed("img4"))
        
    }
}
