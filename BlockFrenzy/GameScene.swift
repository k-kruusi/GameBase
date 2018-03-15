//
//  GameScene.swift
//  BlockFrenzy
//
//  Created by McLoughlin David J. on 3/8/18.
//  Copyright © 2018 McLoughlin David J. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    let BallCatName = "ball"
    let paddleCatName = "paddle"
    let BlockCatName = "block"
    
    
    var BackgroundMusic = AVAudioPlayer()
    var fingerIsOnpaddle = false
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        guard let bgMusic = Bundle.main.url(forResource: "Dark_Knight_Dummo", withExtension: "mp3") else {
            return
        }
        
        do {
            try BackgroundMusic = AVAudioPlayer(contentsOf: bgMusic)
            BackgroundMusic.numberOfLoops = -1;
            BackgroundMusic.prepareToPlay()
            BackgroundMusic.play()
            
            let backgoundImage = SKSpriteNode(imageNamed: "bg")
            backgoundImage.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            self.addChild(backgoundImage)
            
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            
            let border = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.physicsBody = border
            self.physicsBody?.friction = 0
            
            let ball = SKSpriteNode(imageNamed: "Ball")
            ball.name = BallCatName
            ball.position = CGPoint(x: self.frame.size.width/4, y: self.frame.size.width/4)
            self.addChild(ball)
            ball.setScale(2)
            
            
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody?.friction = 0
            ball.physicsBody?.restitution = 1
            ball.physicsBody?.linearDamping = 0
            ball.physicsBody?.allowsRotation = false
            
            ball.physicsBody?.applyImpulse(CGVector(dx: 2, dy: -2))
            
            let paddle = SKSpriteNode(imageNamed: "paddle")
            paddle.name = paddleCatName
            paddle.position = CGPoint(x: self.frame.midX, y: paddle.frame.size.height * 2)
            
            self.addChild(paddle)
            paddle.setScale(1.5)

            paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.frame.size)
            paddle.physicsBody?.friction = 0.4
            paddle.physicsBody?.restitution = 0.1
            paddle.physicsBody?.isDynamic = false
            
            
            
        } catch{
            print(error)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
    
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        let body:SKPhysicsBody? = self.physicsWorld.body(at: touchLocation)
        
        if body?.node?.name == paddleCatName {
            print("paddle touched")
            fingerIsOnpaddle = true
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if fingerIsOnpaddle {
            guard let touch = touches.first else {
                return
            }
            let touchLoc = touch.location(in: self)
            let prevTouchLocation = touch.previousLocation(in: self)
            
            let paddle = self.childNode(withName: paddleCatName) as! SKSpriteNode
            
            var newXPos = paddle.position.x + (touchLoc.x - prevTouchLocation.x)
            
            
            
            newXPos = max(newXPos,paddle.size.width / 2)
            newXPos = min(newXPos, self.size.width - paddle.size.width / 2)
            
            paddle.position = CGPoint(x: newXPos, y: paddle.position.y)
            
        }
        
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fingerIsOnpaddle = false
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
