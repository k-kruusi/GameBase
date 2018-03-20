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
    enum EType {
        case Big
        case Medium
        case Small
    }
    
    var myType : EType?
    
    init(){
        super.init(imageName: "alienYellow", pos: CGPoint(x: 150,y: 450))
        self.SetEType(newType: EType.Small)
    }
    
    func RotateTowards(){
        
        var rotateToPos = CGPoint(x: position.x - rotateToTarget.x, y: position.y - rotateToTarget.y)
        //let length = sqrt(moveToPos.x * moveToPos.x + moveToPos.y * moveToPos.y)
        let angle = atan2(rotateToPos.x, rotateToPos.y)
        
        if (abs(position.x - moveToTarget.x) > moveSpeed + 1){
            zRotation = angle - 90 * CGFloat(Double.pi/180.0)
            NSLog("%f", zRotation);
        }
    }
    
    
    func SetEType(newType : EType){
        myType = newType
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
