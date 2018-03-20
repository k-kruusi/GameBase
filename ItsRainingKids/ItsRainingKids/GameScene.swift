//
//  GameScene.swift
//  ItsRainingKids
//
//  Created by Kanabe Lucas A. on 2/28/18.
//  Copyright © 2018 KanabeBoyko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //variable that will hold our falling objects
    var kids: [Kid] = []
    var _trampoline = Trampoline()
    var score = Int(0)
    lazy var scoreText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(75)
        text.zPosition = 2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .left
        text.verticalAlignmentMode = .bottom
        text.text = "Score: \(score)"
        return text
    }()
    
    var sManager : SpawnManager?
    
     let background = SKSpriteNode(imageNamed: "bg_kids")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        //background image instantiation
        
        addChild(background)
        addChild(_trampoline)
        addChild(scoreText)
        
        //setting the background to the center of the screen
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.scale(to: CGSize(width: size.width, height: size.height))
        _trampoline.position = CGPoint(x: size.width / 2, y: size.height / 7)
        _trampoline.zPosition = -0.5
        scoreText.position = CGPoint(x: size.width / 3.25, y: 55)
       
        
        //setting the depth of the background to be at the back, always rendering first
        background.zPosition = -1
        
        //initializing spawn manager
        sManager = SpawnManager(sRef: self)
        
        Timer.scheduledTimer(timeInterval: Double(arc4random_uniform(3)+1), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: false)
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        var markedForDeletion: [Int] = []
        var counter = Int(0)
        for k in kids {
            k.updateKids()
            if (_trampoline.isKidTouching(_position: k.position)) {
                if (k.reverseDirection()) {
                score += 1
                print("score is " , score)
                scoreText.text = "Score: \(score)"
                }
    
                
            }
            if (k.deleteIfOffscreen()){
                markedForDeletion.append(counter)
            }
            counter += 1
        }
        
        for i in markedForDeletion {
            kids[i].removeFromParent()
            kids.remove(at: i)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            _trampoline.handleMovement(_position: touch.location(in: self))
        }
    }
    
    @objc func CreateNewKid(){
        //print("SPAWNING")
        kids.append(sManager!.spawnKid())
        kids.last!.speedMultiplier(mod: score)
        addChild(kids.last!)
        //kids.last!.position = CGPoint(x: size.width / 2, y: size.height / 2)
        Timer.scheduledTimer(timeInterval: Double(arc4random_uniform(3)+1), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: false)
    }
   
}
