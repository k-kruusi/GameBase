//
//  Projectile.swift
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
        super.init(imageName: "alienYellow", pos: CGPoint(x: 250,y: 450))
        self.SetEType(newType: EType.Small)
    }
    
    func Shoot(){
        
        
    }
    
    func SetEType(newType : EType){
        myType = newType
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}

