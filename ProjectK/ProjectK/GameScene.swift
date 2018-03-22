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
    let arrow = Projectile()
    let enemy = Enemy()
    let background = SKSpriteNode(imageNamed: "background2")
    
    override func didMove(to view: SKView) {
        //test background
        backgroundColor = SKColor.white
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        addChild(background)
        background.zPosition = -1
        
        //addChild(zombie)
        
        //player
        addChild(player)
        player.SetInitPosition(newPos: CGPoint(x: size.width / 2, y: size.height / 2 ))
        
        //Arrow
        addChild(arrow)
        arrow.SetInitPosition(newPos: CGPoint(x: size.width / 2, y: size.height / 2 ))
        
        //Enemy //Change to a factory of enemies later
        addChild(enemy)
        enemy.SetInitPosition(newPos: CGPoint(x: enemy.size.width / 2, y: size.height / 1.25 ))
        //enemy.GetScreenSize(screenSize: CGPoint(x: size.point)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        arrow.Update()
        
        enemy.SetTarget(newTarget: CGPoint(x:size.width,y: size.height/1.25))
        enemy.Update()
        
        //player.MoveTo() //moves player towards target destination
        
        //zombie test
        //zombie.SetTarget(newTarget: player.position)
        //zombie.MoveTo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //player.SetTarget(newTarget: touch.location(in: self))  //set target for player to move to
        player.SetRotateTarget(newTarget: touch.location(in: self))  //set target for rotation
        player.RotateTowards() //rotate towards target
        
        //Arrow
        arrow.GetInitialPosition(initPos: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //Arrow
        arrow.GetFinalPosition(finalPos: touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first as! UITouch
        
        player.SetRotateTarget(newTarget: touch.location(in: self))  //set target for rotation
        player.RotateTowards() //rotate towards target
    }
}
