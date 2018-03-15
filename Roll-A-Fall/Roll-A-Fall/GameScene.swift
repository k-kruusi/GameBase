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


    override func didMove(to view: SKView) {
     //Runs At First View Load
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        if(screenTapped){
            //ScreenTap With Touch Position Recorded
            print("[ " , recentTouchPostion.x, " , ", recentTouchPostion.y, " ]")
            
            
            
            //Check To See If Touch Was General Screen Or If It Was A Button
            
            
            
            
            screenTapped = false
        }
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

