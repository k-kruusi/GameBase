//
//  GameScene.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let player = Player()
    //let zombie = Zombie()
    let background = SKSpriteNode(imageNamed: "background1")
    
    override func didMove(to view: SKView) {
        //test background
        backgroundColor = SKColor.black
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        addChild(background)
        background.zPosition = -1
        
        //addChild(zombie)
        
        //test cat lady
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        player.MoveTo()
        
        //zombie test
        //zombie.SetTarget(newTarget: player.position)
        //zombie.MoveTo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        player.SetTarget(newTarget: touch.location(in: self))
        player.SetRotateTarget(newTarget: touch.location(in: self))
        player.RotateTowards()
    }
}
