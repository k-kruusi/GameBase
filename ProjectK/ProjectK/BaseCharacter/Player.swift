//
//  Player.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class Player : GameObject{
    init(){
        super.init(imageName: "bow", pos: CGPoint(x: 450,y: 450))
        
        SetInitPosition(newPos: CGPoint(x: size.width / 2, y: size.height / 2 ))
    }
    
    func RotateTowards(){
        
        var rotateToPos = CGPoint(x: position.x - rotateToTarget.x, y: position.y - rotateToTarget.y)
        //let length = sqrt(moveToPos.x * moveToPos.x + moveToPos.y * moveToPos.y)
        let angle = atan2(-rotateToPos.x, rotateToPos.y)
        
        zRotation = (angle - 90 * CGFloat(Double.pi/180.0)) + 135
        //NSLog("%f", zRotation * CGFloat(180.0 / Double.pi));
        
        //if moving
        //if (abs(position.x - moveToTarget.x) > moveSpeed + 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
