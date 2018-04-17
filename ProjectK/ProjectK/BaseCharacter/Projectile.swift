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
    
    var shootTime : Double = 1
    var gameTime : TimeInterval = 0
    
    //Parameters
    var damage : CGFloat = 10.0
    var shootForce : CGFloat = 25.0
    var reloadSpeed : Double = 2
    
    //touch locations
    var startShootPos = CGPoint(x: 0, y: 0)
    var endShootPos = CGPoint(x: 0, y: 0)
    
    init(){
        super.init(imageName: "alienYellow", pos: CGPoint(x: 0,y: 0))
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        SetInitPosition(newPos: CGPoint(x: size.width / 2, y: size.height / 2 ))
        
        //Arrow in dormant state
        ResetArrow()
    }
    
    func Update(currentTime: TimeInterval){
        //update game time
        gameTime = currentTime
        
        //reload after reload speed is done
        if (myState == EState.Reloading && currentTime >= shootTime)
        {
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
            SetState(myState: EState.Reloading)
            shootTime = gameTime + reloadSpeed
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

