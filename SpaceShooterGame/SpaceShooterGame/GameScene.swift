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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var gbackground:SKEmitterNode!
    var player:SKSpriteNode!
    
    //Score
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        //Background (File, Position, Time)
        gbackground = SKEmitterNode(fileNamed: "Background")
        gbackground.position = CGPoint(x: 0, y: 1472)
        gbackground.advanceSimulationTime(10)
        self.addChild(gbackground)
        
        gbackground.zPosition = -1
        
        //Player (File, Scale, Position, Add)
        player = SKSpriteNode (imageNamed: "redfighter0006")
        player.setScale(0.4)
        player.position = CGPoint(x: self.frame.size.width / 40 - 20, y: player.size.height / 25 - 500)
        self.addChild(player)
        
        //Removes Gravity
        self.physicsWorld.gravity = CGVector(dx: 0, dy:0)
        self.physicsWorld.contactDelegate = self
        
        //Score (Text, Position, Font, Size, Color, Default, Add)
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -300, y: -550)
        scoreLabel.fontName = "TimesNewRoman"
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.white
        score = 0
        self.addChild(scoreLabel)
        
        
        
        
        
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
