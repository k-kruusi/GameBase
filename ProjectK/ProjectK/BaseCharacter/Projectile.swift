//
//  Projectile.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile : GameObject{
    enum EState {
        case Dormant
        case InAir
        case Reloading
    }
    
    var myState : EState?
    
    //Parameters
    var damage : CGFloat = 10.0
    var shootForce : CGFloat = 25.0
    
    //touch locations
    var startShootPos = CGPoint(x: 0, y: 0)
    var endShootPos = CGPoint(x: 0, y: 0)
    
    init(){
        super.init(imageName: "alienYellow", pos: CGPoint(x: 0,y: 0))
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        
        //Arrow in dormant state
        ResetArrow()
    }
    
    func Update(){
        //If Arrow falls out of screen, reset it
        if (position.y < -0){ //change to background height later
            ResetArrow()
        }
    }
    
    //Reset Arrow back to bow
    func ResetArrow(){
        position = initPos
        physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        physicsBody?.affectedByGravity = false
        SetState(myState: EState.Dormant)
    }
    
    //Get Initial Position
    func GetInitialPosition(initPos : CGPoint){
        startShootPos = initPos
    }
    
    //Get Final Position
    func GetFinalPosition(finalPos : CGPoint){
        endShootPos = finalPos
        
        //Calculate Shoot Force and dir
        var shootDir = CGPoint(x: startShootPos.x - endShootPos.x, y: startShootPos.y - endShootPos.y)
        //let hypotenuse = sqrt(shootDir.x * shootDir.x + shootDir.y * shootDir.y)
    
        //Shoot arrow if not in air
        if (myState == EState.Dormant){
            Shoot(shootForce : CGVector(dx: shootForce * shootDir.x, dy: shootForce * shootDir.y))
        }
    }
    
    //Shoot the Arrow
    func Shoot(shootForce : CGVector){
        physicsBody?.applyForce(shootForce)
        physicsBody?.affectedByGravity = true
        SetState(myState: EState.InAir)
    }
    
    //Set Arrow State
    func SetState(myState : EState){
        self.myState = myState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}

