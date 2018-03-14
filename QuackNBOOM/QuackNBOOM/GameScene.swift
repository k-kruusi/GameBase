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
    private var lastUpdateTime: TimeInterval?
    var isGameOver = false
    
    ///just setting up the scene
    
    //creating variables
    let background = GameObject(imagePath: "Background")
    let breadSprite = Bread(imagePath: "Bread")
    let gameManager = GameManager()
    let gameOver = GameObject(imagePath: "GameOver")
    
    override func didMove(to view: SKView) {
        //adding the background to the scene
        addChild(background)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        //adding the duck to the scene
        for duck in gameManager.getAllDucks(){
            addChild(duck)
        }
        
        //adding the bomb to the scene
        for bomb in gameManager.getAllBombs(){
            addChild(bomb)
            addChild(bomb.explosionSprite)
        }
        
        //adding the bread to the scene
        addChild(breadSprite)
        breadSprite.position = CGPoint(x: size.width/2, y: 100)
        
        //adding the gameOver to the scene
        addChild(gameOver)
        gameOver.position = CGPoint(x: size.width/2, y: size.height/2)
        gameOver.isHidden = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        // Calculate deltaTime
        let deltaTime = currentTime - lastUpdateTime
        self.lastUpdateTime = currentTime
        background.update(deltaTime)
        gameManager.update(deltaTime)
        breadSprite.update(deltaTime)
        gameOver.update(deltaTime)
        
        if(gameManager.isGameOver()){
            isGameOver = true
            gameOver.isHidden = false
        }
    }
    
    // Shoot a bomb to the touched location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!isGameOver){
            for touch in touches {
                let location = touch.location(in: self)
                //bombSprite.pos = location
                gameManager.shootBomb(location: location)
            }
        }
        else{
            gameManager.duckController.resetDucks()
            isGameOver = false
            gameOver.isHidden = true
        }
    }
}
