//
//  GameScene.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 2/28/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameManager: GameManager?
    var joystick: Joystick?
    
    var stickActive:Bool = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = #colorLiteral(red: 0.1631777585, green: 0.1484030187, blue: 0.2081771195, alpha: 1)
        gameManager = GameManager()
        gameManager?.scene = self
        gameManager?.StartGame(size: size)
        
        joystick = Joystick()
        joystick?.scene = self
        joystick?.Start()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if((gameManager?.player.position.x)! > CGFloat(800))
        {
            
        }
        
        gameManager?.player.update(currentTime)
        
        gameManager?.player.SetDirection(dir: (joystick?.dirVector)!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            joystick?.OnBegin(loc: location)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            joystick?.OnMoved(loc: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick?.OnEnded()
    }
    
}
