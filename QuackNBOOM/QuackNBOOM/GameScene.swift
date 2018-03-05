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
    ///just setting up the scene
    
    //creating variables
    let background = SKSpriteNode(imageNamed: "Background")
    let duckSprite = Duck(imagePath: "Duck")
    let bombSprite = Bomb(imagePath: "Bomb")
    let breadSprite = GameObject(imagePath: "Bread")
    
    override func didMove(to view: SKView) {
        //adding the background to the scene
        addChild(background)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.xScale = 0.6
        background.yScale = 0.75
        
        //adding the duck to the scene
        addChild(duckSprite.sprite)
        duckSprite.pos = CGPoint(x: size.width/2, y: 1000)
        duckSprite.sprite.zPosition = 2
        duckSprite.sprite.xScale = 0.75
        duckSprite.sprite.yScale = 0.75
        
        //adding the bomb to the scene
        addChild(bombSprite.sprite)
        bombSprite.pos = CGPoint(x: 750, y: 150)
        bombSprite.sprite.zPosition = 2
        bombSprite.sprite.xScale = 0.75
        bombSprite.sprite.yScale = 0.75
        
        //adding the bread to the scene
        addChild(breadSprite.sprite)
        breadSprite.pos = CGPoint(x: size.width/2, y: 100)
        breadSprite.sprite.zPosition = 2
        breadSprite.sprite.xScale = 0.75
        breadSprite
            .sprite.yScale = 0.75
    }
    
    override func update(_ currentTime: TimeInterval) {
        duckSprite.update(_deltaTime: currentTime)
        bombSprite.update(_deltaTime: currentTime)
        breadSprite.update(_deltaTime: currentTime)
    }
}
