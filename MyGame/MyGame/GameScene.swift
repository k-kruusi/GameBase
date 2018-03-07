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
    
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
