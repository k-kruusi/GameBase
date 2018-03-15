//
//  GameScene.swift
//  ZombieConga
//
//  Created by Kevin Kruusi on 2018-02-04.
//  Copyright © 2018 kevin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let player = CatLady()
    let zombie = Zombie()
    let background = SKSpriteNode(imageNamed: "background1")
    
    /*
    let player = SKSpriteNode(imageNamed: "zombie1")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        addChild(background)
        addChild(player)
        player.zPosition = 1
        player.position = CGPoint(x: 400, y: 400)
    }
 */
    
   
    override func didMove(to view: SKView) {
        //test background
        backgroundColor = SKColor.black
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        addChild(background)
        background.zPosition = -1
        
         //test zombie
        //var zombie = Zombie(imageName: "zombie1",pos: CGPoint(x: 150,y: 450))
        
        addChild(zombie)
        
        //test cat lady
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        player.MoveTo()
        
        //zombie test
        zombie.SetTarget(newTarget: player.position)
        zombie.MoveTo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //player.position = touch.location(in: self)
        //player.MoveTo(newPos: touch.location(in: self))
        player.SetTarget(newTarget: touch.location(in: self))
    }
}
