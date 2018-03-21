//
//  UIElements.swift
//  Get to the Chopper
//
//  Created by Sacchitiello Fabio on 3/20/18.
//  Copyright © 2018 Sacchitiello Fabio. All rights reserved.
//

import SpriteKit

//struct for physics body
struct CollisionBitMask {
    static let chopperCategory: UInt32 = 0x1 << 0
    static let wallCategory: UInt32 = 0x1 << 1
    static let collectibleCategory: UInt32 = 0x1 << 2
    static let groundCategory: UInt32 = 0x1 << 3
}

extension GameScene {
    
    //create restart buton and add to scene
    func createRestartButton() {
        restartButton = SKSpriteNode(imageNamed: "restart")
        restartButton.size = CGSize(width: 100, height: 100)
        restartButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartButton.zPosition = 6
        restartButton.setScale(0)
        self.addChild(restartButton)
        restartButton.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    //create pause button and add to scene
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause")
        pauseButton.size = CGSize(width: 40, height: 40)
        pauseButton.position = CGPoint(x: self.frame.width - 30, y: 30)
        pauseButton.zPosition = 6
        self.addChild(pauseButton)
    }
    
    //display label to show score
    func createScoreLabel() -> SKLabelNode {
        let scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 5
        scoreLabel.fontSize = 50
        scoreLabel.fontName = "HelveticaNeue-Bold"
        
        let scoreBg = SKShapeNode()
        scoreBg.position = CGPoint(x: 0, y: 0)
        scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100),         height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
        let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
        scoreBg.strokeColor = UIColor.clear
        scoreBg.fillColor = scoreBgColor
        scoreBg.zPosition = -1
        scoreLabel.addChild(scoreBg)
        return scoreLabel
    }
    
    //create highscore label and add to scene
    //keep track of highest score from games played
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLabel = SKLabelNode()
        highscoreLabel.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore") {
            highscoreLabel.text = "HighestScore: \(highestScore)"
        }
        else {
            highscoreLabel.text = "High Score: 0"
        }
        
        highscoreLabel.zPosition = 5
        highscoreLabel.fontSize = 15
        highscoreLabel.fontName = "HelveticaNeue-Bold"
        return highscoreLabel
    }
    
    //add image of a logo to the scene
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 272, height: 65)
        logoImg.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    //create label to start game/play instructions
    func createPlayLabel() -> SKLabelNode {
        let playLabel = SKLabelNode()
        playLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playLabel.text = "Tap screen to play"
        playLabel.fontColor = UIColor(red: 63 / 255, green: 79 / 255, blue: 145 / 255, alpha: 1.0)
        playLabel.zPosition = 5
        playLabel.fontSize = 20
        playLabel.fontName = "HelveticaNeue-Bold"
        return playLabel
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
}

