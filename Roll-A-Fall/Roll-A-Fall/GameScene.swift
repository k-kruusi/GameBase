//
//  GameScene.swift
//  Roll-A-Fall
//
//  Created by Stefen Matias on 2018-03-01.
//  Copyright © 2018 Stefen Matias. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var recentTouchPostion = CGPoint()
    var screenTapped = false
    var gameSpeed: CGFloat = 10
    var player : Player = Player(StartingPosition: CGPoint(x:1000, y:1000))
    var backgroundImage01 : Gameobject = Gameobject(NameId: "Background", zPos: -1, transparency: 1)
    var backgroundImage02 : Gameobject = Gameobject(NameId: "Background", zPos: -1, transparency: 1)
    var parallaxer : ParallaxingBackground?
    
    //UI
    var slowDownButton: InGameButton = InGameButton(StartingPosition: CGPoint(x:250,y:250), ButtonNameId: "Button_SlowDown", Type: "slowDown")
    var speedUpButton: InGameButton = InGameButton(StartingPosition: CGPoint(x:1800,y:250), ButtonNameId: "Button_SpeedUp", Type: "speedUp")


    override func didMove(to view: SKView) {
     //Runs At First View Load
    
        //Set Background Color
        backgroundColor = SKColor.black
        
        
        
        
        parallaxer = ParallaxingBackground(BackgroundImage01: backgroundImage01, BackgroundImage02: backgroundImage02, ScreenMax: CGPoint(x: 2048, y: 1536))
        //setPosition
        backgroundImage01.position = CGPoint(x:1024,y:1018)
        backgroundImage02.position = CGPoint(x:3072, y:1018)
        
        addChild(speedUpButton)
        addChild(slowDownButton)
        addChild(backgroundImage01)
        addChild(backgroundImage02)
        addChild(player)
        
        speedUpButton.updateCollider();
        slowDownButton.updateCollider();
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        parallaxer?.parralaxing();
        
        if(screenTapped){
            //ScreenTap With Touch Position Recorded
            print("[ " , recentTouchPostion.x, " , ", recentTouchPostion.y, " ]")
            
            
            
            //Check To See If Touch Was General Screen Or If It Was A Button
           // if(){
           //     player.isJumping = true;
           // }
            if(speedUpButton.isCollidingBox(positions: [recentTouchPostion])){
                speedUpButton.ifClicked(background: parallaxer!)
                //print("Speeding UP")
            }
            else if(slowDownButton.isCollidingBox(positions: [recentTouchPostion])){
                slowDownButton.ifClicked(background: parallaxer!)
                //print("Slowing Down")
            }
            else{
                player.isJumping = true;
            }
            
            
            screenTapped = false
        }
        
        player.updatePlayer()
    }
    
    
    //Screen Tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPosition = touch.location(in: self)
            recentTouchPostion = touchPosition
            screenTapped = true
        }
        
    }
}

