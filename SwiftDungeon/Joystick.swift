//
//  Joystick.swift
//  SwiftDungeon
//
//  Created by Puntillo Andrew J. on 3/13/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import Foundation
import SpriteKit

class Joystick {

    //Joystick sprites
    let joystickBase = SKSpriteNode(imageNamed: "joystick_arrows")
    let joystick = SKSpriteNode(imageNamed: "joystick_arrows")
    //Check for active
    var stickActive:Bool = false
    //Weak ref to scene
    weak var scene: GameScene?
    //Movement vector to output
    var dirVector:CGPoint = CGPoint(x:0, y:0)
    var xDist:CGFloat = 0
    var yDist:CGFloat = 0

    init() {
    }
    
    func Start(size:CGSize) {
        //Set alpha of the base to 0 so that only the joystick ball is visible
        scene?.addChild(joystickBase)
        joystickBase.position = CGPoint(x: 400, y: 400)
        joystickBase.alpha = 0
        
        scene?.addChild(joystick)
        joystick.position = joystickBase.position
        joystick.alpha = 0.5
        joystickBase.zPosition = CGFloat(10)
    }

    func OnBegin(loc:CGPoint) {
        if (joystick.frame.contains(loc)) {
            stickActive = true
        }
        else {
            stickActive = false
        }
    }
    
    func OnMoved(loc:CGPoint) {
        if (stickActive) {
            //Finding the direction and angle of the gesture
            let v = CGVector(dx: loc.x - joystickBase.position.x, dy: loc.y - joystickBase.position.y)
            let angle = atan2(v.dy, v.dx)
            
            //Conversion to degrees
            let deg = angle * CGFloat(180 / Double.pi)
            
            //How far the joystick can move out from the base
            let length:CGFloat = joystickBase.frame.size.height / 2
            
            //The angle of y and x
            xDist = sin(angle - 1.5708) * length
            yDist = cos(angle - 1.5708) * length
            //Allows movement within the joystickBase frame
            if (joystickBase.frame.contains(loc)) {
                joystick.position = loc
            }
            else {
                //Applies limitation when outside the joystickBase frame
                joystick.position = CGPoint(x:(joystickBase.position.x - xDist), y:(joystickBase.position.y + yDist))
            }
            
            dirVector = CGPoint(x: xDist / 60, y: (yDist / 60))

        }
    }
    
    func OnEnded() {
        //Reset the joystick's position back to the joystickBase's position after the touch event has ended
        if (stickActive) {
            let move:SKAction = SKAction.move(to: joystickBase.position, duration: 0.2)
            move.timingMode = .easeOut
            joystick.run(move)
            
            dirVector = CGPoint(x:0, y:0)
        }
    }
    
}
