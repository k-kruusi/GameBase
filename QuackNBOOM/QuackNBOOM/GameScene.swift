//
//  GameScene.swift
//  QuackNBOOM
//
//  Created by Ngo Tuyetnhi N. and Benoit Neriah on 3/4/18.
//  Copyright © 2018 Neriah and Neenee. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //let background = SKSpriteNode(imageNamed: "background")
    let ugly = Duck(imagePath: "background")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        //addChild(background)
        //background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        addChild(ugly.sprite)
        //ugly.pos = CGPoint(x: size.width/2, y: size.height/2)
        ugly.pos = CGPoint(x: 400, y: 400)  
    }
    
    override func update(_ currentTime: TimeInterval) {
        ugly.update(_deltaTime: currentTime)
    }
}
