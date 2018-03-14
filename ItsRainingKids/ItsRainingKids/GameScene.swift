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
    
    var sManager : SpawnManager?
    
     let background = SKSpriteNode(imageNamed: "bg_kids")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        //background image instantiation
        
        addChild(background)
        
        //setting the background to the center of the screen
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.scale(to: CGSize(width: size.width, height: size.height))
        
        //setting the depth of the background to be at the back, always rendering first
        background.zPosition = -1
        
        //initializing spawn manager
        sManager = SpawnManager(sRef: self)
        
        Timer.scheduledTimer(timeInterval: Double(arc4random_uniform(3)+1), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: false)
        
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        for k in kids {
            k.updateKids()
        }
        //print(kids.last?.position.x, " ", kids.last?.position.y)
    }
    
    @objc func CreateNewKid(){
        //print("SPAWNING")
        kids.append(sManager!.spawnKid())
        addChild(kids.last!)
        //kids.last!.position = CGPoint(x: size.width / 2, y: size.height / 2)
        Timer.scheduledTimer(timeInterval: Double(arc4random_uniform(3)+1), target: self, selector: #selector(self.CreateNewKid), userInfo: nil, repeats: false)
    }
   
}
