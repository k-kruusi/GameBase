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
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    
    ///just setting up the scene
    
    //creating variables
    let background = GameObject(imagePath: "Background")
    //let duckSprite = Duck(imagePath: "Duck")
    //let bombSprite = Bomb(imagePath: "Bomb")
    let breadSprite = Bread(imagePath: "Bread")
    let gameOver = GameObject(imagePath: "GameOver")
    let duckController = DuckController()
    let bombController = BombController()
    
    override func didMove(to view: SKView) {
        //adding the background to the scene
        addChild(background)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        //adding the duck to the scene
        //addChild(duckSprite.sprite)
        //duckSprite.pos = CGPoint(x: size.width/2, y: 1000)
        addChild(duckController.getAllDucks())
        
        //adding the bomb to the scene
        //addChild(bombSprite.sprite)
        //addChild(bombSprite.explosionSprite)
        //bombSprite.pos = CGPoint(x: 750, y: 150)
        addChild(bombController.getAllBombs())
        addChild(bombController.getAllBombs().explosionSprite)
        
        //adding the bread to the scene
        addChild(breadSprite)
        breadSprite.position = CGPoint(x: size.width/2, y: 100)
        
        //addChild(gameOver.sprite)
        //gameOver.pos = CGPoint(x: size.width/2, y: size.height/2)
        //gameOver.zPos = 3.0
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        
        // Calculate deltaTime
        deltaTime = currentTime - lastUpdateTime
        self.lastUpdateTime = currentTime
        background.update(deltaTime)
        //duckSprite.update(_deltaTime: deltaTime)
        //bombSprite.update(_deltaTime: currentTime)
        bombController.update(deltaTime)
        duckController.update(deltaTime)
        breadSprite.update(deltaTime)
        gameOver.update(deltaTime)
    }
    
    // Shoot a bomb to the touched location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            //bombSprite.pos = location
            bombController.shootBomb(location: location)
        }
    }
}
