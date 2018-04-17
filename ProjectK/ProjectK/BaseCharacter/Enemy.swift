//
//  Enemy.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 3/22/18.
//  Copyright © 2018 Khizer. All rights reserved.
//


import Foundation
import SpriteKit

class Enemy : GameObject{
    
    init(){
        super.init(imageName: "alienYellow", pos: CGPoint(x: -450,y: 1250))
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        physicsBody?.affectedByGravity = false
        
        SetInitPosition(newPos: CGPoint(x: size.width / 2, y: 800 / 1.25 ))
        
    }
    
    func Update(){
        //move left or right
        physicsBody?.velocity = CGVector(dx: 550, dy: 0)
        
        if (position.x > screenSize.x){
            //SetTarget(newTarget: CGPoint(x: -screenSize.x,y: screenSize.y / 1.25)) //change later
            physicsBody?.velocity = CGVector(dx: -350, dy: 0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}

    /*
    func RotateTowards(){
        
        var rotateToPos = CGPoint(x: position.x - rotateToTarget.x, y: position.y - rotateToTarget.y)
        //let length = sqrt(moveToPos.x * moveToPos.x + moveToPos.y * moveToPos.y)
        let angle = atan2(-rotateToPos.x, rotateToPos.y)
        
        zRotation = (angle - 90 * CGFloat(Double.pi/180.0)) + 135
        NSLog("%f", zRotation * CGFloat(180.0 / Double.pi));
        
        //if moving
        //if (abs(position.x - moveToTarget.x) > moveSpeed + 1)
 }
 */
